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

part of universal_html.internal;

class ScrollAlignment {
  static const ScrollAlignment BOTTOM = ScrollAlignment._('BOTTOM');
  static const ScrollAlignment CENTER = ScrollAlignment._('CENTER');
  static const ScrollAlignment TOP = ScrollAlignment._('TOP');
  final String _name;

  const ScrollAlignment._(this._name);

  @override
  String toString() => _name;
}

class _ElementChildren extends ListBase<Element> {
  final _ElementOrDocument _element;

  _ElementChildren(this._element);

  @override
  Iterator<Element> get iterator {
    return _ElementIterator(_element);
  }

  @override
  int get length {
    var node = _element.firstChild;
    var length = 0;
    while (node != null) {
      if (node is Element) {
        length++;
      }
      node = node.nextNode;
    }
    return length;
  }

  @override
  set length(int newLength) {
    final element = _element;
    if (newLength == 0) {
      while (true) {
        final first = element._firstElementChild;
        if (first == null) {
          break;
        }
        first.remove();
      }
    } else {
      final lastChild = this[newLength - 1];
      while (true) {
        final last = lastChild.nextElementSibling;
        if (last == null) {
          break;
        }
        last.remove();
      }
    }
  }

  @override
  Element operator [](int index) {
    var node = _element.firstChild;
    while (node != null) {
      if (node is Element) {
        if (index == 0) {
          return node;
        }
        index--;
      }
      node = node.nextNode;
    }
    throw ArgumentError.value(index);
  }

  @override
  operator []=(int index, Element child) {
    this[index].replaceWith(child);
  }
}

class _ElementIterator extends Iterator<Element> {
  final _ElementOrDocument _parent;
  Element? _current;

  _ElementIterator(this._parent);

  @override
  Element get current => _current!;

  @override
  bool moveNext() {
    final current = _current;
    if (current == null) {
      final first = _parent._firstElementChild;
      _current = first;
      return first != null;
    }
    if (!identical(_parent, current.parent)) {
      // TODO: Implementation that handles modifications like 'dart:html' does.
      throw StateError('DOM tree was modified during iteration');
    }
    final next = current.nextElementSibling;
    if (next == null) {
      return false;
    }
    _current = next;
    return true;
  }
}
