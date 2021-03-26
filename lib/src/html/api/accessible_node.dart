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

class AccessibleNode extends EventTarget {
  static const EventStreamProvider<Event> accessibleClickEvent =
      EventStreamProvider<Event>('accessibleclick');

  static const EventStreamProvider<Event> accessibleContextMenuEvent =
      EventStreamProvider<Event>('accessiblecontextmenu');

  static const EventStreamProvider<Event> accessibleDecrementEvent =
      EventStreamProvider<Event>('accessibledecrement');

  static const EventStreamProvider<Event> accessibleFocusEvent =
      EventStreamProvider<Event>('accessiblefocus');

  static const EventStreamProvider<Event> accessibleIncrementEvent =
      EventStreamProvider<Event>('accessibleincrement');

  static const EventStreamProvider<Event> accessibleScrollIntoViewEvent =
      EventStreamProvider<Event>('accessiblescrollintoview');

  AccessibleNode? activeDescendant;

  bool? atomic;

  String? autocomplete;

  bool? busy;

  String? checked;

  int? colCount;

  int? colIndex;

  int? colSpan;

  AccessibleNodeList? controls;

  String? current;

  AccessibleNodeList? describedBy;

  AccessibleNode? details;

  bool? disabled;

  AccessibleNode? errorMessage;

  bool? expanded;

  AccessibleNodeList? flowTo;

  String? hasPopUp;

  bool? hidden;

  String? invalid;

  String? keyShortcuts;

  String? label;

  AccessibleNodeList? labeledBy;

  int? level;

  String? live;

  bool? modal;

  bool? multiline;

  bool? multiselectable;

  String? orientation;

  AccessibleNodeList? owns;

  String? placeholder;

  int? posInSet;

  String? pressed;

  bool? readOnly;

  String? relevant;

  bool? required;

  String? role;

  String? roleDescription;

  int? rowCount;

  int? rowIndex;

  int? rowSpan;

  bool? selected;

  int? setSize;

  String? sort;

  num? valueMax;

  num? valueMin;

  num? valueNow;

  String? valueText;

  AccessibleNode() : super.internal();

  Stream<Event> get onAccessibleClick => accessibleClickEvent.forTarget(this);

  Stream<Event> get onAccessibleContextMenu =>
      accessibleContextMenuEvent.forTarget(this);

  Stream<Event> get onAccessibleDecrement =>
      accessibleDecrementEvent.forTarget(this);

  Stream<Event> get onAccessibleFocus => accessibleFocusEvent.forTarget(this);

  Stream<Event> get onAccessibleIncrement =>
      accessibleIncrementEvent.forTarget(this);

  Stream<Event> get onAccessibleScrollIntoView =>
      accessibleScrollIntoViewEvent.forTarget(this);

  void appendChild(AccessibleNode child) {}
}

abstract class AccessibleNodeList {
  factory AccessibleNodeList([List<AccessibleNode>? nodes]) {
    throw UnimplementedError();
  }

  int get length;

  void add(AccessibleNode node, AccessibleNode before) {
    throw UnimplementedError();
  }

  AccessibleNode item(int index) {
    throw UnimplementedError();
  }

  void remove(int index) {
    throw UnimplementedError();
  }
}
