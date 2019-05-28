part of universal_html;

int _getPrintingFlags(Node node) {
  int flags = 0;
  final doc = node.ownerDocument;
  switch (doc.contentType) {
    case "text/html":
      flags = _printingHtml;
      break;
    case "application/xhtml+xml":
      flags = _printingHtml | _printingAttributeNamespaces;
      break;
    default:
      flags = _printingAttributeNamespaces;
      break;
  }
  return flags;
}

const _printingHtml = 1;
const _printingAttributeNamespaces = 2;

void _printNode(StringBuffer sb, int flags, Node node) {
  switch (node.nodeType) {
    case Node.ELEMENT_NODE:
      _printElement(sb, flags, node as Element);
      break;

    case Node.TEXT_NODE:
      final value = node.nodeValue;

      // The choice of escaped characters should be identical to
      // 'outerHTML' in Chrome.
      var writeFrom = 0;
      for (var i = 0; i < value.length; i++) {
        final codeUnit = value.codeUnitAt(i);
        String escape;
        switch (codeUnit) {
          case charcode.$ampersand:
            escape = "&amp;";
            break;
          case charcode.$lt:
            escape = "&lt;";
            break;
          case charcode.$gt:
            escape = "&gt;";
            break;
        }
        if (escape != null) {
          sb.write(value.substring(writeFrom, i));
          sb.write(escape);
          writeFrom = i + 1;
        }
      }
      sb.write(0 == writeFrom ? value : value.substring(writeFrom));
      break;

    case Node.COMMENT_NODE:
      // To be safe, escape value.
      final value = node.nodeValue;
      if (value.contains("-->")) {
        throw StateError("Comment contains '-->': '${value}'");
      }

      sb.write("<!--");
      sb.write(value);
      sb.write('-->');
      break;

    case Node.CDATA_SECTION_NODE:
      sb.write("<![CDATA[");
      // We don't provide an API to create CDATA other than parsing,
      // so no need to inspect the value.
      sb.write(node.nodeValue);
      sb.write(']]>');
      break;

    case Node.DOCUMENT_TYPE_NODE:
      sb.write("<!doctype ");
      // We don't provide an API to create DOCTYPE other than parsing,
      // so no need to inspect the value.
      sb.write(node.nodeValue);
      sb.write(">");
      break;

    case Node.DOCUMENT_FRAGMENT_NODE:
      _printChildren(sb, flags, node);
      break;

    case Node.DOCUMENT_NODE:
      _printChildren(sb, flags, node);
      break;

    default:
      throw UnimplementedError();
  }
}

/// Empty elements from:
/// https://developer.mozilla.org/en-US/docs/Glossary/empty_element
final Set<String> _singleTagNamesInLowerCase = new Set<String>.from(const [
  "area",
  "base",
  "br",
  "col",
  "embed",
  "hr",
  "img",
  "input",
  "link",
  "meta",
  "param",
  "source",
  "track",
  "wbr",
]);

void _printElement(StringBuffer sb, int flags, Element node) {
  sb.write("<");
  sb.write(node._lowerCaseTagName); // Already validated!
  node.attributes.forEach((name, value) {
    _printAttribute(sb, flags, null, name, value);
  });
  final namespaces = node._namedspacedAttributes;
  if (namespaces != null) {
    for (var namespace in namespaces.keys.toList()..sort()) {
      final attributes = namespaces[namespace];
      for (var name in attributes.keys.toList()..sort()) {
        final value = attributes[name];
        _printAttribute(sb, flags, namespace, name, value);
      }
    }
  }
  sb.write(">");
  if (_singleTagNamesInLowerCase.contains(node._lowerCaseTagName)) {
    return;
  }
  _printChildren(sb, flags, node);
  sb.write("</");
  sb.write(node._lowerCaseTagName); // Already validated!
  sb.write(">");
}

void _printAttribute(
    StringBuffer sb, int flags, String namespace, String name, String value) {
  sb.write(" ");
  if (namespace == null) {
    // Already validated!
    sb.write(name);
  } else {
    // TODO: Validate mutations (like browsers do) so nothing needs to be done here.
    if (!(Element._normalizedAttributeNameRegExp.hasMatch(name) &&
        Element._normalizedAttributeNameRegExp.hasMatch(name))) {
      throw StateError(
        "Invalid namespaced attribute: '${namespace}:${name}'",
      );
    }
    if (_printingAttributeNamespaces & flags != 0) {
      // In non-xml mode, Chrome prints only name
      sb.write(namespace);
      sb.write(":");
    }
    sb.write(name);
  }
  sb.write('="');

  // We want escaping to be identical to Chrome's 'outerHTML'
  var writeFrom = 0;
  for (var i = 0; i < value.length; i++) {
    final codeUnit = value.codeUnitAt(i);
    String escape;
    switch (codeUnit) {
      case charcode.$ampersand:
        escape = "&amp;";
        break;
      case charcode.$quot:
        escape = "&quot;";
        break;
    }
    if (escape != null) {
      sb.write(value.substring(writeFrom, i));
      sb.write(escape);
      writeFrom = i + 1;
    }
  }
  sb.write(0 == writeFrom ? value : value.substring(writeFrom));
  sb.write('"');
}

void _printChildren(StringBuffer sb, int flags, Node node) {
  Node next = node.firstChild;
  while (next != null) {
    _printNode(sb, flags, next);
    next = next._nextNode;
  }
}
