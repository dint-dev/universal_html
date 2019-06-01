part of universal_html;

Window get window => HtmlDriver.current.window;

typedef FrameRequestCallback = void Function(num highResTime);

typedef IdleRequestCallback = void Function(IdleDeadline deadline);

abstract class CustomElementRegistry {
  void define(String name, Object constructor, [Map options]);

  Object get(String name);

  Future whenDefined(String name);
}

class IdleDeadline {
  final DateTime _deadline;

  IdleDeadline._(this._deadline);

  bool get didTimeout => DateTime.now().isAfter(_deadline);

  double get timeRemaining {
    final now = DateTime.now();
    if (now.isAfter(_deadline)) {
      return 0.0;
    }
    return _deadline.difference(now).inMicroseconds / 1e6;
  }
}

abstract class Selection {
  Node get anchorNode;

  int get anchorOffset;

  int get baseOffset;

  Node get baserNode;

  Node get extentNode;

  int get extentOffset;

  Node get focusNode;

  int get focusOffset;
}

class Window extends EventTarget with WindowBase {
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>("message");

  static const EventStreamProvider<PopStateEvent> popStateEvent =
      EventStreamProvider<PopStateEvent>("popstate");

  Navigator _navigator;

  Storage _localStorage;

  Storage _sessionStorage;

  Console _console;

  Location _location;

  History _history;

  bool _closed = false;

  Performance _performance;

  /// IMPORTANT: Not part 'dart:html'.
  Window.internal();

  Future<num> get animationFrame {
    final completer = Completer<num>.sync();
    requestAnimationFrame((num value) {
      completer.complete(value);
    });
    return completer.future;
  }

  ApplicationCache get applicationCache => null;

  bool get closed => _closed;

  Console get console => _console ?? (_console = Console._());

  CustomElementRegistry get customElements => null;

  num get devicePixelRatio => 1;

  History get history => _history ?? (_history = History._());

  int get innerHeight => 1;

  int get innerWidth => 1;

  Storage get localStorage => _localStorage ?? (_localStorage = Storage._());

  Location get location => _location ?? (_location = Location._());

  Navigator get navigator => _navigator ?? (_navigator = Navigator._());

  Stream<MessageEvent> get onMessage => Window.messageEvent.forTarget(this);

  Stream<PopStateEvent> get onPopState => Window.popStateEvent.forTarget(this);

  int get orientation => 0;

  Performance get performance =>
      this._performance ?? (this._performance = Performance._());

  Storage get sessionStorage =>
      _sessionStorage ?? (_sessionStorage = Storage._());

  void alert([String message]) {}

  void close() {
    _closed = true;
  }

  void confirm([String message]) {
    throw UnimplementedError();
  }

  Selection getSelection() {
    return null;
  }

  void postMessage(dynamic message, String targetOrigin,
      [List<Object> transfer]) {
    throw UnimplementedError();
  }

  void requestAnimationFrame(FrameRequestCallback callback) {
    throw UnimplementedError();
  }

  Future<FileSystem> requestFileSystem(int size, {bool persistent = false}) {
    throw UnimplementedError();
  }

  int requestIdleCallback(IdleRequestCallback callback, [Map options]) {
    Timer(const Duration(microseconds: 1), () {
      final idleDeadline =
          IdleDeadline._(DateTime.now().add(const Duration(microseconds: 10)));
      callback(idleDeadline);
    });
    return 0;
  }

  void scroll([dynamic options_OR_x, dynamic y, Map scrollOptions]) {}

  void scrollBy([dynamic options_OR_x, dynamic y, Map scrollOptions]) {}

  void scrollTo([dynamic options_OR_x, dynamic y, Map scrollOptions]) {}
}

abstract class WindowBase {
  bool get closed;

  History get history;

  Location get location;

  WindowBase get opener => null;

  WindowBase get parent => null;

  WindowBase get top => null;

  void close();

  void postMessage(dynamic message, String targetOrigin,
      [List<Object> transfer]);
}
