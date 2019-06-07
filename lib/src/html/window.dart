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

  final HtmlDriver _driver;

  Navigator _navigator;

  Storage _localStorage;

  Storage _sessionStorage;

  Console _console;

  Location _location;

  History _history;

  bool _closed = false;

  Performance _performance;

  /// IMPORTANT: Not part 'dart:html'.
  Window.internal(this._driver);

  Future<num> get animationFrame {
    final completer = Completer<num>.sync();
    requestAnimationFrame((num value) {
      completer.complete(value);
    });
    return completer.future;
  }

  ApplicationCache _applicationCache;

  ApplicationCache get applicationCache =>
      _applicationCache ?? (_applicationCache = _driver.newApplicationCache());

  bool get closed => _closed;

  Console get console => _console ?? (_console = _driver.newConsole());

  CustomElementRegistry get customElements => null;

  num get devicePixelRatio => 1;

  History get history => _history ?? (_history = _driver.newHistory());

  int get innerHeight => 1;

  int get innerWidth => 1;

  Storage get localStorage =>
      _localStorage ?? (_localStorage = _driver.newStorage());

  Location get location => _location ?? (_location = _driver.newLocation());

  Navigator get navigator =>
      _navigator ?? (_navigator = _driver.newNavigator());

  Stream<MessageEvent> get onMessage => Window.messageEvent.forTarget(this);

  Stream<PopStateEvent> get onPopState => Window.popStateEvent.forTarget(this);

  int get orientation => 0;

  Performance get performance =>
      this._performance ?? (this._performance = Performance._());

  Storage get sessionStorage =>
      _sessionStorage ??
      (_sessionStorage = _driver.newStorage(sessionStorage: true));

  void alert([String message]) {
    // Ignore
  }

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

  void scroll([dynamic options_OR_x, dynamic y, Map scrollOptions]) {
    // Ignore
  }

  void scrollBy([dynamic options_OR_x, dynamic y, Map scrollOptions]) {
    // Ignore
  }

  void scrollTo([dynamic options_OR_x, dynamic y, Map scrollOptions]) {
    // Ignore
  }
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
