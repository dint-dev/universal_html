part of universal_html;

class DomParser {
  Document parseFromString(String input, String type) {
    switch (type) {
      case "text/html":
        return const _DomParserHandler().parseHtmlDocument(input);
      case "application/xhtml+xml":
        return const _DomParserHandler().parseHtmlDocument(input);
      case "text/xml":
        return const _DomParserHandler().parseXmlDocument(input);
      case "application/xml":
        return const _DomParserHandler().parseXmlDocument(input);
      case "image/svg+xml":
        return const _DomParserHandler().parseSvgDocument(input);
      default:
        throw ArgumentError.value(type, "type");
    }
  }
}

/// IMPORTANT: Not part 'dart:html'.
class XmlElement extends Element {
  /// IMPORTANT: Not part 'dart:html'.
  XmlElement.internalTag(Document ownerDocument, String name)
      : super._(ownerDocument, name);

  @override
  Element _newInstance(Document ownerDocument) =>
      XmlElement.internalTag(ownerDocument, tagName);
}

class _DomParserHandler extends _DomParserHandlerBase {
  static NodeValidatorBuilder _defaultValidator;
  static _ValidatingTreeSanitizer _defaultSanitizer;

  static const int _typeHtml = 0;
  static const int _typeXml = 1;
  static const int _typeSvg = 2;

  const _DomParserHandler();

  DocumentFragment parseFragmentWithHtml(Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    if (html == null) {
      throw ArgumentError.notNull();
    }
    if (treeSanitizer == null) {
      if (validator == null) {
        if (_defaultValidator == null) {
          _defaultValidator = NodeValidatorBuilder.common();
        }
        validator = _defaultValidator;
      }
      if (_defaultSanitizer == null) {
        _defaultSanitizer = _ValidatingTreeSanitizer(validator);
      } else {
        _defaultSanitizer.validator = validator;
      }
      treeSanitizer = _defaultSanitizer;
    } else if (validator != null) {
      throw ArgumentError(
          'validator can only be passed if treeSanitizer is null');
    }
    final fragment =
        _convertParsed(null, html_parsing.parseFragment(html), _typeHtml);
    assert(fragment is DocumentFragment);
    var child = fragment.firstChild;
    while (child != null) {
      treeSanitizer.sanitizeTree(child);
      child = child.nextNode;
    }
    return fragment;
  }

  DocumentFragment parseFragmentWithSvg(Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    if (html == null) {
      throw ArgumentError.notNull();
    }
    if (treeSanitizer == null) {
      if (validator == null) {
        if (_defaultValidator == null) {
          _defaultValidator = NodeValidatorBuilder.common();
        }
        validator = _defaultValidator;
      }
      if (_defaultSanitizer == null) {
        _defaultSanitizer = _ValidatingTreeSanitizer(validator);
      } else {
        _defaultSanitizer.validator = validator;
      }
      treeSanitizer = _defaultSanitizer;
    } else if (validator != null) {
      throw ArgumentError(
          'validator can only be passed if treeSanitizer is null');
    }
    final fragment = _convertParsed(
        null, html_parsing.parseFragment(html, container: "svg"), _typeSvg);
    assert(fragment is DocumentFragment);
    var child = fragment.firstChild;
    while (child != null) {
      treeSanitizer.sanitizeTree(child);
      child = child.nextNode;
    }
    return fragment;
  }

  @override
  HtmlDocument parseHtmlDocument(String input) {
    return _convertParsed(null, html_parsing.parse(input), _typeHtml);
  }

  @override
  XmlDocument parseSvgDocument(String input) {
    // TODO: Real SVG parsing
    return _convertParsed(null, html_parsing.parse(input), _typeSvg);
  }

  @override
  XmlDocument parseXhtmlDocument(String input) {
    return _convertParsed(null, html_parsing.parse(input), _typeHtml);
  }

  @override
  XmlDocument parseXmlDocument(String input) {
    // TODO: Real XML parsing
    return _convertParsed(null, html_parsing.parse(input), _typeXml);
  }

