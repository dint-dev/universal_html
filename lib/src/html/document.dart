part of universal_html;

HtmlDocument get document => HtmlIsolate.current.document;

/// Outside the browser, throws [UnimplementedError].
T querySelector<T extends Element>(String s) => document.querySelector(s);

/// Outside the browser, throws [UnimplementedError].
List<T> querySelectorAll<T extends Element>(String s) =>
    document.querySelectorAll(s);

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

abstract class Document extends Node
    with _ElementOrDocument, DocumentOrShadowRoot, _DocumentOrFragment {
  static const EventStreamProvider<Event> readyStateChangeEvent =
      const EventStreamProvider<Event>("readystatechange");

  static const EventStreamProvider<SecurityPolicyViolationEvent>
      securityPolicyViolationEvent =
      const EventStreamProvider<SecurityPolicyViolationEvent>(
          "securitypolicyviolation");

  static const EventStreamProvider<Event> selectionChangeEvent =
      const EventStreamProvider<Event>("selectionchange");

  final String contentType;

  factory Document() {
    return new XmlDocument._();
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
    final clone = node.cloneWithOwnerDocument(this, true);
    clone._parent = null;
    return clone;
  }

  DocumentFragment createDocumentFragment() {
    return new DocumentFragment._(this);
  }

  Element createElement(String tagName, [String typeExtension]) {
    return new Element._tag(this, tagName, typeExtension);
  }

  Element createElementNS(String namespaceUri, String qualifiedName,
      [String typeExtension]) {
    return new Element._tagNS(this, namespaceUri, qualifiedName, typeExtension);
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
    final result = <Node>[];
    this._forEachTreeElement((element) {
      if (element.nodeName == elementName) {
        result.add(element);
      }
    });
    return result;
  }

  List<Node> getElementsByTagName(String tagName) {
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
    if (node is! Element && node is! _DocumentType) {
      throw new DomException._mayNotBeInsertedInside(
          "Document", "insertBefore", node, this);
    }
    if (node is Element && this._firstElementChild != null) {
      throw new DomException._failedToExecute(DomException.HIERARCHY_REQUEST,
          "Document", "insertBefore", "Only one element is allowed inside document node.");
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
    return const _NodeParserDriver().parseFragmentWithHtml(document, input,
        validator: validator, treeSanitizer: treeSanitizer);
  }

  factory DocumentFragment.svg(String input,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    return const _NodeParserDriver().parseFragmentWithSvg(document, input,
        validator: validator, treeSanitizer: treeSanitizer);
  }

  DocumentFragment._(Document ownerDocument) : super._(ownerDocument);

  String get innerHtml {
    final sb = new StringBuffer();
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
  Node cloneWithOwnerDocument(Document ownerDocument, bool deep) {
    final clone = DocumentFragment();
    if (deep != false) {
      Node._cloneChildrenFrom(ownerDocument, clone, this);
    }
    return clone;
  }
}

class DocumentOrShadowRoot {
  Element get activeElement => null;

  Element get fullscreenElement => null;

  Element get pointerLockElement => null;

  List<StyleSheet> get styleSheets => [];
}

class DomImplementation {
  const DomImplementation._();

  XmlDocument createDocument(
      String namespaceURI, String qualifiedName, _DocumentType doctype) {
    final result = new XmlDocument._();
    if (doctype != null) {
      result.append(doctype.cloneWithOwnerDocument(result, true));
    }
    final element = result.createElement(qualifiedName);
    if (namespaceURI != null) {
      element.setAttribute("xmlns", namespaceURI);
    }
    return result;
  }

  _DocumentType createDocumentType(
      String qualifiedName, String publicId, String systemId) {
    return new _DocumentType(null, null);
  }

  HtmlDocument createHtmlDocument([String title]) {
    return new HtmlDocument._normal();
  }
}

class HtmlDocument extends Document {
  HtmlDocument._({String contentType: "text/html"}) : super._(contentType);

  /// Returns document:
  ///   <doctype html>
  ///   <html>
  ///   <head></head>
  ///   <body></body>
  ///   </html>
  factory HtmlDocument._normal() {
    final result = new HtmlDocument._();
    final docType = new _DocumentType(result, "html");
    result.append(docType);
    final html = new HtmlHtmlElement._(result);
    result.append(html);
    html.append(new HeadElement._(result));
    html.append(new BodyElement._(result));
    return result;
  }

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

  List<StyleSheet> get styleSheets {
    final list = <StyleSheet>[];
    _forEachTreeElement((element) {
      if (element is StyleElement) {
        list.add(element.sheet);
      }
    });
    return list;
  }

  @override
  Node cloneWithOwnerDocument(Document ownerDocument, bool deep) {
    final clone = HtmlDocument._(contentType: contentType);
    if (deep != false) {
      Node._cloneChildrenFrom(clone, clone, this);
    }
    return clone;
  }
}

class XmlDocument extends Document {
  XmlDocument._({String contentType: "application/xml"})
      : super._(contentType) {}

  @override
  Node cloneWithOwnerDocument(Document ownerDocument, bool deep) {
    final clone = XmlDocument._(contentType: contentType);
    if (deep != false) {
      Node._cloneChildrenFrom(clone, clone, this);
    }
    return clone;
  }
}
