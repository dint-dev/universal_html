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

abstract class CharacterData extends Node
    with _ChildNode, _NonDocumentTypeChildNode
    implements ChildNode, NonDocumentTypeChildNode {
  String _data = '';
  CharacterData._(Document ownerDocument, this._data) : super._(ownerDocument);
  String? get data => _data;

  set data(String? value) {
    _data = value ?? '';
  }

  int? get length => data?.length;

  @override
  Element? get nextElementSibling {
    var node = nextNode;
    while (true) {
      if (node == null) {
        return null;
      }
      if (node is Element) {
        return node;
      }
      node = node.nextNode;
    }
  }

  @override
  String? get nodeValue => data;

  @override
  Element? get previousElementSibling {
    var node = previousNode;
    while (true) {
      if (node == null) {
        return null;
      }
      if (node is Element) {
        return node;
      }
      node = node.previousNode;
    }
  }

  @override
  String? get text => nodeValue;

  @override
  set text(String? newValue) {
    data = newValue;
  }

  void appendData(String data) {
    final oldData = this.data ?? '';
    this.data = '$oldData$data';
  }

  void deleteData(int offset, int count) {
    final oldData = data ?? '';
    final a = oldData.substring(0, offset);
    final b = oldData.substring(offset + count);
    data = '$a$b';
  }

  void insertData(int offset, String data) {
    final oldData = this.data ?? '';
    final a = oldData.substring(0, offset);
    final b = oldData.substring(offset);
    this.data = '$a$data$b';
  }

  void replaceData(int offset, int count, String data) {
    final oldData = this.data ?? '';
    final a = oldData.substring(0, offset);
    final b = oldData.substring(offset + count);
    this.data = '$a$data$b';
  }

  String substringData(int offset, int count) {
    return (data ?? '').substring(offset, offset + count);
  }

  @override
  String toString() => nodeValue ?? '';
}

abstract class ChildNode {
  ChildNode._();
  void after(Object nodes);
  void before(Object nodes);
  void remove();
}

class Comment extends CharacterData {
  factory Comment([String? value]) {
    if (value != null && value.contains('-->')) {
      throw ArgumentError.value(value);
    }
    return Comment.internal(window.document, value ?? '');
  }

  Comment.internal(Document ownerDocument, String? value)
      : super._(ownerDocument, value ?? '');

  @override
  int get nodeType => Node.COMMENT_NODE;

  @visibleForTesting
  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool? deep) =>
      Comment.internal(ownerDocument, data ?? '');
}

/// Internal class. __Not part of dart:html__.
@protected
class InternalDocumentType extends Node {
  final String? _value;

  /// Internal constructor. __Not part of dart:html__.
  InternalDocumentType.internal(Document ownerDocument, this._value)
      : super._(ownerDocument);

  @override
  String get nodeName {
    final value = _value ?? 'null';
    final i = value.indexOf(' ');
    if (i < 0) {
      return value;
    }
    return value.substring(0, i);
  }

  @override
  int get nodeType => Node.DOCUMENT_TYPE_NODE;

  @override
  String? get text => null;

  @visibleForTesting
  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool? deep) =>
      InternalDocumentType.internal(ownerDocument, _value);
}

abstract class Node extends EventTarget {
  static const int ATTRIBUTE_NODE = 2;
  static const int CDATA_SECTION_NODE = 4;
  static const int COMMENT_NODE = 8;
  static const int DOCUMENT_FRAGMENT_NODE = 11;
  static const int DOCUMENT_NODE = 9;
  static const int DOCUMENT_TYPE_NODE = 10;
  static const int ELEMENT_NODE = 1;
  static const int ENTITY_NODE = 6;
  static const int ENTITY_REFERENCE_NODE = 5;
  static const int NOTATION_NODE = 12;
  static const int PROCESSING_INSTRUCTION_NODE = 7;
  static const int TEXT_NODE = 3;

  /// Document that owns this node.
  ///
  /// In [Document] nodes, the value is null. In all other nodes, the value
  /// is non-null.
  final Document? ownerDocument;

  /// Parent node.
  _ElementOrDocument? _parent;

  /// Next node (if this has a parent).
  Node? _nextNode;

  /// Previous node (if this has a parent).
  Node? _previousNode;

  /// Constructor for most subclasses.
  Node._(this.ownerDocument) : super.internal();

  /// Constructor used by [Document].
  Node._document()
      : ownerDocument = null,
        super.internal();

  String? get baseUri {
    return ownerDocument?.baseUri;
  }

  List<Node> get childNodes => _ChildNodeListLazy(this);

  Node? get firstChild => null;

  InternalElementData? get internalElementData => parent?.internalElementData;

