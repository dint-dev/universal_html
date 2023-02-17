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

part of universal_html.internal;

/// Use the WebSocket interface to connect to a WebSocket,
/// and to send and receive data on that WebSocket.
///
/// To use a WebSocket in your web app, first create a WebSocket object,
/// passing the WebSocket URL as an argument to the constructor.
///
///     var webSocket = new WebSocket('ws://127.0.0.1:1337/ws');
///
/// To send data on the WebSocket, use the [send] method.
///
///     if (webSocket != null && webSocket.readyState == WebSocket.OPEN) {
///       webSocket.send(data);
///     } else {
///       print('WebSocket not connected, message $data not sent');
///     }
///
/// To receive data on the WebSocket, register a listener for message events.
///
///     webSocket.onMessage.listen((MessageEvent e) {
///       receivedData(e.data);
///     });
///
/// The message event handler receives a [MessageEvent] object
/// as its sole argument.
/// You can also define open, close, and error handlers,
/// as specified by [WebSocketEvents].
///
/// For more information, see the
/// [WebSockets](http://www.dartlang.org/docs/library-tour/#html-websockets)
/// section of the library tour and
/// [Introducing WebSockets](http://www.html5rocks.com/en/tutorials/websockets/basics/),
/// an HTML5Rocks.com tutorial.
@SupportedBrowser(SupportedBrowser.CHROME)
@SupportedBrowser(SupportedBrowser.FIREFOX)
@SupportedBrowser(SupportedBrowser.IE, '10')
@SupportedBrowser(SupportedBrowser.SAFARI)
@Unstable()
@Native('WebSocket')
class WebSocket extends EventTarget {
  /// Static factory designed to expose `close` events to event
  /// handlers that are not necessarily instances of [WebSocket].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<CloseEvent> closeEvent =
      EventStreamProvider<CloseEvent>('close');

  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [WebSocket].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  /// Static factory designed to expose `message` events to event
  /// handlers that are not necessarily instances of [WebSocket].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  /// Static factory designed to expose `open` events to event
  /// handlers that are not necessarily instances of [WebSocket].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> openEvent =
      EventStreamProvider<Event>('open');

  static const int CLOSED = 3;

  static const int CLOSING = 2;

  static const int CONNECTING = 0;

  static const int OPEN = 1;

  /// Checks if this type is supported on the current platform.
  static bool get supported => false;

  factory WebSocket(String url, [Object? protocols]) {
    throw UnimplementedError();
  }

  String? get binaryType {
    throw UnimplementedError();
  }

  set binaryType(String? value) {
    throw UnimplementedError();
  }

  int? get bufferedAmount {
    throw UnimplementedError();
  }

  String? get extensions {
    throw UnimplementedError();
  }

  /// Stream of `close` events handled by this [WebSocket].
  Stream<CloseEvent> get onClose => closeEvent.forTarget(this);

  /// Stream of `error` events handled by this [WebSocket].
  Stream<Event> get onError => errorEvent.forTarget(this);

  /// Stream of `message` events handled by this [WebSocket].
  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  /// Stream of `open` events handled by this [WebSocket].
  Stream<Event> get onOpen => openEvent.forTarget(this);

  String? get protocol {
    throw UnimplementedError();
  }

  int get readyState {
    throw UnimplementedError();
  }

  String? get url {
    throw UnimplementedError();
  }

  void close([int? code, String? reason]) {
    throw UnimplementedError();
  }

  /// Transmit data to the server over this connection.
  ///
  /// This method accepts data of type [Blob], [ByteBuffer], [String], or
  /// [TypedData]. Named variants [sendBlob], [sendByteBuffer], [sendString],
  /// or [sendTypedData], in contrast, only accept data of the specified type.
  void send(data) {
    throw UnimplementedError();
  }

  @JSName('send')

  /// Transmit data to the server over this connection.
  ///
  /// This method accepts data of type [Blob], [ByteBuffer], [String], or
  /// [TypedData]. Named variants [sendBlob], [sendByteBuffer], [sendString],
  /// or [sendTypedData], in contrast, only accept data of the specified type.
  void sendBlob(Blob data) {
    throw UnimplementedError();
  }

  @JSName('send')

  /// Transmit data to the server over this connection.
  ///
  /// This method accepts data of type [Blob], [ByteBuffer], [String], or
  /// [TypedData]. Named variants [sendBlob], [sendByteBuffer], [sendString],
  /// or [sendTypedData], in contrast, only accept data of the specified type.
  void sendByteBuffer(ByteBuffer data) {
    throw UnimplementedError();
  }

  @JSName('send')

  /// Transmit data to the server over this connection.
  ///
  /// This method accepts data of type [Blob], [ByteBuffer], [String], or
  /// [TypedData]. Named variants [sendBlob], [sendByteBuffer], [sendString],
  /// or [sendTypedData], in contrast, only accept data of the specified type.
  void sendString(String data) {
    throw UnimplementedError();
  }

  @JSName('send')

  /// Transmit data to the server over this connection.
  ///
  /// This method accepts data of type [Blob], [ByteBuffer], [String], or
  /// [TypedData]. Named variants [sendBlob], [sendByteBuffer], [sendString],
  /// or [sendTypedData], in contrast, only accept data of the specified type.
  void sendTypedData(TypedData data) {
    throw UnimplementedError();
  }
}
