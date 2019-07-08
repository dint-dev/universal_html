import 'package:html/dom.dart' as html_parsing;
import 'package:html/parser.dart' as html_parsing;
import 'package:meta/meta.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/src/html.dart';
import 'package:universal_html/src/svg.dart';
import 'package:xml/xml.dart' as xml;

/// Parses DOM trees.
class DomParserDriver {
  final HtmlDriver _htmlDriver;

  const DomParserDriver({HtmlDriver driver}) : this._htmlDriver = driver;

  HtmlDriver get htmlDriver => _htmlDriver ?? HtmlDriver.current;

  /// Parses [Document] based on [mime] (e.g. "text/html").
  ///
  /// The result is either [HtmlDocument] or [XmlDocument].
  Document parseDocument(
    String input, {
    @required String mime,
  }) {
    if (mime == null) {
      throw ArgumentError.notNull("mime");
    }
    switch (mime) {
      case "text/plain":
        final document = HtmlDocument.internal(
          htmlDriver,
          contentType: mime,
          filled: true,
        );
        document.body.appendText(input);
        return document;

      // HTML
      case "text/html":
        return parseHtml(input, mime: mime);
      case "application/html":
        return parseHtml(input, mime: mime);

      // XHTML
      case "application/xhtml+xml":
        return parseXml(input, mime: mime);

      // SVG
      case "text/svg":
        return parseSvg(input, mime: mime);
      case "application/svg":
        return parseSvg(input, mime: mime);

      // XML
      case "text/xml":
        return parseXml(input, mime: mime);
      case "application/xml":
        return parseXml(input, mime: mime);

      default:
        throw ArgumentError.value(
          mime,
          "mime",
          "Unsupported MIME type",
        );
    }
  }

  DocumentFragment parseDocumentFragmentFromHtml(
      Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    final task = _HtmlParser(
      htmlDriver,
      type: _HtmlParser._typeHtml,
      mime: "text/html",
    );
    return task._parseDocumentFragment(
      _HtmlParser._typeHtml,
      ownerDocument,
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
  }

  DocumentFragment parseDocumentFragmentFromSvg(
      Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    final task = _HtmlParser(
      htmlDriver,
      type: _HtmlParser._typeSvg,
      mime: "application/svg",
    );
    return task._parseDocumentFragment(
      _HtmlParser._typeSvg,
      ownerDocument,
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
      container: "svg",
    );
  }

  /// Parses [HtmlDocument].
  ///
  /// If [parseDocument]  actually returns [XmlDocument] (e.g. XHTML, SVG,
  /// etc.), converts it to HTML document.
  ///
  /// Currently conversion happens by inserting the document element into the
  /// body of blank HTML document.
  HtmlDocument parseHtmlFromAnything(
    String input, {
    String mime = "text/html",
  }) {
    final document = parseDocument(input, mime: mime);
    if (document is HtmlDocument) {
      return document;
    }
    if (document is XmlDocument) {
      // Convert XML document to HTML document
      final htmlDocument = HtmlDocument.internal(
        htmlDriver,
        contentType: mime,
        filled: false,
      );
      while (true) {
        final firstChild = document.firstChild;
        if (firstChild == null) {
          break;
        }
        if (firstChild is Element) {
          htmlDocument.append(firstChild);
        }
      }
      return htmlDocument;
    }
    throw StateError("Invalid document type");
  }

  HtmlDocument parseHtml(String input, {String mime = "text/html"}) {
    final task = _HtmlParser(
      htmlDriver,
      type: _HtmlParser._typeHtml,
      mime: mime,
    );
    final node = task._newNodeFrom(null, html_parsing.parse(input));
    return node as HtmlDocument;
  }

  XmlDocument parseXhtml(String input,
      {String mime = "application/xhtml+xml"}) {
    final parser = _XmlParser(htmlDriver, mime);
    final node = parser._newNodeFrom(null, xml.parse(input));
    return node as XmlDocument;
  }

  XmlDocument parseXml(String input, {String mime = "text/xml"}) {
    final parser = _XmlParser(htmlDriver, mime);
    final node = parser._newNodeFrom(null, xml.parse(input));
    return node as XmlDocument;
  }

  XmlDocument parseSvg(String input, {String mime = "application/svg"}) {
    final parser = _XmlParser(htmlDriver, mime);
    final node = parser._newNodeFrom(null, xml.parse(input));
    return node as XmlDocument;
  }
}

class _HtmlParser {
  static final NodeValidatorBuilder _defaultValidator =
      NodeValidatorBuilder.common();

  static final NodeTreeSanitizer _defaultSanitizer =
      NodeTreeSanitizer(_defaultValidator);

  static const int _typeHtml = 0;
  static const int _typeXml = 1;
  static const int _typeSvg = 2;

  final HtmlDriver htmlDriver;
  final int type;
  final String mime;

  _HtmlParser(this.htmlDriver, {@required this.type, @required this.mime});

  Element _newElementWithoutChildrenFrom(
    Document ownerDocument,
    html_parsing.Element input,
  ) {
    switch (type) {
      case _typeHtml:
        final tag = input.localName.toUpperCase();
        switch (tag) {
          case "INPUT":
            String type;
            for (var name in input.attributes.keys) {
              if (name.toLowerCase() == "type") {
                type = input.attributes[name];
              }
            }
            return InputElementBase.internalFromType(
              ownerDocument,
              type,
            );
          default:
            return Element.internalTag(
              ownerDocument,
              tag,
            );
        }
        break;
      case _typeXml:
        return UnknownElement.internal(
            ownerDocument, input.namespaceUri, input.localName);
      case _typeSvg:
        return SvgElement.internal(ownerDocument, input.localName);
      default:
        throw ArgumentError.value(type);
    }
  }