  bool get isConnected => Node.DOCUMENT_NODE == getRootNode().nodeType;

  Node? get lastChild => null;

  Node? get nextNode => _nextNode;

  String? get nodeName => null;

  List<Node> get nodes => _ChildNodeListLazy(this);

  set nodes(List<Node> nodes) {
    _clearChildren();
    for (var node in nodes) {
      append(node);
    }
  }

  int get nodeType;

  String? get nodeValue => null;

  Element? get parent {
    final parent = _parent;
    if (parent is Element) {
      return parent;
    }
    return null;
  }

  Node? get parentNode => _parent;

  Node? get previousNode => _previousNode;

  String? get text {
    final sb = StringBuffer();
    _buildText(sb);
    return sb.toString();
  }

  set text(String? newValue) {
    _clearChildren();
    append(Text(newValue.toString()));
  }

  Element? get _firstElementChild {
    var node = firstChild;
    while (node != null) {
      if (node is Element) {
        return node;
      }
      node = node.nextNode;
    }
    return null;
  }

  /// Used by error messages.
  String get _nodeTypeName {
    switch (nodeType) {
      case ELEMENT_NODE:
        return 'element';
      case ATTRIBUTE_NODE:
        return 'attribute';
      case TEXT_NODE:
        return 'text';
      case CDATA_SECTION_NODE:
        return 'cdata';
      case ENTITY_REFERENCE_NODE:
        return 'entityreference';
      case ENTITY_NODE:
        return 'entity';
      case COMMENT_NODE:
        return 'comment';
      case DOCUMENT_NODE:
        return 'document';
      case DOCUMENT_TYPE_NODE:
        return 'documenttype';
      case DOCUMENT_FRAGMENT_NODE:
        return 'documentfragment';
      default:
        throw UnimplementedError();
    }
  }

  @override
  EventTarget? get _parentEventTarget => parent;

  Node append(Node node) {
    insertBefore(node, null);

    // DocumentFragment is handled differently, according to Mozilla
    if (node is DocumentFragment) {
      return DocumentFragment();
    }

    return node;
  }

  Node clone(bool? deep) {
    final clone = internalCloneWithOwnerDocument(ownerDocument!, deep ?? false);
    clone._parent = null;
    return clone;
  }

  bool contains(Node? node) {
    while (node != null) {
      node = node.parentNode;
      if (node == null) {
        return false;
      }
      if (identical(node, this)) {
        return true;
      }
    }
    return false;
  }

  Node getRootNode() {
    var current = this;
    while (true) {
      final parent = current.parentNode;
      if (parent == null) {
        return current;
      }
      current = parent;
    }
  }

  bool hasChildNodes() => firstChild != null;

  void insertAllBefore(Iterable<Node> nodes, Node? before) {
    throw DomException._invalidMethod('Node', 'insertAllBefore');
  }

  void insertBefore(Node node, Node? before) {
    throw DomException._invalidMethod('Node', 'insertBefore');
  }

  @visibleForTesting
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool deep);

  /// Internal method. __Not part of "dart:html".
  ///
  /// Produces string representation of DOM tree.
  String internalToString() {
    final sb = StringBuffer();
    _printNode(sb, _getPrintingFlags(this), this);
    return sb.toString();
  }

  void _removeFromTree(Node? replaceWith) {
    final parent = _parent;
    if (parent == null) {
      assert(_previousNode == null);
      assert(_nextNode == null);
      return;
    }

    // Get previous and next
    final previous = _previousNode;
    final next = _nextNode;

    if (previous == null) {
      // This was the first sibling
      parent._firstChild = replaceWith ?? next;
    } else {
      // Mutate the previous sibling
      previous._nextNode = replaceWith ?? next;
    }

    if (next == null) {
      // This was the last sibling
      parent._lastChild = replaceWith ?? previous;
    } else {
      // Mutate the next sibling
      next._previousNode = replaceWith ?? previous;
    }
    if (replaceWith != null) {
      // move replaceWith
      replaceWith._parent = parent;
      replaceWith._previousNode = previous;
      replaceWith._nextNode = next;
    }
    // Set fields of this node
    _parent = null;
    _previousNode = null;
    _nextNode = null;
  }

  void remove() {
    final parent = _parent;
    // Mark node as dirty
    _markDirty();
    _removeFromTree(null);
    parent?._mutated();
    _mutated();
  }

  void replaceWith(Node node) {
    // Mark nodes as dirty
    _markDirty();
    node._markDirty();
    node._removeFromTree(null);
    _removeFromTree(node);
    _mutated();
    node._mutated();
  }

  /// Used by [_ChildNodeListLazy].
  void _buildText(StringBuffer sb) {
    var current = firstChild;
    while (current != null) {
      current._buildText(sb);
      current = current.nextNode;
    }
  }

  void _clearChildren() {
    while (true) {
      final child = firstChild;
      if (child == null) {
        break;
      }
      child.remove();
    }
  }

  void _markDirty() {
    internalElementData?.beforeNonElementChildMutation();
  }

  /// Invoked when this is:
  ///   - Attached to a parent.
  ///   - Detached to a parent.
  ///   - Moved among siblings.
  ///   - A child is attached/detached.
  ///
  /// Main purpose is tracking style changes.
  void _mutated() {}

  /// Used by [_ChildNodeListLazy].
  void _removeChild(Node child) {
    child.remove();
  }

  /// Clones all siblings starting from the argument.
  static void _cloneChildrenFrom(
    Document ownerDocument, {
    required _ElementOrDocument newParent,
    required _ElementOrDocument oldParent,
  }) {
    Node? newChildPrevious;
    var oldChild = oldParent._firstChild;
    while (oldChild != null) {
      final newChild = oldChild.internalCloneWithOwnerDocument(
        ownerDocument,
        true,
      );
      newChild._parent = newParent;
      newChild._previousNode = newChildPrevious;
      if (newChildPrevious == null) {
        newParent._firstChild = newChild;
      } else {
        newChildPrevious._nextNode = newChild;
        newChild._previousNode = newChildPrevious;
      }
      newChildPrevious = newChild;
      oldChild = oldChild._nextNode;
    }
    newParent._lastChild = newChildPrevious;
  }
}

