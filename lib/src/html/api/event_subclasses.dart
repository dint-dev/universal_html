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
// ignore_for_file: constant_identifier_names

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

part of '../../html.dart';

class AbortPaymentEvent extends ExtendableEvent {
  factory AbortPaymentEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  void respondWith(Future paymentAbortedResponse) {
    throw UnimplementedError();
  }
}

abstract class AnimationEvent extends Event {
  factory AnimationEvent(String type, [Map? eventInitDict]) {
    throw UnimplementedError();
  }

  String? get animationName;

  num? get elapsedTime;
}

class AnimationPlaybackEvent extends Event {
  AnimationPlaybackEvent(super.type) : super.internal();
}

class BackgroundFetchedEvent extends Event {
  final List<BackgroundFetchSettledFetch>? fetches = [];

  BackgroundFetchedEvent(super.type, Map init) : super.internal();

  Future updateUI(String title) {
    throw UnimplementedError();
  }
}

class BackgroundFetchEvent extends Event {
  BackgroundFetchEvent(super.type, Map init) : super.internal();

  String? get id => throw UnimplementedError();
}

class BackgroundFetchFailEvent extends Event {
  BackgroundFetchFailEvent(super.type) : super.internal();
}

abstract class BeforeInstallPromptEvent extends Event {
  BeforeInstallPromptEvent(super.type, [Map? eventInitDict]) : super.internal();

  List<String> get platforms;

  Future<Map<String, dynamic>> get userChoice;

  Future prompt();
}

class BeforeUnloadEvent extends Event {
  String? returnValue;

  BeforeUnloadEvent._(super.type) : super.internal();
}

class BlobEvent extends Event {
  final Blob? data;
  final num? timecode;

  BlobEvent(String type, [Map? dict])
      : this._(type, data: dict?['data'], timecode: dict?['timecode']);

  BlobEvent._(super.type, {this.data, this.timecode}) : super.internal();
}

abstract class CanMakePaymentEvent extends ExtendableEvent {
  factory CanMakePaymentEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  List? get methodData => throw UnimplementedError();

  List? get modifiers => throw UnimplementedError();

  String? get paymentRequestOrigin => throw UnimplementedError();

  String? get topLevelOrigin => throw UnimplementedError();

  void respondWith(Future canMakePaymentResponse) {
    throw UnimplementedError();
  }
}

abstract class ClipboardEvent extends Event {
  factory ClipboardEvent(String type, [Map? eventInitDict]) {
    throw UnimplementedError();
  }

  DataTransfer? get clipboardData;
}

class CloseEvent extends Event {
  final int? code;

  final String? reason;

  final bool? wasClean;

  CloseEvent.constructor(super.type, {this.code, this.reason, this.wasClean})
      : super.internal();
}

class CompositionEvent extends Event {
  CompositionEvent(super.type) : super.internal();
}

class CustomEvent extends Event {
  final Object? detail;

  factory CustomEvent(
    String type, {
    bool canBubble = true,
    bool cancelable = true,
    Object? detail,
  }) {
    return CustomEvent._(
      type,
      canBubble: canBubble,
      cancelable: cancelable,
      detail: detail,
    );
  }

  CustomEvent._(
    super.type, {
    super.canBubble,
    bool super.cancelable,
    this.detail,
  }) : super.internal();
}

class DeviceAcceleration {
  final num x;
  final num y;
  final num z;

  DeviceAcceleration._(this.x, this.y, this.z);
}

abstract class DeviceMotionEvent extends Event {
  factory DeviceMotionEvent(String type, [Map? eventInitDict]) {
    throw UnimplementedError();
  }

  DeviceAcceleration? get acceleration;

  DeviceAcceleration? get accelerationIncludingGravity;

  num? get interval;

  DeviceRotationRate? get rotationRate;
}

class DeviceOrientationEvent extends Event {
  final num? absolute;

  final num? alpha;

  final num? beta;

  final num? gamma;

  DeviceOrientationEvent.constructor(
    super.type, {
    this.absolute,
    this.alpha,
    this.beta,
    this.gamma,
  }) : super.internal();
}

class DeviceRotationRate {
  final num alpha;

  final num beta;

  final num gamma;

