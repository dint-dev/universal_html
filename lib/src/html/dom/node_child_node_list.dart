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

/// Lazy implementation of the child nodes of an element that does not request
/// the actual child nodes of an element until strictly necessary greatly
/// improving performance for the typical cases where it is not required.
class _ChildNodeListLazy extends ListBase<Node> {
  final Node _this;

  _ChildNodeListLazy(this._this);

  @override
  Node get first {
    final result = _this.firstChild;
    if (result == null) throw StateError('No elements');
    return result;
  }

  @override
  Iterator<Node> get iterator => _ChildNodeIterator(_this);

  @override
  Node get last {
    var result = _this.lastChild;
    if (result == null) throw StateError('No elements');
    return result;
  }

  @override
  int get length {
    var result = 0;
    var node = _this.firstChild;
    while (node != null) {
      result++;
      node = node.nextNode;
    }
    return result;
  }

  @override
  set length(int value) {
    throw UnsupportedError('Cannot set length on immutable List.');
  }

  List<Node> get rawList => _this.childNodes;

  @override
  Node get single {
    final result = _this.firstChild;
    if (result == null) throw StateError('No elements');
    if (result.nextNode != null) throw StateError('More than one element');
    return result;
  }

  @override
  Node operator [](int index) {
    var node = _this.firstChild;
    while (node != null) {
      if (0 == index) {
        return node;
      }
      index--;
      node = node.nextNode;
    }
    throw StateError('Index out of bounds');
  }

  @override
  void operator []=(int index, Node value) {
    this[index].replaceWith(value);
  }

  @override
  void add(Node value) {
    _this.append(value);
  }

  @override
  void addAll(Iterable<Node> iterable) {
    if (iterable is _ChildNodeListLazy) {
      final otherList = iterable;
      if (!identical(otherList._this, _this)) {
        // Optimized route for copying between nodes.
        for (var i = 0, len = otherList.length; i < len; ++i) {
          _this.append(otherList._this.firstChild!);
        }
      }
      return;
    }
    for (var node in iterable) {
      _this.append(node);
    }
  }

  @override
  void clear() {
    _this._clearChildren();
  }

  @override
  void fillRange(int start, int end, [Node? fill]) {
    throw UnsupportedError('Cannot fillRange on Node list');
  }

  @override
  void insert(int index, Node node) {
    if (index < 0 || index > length) {
      throw RangeError.range(index, 0, length);
    }
    if (index == length) {
      _this.append(node);
    } else {
      _this.insertBefore(node, this[index]);
    }
  }

  @override
  void insertAll(int index, Iterable<Node> iterable) {
    if (index == length) {
      addAll(iterable);
    } else {
      var item = this[index];
      _this.insertAllBefore(iterable, item);
    }
  }

  @override
  bool remove(Object? object) {
    if (object is Node) {
      if (!identical(_this, object.parentNode)) return false;
      _this._removeChild(object);
      return true;
    }
    return false;
  }

  @override
  Node removeAt(int index) {
    var result = this[index];
    _this._removeChild(result);
    return result;
  }

  @override
  Node removeLast() {
    final result = last;
    _this._removeChild(result);
    return result;
  }

  @override
  void removeRange(int start, int end) {
    throw UnsupportedError('Cannot removeRange on Node list');
  }

  @override
  void removeWhere(bool Function(Node node) test) {
    _filter(test, true);
  }

  @override
  void retainWhere(bool Function(Node node) test) {
    _filter(test, false);
  }

  @override
  void setAll(int index, Iterable<Node> iterable) {
    throw UnsupportedError('Cannot setAll on Node list');
  }

  @override
  void setRange(int start, int end, Iterable<Node> iterable,
      [int skipCount = 0]) {
    throw UnsupportedError('Cannot setRange on Node list');
  }

  @override
  void shuffle([Random? random]) {
    throw UnsupportedError('Cannot shuffle Node list');
  }

  @override
  void sort([Comparator<Node>? compare]) {
    throw UnsupportedError('Cannot sort Node list');
  }

  void _filter(bool Function(Node node) test, bool removeMatching) {
    // This implementation of removeWhere/retainWhere is more efficient
    // than the default in ListBase. Child nodes can be removed in constant
    // time.
    var child = _this.firstChild;
    while (child != null) {
      final nextChild = child.nextNode;
      if (test(child) == removeMatching) {
        _this._removeChild(child);
      }
      child = nextChild;
    }
  }
}