abstract class NonDocumentTypeChildNode {
  NonDocumentTypeChildNode._();
  Element? get nextElementSibling;
  Element? get previousElementSibling;
}

abstract class ParentNode {
  ParentNode._();
  Element? querySelector(String selectors);
}

class ProcessingInstruction extends CharacterData {
  final StyleSheet? sheet;
  final String? target;

  /// Internal constructor. __Not part of dart:html__.
  ProcessingInstruction.internal(Document ownerDocument,
      {this.sheet, this.target})
      : super._(ownerDocument, '');

  @override
  int get nodeType => Node.PROCESSING_INSTRUCTION_NODE;

  @visibleForTesting
  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool? deep) {
    return ProcessingInstruction.internal(
      ownerDocument,
      sheet: sheet,
      target: target,
    );
  }
}

class Range {}

class Text extends CharacterData {
  factory Text(String value) {
    return Text.internal(window.document, value);
  }

  /// Internal constructor. __Not part of dart:html__.
  Text.internal(Document ownerDocument, String value)
      : super._(ownerDocument, value);

  @override
  int get length => data!.length;

  @override
  int get nodeType => Node.TEXT_NODE;

  @visibleForTesting
  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool? deep) =>
      Text.internal(ownerDocument, data!);

  @override
  void _buildText(StringBuffer sb) {
    sb.write(data!);
  }
}

mixin _ChildNode implements ChildNode {
  @override
  void after(Object nodes) {}

  @override
  void before(Object nodes) {}

  @override
  void remove();
}

class _ChildNodeIterator extends Iterator<Node> {
  final Node _parent;
  Node? _current;

  _ChildNodeIterator(this._parent);

  @override
  Node get current {
    return _current!;
  }

  @override
  bool moveNext() {
    var current = _current;
    if (current == null) {
      var node = _parent.firstChild;
      if (node == null) {
        return false;
      }
      _current = node;
      return true;
    } else {
      if (!identical(current.parentNode, _parent)) {
        throw StateError('DOM tree was modified during iteration');
      }
      final next = current.nextNode;
      if (next == null) {
        return false;
      }
      _current = next;
      return true;
    }
  }
}

