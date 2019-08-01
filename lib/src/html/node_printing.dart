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

part of universal_html.internal;

const _printingAttributeNamespaces = 2;

const _printingHtml = 1;
/// Empty elements from:
/// https://developer.mozilla.org/en-US/docs/Glossary/empty_element
final Set<String> _singleTagNamesInLowerCase = Set<String>.from(const [
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

int _getPrintingFlags(Node node) {
  int flags = 0;
  final doc = node.ownerDocument;
  if (doc == null) {
    return _printingHtml;
  }
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

String _namespaceUriToPrefix(Node node, String uri) {
  if (uri == "xmlns") {
    return "xmlns";
  }
  for (; node != null; node = node.parent) {
    if (node is Element) {
      final defaultNamespace = node.getAttribute("xmlns");
      if (defaultNamespace == uri) {
        return null;
      }
      final namespaces = node._namespacedAttributes;
      if (namespaces == null) {
        continue;
      }
      final map = namespaces["xmlns"];
      if (map == null) {
        continue;
      }
      for (var entry in map.entries) {
        if (entry.value == uri) {
          return entry.key;
        }
      }
    }
  }
  return null;
}

void _printAttribute(
    StringBuffer sb, int flags, String prefix, String name, String value) {
  sb.write(" ");
  if (prefix != null) {
    // TODO: Validate mutations (like browsers do) so nothing needs to be done here.
    if (!(Element._normalizedAttributeNameRegExp.hasMatch(name) &&
        Element._normalizedAttributeNameRegExp.hasMatch(name))) {
      throw StateError(
        "Invalid namespaced attribute: '${prefix}:${name}'",
      );
    }
    if (_printingAttributeNamespaces & flags != 0) {
      sb.write(prefix);
      sb.write(":");
    }
  }
  sb.write(name);
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

void _printElement(StringBuffer sb, int flags, Element node) {
  String prefix;
  final namespaceUri = node.namespaceUri;
  if (namespaceUri != null) {
    prefix = _namespaceUriToPrefix(node, namespaceUri);
  }
  sb.write("<");
  if (prefix != null) {
    sb.write(prefix);
    sb.write(":");
  }
  if (node._isCaseSensitive) {
    sb.write(node._nodeName); // Already validated!
  } else {
    sb.write(node._lowerCaseTagName); // Already validated!
  }
  node.attributes.forEach((name, value) {
    _printAttribute(sb, flags, null, name, value);
  });
  final namespaces = node._namespacedAttributes;
  if (namespaces != null) {
    for (var namespaceUri in namespaces.keys.toList()..sort()) {
      final attributes = namespaces[namespaceUri];
      final prefix = _namespaceUriToPrefix(node, namespaceUri);
      for (var name in attributes.keys.toList()..sort()) {
        final value = attributes[name];
        _printAttribute(sb, flags, prefix, name, value);
      }
    }
  }
  if (node.childNodes.isEmpty && node.ownerDocument is XmlDocument) {
    sb.write("/>");
    return;
  }
  sb.write(">");
  if (_singleTagNamesInLowerCase.contains(node._lowerCaseTagName) &&
      node.ownerDocument is HtmlDocument) {
    return;
  }
  _printChildren(sb, flags, node);
  sb.write("</");
  if (prefix != null) {
    sb.write(prefix);
    sb.write(":");
  }
  if (node._isCaseSensitive) {
    sb.write(node._nodeName); // Already validated!
  } else {
    sb.write(node._lowerCaseTagName); // Already validated!
  }
  sb.write(">");
}

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
      sb.write("<!doctype");
      // We don't provide an API to create DOCTYPE other than parsing,
      // so no need to inspect the value.
      if (node.nodeValue != null) {
        sb.write(" ");
        sb.write(node.nodeValue);
      }
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
