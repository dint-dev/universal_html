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

import 'dart:html';
import 'dart:indexed_db';

import 'window_controller.dart';

Document newDocument({
  required Window window,
  required String contentType,
  required bool filled,
}) {
  return DomParser().parseFromString('<html></html>', contentType);
}

HtmlDocument newHtmlDocument({
  required Window window,
  String? contentType,
}) {
  return DomParser().parseFromString(
      '<html></html>', contentType ?? 'text/html') as HtmlDocument;
}

Navigator newNavigator({
  required Window window,
}) {
  throw UnsupportedError(
    'Constructing a new navigator is unsupported in browser',
  );
}

Window newWindow({
  required WindowController windowController,
}) {
  return _FakeWindow();
}

/// A fake window that only implements [document].
class _FakeWindow implements Window {
  @override
  String? defaultStatus;

  @override
  String? defaultstatus;

  @override
  String? name;

  @override
  WindowBase? opener;

  @override
  String? status;

  @override
  late final Document document = newHtmlDocument(window: this);

  @override
  // TODO: implement animationFrame
  Future<num> get animationFrame => throw UnimplementedError();

  @override
  // TODO: implement animationWorklet
  Never get animationWorklet => throw UnimplementedError();

  @override
  // TODO: implement applicationCache
  ApplicationCache? get applicationCache => throw UnimplementedError();

  @override
  // TODO: implement audioWorklet
  Never get audioWorklet => throw UnimplementedError();

  @override
  // TODO: implement caches
  CacheStorage? get caches => throw UnimplementedError();

  @override
  // TODO: implement closed
  bool? get closed => throw UnimplementedError();

  @override
  // TODO: implement console
  Console get console => throw UnimplementedError();

  @override
  // TODO: implement cookieStore
  CookieStore? get cookieStore => throw UnimplementedError();

  @override
  // TODO: implement crypto
  Crypto? get crypto => throw UnimplementedError();

  @override
  // TODO: implement customElements
  CustomElementRegistry? get customElements => throw UnimplementedError();

  @override
  // TODO: implement devicePixelRatio
  num get devicePixelRatio => throw UnimplementedError();

  @override
  // TODO: implement external
  External? get external => throw UnimplementedError();

  @override
  // TODO: implement history
  History get history => throw UnimplementedError();

  @override
  // TODO: implement indexedDB
  IdbFactory? get indexedDB => throw UnimplementedError();

  @override
  // TODO: implement innerHeight
  int? get innerHeight => throw UnimplementedError();

  @override
  // TODO: implement innerWidth
  int? get innerWidth => throw UnimplementedError();

  @override
  // TODO: implement isSecureContext
  bool? get isSecureContext => throw UnimplementedError();

  @override
  // TODO: implement localStorage
  Storage get localStorage => throw UnimplementedError();

  @override
  Location get location {
    throw UnimplementedError();
  }

  @override
  set location(LocationBase location) {
    throw UnimplementedError();
  }

  @override
  // TODO: implement locationbar
  // ignore: deprecated_member_use
  BarProp? get locationbar => throw UnimplementedError();

  @override
  // TODO: implement menubar
  // ignore: deprecated_member_use
  BarProp? get menubar => throw UnimplementedError();

  @override
  // TODO: implement navigator
  Navigator get navigator => throw UnimplementedError();

  @override
  // TODO: implement offscreenBuffering
  bool? get offscreenBuffering => throw UnimplementedError();

  @override
  // TODO: implement on
  Events get on => throw UnimplementedError();

  @override
  // TODO: implement onAbort
  Stream<Event> get onAbort => throw UnimplementedError();

  @override
  // TODO: implement onAnimationEnd
  Stream<AnimationEvent> get onAnimationEnd => throw UnimplementedError();

  @override
  // TODO: implement onAnimationIteration
  Stream<AnimationEvent> get onAnimationIteration => throw UnimplementedError();

  @override
  // TODO: implement onAnimationStart
  Stream<AnimationEvent> get onAnimationStart => throw UnimplementedError();

  @override
  // TODO: implement onBeforeUnload
  Stream<Event> get onBeforeUnload => throw UnimplementedError();

  @override
  // TODO: implement onBlur
  Stream<Event> get onBlur => throw UnimplementedError();

  @override
  // TODO: implement onCanPlay
  Stream<Event> get onCanPlay => throw UnimplementedError();

  @override
  // TODO: implement onCanPlayThrough
  Stream<Event> get onCanPlayThrough => throw UnimplementedError();

  @override
  // TODO: implement onChange
  Stream<Event> get onChange => throw UnimplementedError();

  @override
  // TODO: implement onClick
  Stream<MouseEvent> get onClick => throw UnimplementedError();