/// Mixin for [Element] and [Document].
mixin _ElementOrDocument implements Node, ParentNode {
  Node? _firstChild;
  Node? _lastChild;

  @override
  Node? get firstChild => _firstChild;

  @override
  Node? get lastChild => _lastChild;

  Iterable<Element> get _ancestors sync* {
    var ancestor = parent;
    while (ancestor != null) {
      yield (ancestor);
      ancestor = ancestor.parent;
    }
  }

  @override
  void insertAllBefore(Iterable<Node> nodes, Node? before) {
    var previous = before == null ? lastChild : before.previousNode;
    var isFirstIteration = true;
    for (var node in nodes) {
      if (isFirstIteration) {
        _markDirty();
        isFirstIteration = false;
      }
      if (node.parentNode != null) {
        node.remove();
      }
      if (previous == null) {
        _firstChild = node;
      } else {
        previous._nextNode = node;
      }
      node._parent = this;
      previous = node;
    }
    previous!._nextNode = before;
  }

  @override
  void insertBefore(Node node, Node? before) {
    // Can't add document
    if (node is Document) {
      throw ArgumentError.value(node, 'node');
    }

    // Can't add node into itself
    if (identical(node, this)) {
      throw ArgumentError.value(node, 'node');
    }

    // If 'before' is non-null, it must be a child
    if (before != null && !identical(before._parent, this)) {
      throw ArgumentError.value(before, 'before');
    }

    // Mark as dirty
    _markDirty();

    // Remove from old parent
    if (node.parentNode != null) {
      node.remove();
    }

    // Validate state
    if (node.parentNode != null ||
        node.previousNode != null && node.nextNode != null) {
      throw StateError('Node is not detached.');
    }

    node._parent = this;
    if (before == null) {
      final oldLastChild = _lastChild;
      if (oldLastChild == null) {
        _firstChild = node;
      } else {
        oldLastChild._nextNode = node;
      }
      node._previousNode = oldLastChild;
      _lastChild = node;
    } else {
      final previous = before._previousNode;
      if (previous == null) {
        // Set first sibling
        _firstChild = node;
      } else {
        previous._nextNode = node;
        node._previousNode = previous;
      }
      node._nextNode = before;
      before._previousNode = node;
    }

    // Validate state
    if (_firstChild == null || _lastChild == null || node.parentNode == null) {
      throw StateError('Node is not attached.');
    }
  }

  @override
  Element? querySelector(String selectors) {
    final all = querySelectorAll(selectors);
    if (all.isEmpty) return null;
    return all.first;
  }

  /// Finds all descendant elements of this document that match the specified
  /// group of selectors.
  ///
  /// Unless your webpage contains multiple documents, the top-level
  /// [querySelectorAll]
  /// method behaves the same as this method, so you should use it instead to
  /// save typing a few characters.
  ///
  /// [selectors] should be a string using CSS selector syntax.
  ///
  ///     var items = document.querySelectorAll('.itemClassName');
  ///
  /// For details about CSS selector syntax, see the
  /// [CSS selector specification](http://www.w3.org/TR/css3-selectors/).
  ElementList<T> querySelectorAll<T extends Element>(String input) {
    final selectorGroup = css.parseSelectorGroup(input);
    if (selectorGroup == null) {
      throw DomException._(
        DomException.SYNTAX,
        "Failed to execute 'querySelector' on 'Element': The provided selector is empty.",
      );
    }
    final result = <Element>[];
    _forEachElementInTree((element) {
      if (_matchesSelectorGroup(element, selectorGroup, null)) {
        result.add(element);
      }
    });
    return _FrozenElementList<T>._wrap(result);
  }

  /// Visits all nodes in the subtree (excludes this node).
  void _forEachElementInTree(void Function(Element element) f) {
    final firstChildOfRoot = firstChild;
    if (firstChildOfRoot == null) {
      return;
    }

    // A sanity check
    assert(identical(firstChildOfRoot.parentNode, this));
    assert(identical(firstChildOfRoot.parent, this) ||
        firstChildOfRoot.parent == null);

    var node = firstChildOfRoot;
    loop:
    while (true) {
      // Emit this element.
      if (node is Element) {
        f(node);
      }

      // Does this node have children?
      final firstChild = node.firstChild;
      if (firstChild != null) {
        // A sanity check
        assert(identical(firstChild.parentNode, node));

        // Go the first child.
        node = firstChild;
        continue loop;
      }

      while (true) {
        // Go to the next child.
        final nextNode = node.nextNode;
        if (nextNode != null) {
          // A sanity check
          assert(identical(nextNode.parentNode, node.parentNode));

          // Go to the next sibling.
          node = nextNode;
          break;
        }

        final parent = node.parentNode;
        if (parent == null) {
          throw StateError('DOM tree failed a sanity check.');
        }

        if (identical(parent, this)) {
          // No more nodes.
          return;
        }

        // Try next sibling of the parent.
        node = parent;
      }
    }
  }
}

/// For accessing underlying node lists, for dart:js interop.
abstract class _NodeListWrapper {
  List<Node> get rawList;
}

mixin _NonDocumentTypeChildNode implements Node, NonDocumentTypeChildNode {
  @override
  Element? get nextElementSibling {
    var node = nextNode;
    while (node != null) {
      if (Node.ELEMENT_NODE == node.nodeType) {
        return node as Element;
      }
      node = node.nextNode;
    }
    return null;
  }

  @override
  Element? get previousElementSibling {
    var node = previousNode;
    while (node != null) {
      if (Node.ELEMENT_NODE == node.nodeType) {
        return node as Element;
      }
      node = node.previousNode;
    }
    return null;
  }
}
