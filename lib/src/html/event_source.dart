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

  final String url;
  final bool withCredentials;
  Uri _parsedUri;
  StreamSubscription _subscription;
  int _readyState = CONNECTING;

  EventSource(this.url, {this.withCredentials = false}) {
    var parsedUri = Uri.tryParse(url);
    if (parsedUri == null) {
      throw ArgumentError.value(url, "url", "Invalid URL");
    }
    if (!parsedUri.isAbsolute) {
      parsedUri = Uri.parse(window.location.origin).resolveUri(parsedUri);
    }
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
    this._parsedUri = parsedUri;
    _connect();
  }

  Stream<Event> get onError => errorEvent.forTarget(this);
  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Stream<Event> get onOpen => openEvent.forTarget(this);

  int get readyState => _readyState;

  void close() {
    _readyState = CLOSED;
    _close();
  }

  void _close() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

  void _addError(Object error, [StackTrace stackTrace]) {
    this.dispatchEvent(Event.eventType("error", "error"));
  }

  void _connect() async {
    String lastEventId;
    while (_readyState != CLOSED) {
      close();
      final httpClient = HtmlDriver.current.newHttpClient();
      final httpRequest = await httpClient.getUrl(_parsedUri);
      httpRequest.headers.set("Accept", "application/event-stream");
      if (lastEventId != null) {
        httpRequest.headers.set("Last-Event-Id", lastEventId);
      }
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != 200) {
        _readyState = CLOSED;
        await httpResponse.listen((data) {}).cancel();
        return;
      }
      final mimeType = httpResponse.headers.contentType.mimeType;
      switch (mimeType) {
        case "application/event-stream":
          break;
        default:
          this._addError(StateError(
            "Server returned MIME type '$mimeType': $_parsedUri",
          ));
      }
      _readyState = OPEN;
      var timeout = Duration(seconds: 5);
      final transformer = EventStreamDecoder(onReceivedTimeout: (newTimeout) {
        timeout = newTimeout;
      });
      _subscription = httpResponse.transform(transformer).listen((event) {
        lastEventId = event.lastEventId;
        window.dispatchEvent(event);
      });
      await _subscription.asFuture();
      await Future.delayed(timeout);
    }
  }
}