  DeviceRotationRate._(this.alpha, this.beta, this.gamma);
}

class ErrorEvent extends Event {
  final int? colno;
  final Object? error;
  final String? filename;
  final int? lineno;
  final String? message;

  ErrorEvent(String type, [Map? eventInitDict])
      : this.internal(
          colno: eventInitDict?['colno'],
          error: eventInitDict?['error'],
          filename: eventInitDict?['filename'],
          lineno: eventInitDict?['lineno'],
          message: eventInitDict?['message'],
        );

  /// Internal constructor. __Not part of dart:html__.
  ErrorEvent.internal({
    this.colno,
    this.error,
    this.filename,
    this.lineno,
    this.message,
  }) : super.internal('error');

  @override
  String toString() => '[ErrorEvent: $message]';
}

class ExtendableEvent extends Event {
  ExtendableEvent._(
    super.type, {
    bool bubbles = true,
    bool super.cancelable = false,
  }) : super.internal(canBubble: bubbles);

  void waitUntil(Future f) {
    throw UnimplementedError();
  }
}

abstract class FetchEvent extends ExtendableEvent {
  factory FetchEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  String get clientId;

  bool get isReload;

  Future get preloadResponse;

  void respondWith(Future r) {
    throw UnimplementedError();
  }
}

class FocusEvent extends UIEvent {
  final EventTarget? relatedTarget;

  FocusEvent(super.type, {this.relatedTarget});
}

class HashChangeEvent extends Event {
  final String oldUrl;
  final String newUrl;

  HashChangeEvent(
    super.type, {
    bool canBubble = true,
    bool cancelable = true,
    required this.oldUrl,
    required this.newUrl,
  }) : super.internal();

  bool get supported => true;
}

class InputDeviceCapabilities {}

class InstallEvent extends Event {
  factory InstallEvent(String type, Map dict) {
    throw UnimplementedError();
  }
}

class KeyboardEvent extends UIEvent {
  static const int DOM_KEY_LOCATION_LEFT = 0x01;
  static const int DOM_KEY_LOCATION_NUMPAD = 0x03;
  static const int DOM_KEY_LOCATION_RIGHT = 0x02;
  static const int DOM_KEY_LOCATION_STANDARD = 0x00;

  final bool altKey;
  final int charCode;
  final String? code;
  final bool ctrlKey;
  final bool? isComposing;
  final int keyCode;
  final int? location;
  final bool metaKey;
  final bool? repeat;
  final bool shiftKey;

  KeyboardEvent(
    super.type, {
    Window? view,
    this.altKey = false,
    int? charCode,
    this.code,
    this.ctrlKey = false,
    this.isComposing = false,
    int? keyCode,
    this.location,
    this.metaKey = false,
    this.repeat = false,
    this.shiftKey = false,
    super.canBubble,
    super.cancelable,
  })  : charCode = charCode ?? -1,
        keyCode = keyCode ?? -1;

  String? get key => throw UnimplementedError();

  int? get which => throw UnimplementedError();

  bool getModifierState(String keyArg) => false;
}

class KeyEvent extends KeyboardEvent {
  /// Accessor to provide a stream of KeyEvents on the desired target.
  static EventStreamProvider<KeyEvent> get keyDownEvent =>
      throw UnimplementedError();

  /// Accessor to provide a stream of KeyEvents on the desired target.
  static EventStreamProvider<KeyEvent> get keyPressEvent =>
      throw UnimplementedError();

  /// Accessor to provide a stream of KeyEvents on the desired target.
  static EventStreamProvider<KeyEvent> get keyUpEvent =>
      throw UnimplementedError();

  @override
  final EventTarget currentTarget;

  KeyEvent(
    super.type, {
    required this.currentTarget,
    super.charCode,
    super.altKey,
    super.canBubble,
    super.cancelable,
    super.ctrlKey,
    super.keyCode,
    super.location,
    super.metaKey,
    super.shiftKey,
    super.view,
  });
}

class MessageEvent extends Event {
  final dynamic data;
  final String lastEventId;
  final String origin;
  final EventTarget? source;
  final List<MessagePort> ports;

