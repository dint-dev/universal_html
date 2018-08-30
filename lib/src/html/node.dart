part of universal_html;

abstract class CharacterData extends Node
    with ChildNode, NonDocumentTypeChildNode {
  final String nodeValue;

  CharacterData._(Document ownerDocument, this.nodeValue)
      : super._(ownerDocument);

  @override
  String toString() => nodeValue;
}

abstract class ChildNode implements Node {}

class Comment extends CharacterData {
  factory Comment(String value) {
    if (value.contains("-->")) {
      throw new ArgumentError();
    }
    return Comment._(null, value);
  }

  Comment._(Document ownerDocument, String value)
      : super._(ownerDocument, value);

  @override
  int get nodeType => Node.COMMENT_NODE;

  @override
  Node cloneWithOwnerDocument(Document ownerDocument, bool deep) =>
      Comment._(ownerDocument, nodeValue);
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

  final Document ownerDocument;
  _ElementOrDocument _parent;

  Node _nextNode;
  Node _previousNode;

  Node._(Document ownerDocument)
      : this.ownerDocument = ownerDocument ?? document;

  Node._document() : this.ownerDocument = null;

  List<Node> get childNodes => _ChildNodeListLazy(this);

  Node get firstChild => null;

  bool get isConnected => Node.DOCUMENT_NODE == getRootNode().nodeType;

  Node get lastChild => null;

  Node get nextNode => _nextNode;

  String get nodeName => null;

  int get nodeType;

  String get nodeValue => null;

  Element get parent {
    final parent = this._parent;
    if (parent is Element) {
      return parent;
    }
    return null;
  }

  Node get parentNode => this._parent;

  Node get previousNode => _previousNode;

  String get text {
    final sb = new StringBuffer();
    _buildText(sb);
    return sb.toString();
  }

  set text(String newValue) {
    _clearChildren();
    append(new Text(newValue));
  }

  Element get _firstElementChild {
    Node node = this.firstChild;
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
        return "element";
      case ATTRIBUTE_NODE:
        return "attribute";
      case TEXT_NODE:
        return "text";
      case CDATA_SECTION_NODE:
        return "cdata";
      case ENTITY_REFERENCE_NODE:
        return "entityreference";
      case ENTITY_NODE:
        return "entity";
      case COMMENT_NODE:
        return "comment";
      case DOCUMENT_NODE:
        return "document";
      case DOCUMENT_TYPE_NODE:
        return "documenttype";
      case DOCUMENT_FRAGMENT_NODE:
        return "documentfragment";
      default:
        throw new UnimplementedError();
    }
  }

  @override
  EventTarget get _parentEventTarget => this.parent;

  void append(Node node) {
    this.insertBefore(node, null);
  }

  Node clone(bool deep) {
    final clone = cloneWithOwnerDocument(this.ownerDocument, deep);
    clone._parent = null;
    return clone;
  }

  @visibleForTesting
  Node cloneWithOwnerDocument(Document ownerDocument, bool deep);

  bool contains(Node node) {
    while (true) {
      node = node.parentNode;
      if (node == null) {
        return false;
      }
      if (identical(node, this)) {
        return true;
      }
    }
  }

  Node getRootNode() {
    Node current = this;
    while (true) {
      final parent = current.parentNode;
      if (parent == null) {
        return current;
      }
      current = parent;
    }
  }

  bool hasChildNodes() => firstChild != null;

  void insertAllBefore(Iterable<Node> nodes, Node before) {
    throw DomException._invalidMethod("Node", "insertAllBefore");
  }

  void insertBefore(Node node, Node before) {
    throw DomException._invalidMethod("Node", "insertBefore");
  }

  void remove() {
    final parent = this._parent;
    if (parent == null) {
      throw _NodeMissingParent();
    }

    // Get previous and next
    final previous = this._previousNode;
    final next = this._nextNode;

    if (previous == null) {
      // This was the first sibling
      parent._firstChild = next;
    } else {
      // Mutate the previous sibling
      previous._nextNode = next;
    }

    if (next == null) {
      // This was the last sibling
      parent._lastChild = previous;
    } else {
      // Mutate the next sibling
      next._previousNode = previous;
    }

    // Set fields of this node
    this._parent = null;
    this._previousNode = null;
    this._nextNode = null;
    parent._mutated();
    this._mutated();
  }

  void replaceWith(Node node) {
    final parent = this._parent;
    if (parent == null) {
      throw _NodeMissingParent();
    }
    // Get previous and next
    final previous = this._previousNode;
    final next = this._nextNode;

    if (previous == null) {
      // This was the first sibling
      parent._firstChild = node;
    } else {
      // Mutate the previous sibling
      previous._nextNode = node;
    }

    if (next == null) {
      // This was the last sibling
      parent._lastChild = node;
    } else {
      // Mutate the next sibling
      next._previousNode = node;
    }

    node._parent = parent;
    node._previousNode = previous;
    node._nextNode = next;
    this._parent = null;
    this._previousNode = null;
    this._nextNode = null;
    this._mutated();
    node._mutated();
  }

  /// Used by [_ChildNodeListLazy].
  void _buildText(StringBuffer sb) {
    Node current = this.firstChild;
    while (current != null) {
      current._buildText(sb);
      current = current.nextNode;
    }
  }

  void _clearChildren() {
    Node child = this.firstChild;
    while (child != null) {
      child.remove();
    }
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
  static void _cloneChildrenFrom(Document ownerDocument,
      _ElementOrDocument newParent, _ElementOrDocument oldParent) {
    Node newPrevious;
    Node oldChild = oldParent._firstChild;
    while (oldChild != null) {
      final newChild = oldChild.cloneWithOwnerDocument(ownerDocument, true);
      newChild._parent = newParent;
      newChild._previousNode = newPrevious;
      if (newPrevious == null) {
        newParent._firstChild = newChild;
      } else {
        newPrevious._nextNode = newChild;
        newChild._previousNode = newPrevious;
      }
      newPrevious = newChild;
      oldChild = oldChild._nextNode;
    }
    newParent._lastChild = newPrevious;
  }
}

