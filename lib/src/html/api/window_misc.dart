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

typedef FrameRequestCallback = void Function(num highResTime);

typedef IdleRequestCallback = void Function(IdleDeadline deadline);

class BarProp {
  BarProp._();
}

class CacheStorage {
  factory CacheStorage._() {
    throw UnimplementedError();
  }

  Future delete(String cacheName) => throw UnimplementedError();

  Future has(String cacheName) => throw UnimplementedError();

  Future keys() => throw UnimplementedError();

  Future match(/*RequestInfo*/ request, [Map? options]) {
    throw UnimplementedError();
  }

  Future open(String cacheName) => throw UnimplementedError();
}

class CookieStore {
  factory CookieStore._() {
    throw UnimplementedError();
  }

  Future getAll([Map? options]) {
    throw UnimplementedError();
  }

  Future set(String name, String value, [Map? options]) {
    throw UnimplementedError();
  }
}

abstract class CustomElementRegistry {
  CustomElementRegistry._();

  void define(String name, Object constructor, [Map options]);

  Object get(String name);

  Future whenDefined(String name);
}

class External {
  External.internal();

  void AddSearchProvider() {
    throw UnimplementedError();
  }

  void IsSearchProviderInstalled() {
    throw UnimplementedError();
  }
}

class IdleDeadline {
  final DateTime _deadline;

  IdleDeadline._(this._deadline);

  bool get didTimeout => DateTime.now().isAfter(_deadline);

  double timeRemaining() {
    final now = DateTime.now();
    if (now.isAfter(_deadline)) {
      return 0.0;
    }
    return _deadline.difference(now).inMicroseconds / 1e6;
  }
}

abstract class MediaQueryList extends EventTarget {
  static const EventStreamProvider<Event> changeEvent =
      EventStreamProvider<Event>('change');

  factory MediaQueryList._() {
    throw UnimplementedError();
  }

  bool get matches;

  String get media;

  Stream<Event> get onChange => changeEvent.forTarget(this);

  void addListener(EventListener listener) {
    throw UnimplementedError();
  }

  void removeListener(EventListener listener) {
    throw UnimplementedError();
  }
}

class Screen {
  final int colorDepth;

  final int height;

  bool keepAwake;

  final ScreenOrientation orientation = ScreenOrientation.constructor();

  final int width;

  Screen.constructor({
    this.colorDepth = 24,
    this.height = 800,
    this.keepAwake = false,
    this.width = 600,
  });

  Rectangle get available => Rectangle(0, 0, 0, 0);

  int get pixelDepth => 24;
}

class ScreenOrientation extends EventTarget {
  static const EventStreamProvider<Event> changeEvent =
      EventStreamProvider<Event>('change');

  final int angle;

  final String type;

  ScreenOrientation.constructor({this.angle = 1, this.type = 'vertical'})
      : super.internal();

  Stream<Event> get onChange => changeEvent.forTarget(this);

  Future lock(String orientation) {
    throw UnimplementedError();
  }

  void unlock() {
    throw UnimplementedError();
  }
}

abstract class Selection {
  final Node? anchorNode;

  final int? anchorOffset;

  final Node? baseNode;

  final int? baseOffset;

  final Node? extentNode;

  final int? extentOffset;

  final Node? focusNode;

  final int? focusOffset;

  final bool? isCollapsed;

  final int? rangeCount;

  final String? type;

  Selection.constructor({
    this.anchorNode,
    this.anchorOffset,
    this.baseNode,
    this.baseOffset,
    this.extentNode,
    this.extentOffset,
    this.focusNode,
    this.focusOffset,
    this.isCollapsed,
    this.rangeCount,
    this.type,
  });

  void addRange(Range range) {
    throw UnimplementedError();
  }

  void collapse(Node node, [int? offset]) {
    throw UnimplementedError();
  }

  void collapseToEnd() {
    throw UnimplementedError();
  }

  void collapseToStart() {
    throw UnimplementedError();
  }

  bool containsNode(Node node, [bool? allowPartialContainment]) {
    throw UnimplementedError();
  }

  void deleteFromDocument() {
    throw UnimplementedError();
  }

  void empty() {
    throw UnimplementedError();
  }

  void extend(Node node, [int? offset]) {
    throw UnimplementedError();
  }

  Range getRangeAt(int index) {
    throw UnimplementedError();
  }

  void modify(String alter, String direction, String granularity) {
    throw UnimplementedError();
  }

  void removeAllRanges() {
    throw UnimplementedError();
  }

  void removeRange(Range range) {
    throw UnimplementedError();
  }

  void selectAllChildren(Node node) {
    throw UnimplementedError();
  }

  void setBaseAndExtent(
      Node baseNode, int baseOffset, Node extentNode, int extentOffset) {
    throw UnimplementedError();
  }

  void setPosition(Node node, [int? offset]) {
    throw UnimplementedError();
  }
}

class StyleMedia {
  StyleMedia._();

  String get type => throw UnimplementedError();

  bool matchMedium(String mediaquery) {
    throw UnimplementedError();
  }
}

abstract class VisualViewport implements EventTarget {
  static const EventStreamProvider<Event> resizeEvent =
      EventStreamProvider<Event>('resize');

  static const EventStreamProvider<Event> scrollEvent =
      EventStreamProvider<Event>('scroll');

  VisualViewport._();

  num get height;

  num get offsetLeft;

  num get offsetTop;

  Stream<Event> get onResize => resizeEvent.forTarget(this);

  Stream<Event> get onScroll => scrollEvent.forTarget(this);

  num get pageLeft;

  num get pageTop;

  num get scale;

  num get width;
}

abstract class Worklet {}
