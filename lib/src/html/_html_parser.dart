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

import 'package:html/dom.dart' as html_parsing;
import 'package:html/parser.dart' as html_parsing;
import 'package:universal_html/src/html.dart';
import 'package:universal_html/src/svg.dart';

DocumentFragment parseDocumentFragmentFromHtml({
  required Document ownerDocument,
  required String content,
  NodeValidator? validator,
  NodeTreeSanitizer? treeSanitizer,
}) {
  final task = _HtmlParser(
    window: ownerDocument.window,
    type: _HtmlParser._typeHtml,
    mime: 'text/html',
  );
  return task.parseDocumentFragment(
    type: _HtmlParser._typeHtml,
    ownerDocument: ownerDocument,
    html: content,
    validator: validator,
    treeSanitizer: treeSanitizer,
  );
}

DocumentFragment parseDocumentFragmentFromSvg({
  required Document ownerDocument,
  required String content,
  NodeValidator? validator,
  NodeTreeSanitizer? treeSanitizer,
}) {
  final task = _HtmlParser(
    window: ownerDocument.window,
    type: _HtmlParser._typeSvg,
    mime: 'application/svg',
  );
  return task.parseDocumentFragment(
    type: _HtmlParser._typeSvg,
    ownerDocument: ownerDocument,
    html: content,
    validator: validator,
    treeSanitizer: treeSanitizer,
    container: 'svg',
  );
}

HtmlDocument parseHtml({
  required Window window,
  required String content,
  String mime = 'text/html',
}) {
  final task = _HtmlParser(
    window: window,
    type: _HtmlParser._typeHtml,
    mime: mime,
  );
  final node = task._newNodeFrom(window.document, html_parsing.parse(content));
  return node as HtmlDocument;
}

class _HtmlParser {
  static final NodeValidatorBuilder _defaultValidator =
      NodeValidatorBuilder.common();

  static final NodeTreeSanitizer _defaultSanitizer =
      NodeTreeSanitizer(_defaultValidator);

  static const int _typeHtml = 0;
  static const int _typeXml = 1;
  static const int _typeSvg = 2;

  final Window window;
  final int type;
  final String mime;

  _HtmlParser({
    required this.window,
    required this.type,
    required this.mime,
  });

  DocumentFragment parseDocumentFragment({
    required int type,
    required Document ownerDocument,
    required String html,
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
    String container = 'div',
  }) {
    if (treeSanitizer == null) {
      if (validator == null) {
        validator = _defaultValidator;
        treeSanitizer = _defaultSanitizer;
      } else {
        treeSanitizer = NodeTreeSanitizer(validator);
      }
    } else if (validator != null) {
      throw ArgumentError(
        'validator can only be passed if treeSanitizer is null',
      );
    }
    final node = _newNodeFrom(
      ownerDocument,
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
    Document ownerDocument,
    html_parsing.Element input,
  ) {
    switch (type) {
      case _typeHtml:
        final localName = input.localName!;
        final tagName = localName.toUpperCase();

        // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
        return Element.internalTag(
          ownerDocument,
          tagName,
        );
      case _typeXml:
        return UnknownElement.internal(
          ownerDocument,
          input.namespaceUri,
          input.localName!,
        );
      case _typeSvg:
        return SvgElement.internal(ownerDocument, input.localName!);
      default:
        throw ArgumentError.value(type);
    }
  }

  Node? _newNodeFrom(Document ownerDocument, html_parsing.Node? input) {
    if (input == null) {
      return null;
    } else if (input is html_parsing.Element) {
      // -------
      // Element
      // -------
      var result = _newElementWithoutChildrenFrom(ownerDocument, input);

      // Set attributes
      final inputAttributes = input.attributes;
      if (inputAttributes.isNotEmpty) {
        inputAttributes.forEach((dynamic name, String value) {
          if (name is html_parsing.AttributeName) {
            result.internalSetAttributeNSFromParser(
              namespaceUri: name.namespace,
              qualifiedName: name.prefix == null
                  ? name.name
                  : '${name.prefix}:${name.name}',
              localName: name.name,
              value: value,
            );
          } else if (name is String) {
            result.internalSetAttributeNSFromParser(
              namespaceUri: '',
              qualifiedName: name,
              localName: name,
              value: value,
            );
          } else {
            throw UnimplementedError();
          }
        });
      }

      // Append children
      for (var child in input.nodes) {
        result.append(_newNodeFrom(ownerDocument, child)!);
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
      final data = input.data!;
      if (data.startsWith('[CDATA[') && data.endsWith(']]')) {
        return Text(
            data.substring('[CDATA['.length, data.length - ']]'.length));
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
            window: window,
            contentType: mime,
            filled: false,
          );
          for (var child in input.nodes) {
            result.append(_newNodeFrom(result, child)!);
          }
          return result;
        default:
          // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
          final result = XmlDocument.internal(
            window: window,
            contentType: mime,
          );
          for (var child in input.nodes) {
            result.append(_newNodeFrom(result, child)!);
          }
          return result;
      }
    } else if (input is html_parsing.DocumentFragment) {
      // ----------------
      // DocumentFragment
      // ----------------

      final result = DocumentFragment.internal(ownerDocument);
      for (var child in input.nodes) {
        result.append(_newNodeFrom(ownerDocument, child)!);
      }
      return result;
    } else if (input is html_parsing.DocumentType) {
      // ------------
      // DocumentType
      // ------------

      return InternalDocumentType.internal(
        ownerDocument,
        input.name!,
      );
    } else {
      throw UnimplementedError();
    }
  }
}