abstract class NonDocumentTypeChildNode implements Node {
  Element get nextElementSibling {
    Node node = this.nextNode;
    while (node != null) {
      if (Node.ELEMENT_NODE == node.nodeType) {
        return node as Element;
      }
      node = node.nextNode;
    }
    return null;
  }

  Element get previousElementSibling {
    Node node = this.previousNode;
    while (node != null) {
      if (Node.ELEMENT_NODE == node.nodeType) {
        return node as Element;
      }
      node = node.previousNode;
    }
    return null;
  }
}

abstract class ParentNode implements Node {
  Element querySelector(String selectors);
}

class Text extends CharacterData {
  factory Text(String value) {
    return new Text._(null, value);
  }

  Text._(Document ownerDocument, String value) : super._(ownerDocument, value);

  @override
  int get nodeType => Node.TEXT_NODE;

  @override
  String get text => nodeValue;

  @override
  Node cloneWithOwnerDocument(Document ownerDocument, bool deep) =>
      Text._(ownerDocument, nodeValue);

  @override
  void _buildText(StringBuffer sb) {
    sb.write(nodeValue);
  }
}

class _ChildNodeIterator extends Iterator<Node> {
  final Node _parent;
  Node _current;

  _ChildNodeIterator(this._parent);

  @override
  Node get current => _current;

  @override
  bool moveNext() {
    Node current = this._current;
    if (current == null) {
      Node node = _parent.firstChild;
      if (node == null) {
        return false;
      }
      this._current = node;
      return true;
    } else {
      if (!identical(current.parentNode, _parent)) {
        throw new StateError("DOM tree was modified during iteration");
      }
      final next = current.nextNode;
      if (next == null) {
        return false;
      }
      this._current = next;
      return true;
    }
  }
}

class _DocumentType extends Node {
  final String _value;

  _DocumentType(Document ownerDocument, this._value) : super._(ownerDocument);

  @override
  String get nodeName => _value;

  @override
  int get nodeType => Node.DOCUMENT_TYPE_NODE;

  @override
  Node cloneWithOwnerDocument(Document ownerDocument, bool deep) =>
      new _DocumentType(ownerDocument, this._value);
}

/// Mixin for [Element] and [Document].
abstract class _ElementOrDocument implements Node, ParentNode {
  Node _firstChild;
  Node _lastChild;

  @override
  Node get firstChild => _firstChild;

  Node get lastChild => _lastChild;

  @override
  void insertAllBefore(Iterable<Node> nodes, Node before) {
    Node previous = before == null ? this.lastChild : before.previousNode;
    for (var node in nodes) {
      if (node.parentNode != null) {
        node.remove();
      }
      if (previous == null) {
        this._firstChild = node;
      } else {
        previous._nextNode = node;
      }
      node._parent = this;
      previous = node;
    }
    previous._nextNode = before;
  }

  @override
  void insertBefore(Node node, Node before) {
    if (node is Document) {
      throw new ArgumentError.value(node);
    }
    final thisOwnerDocument = this.ownerDocument;
    if (before != null && !identical(before._parent, this)) {
      throw new ArgumentError.value(before, "before");
    }

    // Remove from old parent
    if (node.parentNode != null) {
      node.remove();
    }

    if (before == null) {
      final oldLastChild = this._lastChild;
      if (oldLastChild == null) {
        // Set first sibling
        this._firstChild = node;
      } else {
        // Set next sibling of the previous sibling
        oldLastChild._nextNode = node;

        // Set previous sibling
        node._previousNode = oldLastChild;
      }

      // Set last sibling
      this._lastChild = node;
    } else {
      final previous = before._previousNode;
      if (previous == null) {
        // Set first sibling
        this._firstChild = node;

        // Set previous sibling
        node._previousNode = node;
      } else {
        // Set next sibling of the previous sibling
        previous._nextNode = node;

        // Set previous sibling
        node._previousNode = node;
      }

      // Set next node
      node._nextNode = node;

      // Set previous node of the next node
      before._previousNode = node;
    }

    // Set parent
    node._parent = this;
  }

  Element querySelector(String selectors) {
    final all = querySelectorAll(selectors);
    if (all.isEmpty) return null;
    return all.first;
  }

  List<Element> querySelectorAll<T extends Element>(String input) {
    if (input == null) {
      throw new ArgumentError.notNull(input);
    }
    final selectorGroup = css.parseSelectorGroup(input);
    final result = <Element>[];
    this._forEachTreeElement((element) {
      if (element._matchesSelectorGroup(selectorGroup, null)) {
        result.add(element);
      }
    });
    return result;
  }

  void _forEachTreeElement(void f(Element element)) {
    Node node = this.firstChild;
    if (node == null) {
      return;
    }
    loop:
    while (true) {
      if (node is Element) {
        f(node);
      }
      final firstChild = node.firstChild;
      if (firstChild != null) {
        node = firstChild;
        continue loop;
      }
      while (true) {
        final nextNode = node.nextNode;
        if (nextNode != null) {
          node = nextNode;
          continue loop;
        }
        node = node.parentNode;
        if (identical(node, this)) {
          return;
        }
      }
    }
  }
}

class _NodeMissingParent extends StateError {
  _NodeMissingParent() : super("Node doesn't have a parent");
}