  @override
  // TODO: implement onContentLoaded
  Stream<Event> get onContentLoaded => throw UnimplementedError();

  @override
  // TODO: implement onContextMenu
  Stream<MouseEvent> get onContextMenu => throw UnimplementedError();

  @override
  // TODO: implement onDeviceMotion
  Stream<DeviceMotionEvent> get onDeviceMotion => throw UnimplementedError();

  @override
  // TODO: implement onDeviceOrientation
  Stream<DeviceOrientationEvent> get onDeviceOrientation =>
      throw UnimplementedError();

  @override
  // TODO: implement onDoubleClick
  Stream<Event> get onDoubleClick => throw UnimplementedError();

  @override
  // TODO: implement onDrag
  Stream<MouseEvent> get onDrag => throw UnimplementedError();

  @override
  // TODO: implement onDragEnd
  Stream<MouseEvent> get onDragEnd => throw UnimplementedError();

  @override
  // TODO: implement onDragEnter
  Stream<MouseEvent> get onDragEnter => throw UnimplementedError();

  @override
  // TODO: implement onDragLeave
  Stream<MouseEvent> get onDragLeave => throw UnimplementedError();

  @override
  // TODO: implement onDragOver
  Stream<MouseEvent> get onDragOver => throw UnimplementedError();

  @override
  // TODO: implement onDragStart
  Stream<MouseEvent> get onDragStart => throw UnimplementedError();

  @override
  // TODO: implement onDrop
  Stream<MouseEvent> get onDrop => throw UnimplementedError();

  @override
  // TODO: implement onDurationChange
  Stream<Event> get onDurationChange => throw UnimplementedError();

  @override
  // TODO: implement onEmptied
  Stream<Event> get onEmptied => throw UnimplementedError();

  @override
  // TODO: implement onEnded
  Stream<Event> get onEnded => throw UnimplementedError();

  @override
  // TODO: implement onError
  Stream<Event> get onError => throw UnimplementedError();

  @override
  // TODO: implement onFocus
  Stream<Event> get onFocus => throw UnimplementedError();

  @override
  // TODO: implement onHashChange
  Stream<Event> get onHashChange => throw UnimplementedError();

  @override
  // TODO: implement onInput
  Stream<Event> get onInput => throw UnimplementedError();

  @override
  // TODO: implement onInvalid
  Stream<Event> get onInvalid => throw UnimplementedError();

  @override
  // TODO: implement onKeyDown
  Stream<KeyboardEvent> get onKeyDown => throw UnimplementedError();

  @override
  // TODO: implement onKeyPress
  Stream<KeyboardEvent> get onKeyPress => throw UnimplementedError();

  @override
  // TODO: implement onKeyUp
  Stream<KeyboardEvent> get onKeyUp => throw UnimplementedError();

  @override
  // TODO: implement onLoad
  Stream<Event> get onLoad => throw UnimplementedError();

  @override
  // TODO: implement onLoadedData
  Stream<Event> get onLoadedData => throw UnimplementedError();

  @override
  // TODO: implement onLoadedMetadata
  Stream<Event> get onLoadedMetadata => throw UnimplementedError();

  @override
  // TODO: implement onLoadStart
  Stream<Event> get onLoadStart => throw UnimplementedError();

  @override
  // TODO: implement onMessage
  Stream<MessageEvent> get onMessage => throw UnimplementedError();

  @override
  // TODO: implement onMouseDown
  Stream<MouseEvent> get onMouseDown => throw UnimplementedError();

  @override
  // TODO: implement onMouseEnter
  Stream<MouseEvent> get onMouseEnter => throw UnimplementedError();

  @override
  // TODO: implement onMouseLeave
  Stream<MouseEvent> get onMouseLeave => throw UnimplementedError();

  @override
  // TODO: implement onMouseMove
  Stream<MouseEvent> get onMouseMove => throw UnimplementedError();

  @override
  // TODO: implement onMouseOut
  Stream<MouseEvent> get onMouseOut => throw UnimplementedError();

  @override
  // TODO: implement onMouseOver
  Stream<MouseEvent> get onMouseOver => throw UnimplementedError();

  @override
  // TODO: implement onMouseUp
  Stream<MouseEvent> get onMouseUp => throw UnimplementedError();

  @override
  // TODO: implement onMouseWheel
  Stream<WheelEvent> get onMouseWheel => throw UnimplementedError();

  @override
  // TODO: implement onOffline
  Stream<Event> get onOffline => throw UnimplementedError();

  @override
  // TODO: implement onOnline
  Stream<Event> get onOnline => throw UnimplementedError();

  @override
  // TODO: implement onPageHide
  Stream<Event> get onPageHide => throw UnimplementedError();