  static Node _convertParsed(
      Document ownerDocument, html_parsing.Node input, int type) {
    if (input == null) {
      return null;
    } else if (input is html_parsing.Element) {
      // Create element
      Element result;
      switch (type) {
        case _typeHtml:
          final tag = input.localName;
          switch (tag) {
            case "input":
              result = InputElementBase.internalFromType(
                ownerDocument,
                input.attributes["type"],
              );
              break;
            default:
              result = Element.internalTag(
                ownerDocument,
                input.localName,
              );
              break;
          }
          break;
        case _typeXml:
          return XmlElement.internalTag(ownerDocument, input.localName);
        case _typeSvg:
          // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
          return SvgElement.internalTagWithDocument(
              ownerDocument, input.localName);
      }

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
      Node previous;
      for (var child in input.nodes) {
        final current = _convertParsed(ownerDocument, child, type);

        // Set parent of the child
        current._parent = result;

        // Set sibling chain
        if (previous == null) {
          result._firstChild = current;
        } else {
          previous._nextNode = current;
        }

        // Remember this child
        previous = current;
      }
      return result;
    } else if (input is html_parsing.Text) {
      return Text(input.data);
    } else if (input is html_parsing.Comment) {
      // An ugly workaround for CDATA, which is seems to be parsed as comments.
      final data = input.data;
      if (data.startsWith("[CDATA[") && data.endsWith("]]")) {
        return Text(
            data.substring("[CDATA[".length, data.length - "]]".length));
      }
      return Comment(data);
    } else if (input is html_parsing.Document) {
      final Document result =
          _typeHtml == type ? HtmlDocument._() : XmlDocument._();
      Node previous;
      for (var child in input.nodes) {
        final current = _convertParsed(result, child, type);

        // Set parent
        current._parent = result;

        // Set sibling chain
        if (previous == null) {
          result._firstChild = current;
        } else {
          previous._nextNode = current;
        }
        previous = current;
      }
      return result;
    } else if (input is html_parsing.DocumentFragment) {
      final result = DocumentFragment._(ownerDocument);
      Node previous;
      for (var child in input.nodes) {
        final current = _convertParsed(ownerDocument, child, type);
        // Set parent
        current._parent = result;

        // Set sibling chain
        if (previous == null) {
          result._firstChild = current;
        } else {
          previous._nextNode = current;
        }
        previous = current;
      }
      return result;
    } else if (input is html_parsing.DocumentType) {
      return DocumentType.internal(ownerDocument, input.name);
    } else {
      throw UnimplementedError();
    }
  }
}

abstract class _DomParserHandlerBase {
  const _DomParserHandlerBase();

  DocumentFragment parseFragmentWithHtml(Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer});

  DocumentFragment parseFragmentWithSvg(Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer});

  HtmlDocument parseHtmlDocument(String source);

  XmlDocument parseSvgDocument(String source);

  XmlDocument parseXhtmlDocument(String source);

  XmlDocument parseXmlDocument(String source);

  static Comment newTrustedComment(Document ownerDocument, String text) {
    return Comment.internal(ownerDocument, text);
  }

  static Node newTrustedDocumentType(Document ownerDocument, String name) {
    return DocumentType.internal(ownerDocument, name);
  }

  static Element newTrustedHtmlElement(Document ownerDocument, String tagName) {
    return Element.internalTag(ownerDocument, tagName);
  }

  static Element newTrustedHtmlElementNS(
      Document ownerDocument, String namespace, String tagName) {
    return Element.internalTagNS(ownerDocument, namespace, tagName);
  }

  static Element newTrustedHtmlInputElement(
      Document ownerDocument, String type) {
    return InputElementBase.internalFromType(ownerDocument, type);
  }

  /// A helper for building parsers.
  static Text newTrustedText(Document ownerDocument, String text) {
    return Text.internal(ownerDocument, text);
  }

  /// A helper for building parsers.
  static Element newTrustedXmlElement(Document ownerDocument, String tagName) {
    return XmlElement.internalTag(ownerDocument, tagName);
  }

  /// A helper for building parsers.
  static Element newTrustedXmlElementNS(
      Document ownerDocument, String namespace, String tagName) {
    return UnknownElement.internal(ownerDocument, namespace, tagName);
  }
}