  MessageEvent(
    super.type, {
    this.data,
    String? origin,
    String? lastEventId,
    this.source,
    List<MessagePort>? messagePorts,
  })  : lastEventId = lastEventId ?? '',
        origin = origin ?? '',
        ports = messagePorts ?? const [],
        super.internal();

  String? get suborigin => null;
}

abstract class MessagePort extends EventTarget {
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  MessagePort._() : super.internal();

  /// Stream of `message` events handled by this [MessagePort].
  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  void close();

  void postMessage(dynamic message, [List<Object> transfer]);
}

class MouseEvent extends UIEvent {
  final bool? altKey;

  final int? button;

  final int? buttons;

  final num? _clientX;

  final num? _clientY;

  final bool? ctrlKey;

  final int? _layerX;

  final int? _layerY;

  final bool? metaKey;

  final int? _movementX;

  final int? _movementY;

  final num? _pageX;

  final num? _pageY;

  final String? region;

  final EventTarget? relatedTarget;

  final num? _screenX;

  final num? _screenY;

  final bool? shiftKey;

  factory MouseEvent(
    String type, {
    Window? view,
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
    EventTarget? relatedTarget,
  }) {
    return MouseEvent._(
      type,
      view: view,
      detail: detail,
      screenX: screenX,
      screenY: screenY,
      clientX: clientX,
      clientY: clientY,
      button: button,
    );
  }

  MouseEvent._(
    super.type, {
    this.altKey = false,
    this.button = 0,
    this.ctrlKey = false,
    this.metaKey = false,
    this.relatedTarget,
    this.region,
    int? screenX,
    int? screenY,
    int? clientX,
    int? clientY,
    int? layerX,
    int? layerY,
    int? movementX,
    int? movementY,
    int? pageX,
    int? pageY,
    this.shiftKey = false,
    super.canBubble,
    super.cancelable,
    int super.detail = 0,
    super.view,
  })  : buttons = 0,
        _screenX = screenX,
        _screenY = screenY,
        _clientX = clientX,
        _clientY = clientY,
        _layerX = layerX,
        _layerY = layerY,
        _movementX = movementX,
        _movementY = movementY,
        _pageX = pageX,
        _pageY = pageY;

  Point get client => Point(_clientX!, _clientY!);

  DataTransfer get dataTransfer => throw UnimplementedError();

  Point get layer => Point(_layerX!, _layerY!);

  Point get movement => Point(_movementX!, _movementY!);

  /// The coordinates of the mouse pointer in target node coordinates.
  ///
  /// This value may vary between platforms if the target node moves
  /// after the event has fired or if the element has CSS transforms affecting
  /// it.
  Point get offset {
    final target = this.target as Element;
    var point = (client - target.getBoundingClientRect().topLeft);
    return Point(point.x.toInt(), point.y.toInt());
  }

  Point get page => Point(_pageX!, _pageY!);

  Point get screen => Point(_screenX!, _screenY!);

  bool getModifierState(String keyArg) => false;
}

class NotificationEvent extends ExtendableEvent {
  final String? action;

  final Notification? notification;
  final String? reply;

  factory NotificationEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  NotificationEvent.internal({this.action, this.notification, this.reply})
      : super._('Notification');
}

class PageTransitionEvent extends Event {
  PageTransitionEvent(super.type) : super.internal();
}

class PaymentRequestEvent extends Event {
  PaymentRequestEvent(super.type) : super.internal();
}

class PaymentRequestUpdateEvent extends Event {
  PaymentRequestUpdateEvent(super.type) : super.internal();
}

class PointerEvent extends MouseEvent {
  final num? height;
  final bool? isPrimary;
  final int? pointerId;
  final String? pointerType;
  final num? pressure;
  final num? tangentialPressure;
  final int? tiltX;
  final int? tiltY;
  final int? twist;
  final num? width;

  factory PointerEvent(String type, [Map? dict]) =>
      PointerEvent.constructor(type: type);