  @override
  // TODO: implement onPageShow
  Stream<Event> get onPageShow => throw UnimplementedError();

  @override
  // TODO: implement onPause
  Stream<Event> get onPause => throw UnimplementedError();

  @override
  // TODO: implement onPlay
  Stream<Event> get onPlay => throw UnimplementedError();

  @override
  // TODO: implement onPlaying
  Stream<Event> get onPlaying => throw UnimplementedError();

  @override
  // TODO: implement onPopState
  Stream<PopStateEvent> get onPopState => throw UnimplementedError();

  @override
  // TODO: implement onProgress
  Stream<Event> get onProgress => throw UnimplementedError();

  @override
  // TODO: implement onRateChange
  Stream<Event> get onRateChange => throw UnimplementedError();

  @override
  // TODO: implement onReset
  Stream<Event> get onReset => throw UnimplementedError();

  @override
  // TODO: implement onResize
  Stream<Event> get onResize => throw UnimplementedError();

  @override
  // TODO: implement onScroll
  Stream<Event> get onScroll => throw UnimplementedError();

  @override
  // TODO: implement onSearch
  Stream<Event> get onSearch => throw UnimplementedError();

  @override
  // TODO: implement onSeeked
  Stream<Event> get onSeeked => throw UnimplementedError();

  @override
  // TODO: implement onSeeking
  Stream<Event> get onSeeking => throw UnimplementedError();

  @override
  // TODO: implement onSelect
  Stream<Event> get onSelect => throw UnimplementedError();

  @override
  // TODO: implement onStalled
  Stream<Event> get onStalled => throw UnimplementedError();

  @override
  // TODO: implement onStorage
  Stream<StorageEvent> get onStorage => throw UnimplementedError();

  @override
  // TODO: implement onSubmit
  Stream<Event> get onSubmit => throw UnimplementedError();

  @override
  // TODO: implement onSuspend
  Stream<Event> get onSuspend => throw UnimplementedError();

  @override
  // TODO: implement onTimeUpdate
  Stream<Event> get onTimeUpdate => throw UnimplementedError();

  @override
  // TODO: implement onTouchCancel
  Stream<TouchEvent> get onTouchCancel => throw UnimplementedError();

  @override
  // TODO: implement onTouchEnd
  Stream<TouchEvent> get onTouchEnd => throw UnimplementedError();

  @override
  // TODO: implement onTouchMove
  Stream<TouchEvent> get onTouchMove => throw UnimplementedError();

  @override
  // TODO: implement onTouchStart
  Stream<TouchEvent> get onTouchStart => throw UnimplementedError();

  @override
  // TODO: implement onTransitionEnd
  Stream<TransitionEvent> get onTransitionEnd => throw UnimplementedError();

  @override
  // TODO: implement onUnload
  Stream<Event> get onUnload => throw UnimplementedError();

  @override
  // TODO: implement onVolumeChange
  Stream<Event> get onVolumeChange => throw UnimplementedError();

  @override
  // TODO: implement onWaiting
  Stream<Event> get onWaiting => throw UnimplementedError();

  @override
  // TODO: implement onWheel
  Stream<WheelEvent> get onWheel => throw UnimplementedError();

  @override
  // TODO: implement orientation
  int? get orientation => throw UnimplementedError();

  @override
  // TODO: implement origin
  String? get origin => throw UnimplementedError();

  @override
  // TODO: implement outerHeight
  int get outerHeight => throw UnimplementedError();

  @override
  // TODO: implement outerWidth
  int get outerWidth => throw UnimplementedError();

  @override
  // TODO: implement pageXOffset
  int get pageXOffset => throw UnimplementedError();

  @override
  // TODO: implement pageYOffset
  int get pageYOffset => throw UnimplementedError();

  @override
  // TODO: implement parent
  WindowBase? get parent => throw UnimplementedError();

  @override
  // TODO: implement performance
  Performance get performance => throw UnimplementedError();

  @override
  // TODO: implement screen
  Screen? get screen => throw UnimplementedError();

  @override
  // TODO: implement screenLeft
  int? get screenLeft => throw UnimplementedError();

  @override
  // TODO: implement screenTop
  int? get screenTop => throw UnimplementedError();

  @override
  // TODO: implement screenX
  int? get screenX => throw UnimplementedError();

  @override
  // TODO: implement screenY
  int? get screenY => throw UnimplementedError();

  @override
  // TODO: implement scrollbars
  // ignore: deprecated_member_use
  BarProp? get scrollbars => throw UnimplementedError();

  @override
  // TODO: implement scrollX
  int get scrollX => throw UnimplementedError();

