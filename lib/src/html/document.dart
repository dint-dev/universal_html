part of universal_html;

HtmlDocument get document => HtmlDriver.current.document;

/// Outside the browser, throws [UnimplementedError].
T querySelector<T extends Element>(String s) => document.querySelector(s);

/// Outside the browser, throws [UnimplementedError].
List<T> querySelectorAll<T extends Element>(String s) =>
    document.querySelectorAll(s);

abstract class Document extends Node
    with _ElementOrDocument, DocumentOrShadowRoot, _DocumentOrFragment {
  static const EventStreamProvider<Event> readyStateChangeEvent =
      EventStreamProvider<Event>("readystatechange");

  static const EventStreamProvider<SecurityPolicyViolationEvent>
      securityPolicyViolationEvent =
      EventStreamProvider<SecurityPolicyViolationEvent>(
          "securitypolicyviolation");

  static const EventStreamProvider<Event> selectionChangeEvent =
      EventStreamProvider<Event>("selectionchange");

  final String contentType;

  factory Document() {
    return XmlDocument._();
  }

  Document._(this.contentType) : super._document();

  /// Outside the browser, returns null.
  Element get activeElement => null;

  DomImplementation get implementation => const DomImplementation._();

  @override
  int get nodeType => Node.DOCUMENT_NODE;

  ElementStream<Event> get onReadyStateChange =>
      readyStateChangeEvent.forTarget(this);

  ElementStream<SecurityPolicyViolationEvent> get onSecurityPolicyViolation =>
      securityPolicyViolationEvent.forTarget(this);

  ElementStream<Event> get onSelectionChange =>
      selectionChangeEvent.forTarget(this);

  Node adoptNode(Node node) {
    final clone = node.internalCloneWithOwnerDocument(this, true);
    clone._parent = null;
    return clone;
  }

  DocumentFragment createDocumentFragment() {
    return DocumentFragment._(this);
  }

  Element createElement(String tagName, [String typeExtension]) {
    return Element.internalTag(this, tagName, typeExtension);
  }

  Element createElementNS(String namespaceUri, String qualifiedName,
      [String typeExtension]) {
    return Element.internalTagNS(this, namespaceUri, qualifiedName, typeExtension);
  }

  List<Node> getElementsByClassName(String classNames) {
    final result = <Node>[];
    final classNameList = classNames.split(" ");
    this._forEachTreeElement((element) {
      for (var className in classNameList) {
        if (!element.classes.contains(className)) {
          return;
        }
      }
      result.add(element);
    });
    return result;
  }

  List<Node> getElementsByName(String elementName) {
    // Only works in XHTML documents
    if (document is HtmlDocument) {
      return const <Node>[];
    }
    elementName = elementName.toUpperCase();
    final result = <Node>[];
    this._forEachTreeElement((element) {
      if (element.nodeName == elementName) {
        result.add(element);
      }
    });
    return result;
  }

  List<Node> getElementsByTagName(String tagName) {
    tagName = tagName.toUpperCase();
    final result = <Node>[];
    this._forEachTreeElement((element) {
      if (element.tagName == tagName) {
        result.add(element);
      }
    });
    return result;
  }

  @override
  void insertBefore(Node node, Node before) {
    if (node is! Element && node is! DocumentType) {
      throw DomException._mayNotBeInsertedInside(
          "Document", "insertBefore", node, this);
    }
    if (node is Element && this._firstElementChild != null) {
      throw DomException._failedToExecute(
          DomException.HIERARCHY_REQUEST,
          "Node",
          "appendChild",
          "Only one element on document allowed.");
    }
    super.insertBefore(node, before);
  }

  @override
  void remove() {
    throw UnsupportedError("Can't be removed");
  }
}

class DocumentFragment extends Node
    with _ElementOrDocument, _DocumentOrFragment {
  factory DocumentFragment() {
    return DocumentFragment._(null);
  }

  factory DocumentFragment.html(String input,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    return const _DomParserHandler().parseFragmentWithHtml(document, input,
        validator: validator, treeSanitizer: treeSanitizer);
  }

  factory DocumentFragment.svg(String input,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    return const _DomParserHandler().parseFragmentWithSvg(document, input,
        validator: validator, treeSanitizer: treeSanitizer);
  }

  DocumentFragment._(Document ownerDocument) : super._(ownerDocument);

  String get innerHtml {
    final sb = StringBuffer();
    final flags = _getPrintingFlags(this);
    Node next = this._firstChild;
    while (next != null) {
      _printNode(sb, flags, next);
      next = next.nextNode;
    }
    return sb.toString();
  }

  @override
  int get nodeType => Node.DOCUMENT_FRAGMENT_NODE;

  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool deep) {
    final clone = DocumentFragment();
    if (deep != false) {
      Node._cloneChildrenFrom(ownerDocument, clone, this);
    }
    return clone;
  }
}

