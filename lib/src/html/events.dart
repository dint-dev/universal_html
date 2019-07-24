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

class BlobEvent extends Event {
  final Blob blob;
  final num timecode;

  BlobEvent(String type, {this.blob, this.timecode})
      : super.internalConstructor(type);
}

abstract class ClipboardEvent implements Event {
  DataTransfer get clipboardData;
}

abstract class CloseEvent implements Event {
  int get code;

  String get reason;

  bool get wasClean;
}

class CustomEvent extends Event {
  final Object detail;

  factory CustomEvent(
    String type, {
    bool canBubble = true,
    bool cancelable = true,
    Object detail,
  }) {
    return CustomEvent(
      type,
      canBubble: canBubble,
      cancelable: cancelable,
      detail: detail,
    );
  }

  CustomEvent._(String type, {bool canBubble, cancelable, this.detail})
      : super.internalConstructor(type,
            bubbles: canBubble, cancelable: cancelable);
}

abstract class DeviceOrientationEvent implements Event {
  num get absolute;

  num get alpha;

  num get beta;

  num get gamma;
}

class ErrorEvent extends Event {
  final int colno;
  final Object error;
  final String fileName;
  final int lineno;
  final String message;

  /// IMPORTANT: Not part of 'dart:html' API.
  ErrorEvent.internalConstructor(
      {this.colno, this.error, this.fileName, this.lineno, this.message})
      : super.internalConstructor("error");

  @override
  String toString() => "[ErrorEvent: $message]";
}

abstract class ExtendableEvent extends Event {
  /// IMPORTANT: Not part of 'dart:html' API.
  ExtendableEvent.internalConstructor(String type,
      {bool bubbles = true, bool cancelable = false})
      : super.internalConstructor(type,
            bubbles: bubbles, cancelable: cancelable);

  void waitUntil(Future f) {
    throw UnimplementedError();
  }
}

class FetchEvent extends ExtendableEvent {
  final String clientId;

  final bool isReload;

  final Future preloadResponse;

  final _Request request;

  factory FetchEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  FetchEvent.internal(
      {this.clientId, this.isReload, this.preloadResponse, this.request})
      : super.internalConstructor("fetch");

  void respondWith(Future r) {
    throw UnimplementedError();
  }
}

class FocusEvent extends UIEvent {
  final EventTarget relatedTarget;

  FocusEvent(String type, {this.relatedTarget}) : super(type);
}

class HashChangeEvent extends Event {
  final String oldUrl;
  final String newUrl;

  HashChangeEvent(String type,
      {bool canBubble = true, bool cancelable = true, this.oldUrl, this.newUrl})
      : super.internalConstructor(type);

  bool get supported => true;
}

class InputDeviceCapabilities {}

class KeyboardEvent extends UIEvent {
  final Window view;
  final bool canBubble;
  final bool cancelable;
  final int location;
  final int keyCode;
  final int keyLocation;
  final bool ctrlKey;
  final bool altKey;
  final bool shiftKey;
  final bool metaKey;

  KeyboardEvent(
    String type, {
    this.view,
    this.canBubble = true,
    this.cancelable = true,
    this.location,
    this.keyCode,
    this.keyLocation,
    this.ctrlKey = false,
    this.altKey = false,
    this.shiftKey = false,
    this.metaKey = false,
  }) : super(type);
}

class KeyEvent extends KeyboardEvent {
  final int charCode;
  final EventTarget currentTarget;

  KeyEvent(
    String type, {
    Window view,
    bool canBubble = true,
    bool cancelable = true,
    this.charCode = 0,
    int keyCode,
    int keyLocation = 1,
    bool ctrlKey = false,
    bool altKey = false,
    bool shiftKey = false,
    bool metaKey = false,
    this.currentTarget,
  }) : super(
          type,
          view: view,
          canBubble: canBubble,
          cancelable: cancelable,
          keyCode: keyCode,
          keyLocation: keyLocation,
          ctrlKey: ctrlKey,
          altKey: altKey,
          shiftKey: shiftKey,
          metaKey: metaKey,
        );
}

class MessageEvent extends Event {
  final dynamic data;
  final String lastEventId;
  final String origin;
  final EventTarget source;
  final List<MessagePort> ports;

  MessageEvent(
    String type, {
    this.data,
    this.origin,
    this.lastEventId,
    this.source,
    this.ports,
  }) : super.internalConstructor(type);
}

abstract class MessagePort {
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  void close();

  void postMessage(dynamic message, [List<Object> transfer]);
}

class MouseEvent extends UIEvent {
  final Object view;
  final int detail;
  final int clientX;
  final int clientY;
  final int button;
  final bool canBubble;
  final bool cancelable;
  final bool ctrlKey;
  final bool shiftKey;
  final bool altKey;
  final bool metaKey;
  final EventTarget relatedTarget;

