part of universal_html;

class BlobEvent extends Event {
  final Blob blob;
  final num timecode;

  BlobEvent(String type, {this.blob, this.timecode}) : super.constructor(type);
}

abstract class ClipboardEvent implements Event {
  DataTransfer get clipboardData;
}

abstract class CloseEvent implements Event {
  int get code;

  String get reason;

  bool get wasClean;
}

abstract class DeviceOrientationEvent implements Event {
  num get absolute;

  num get alpha;

  num get beta;

  num get gamma;
}

class FocusEvent extends UIEvent {
  final EventTarget relatedTarget;

  FocusEvent(String type, {this.relatedTarget}) : super(type);
}

class HashChangeEvent extends Event {
  final String oldUrl;
  final String newUrl;

  HashChangeEvent(String type,
      {bool canBubble: true, bool cancelable: true, this.oldUrl, this.newUrl})
      : super.constructor(type);

  bool get supported => true;
}

class InputDeviceCapabilities {}

class KeyboardEvent extends UIEvent {
  final Window view;
  final bool canBubble;
  final bool cancelable;
  final int location;
  final int keyLocation;
  final bool ctrlKey;
  final bool altKey;
  final bool shiftKey;
  final bool metaKey;

  KeyboardEvent(
    String type, {
    this.view,
    this.canBubble: true,
    this.cancelable: true,
    this.location,
    this.keyLocation,
    this.ctrlKey: false,
    this.altKey: false,
    this.shiftKey: false,
    this.metaKey: false,
  }) : super(type);
}

class KeyEvent extends KeyboardEvent {
  final int keyCode;
  final int charCode;
  final EventTarget currentTarget;

  KeyEvent(
    String type, {
    Window view,
    bool canBubble: true,
    bool cancelable: true,
    this.keyCode: 0,
    this.charCode: 0,
    int keyLocation: 1,
    bool ctrlKey: false,
    bool altKey: false,
    bool shiftKey: false,
    bool metaKey: false,
    this.currentTarget,
  }) : super(
          type,
          view: view,
          canBubble: canBubble,
          cancelable: cancelable,
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

  MessageEvent(
    String type, {
    this.data,
    this.origin,
    this.lastEventId,
    this.source,
  }) : super.constructor(type);
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
      this.detail: 0,
      this.clientX: 0,
      this.clientY: 0,
      this.button: 0,
      this.canBubble: true,
      this.cancelable: true,
      this.ctrlKey: false,
      this.altKey: false,
      this.shiftKey: false,
      this.metaKey: false,
      this.relatedTarget})
      : super(type);
}

class PopStateEvent extends Event {
  final Object state;

  PopStateEvent({this.state}) : super.constructor("popstate");
}

class ProgressEvent extends Event {
  ProgressEvent() : super.constructor("progress");
}

abstract class SecurityPolicyViolationEvent implements Event {
  String get blockedUri;

  int get columnNumber;

  String get disposition;

  String get documentUri;

  String get effectiveDirective;

  int get lineNumber;

  String get originalPolicy;

  String get referrer;

  String get sample;

  String get sourceFile;

  int get statusCode;

  String get violatedDirective;
}

class Touch {
  static bool get supported => true;
  final int radiusX;
  final int radiusY;

  Touch({this.radiusX, this.radiusY});
}

class TouchEvent extends UIEvent {
  static bool get supported => true;

  TouchEvent(
    List<Touch> touches,
    List<Touch> targetTouches,
    List<Touch> changedTouches,
    String type, {
    Window view,
    int screenX: 0,
    int screenY: 0,
    int clientX: 0,
    int clientY: 0,
    bool ctrlKey: false,
    bool altKey: false,
    bool shiftKey: false,
    bool metaKey: false,
  }) : super("touch") {}
}

abstract class UIEvent extends Event {
  UIEvent(String type) : super.constructor(type);

  int get detail => null;

  InputDeviceCapabilities get sourceCapabilities => null;
}
