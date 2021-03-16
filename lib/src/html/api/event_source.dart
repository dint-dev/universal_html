// Copyright 2019 terrier989@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

part of universal_html.internal;

class EventSource extends EventTarget {
  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [EventSource].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  /// Static factory designed to expose `message` events to event
  /// handlers that are not necessarily instances of [EventSource].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  /// Static factory designed to expose `open` events to event
  /// handlers that are not necessarily instances of [EventSource].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> openEvent =
      EventStreamProvider<Event>('open');

  static const int CLOSED = 2;
  static const int CONNECTING = 0;
  static const int OPEN = 1;

  static const String _mediaType = 'text/event-stream';

  /// URL of this event source.
  final String? url;

  /// Value of `withCredentials` given in the constructor.
  final bool? withCredentials;

  /// Parsed [url].
  Uri? _parsedUri;

  /// HTTP response stream subscription.
  StreamSubscription? _eventSubscription;

  /// Used by [readyState].
  int _readyState = CONNECTING;

  EventSource(String url, {this.withCredentials = false})
      : url = url,
        super.internal() {
    // Parse URI
    var parsedUri = Uri.tryParse(url);
    if (parsedUri == null) {
      throw ArgumentError.value(url, 'url', 'Invalid URL');
    }

    // Resolve relative URLs
    if (!parsedUri.isAbsolute) {
      parsedUri = Uri.parse(window.location.origin!).resolveUri(parsedUri);
    }

    // Check the scheme
    final scheme = parsedUri.scheme;
    switch (scheme) {
      case 'http':
        break;
      case 'https':
        break;
      default:
        throw ArgumentError.value(
          url,
          'url',
          'Scheme must be "http" or "https"',
        );
    }

    // Connect
    _parsedUri = parsedUri;
    _connect();
  }

  Stream<Event> get onError => errorEvent.forTarget(this);

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Stream<Event> get onOpen => openEvent.forTarget(this);

  int get readyState => _readyState;

  /// Closes the event stream.
  void close() {
    _readyState = CLOSED;
    final eventSubscription = _eventSubscription;
    if (eventSubscription != null) {
      eventSubscription.cancel();
      _eventSubscription = null;
    }
  }

  Future<void> _connect() async {
    try {
      String? lastEventId;
      while (_readyState != CLOSED) {
        // Create a HTTP request
        final httpClient = io.HttpClient();
        final httpRequest = await httpClient.getUrl(_parsedUri!);

        // Add HTTP header 'Accept'
        httpRequest.headers.set('Accept', _mediaType);

        // Add HTTP header 'Last-Event-ID'
        final currentLastEventId = lastEventId;
        if (currentLastEventId != null) {
          httpRequest.headers.set('Last-Event-ID', currentLastEventId);
        }

        // Send the HTTP request
        final httpResponse = await httpRequest.close();

        // Validate and parse HTTP response
        var timeout = Duration(seconds: 5);
        final eventStream = _readHttpResponse(
          httpResponse,
          (newTimeout) {
            timeout = newTimeout;
          },
        );

        // Listen the event stream
        final eventSubscription = eventStream.listen((event) {
          lastEventId = event.lastEventId;
          dispatchEvent(event);
        });
        _eventSubscription = eventSubscription;

        // Wait for
        await eventSubscription.asFuture();

        if (_readyState == CLOSED) {
          return;
        }

        // Update state
        _readyState = CONNECTING;

        // Dispatch 'stream interruption' event
        dispatchEvent(Event.internal('error'));

        // Reconnect after a timeout
        await Future.delayed(timeout);
      }
    } catch (error, stackTrace) {
      // Ignore errors after closing
      if (_readyState == CLOSED) {
        return;
      }
      _readyState = CLOSED;

      // Add error
      dispatchEvent(
        ErrorEvent.internal(
          error: error,
          message: 'Error:\n  $error\n\nStack trace:\n  $stackTrace',
        ),
      );
    } finally {
      // Close
      close();
    }
  }

  Stream<MessageEvent> _readHttpResponse(io.HttpClientResponse httpResponse,
      void Function(Duration d) onTimeout) async* {
    var close = false;
    EventStreamDecoder? transformer;
    try {
      // Check HTTP status
      final statusCode = httpResponse.statusCode;
      if (statusCode != 200) {
        throw StateError(
          'Server returned HTTP status $statusCode',
        );
      }

      // Check HTTP header 'Content-Type'
      final mimeType = httpResponse.headers.contentType?.mimeType;
      switch (mimeType) {
        case _mediaType:
          break;

        default:
          throw StateError(
            'Server returned MIME type "$mimeType": $_parsedUri',
          );
      }

      // Did we close the stream already?
      if (_readyState == CLOSED) {
        return;
      }

      // The connection is open
      _readyState = OPEN;
      dispatchEvent(Event.internal('open'));

      // Transform to event stream
      final origin = _parsedUri!.origin;
      transformer = EventStreamDecoder(
        origin: origin,
        onReceivedTimeout: onTimeout,
      );
    } finally {
      if (close) {
        // To avoid leaking memory, dart:io instructs to read HTTP response body.
        // ignore: unawaited_futures
        httpResponse.listen((_) {}).cancel();
      }
    }
    yield* (httpResponse.map((data) {
      return data;
    }).transform(transformer));
  }
}