  MouseEvent(String type,
      {this.view,
      this.detail = 0,
      this.clientX = 0,
      this.clientY = 0,
      this.button = 0,
      this.canBubble = true,
      this.cancelable = true,
      this.ctrlKey = false,
      this.altKey = false,
      this.shiftKey = false,
      this.metaKey = false,
      this.relatedTarget})
      : super(type);
}

class PopStateEvent extends Event {
  final Object state;

  PopStateEvent(String type) : this.internal(type: type);

  /// IMPORTANT: Not part of 'dart:html' API.
  PopStateEvent.internal({String type = "popstate", this.state})
      : super.internalConstructor(type);
}

class ProgressEvent extends Event {
  ProgressEvent(String type) : super.internalConstructor(type);
}

abstract class SecurityPolicyViolationEvent implements Event {
  final String blockedUri;

  final int columnNumber;

  final String disposition;

  final String documentUri;

  final String effectiveDirective;

  final int lineNumber;

  final String originalPolicy;

  final String referrer;

  final String sample;

  final String sourceFile;

  final int statusCode;

  final String violatedDirective;

  /// IMPORTANT: Not part of 'dart:html' API.
  SecurityPolicyViolationEvent.internal(
    String type, {
    this.blockedUri,
    this.columnNumber,
    this.disposition,
    this.documentUri,
    this.effectiveDirective,
    this.lineNumber,
    this.originalPolicy,
    this.referrer,
    this.sample,
    this.sourceFile,
    this.statusCode,
    this.violatedDirective,
  });
}

class Touch {
  static bool get supported => true;
  final int radiusX;
  final int radiusY;

  Touch({this.radiusX, this.radiusY});
}

class TouchEvent extends UIEvent {
  static bool get supported => true;

  TouchEvent(String type) : super(type);

  /// IMPORTANT: Not part of 'dart:html' API.
  TouchEvent.internal(
    List<Touch> touches,
    List<Touch> targetTouches,
    List<Touch> changedTouches,
    String type, {
    Window view,
    int screenX = 0,
    int screenY = 0,
    int clientX = 0,
    int clientY = 0,
    bool ctrlKey = false,
    bool altKey = false,
    bool shiftKey = false,
    bool metaKey = false,
  }) : super(type);
}

class TransitionEvent extends Event {
  // To suppress missing implicit constructor warnings.
  final num elapsedTime;

  final String propertyName;

  final String pseudoElement;

  factory TransitionEvent(String type, [Map eventInitDict]) {
    return TransitionEvent._(type);
  }

  TransitionEvent._(String type,
      {this.elapsedTime, this.propertyName, this.pseudoElement})
      : super.internalConstructor(type);
}

abstract class UIEvent extends Event {
  UIEvent(String type) : super.internalConstructor(type);

  int get detail => null;

  InputDeviceCapabilities get sourceCapabilities => null;
}

class WheelEvent extends MouseEvent {
  static const int DOM_DELTA_LINE = 0x01;

  static const int DOM_DELTA_PAGE = 0x02;

  static const int DOM_DELTA_PIXEL = 0x00;

  final num deltaZ;

  factory WheelEvent(String type,
      {Window view,
      num deltaX = 0,
      num deltaY = 0,
      num deltaZ = 0,
      int deltaMode = 0,
      int detail = 0,
      int screenX = 0,
      int screenY = 0,
      int clientX = 0,
      int clientY = 0,
      int button = 0,
      bool canBubble = true,
      bool cancelable = true,
      bool ctrlKey = false,
      bool altKey = false,
      bool shiftKey = false,
      bool metaKey = false,
      EventTarget relatedTarget}) {
    return WheelEvent._(type, deltaZ: deltaZ);
  }

  WheelEvent._(String type, {this.deltaZ}) : super(type);

  int get deltaMode {
    return 0;
  }

  /// The amount that is expected to scroll horizontally, in units determined by
  /// [deltaMode].
  ///
  /// See also:
  ///
  /// * [WheelEvent.deltaX](http://dev.w3.org/2006/webapi/DOM-Level-3-Events/html/DOM3-Events.html#events-WheelEvent-deltaX) from the W3C.
  num get deltaX {
    throw UnsupportedError('deltaX is not supported');
  }

  /// The amount that is expected to scroll vertically, in units determined by
  /// [deltaMode].
  ///
  /// See also:
  ///
  /// * [WheelEvent.deltaY](http://dev.w3.org/2006/webapi/DOM-Level-3-Events/html/DOM3-Events.html#events-WheelEvent-deltaY) from the W3C.
  num get deltaY {
    throw UnsupportedError('deltaY is not supported');
  }
}
