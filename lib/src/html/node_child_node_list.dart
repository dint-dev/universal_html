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

/// Lazy implementation of the child nodes of an element that does not request
/// the actual child nodes of an element until strictly necessary greatly
/// improving performance for the typical cases where it is not required.
class _ChildNodeListLazy extends ListBase<Node> {
  final Node _this;

  _ChildNodeListLazy(this._this);

  Node get first {
    Node result = _this.firstChild;
    if (result == null) throw StateError("No elements");
    return result;
  }

  Iterator<Node> get iterator => _ChildNodeIterator(_this);

  Node get last {
    Node result = _this.lastChild;
    if (result == null) throw StateError("No elements");
    return result;
  }

  int get length {
    int result = 0;
    Node node = _this.firstChild;
    while (node != null) {
      result++;
      node = node.nextNode;
    }
    return result;
  }

  set length(int value) {
    throw UnsupportedError("Cannot set length on immutable List.");
  }

  List<Node> get rawList => _this.childNodes;

  Node get single {
    Node result = _this.firstChild;
    if (result == null) throw StateError("No elements");
    if (result.nextNode != null) throw StateError("More than one element");
    return result;
  }

  Node operator [](int index) {
    Node node = _this.firstChild;
    while (node != null) {
      if (0 == index) {
        return node;
      }
      index--;
      node = node.nextNode;
    }
    throw StateError("Index out of bounds");
  }

  void operator []=(int index, Node value) {
    this[index].replaceWith(value);
  }

  void add(Node value) {
    _this.append(value);
  }

  void addAll(Iterable<Node> iterable) {
    if (iterable is _ChildNodeListLazy) {
      _ChildNodeListLazy otherList = iterable;
      if (!identical(otherList._this, _this)) {
        // Optimized route for copying between nodes.
        for (var i = 0, len = otherList.length; i < len; ++i) {
          _this.append(otherList._this.firstChild);
        }
      }
      return;
    }
    for (Node node in iterable) {
      _this.append(node);
    }
  }

  void clear() {
    _this._clearChildren();
  }

  void fillRange(int start, int end, [Node fill]) {
    throw UnsupportedError("Cannot fillRange on Node list");
  }

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

  void insertAll(int index, Iterable<Node> iterable) {
    if (index == length) {
      addAll(iterable);
    } else {
      var item = this[index];
      _this.insertAllBefore(iterable, item);
    }
  }

  bool remove(Object object) {
    if (object is! Node) return false;
    Node node = object;
    if (!identical(_this, node.parentNode)) return false;
    _this._removeChild(node);
    return true;
  }

  Node removeAt(int index) {
    var result = this[index];
    if (result != null) {
      _this._removeChild(result);
    }
    return result;
  }

  Node removeLast() {
    final result = last;
    if (result != null) {
      _this._removeChild(result);
    }
    return result;
  }

  void removeRange(int start, int end) {
    throw UnsupportedError("Cannot removeRange on Node list");
  }

  void removeWhere(bool test(Node node)) {
    _filter(test, true);
  }

  void retainWhere(bool test(Node node)) {
    _filter(test, false);
  }

  void setAll(int index, Iterable<Node> iterable) {
    throw UnsupportedError("Cannot setAll on Node list");
  }

  void setRange(int start, int end, Iterable<Node> iterable,
      [int skipCount = 0]) {
    throw UnsupportedError("Cannot setRange on Node list");
  }

  void shuffle([Random random]) {
    throw UnsupportedError("Cannot shuffle Node list");
  }

  void sort([Comparator<Node> compare]) {
    throw UnsupportedError("Cannot sort Node list");
  }

  void _filter(bool test(Node node), bool removeMatching) {
    // This implementation of removeWhere/retainWhere is more efficient
    // than the default in ListBase. Child nodes can be removed in constant
    // time.
    Node child = _this.firstChild;
    while (child != null) {
      Node nextChild = child.nextNode;
      if (test(child) == removeMatching) {
        _this._removeChild(child);
      }
      child = nextChild;
    }
  }
}
