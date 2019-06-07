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

  final HtmlDriver _htmlDriver;
  final String contentType;

  factory Document() {
    return XmlDocument.internal(HtmlDriver.current);
  }

  Document._(this._htmlDriver, this.contentType) : super._document();

  /// Outside the browser, returns null.
  Element get activeElement => null;

  DomImplementation get implementation => DomImplementation._(_htmlDriver);

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
    return DocumentFragment.internal(this);
  }

  Element createElement(String tagName, [String typeExtension]) {
    return Element.internalTag(this, tagName, typeExtension);
  }

  Element createElementNS(String namespaceUri, String qualifiedName,
      [String typeExtension]) {
    return Element.internalTagNS(
        this, namespaceUri, qualifiedName, typeExtension);
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
      throw DomException._failedToExecute(DomException.HIERARCHY_REQUEST,
          "Node", "appendChild", "Only one element on document allowed.");
    }
    super.insertBefore(node, before);
  }

  @override
  void remove() {
    throw UnsupportedError("Can't be removed");
  }
}

abstract class DocumentOrShadowRoot {
  Element get activeElement => null;

  Element get fullscreenElement => null;

  Element get pointerLockElement => null;
}

class DomImplementation {
  final HtmlDriver _htmlDriver;

  DomImplementation._(this._htmlDriver);

  XmlDocument createDocument(
      String namespaceURI, String qualifiedName, DocumentType doctype) {
    final result = XmlDocument.internal(_htmlDriver);
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
    return HtmlDocument.internal(_htmlDriver);
  }
}

class HtmlDocument extends Document {
  /// IMPORTANT: Not part 'dart:html'.
  ///
  /// If [filled] is true, returns document:
  ///
  ///     <doctype html>
  ///     <html>
  ///     <head></head>
  ///     <body></body>
  ///     </html>
  HtmlDocument.internal(HtmlDriver driver,
      {String contentType = "text/html", bool filled = true})
      : super._(driver, contentType) {
    if (filled) {
      final docType = DocumentType.internal(this, "html");
      append(docType);
      final htmlElement = HtmlHtmlElement._(this);
      append(htmlElement);
      htmlElement.append(HeadElement._(this));
      htmlElement.append(BodyElement._(this));
    }
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
    final clone = HtmlDocument.internal(_htmlDriver, contentType: contentType);
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
