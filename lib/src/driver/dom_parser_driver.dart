import 'package:html/dom.dart' as html_parsing;
import 'package:html/parser.dart' as html_parsing;
import 'package:universal_html/src/html.dart';
import 'package:universal_html/src/svg.dart';
import 'package:universal_html/driver.dart';

/// Parses DOM trees.
class DomParserDriver {
  static final NodeValidatorBuilder _defaultValidator =
      NodeValidatorBuilder.common();
  static final NodeTreeSanitizer _defaultSanitizer =
      NodeTreeSanitizer(_defaultValidator);

  static const int _typeHtml = 0;
  static const int _typeXml = 1;
  static const int _typeSvg = 2;

  final HtmlDriver _htmlDriver;

  HtmlDriver get htmlDriver => _htmlDriver ?? HtmlDriver.current;

  const DomParserDriver({HtmlDriver driver}) : this._htmlDriver = driver;

  /// Parses [Document] based on [mime] (e.g. "text/html").
  ///
  /// The result is either [HtmlDocument] or [XmlDocument].
  Document parseDocument(
    String input, {
    String mime = "text/html",
  }) {
    if (mime == null) {
      throw ArgumentError.notNull("mime");
    }
    switch (mime) {
      case "text/html":
        return parseHtmlDocumentFromHtml(input);
      case "text/plain":
        final document = HtmlDocument.internal(htmlDriver);
        document.body.appendText(input);
        return document;
      case "application/html":
        return parseHtmlDocumentFromHtml(input);
      case "application/xhtml+xml":
        return parseHtmlDocumentFromXhtml(input);
      case "text/xml":
        return parseXmlDocument(input);
      case "application/xml":
        return parseXmlDocument(input);
      case "text/svg":
        return parseXmlDocumentFromSvg(input);
      case "application/svg":
        return parseXmlDocumentFromSvg(input);
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
    return _parseDocumentFragment(
      _typeHtml,
      ownerDocument,
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
  }

  DocumentFragment parseDocumentFragmentFromSvg(
      Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    return _parseDocumentFragment(
      _typeSvg,
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
  HtmlDocument parseHtmlDocument(
    String input, {
    String mime = "text/html",
  }) {
    final document = parseDocument(input, mime: mime);
    if (document is HtmlDocument) {
      return document;
    }
    if (document is XmlDocument) {
      // Convert XML document to HTML document
      final htmlDocument = HtmlDocument.internal(htmlDriver, filled: false);
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

  HtmlDocument parseHtmlDocumentFromHtml(String input) {
    final node = _newNodeFrom(_typeHtml, null, html_parsing.parse(input));
    return node as HtmlDocument;
  }

  HtmlDocument parseHtmlDocumentFromXhtml(String input) {
    final node = _newNodeFrom(_typeHtml, null, html_parsing.parse(input));
    return node as HtmlDocument;
  }

  XmlDocument parseXmlDocument(String input) {
    // TODO: Real XML parsing
    final node = _newNodeFrom(_typeXml, null, html_parsing.parse(input));
    return node as XmlDocument;
  }

  XmlDocument parseXmlDocumentFromSvg(String input) {
    // TODO: Real SVG parsing
    final node = _newNodeFrom(_typeSvg, null, html_parsing.parse(input));
    return node as XmlDocument;
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
      type,
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

  Element _newElementWithoutChildrenFrom(
    int type,
    Document ownerDocument,
    html_parsing.Element input,
  ) {
    switch (type) {
      case _typeHtml:
        final tag = input.localName;
        switch (tag) {
          case "input":
            return InputElementBase.internalFromType(
              ownerDocument,
              input.attributes["type"],
            );
          default:
            return Element.internalTag(
              ownerDocument,
              input.localName,
            );
        }
        break;
      case _typeXml:
        // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
        return Element.internalTag(ownerDocument, input.localName);
      case _typeSvg:
        // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
        return SvgElement.internal(ownerDocument, input.localName);
      default:
        throw ArgumentError.value(type);
    }
  }

  Node _newNodeFrom(
    int type,
    Document ownerDocument,
    html_parsing.Node input,
  ) {
    if (input == null) {
      return null;
    } else if (input is html_parsing.Element) {
      // -------
      // Element
      // -------
      Element result =
          _newElementWithoutChildrenFrom(type, ownerDocument, input);

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
        result.append(_newNodeFrom(type, ownerDocument, child));
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
          final result = HtmlDocument.internal(htmlDriver, filled: false);
          for (var child in input.nodes) {
            result.append(_newNodeFrom(type, result, child));
          }
          return result;
        default:
          // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
          final result = XmlDocument.internal(htmlDriver);
          for (var child in input.nodes) {
            result.append(_newNodeFrom(type, result, child));
          }
          return result;
      }
    } else if (input is html_parsing.DocumentFragment) {
      // ----------------
      // DocumentFragment
      // ----------------

      final result = DocumentFragment.internal(ownerDocument);
      for (var child in input.nodes) {
        result.append(_newNodeFrom(type, ownerDocument, child));
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
}