abstract class DocumentOrShadowRoot {
  Element get activeElement => null;

  Element get fullscreenElement => null;

  Element get pointerLockElement => null;
}

class DomImplementation {
  const DomImplementation._();

  XmlDocument createDocument(
      String namespaceURI, String qualifiedName, DocumentType doctype) {
    final result = XmlDocument._();
    if (doctype != null) {
      result.append(doctype.internalCloneWithOwnerDocument(result, true));
    }
    final element = result.createElement(qualifiedName);
    if (namespaceURI != null) {
      element.setAttribute("xmlns", namespaceURI);
    }
    return result;
  }

  DocumentType createDocumentType(
      String qualifiedName, String publicId, String systemId) {
    return DocumentType.internal(null, null);
  }

  HtmlDocument createHtmlDocument([String title]) {
    return HtmlDocument.internal();
  }
}

class HtmlDocument extends Document {
  /// IMPORTANT: Not part 'dart:html'.
  ///
  /// Returns document:
  ///   <doctype html>
  ///   <html>
  ///   <head></head>
  ///   <body></body>
  ///   </html>
  factory HtmlDocument.internal() {
    final result = HtmlDocument._();
    final docType = DocumentType.internal(result, "html");
    result.append(docType);
    final html = HtmlHtmlElement._(result);
    result.append(html);
    html.append(HeadElement._(result));
    html.append(BodyElement._(result));
    return result;
  }

  HtmlDocument._({String contentType = "text/html"}) : super._(contentType);

  BodyElement get body {
    Element element = this._html?._firstElementChild;
    while (element != null) {
      if (element is BodyElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  set body(BodyElement newValue) {
    final existing = this.head;
    if (existing == null) {
      _html?.append(newValue);
    } else {
      existing.replaceWith(newValue);
    }
    assert(identical(this.body, newValue));
  }

  HeadElement get head {
    Element element = this._html?._firstElementChild;
    while (element != null) {
      if (element is HeadElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  set head(HeadElement newValue) {
    final existing = this.head;
    if (existing == null) {
      _html?.append(newValue);
    } else {
      existing.replaceWith(newValue);
    }
    assert(identical(this.head, newValue));
  }

  List<StyleSheet> get styleSheets {
    final list = <StyleSheet>[];
    _forEachTreeElement((element) {
      if (element is StyleElement) {
        list.add(element.sheet);
      }
    });
    return list;
  }

  HtmlHtmlElement get _html {
    Element element = this._firstElementChild;
    while (element != null) {
      if (element is HtmlHtmlElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool deep) {
    final clone = HtmlDocument._(contentType: contentType);
    if (deep != false) {
      Node._cloneChildrenFrom(clone, clone, this);
    }
    return clone;
  }
}

class XmlDocument extends Document {
  XmlDocument._({String contentType = "application/xml"})
      : assert(contentType!=null), super._(contentType);

  List<StyleSheet> get styleSheets {
    // TODO: Fix style sheet search
    final nodes = getElementsByTagName("style");
    final result = <StyleSheet>[];
    for (var node in nodes) {
      if (node is StyleElement) {
        final sheet = node.sheet;
        if (sheet!=null) {
          result.add(node.sheet);
        }
      }
    }
    return result;
  }

  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool deep) {
    final clone = XmlDocument._(contentType: contentType);
    if (deep != false) {
      Node._cloneChildrenFrom(clone, clone, this);
    }
    return clone;
  }
}

abstract class _DocumentOrFragment implements Node, _ElementOrDocument {
  Element getElementById(String id) {
    Element result;
    _forEachTreeElement((element) {
      if (element.id == id) {
        result = element;
      }
    });
    return result;
  }

  @override
  void remove() {
    throw UnsupportedError("Can't be removed");
  }
}
