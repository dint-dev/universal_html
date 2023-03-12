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

abstract class EventSource extends EventTarget {
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

  factory EventSource(String url, {bool? withCredentials = false}) {
    return _EventSource(url, withCredentials: withCredentials);
  }

  EventSource.internal() : super.internal();

  Stream<Event> get onError => errorEvent.forTarget(this);

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Stream<Event> get onOpen => openEvent.forTarget(this);

  int? get readyState;

  /// URL of this event source.
  String get url;

  /// Value of `withCredentials` given in the constructor.
  bool? get withCredentials;

  /// Closes the event stream.
  void close();
}

abstract class EventSourceOutsideBrowser implements EventSource {
  /// A callback called when a [HttpClientRequest] is ready (only outside
  /// browsers).
  ///
  /// You can access [httpClientRequest] if you want to set headers.
  FutureOr<void> Function(
          EventSourceOutsideBrowser eventSource, io.HttpClientRequest request)?
      onHttpClientRequest;

  /// A callback called when a [HttpClientResponse] arrives (only outside
  /// browsers).
  ///
  /// You can access [httpClientResponse] if you want to access headers.
  FutureOr<void> Function(
      EventSourceOutsideBrowser eventSource,
      io.HttpClientRequest request,
      io.HttpClientResponse response)? onHttpClientResponse;

  Duration retryDuration = Duration(seconds: 3);
}

class _EventSource extends EventSource implements EventSourceOutsideBrowser {
  static const String _mediaType = 'text/event-stream';

  @override
  FutureOr<void> Function(
          EventSourceOutsideBrowser eventSource, io.HttpClientRequest request)?
      onHttpClientRequest;

  @override
  FutureOr<void> Function(
      EventSourceOutsideBrowser eventSource,
      io.HttpClientRequest request,
      io.HttpClientResponse response)? onHttpClientResponse;

  /// URL of this event source.
  @override
  final String url;

  @override
  final bool? withCredentials;

  /// Parsed [url].
  Uri? _parsedUri;

  /// HTTP response stream subscription.
  StreamSubscription? _eventSubscription;

  /// Used by [readyState].
  int? _readyState = EventSource.CONNECTING;

  _EventSource(this.url, {this.withCredentials = false}) : super.internal() {
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

  @override
  int? get readyState => _readyState;

  @override
  Duration retryDuration = const Duration(seconds: 3);

  @override
  void close() {
    _readyState = EventSource.CLOSED;
    final eventSubscription = _eventSubscription;
    if (eventSubscription != null) {
      eventSubscription.cancel();
      _eventSubscription = null;
    }
  }

  Future<void> _connect() async {
    try {
      String? lastEventId;
      while (_readyState != EventSource.CLOSED) {
        // Select HTTP client
        final httpClient =
            window.internalWindowController.onChooseHttpClient(_parsedUri!);

        // Create a HTTP request
        final httpRequest = await httpClient.getUrl(_parsedUri!);

        // Add HTTP header 'Accept'
        httpRequest.headers.set('Accept', _mediaType);

        // Add HTTP header 'Last-Event-ID'
        final currentLastEventId = lastEventId;
        if (currentLastEventId != null) {
          httpRequest.headers.set('Last-Event-ID', currentLastEventId);
        }

        await onHttpClientRequest?.call(
          this as dynamic,
          httpRequest,
        );

        // Send the HTTP request
        final httpResponse = await httpRequest.close();

        await onHttpClientResponse?.call(
          this as dynamic,
          httpRequest,
          httpResponse,
        );

        // Validate and parse HTTP response
        final eventStream = _readHttpResponse(
          httpResponse: httpResponse,
          onRetryDuration: (duration) {
            retryDuration = duration;
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

        if (_readyState == EventSource.CLOSED) {
          return;
        }

        // Update state
        _readyState = EventSource.CONNECTING;

        // Dispatch 'stream interruption' event
        dispatchEvent(Event.internal('error'));

        // Reconnect after a polling period
        await Future.delayed(retryDuration);
      }
    } catch (error, stackTrace) {
      // Ignore errors after closing
      if (_readyState == EventSource.CLOSED) {
        return;
      }
      _readyState = EventSource.CLOSED;

      // Add error
      dispatchEvent(
        ErrorEvent.internal(
          error: error.toString(),
          message: 'Error:\n  $error\n\nStack trace:\n  $stackTrace',
        ),
      );
    } finally {
      // Close
      close();
    }
  }

  Stream<MessageEvent> _readHttpResponse({
    required io.HttpClientResponse httpResponse,
    required void Function(Duration d) onRetryDuration,
  }) async* {
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
      if (_readyState == EventSource.CLOSED) {
        return;
      }

      // The connection is open
      _readyState = EventSource.OPEN;
      dispatchEvent(Event.internal('open'));

      // Transform to event stream
      final origin = _parsedUri!.origin;
      transformer = EventStreamDecoder(
        origin: origin,
        onReceivedTimeout: onRetryDuration,
      );
    } catch (error) {
      // To avoid leaking memory, dart:io instructs to read HTTP response body.
      // ignore: unawaited_futures
      httpResponse.listen((_) {}).cancel();
      rethrow;
    }
    yield* (httpResponse.map((data) {
      return data;
    }).transform(transformer));
  }
}
