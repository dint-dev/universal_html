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
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
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

part of universal_html;

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

  static const String _mediaType = "text/event-stream";

  /// URL of this event source.
  final String url;

  /// Value of `withCredentials` given in the constructor.
  final bool withCredentials;

  /// Parsed [url].
  Uri _parsedUri;

  /// HTTP response stream subscription.
  StreamSubscription _eventSubscription;

  /// Used by [readyState].
  int _readyState = CONNECTING;

  EventSource(this.url, {this.withCredentials = false}) {
    // Parse URI
    var parsedUri = Uri.tryParse(url);
    if (parsedUri == null) {
      throw ArgumentError.value(url, "url", "Invalid URL");
    }

    // Resolve relative URLs
    if (!parsedUri.isAbsolute) {
      parsedUri = Uri.parse(window.location.origin).resolveUri(parsedUri);
    }

    // Check the scheme
    final scheme = parsedUri.scheme;
    switch (scheme) {
      case "http":
        break;
      case "https":
        break;
      default:
        throw ArgumentError.value(
          url,
          "url",
          "Scheme must be 'http' or 'https'",
        );
    }

    // Connect
    this._parsedUri = parsedUri;
    _connect();
  }

  Stream<Event> get onError => errorEvent.forTarget(this);

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Stream<Event> get onOpen => openEvent.forTarget(this);

  int get readyState => _readyState;

  /// Closes the event stream.
  void close() {
    _readyState = CLOSED;
    if (_eventSubscription != null) {
      _eventSubscription.cancel();
      _eventSubscription = null;
    }
  }

  void _addError(Object error, [StackTrace stackTrace]) {
    this.dispatchEvent(ErrorEvent.internalConstructor(
        error: error, message: "Error:\n$error\n\nStack trace:\n$stackTrace"));
  }

  Future<void> _connect() async {
    Stream<Uint8List> nonListenedStream;
    try {
      String lastEventId;
      while (_readyState != CLOSED) {
        // Create a HTTP request
        final httpClient = HtmlDriver.current.newHttpClient();
        final httpRequest = await httpClient.getUrl(_parsedUri);

        // Add HTTP header "Accept"
        httpRequest.headers.set("Accept", _mediaType);

        // Add HTTP header "Last-Event-ID"
        if (lastEventId != null) {
          httpRequest.headers.set("Last-Event-ID", lastEventId);
        }

        // Send the HTTP request
        final httpResponse = await httpRequest.close();
        nonListenedStream = httpResponse;

        // Check HTTP status
        final statusCode = httpResponse.statusCode;
        if (statusCode != 200) {
          throw StateError(
            "Server returned HTTP status $statusCode",
          );
        }

        // Check HTTP header "Content-Type"
        final mimeType = httpResponse.headers.contentType.mimeType;
        switch (mimeType) {
          case _mediaType:
            break;

          default:
            throw StateError(
              "Server returned MIME type '$mimeType': $_parsedUri",
            );
        }

        // Did we close the stream already?
        if (_readyState == CLOSED) {
          return;
        }

        // We are ready
        _readyState = OPEN;

        // Transform to event stream
        var timeout = Duration(seconds: 5);
        final transformer = EventStreamDecoder(onReceivedTimeout: (newTimeout) {
          timeout = newTimeout;
        });
        final eventStream = httpResponse.map((data) {
          // TODO: Remove this when Dart SDK 2.5 becomes stable
          return data is Uint8List ? data : Uint8List.fromList(data);
        }).transform(transformer);

        // Listen the event stream
        nonListenedStream = null;
        _eventSubscription = eventStream.listen((event) {
          lastEventId = event.lastEventId;
          this.dispatchEvent(event);
        });
        await _eventSubscription.asFuture();

        // Wait timeout
        await Future.delayed(timeout);
      }
    } catch (error, stackTrace) {
      // Ignore errors after closing
      if (_readyState == CLOSED) {
        return;
      }

      // Add error
      _addError(error, stackTrace);
    } finally {
      // Close
      close();

      // To avoid leaking memory, dart:io instructs to read HTTP response body.
      // ignore: unawaited_futures
      nonListenedStream?.listen((data) {})?.cancel();
    }
  }
}