  Node _newNodeFrom(Document ownerDocument, html_parsing.Node input) {
    if (input == null) {
      return null;
    } else if (input is html_parsing.Element) {
      // -------
      // Element
      // -------
      Element result = _newElementWithoutChildrenFrom(ownerDocument, input);

      // Set attributes
      final inputAttributes = input.attributes;
      if (inputAttributes != null && inputAttributes.isNotEmpty) {
        inputAttributes.forEach((dynamic name, String value) {
          if (name is html_parsing.AttributeName) {
            result.setAttributeNS(name.namespace, name.name, value);
          } else if (name is String) {
            result.setAttribute(name, value);
          } else {
            throw UnimplementedError();
          }
        });
      }

      // Append children
      for (var child in input.nodes) {
        result.append(_newNodeFrom(ownerDocument, child));
      }
      return result;
    } else if (input is html_parsing.Text) {
      // ----
      // Text
      // ----

      return Text(input.data);
    } else if (input is html_parsing.Comment) {
      // -------
      // Comment
      // -------

      // An ugly workaround for CDATA, which seems to be parsed as comments.
      final data = input.data;
      if (data.startsWith("[CDATA[") && data.endsWith("]]")) {
        return Text(
            data.substring("[CDATA[".length, data.length - "]]".length));
      }

      return Comment(data);
    } else if (input is html_parsing.Document) {
      // --------
      // Document
      // --------
      switch (type) {
        case _typeHtml:
          // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
          final result = HtmlDocument.internal(
            htmlDriver,
            contentType: mime,
            filled: false,
          );
          for (var child in input.nodes) {
            result.append(_newNodeFrom(result, child));
          }
          return result;
        default:
          // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
          final result = XmlDocument.internal(
            htmlDriver,
            contentType: mime,
          );
          for (var child in input.nodes) {
            result.append(_newNodeFrom(result, child));
          }
          return result;
      }
    } else if (input is html_parsing.DocumentFragment) {
      // ----------------
      // DocumentFragment
      // ----------------

      final result = DocumentFragment.internal(ownerDocument);
      for (var child in input.nodes) {
        result.append(_newNodeFrom(ownerDocument, child));
      }
      return result;
    } else if (input is html_parsing.DocumentType) {
      // ------------
      // DocumentType
      // ------------

      return DocumentType.internal(ownerDocument, input.name);
    } else {
      throw UnimplementedError();
    }
  }

  DocumentFragment _parseDocumentFragment(
    int type,
    Document ownerDocument,
    String html, {
    NodeValidator validator,
    NodeTreeSanitizer treeSanitizer,
    String container,
  }) {
    if (html == null) {
      throw ArgumentError.notNull();
    }
    if (treeSanitizer == null) {
      if (validator == null) {
        validator = _defaultValidator;
        treeSanitizer = _defaultSanitizer;
      } else {
        treeSanitizer = NodeTreeSanitizer(validator);
      }
    } else if (validator != null) {
      throw ArgumentError(
          'validator can only be passed if treeSanitizer is null');
    }
    final node = _newNodeFrom(
      null,
      html_parsing.parseFragment(html, container: container),
    );
    final fragment = node as DocumentFragment;
    var child = fragment.firstChild;
    while (child != null) {
      treeSanitizer.sanitizeTree(child);
      child = child.nextNode;
    }
    return fragment;
  }
}

class _XmlParser {
  final HtmlDriver htmlDriver;
  final String contentType;

  _XmlParser(this.htmlDriver, this.contentType);

  Node _newNodeFrom(Document document, xml.XmlNode input) {
    if (input is xml.XmlProcessing) {
      return null;
    }
    if (input is xml.XmlText) {
      return Text.internal(document, input.text);
    }
    if (input is xml.XmlElement) {
      final namespaceUri = input.name.namespaceUri;
      final name = input.name.local;
      if (name == null) {
        throw ArgumentError.value(input);
      }
      final result = UnknownElement.internal(
        document,
        namespaceUri,
        name,
      );
      for (var attribute in input.attributes) {
        final prefix = attribute.name.prefix;
        if (prefix == null) {
          result.setAttribute(
            attribute.name.qualified,
            attribute.value,
          );
          continue;
        }
        var namespaceUri = attribute.name.namespaceUri;
        if (namespaceUri == null) {
          namespaceUri = "xmlns";
        }
        result.setAttributeNS(
          namespaceUri,
          attribute.name.local,
          attribute.value,
        );
      }
      for (var inputChild in input.children) {
        final child = _newNodeFrom(document, inputChild);
        if (child != null) {
          result.append(child);
        }
      }
      return result;
    }
    if (input is xml.XmlCDATA) {
      return Text(input.text);
    }
    if (input is xml.XmlDocument) {
      // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
      final result = XmlDocument.internal(htmlDriver, contentType: contentType);
      for (var inputChild in input.children) {
        final child = _newNodeFrom(result, inputChild);
        if (child != null) {
          result.append(child);
        }
      }
      return result;
    }
    if (input is xml.XmlDoctype) {
      return DocumentType.internal(document, input.text);
    }
    if (input is xml.XmlComment) {
      return Comment.internal(document, input.text);
    }
    throw ArgumentError.value(input);
  }
}