  PointerEvent.constructor({
    required String type,
    this.height,
    this.isPrimary,
    this.pointerId,
    this.pointerType,
    this.pressure,
    this.tangentialPressure,
    this.tiltX,
    this.tiltY,
    this.twist,
    this.width,
    bool altKey = false,
    int button = 0,
    bool canBubble = true,
    bool cancelable = true,
    bool ctrlKey = false,
    int detail = 0,
    bool metaKey = false,
    bool shiftKey = false,
    EventTarget? relatedTarget,
    Object? view,
  }) : super._(
          type,
          view: view,
          detail: detail,
          button: button,
          canBubble: canBubble,
          cancelable: cancelable,
          ctrlKey: ctrlKey,
          altKey: altKey,
          shiftKey: shiftKey,
          metaKey: metaKey,
          relatedTarget: relatedTarget,
        );
}

class PopStateEvent extends Event {
  final Object? state;

  PopStateEvent(String type) : this._(type: type);

  PopStateEvent._({String type = 'popstate', this.state})
      : super.internal(type);
}

class ProgressEvent extends Event {
  ProgressEvent(super.type, [Map? eventInitDict]) : super.internal();

  bool? get lengthComputable => null;

  int? get loaded => null;

  int? get total => null;
}

class PushEvent extends Event {
  PushEvent(super.type, [Map? eventInitDict]) : super.internal();

  PushMessageData? get data => null;
}

class SecurityPolicyViolationEvent extends Event {
  final String? blockedUri;

  final int? columnNumber;

  final String? disposition;

  final String? documentUri;

  final String? effectiveDirective;

  final int? lineNumber;

  final String? originalPolicy;

  final String? referrer;

  final String? sample;

  final String? sourceFile;

  final int? statusCode;

  final String? violatedDirective;

  SecurityPolicyViolationEvent.constructor(
    super.type, {
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
  }) : super.internal();
}

class SensorErrorEvent extends Event {
  SensorErrorEvent(super.type) : super.internal();
}

class SyncEvent extends Event {
  SyncEvent(super.type) : super.internal();

  bool? get lastChance => null;

  String? get tag => null;
}

class TextEvent extends Event {
  TextEvent(super.type) : super.internal();
}

class Touch {
  final int radiusX;
  final int radiusY;

  Point get page => Point(radiusX, radiusY);

  Touch({this.radiusX = 0, this.radiusY = 0});
}

class TouchEvent extends UIEvent {
  static bool get supported => true;

  final bool altKey;

  final TouchList? changedTouches;

  final bool ctrlKey;

  final bool metaKey;

  final bool shiftKey;

  final TouchList? targetTouches;

  final TouchList? touches;

  TouchEvent.constructor(
    super.type, {
    this.altKey = false,
    this.changedTouches,
    this.ctrlKey = false,
    this.metaKey = false,
    this.shiftKey = false,
    this.targetTouches,
    this.touches,
  });
}

class TouchList extends DelegatingList<Touch> {
  /// Checks if this type is supported on the current platform.
  static bool get supported => false;

  factory TouchList._() => throw UnimplementedError();

  @override
  Touch elementAt(int index) => this[index];

  Touch item(int index) => this[index];
}

class TrackEvent extends Event {
  TrackEvent(super.type) : super.internal();
}

class TransitionEvent extends Event {
  final num? elapsedTime;

  final String? propertyName;

  final String? pseudoElement;

  factory TransitionEvent(String type, [Map? eventInitDict]) {
    return TransitionEvent.constructor(type);
  }

  TransitionEvent.constructor(
    super.type, {
    this.elapsedTime,
    this.propertyName,
    this.pseudoElement,
  }) : super.internal();
}

abstract class UIEvent extends Event {
  final int? detail;
  final InputDeviceCapabilities? sourceCapabilities;
  final Object? view;

  UIEvent(
    super.type, {
    this.detail,
    this.sourceCapabilities,
    this.view,
    super.canBubble,
    bool super.cancelable,
  }) : super.internal();
}

class WheelEvent extends MouseEvent {
  static const int DOM_DELTA_LINE = 0x01;

  static const int DOM_DELTA_PAGE = 0x02;

  static const int DOM_DELTA_PIXEL = 0x00;

  final num? deltaZ;

  factory WheelEvent(
    String type, {
    Window? view,
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
    EventTarget? relatedTarget,
  }) {
    return WheelEvent._(type, deltaZ: deltaZ);
  }

  WheelEvent._(super.type, {this.deltaZ}) : super._();

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