  @override
  // TODO: implement scrollY
  int get scrollY => throw UnimplementedError();

  @override
  // TODO: implement self
  WindowBase? get self => throw UnimplementedError();

  @override
  // TODO: implement sessionStorage
  Storage get sessionStorage => throw UnimplementedError();

  @override
  // TODO: implement speechSynthesis
  SpeechSynthesis? get speechSynthesis => throw UnimplementedError();

  @override
  // TODO: implement statusbar
  // ignore: deprecated_member_use
  BarProp? get statusbar => throw UnimplementedError();

  @override
  // TODO: implement styleMedia
  StyleMedia? get styleMedia => throw UnimplementedError();

  @override
  // TODO: implement toolbar
  // ignore: deprecated_member_use
  BarProp? get toolbar => throw UnimplementedError();

  @override
  // TODO: implement top
  WindowBase? get top => throw UnimplementedError();

  @override
  // TODO: implement visualViewport
  VisualViewport? get visualViewport => throw UnimplementedError();

  @override
  // TODO: implement window
  WindowBase? get window => throw UnimplementedError();

  @override
  void addEventListener(String type, listener, [bool? useCapture]) {
    // TODO: implement addEventListener
  }

  @override
  void alert([String? message]) {
    // TODO: implement alert
  }

  @override
  String atob(String atob) {
    // TODO: implement atob
    throw UnimplementedError();
  }

  @override
  String btoa(String btoa) {
    // TODO: implement btoa
    throw UnimplementedError();
  }

  @override
  void cancelAnimationFrame(int id) {
    // TODO: implement cancelAnimationFrame
  }

  @override
  void cancelIdleCallback(int handle) {
    // TODO: implement cancelIdleCallback
  }

  @override
  void close() {
    // TODO: implement close
  }

  @override
  bool confirm([String? message]) {
    // TODO: implement confirm
    throw UnimplementedError();
  }

  @override
  bool dispatchEvent(Event event) {
    // TODO: implement dispatchEvent
    throw UnimplementedError();
  }

  @override
  Future fetch(input, [Map? init]) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  bool find(String? string, bool? caseSensitive, bool? backwards, bool? wrap,
      bool? wholeWord, bool? searchInFrames, bool? showDialog) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  StylePropertyMapReadonly getComputedStyleMap(
      Element element, String? pseudoElement) {
    // TODO: implement getComputedStyleMap
    throw UnimplementedError();
  }

  @override
  List<CssRule> getMatchedCssRules(Element? element, String? pseudoElement) {
    // TODO: implement getMatchedCssRules
    throw UnimplementedError();
  }

  @override
  Selection? getSelection() {
    // TODO: implement getSelection
    throw UnimplementedError();
  }

  @override
  MediaQueryList matchMedia(String query) {
    // TODO: implement matchMedia
    throw UnimplementedError();
  }

  @override
  void moveBy(int x, int y) {
    // TODO: implement moveBy
  }

  @override
  void moveTo(Point<num> p) {
    // TODO: implement moveTo
  }

  @override
  WindowBase open(String url, String name, [String? options]) {
    // TODO: implement open
    throw UnimplementedError();
  }

  @override
  void postMessage(message, String targetOrigin, [List<Object>? transfer]) {
    // TODO: implement postMessage
  }

  @override
  void print() {
    // TODO: implement print
  }

  @override
  void removeEventListener(String type, listener, [bool? useCapture]) {
    // TODO: implement removeEventListener
  }

  @override
  int requestAnimationFrame(callback) {
    // TODO: implement requestAnimationFrame
    throw UnimplementedError();
  }

  @override
  Future<FileSystem> requestFileSystem(int size, {bool persistent = false}) {
    // TODO: implement requestFileSystem
    throw UnimplementedError();
  }

  @override
  int requestIdleCallback(callback, [Map? options]) {
    // TODO: implement requestIdleCallback
    throw UnimplementedError();
  }

  @override
  void resizeBy(int x, int y) {
    // TODO: implement resizeBy
  }

  @override
  void resizeTo(int x, int y) {
    // TODO: implement resizeTo
  }

  @override
  Future<Entry> resolveLocalFileSystemUrl(String url) {
    // TODO: implement resolveLocalFileSystemUrl
    throw UnimplementedError();
  }

  @override
  void scroll([options_OR_x, y, Map? scrollOptions]) {
    // TODO: implement scroll
  }

  @override
  void scrollBy([options_OR_x, y, Map? scrollOptions]) {
    // TODO: implement scrollBy
  }

  @override
  void scrollTo([options_OR_x, y, Map? scrollOptions]) {
    // TODO: implement scrollTo
  }

  @override
  void stop() {
    // TODO: implement stop
  }
}
