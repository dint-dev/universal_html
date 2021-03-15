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

import 'package:universal_html/src/html.dart';

import '_html_parser.dart' as html;
import '_xml_parser.dart' as xml;

/// Parses DOM trees.
class DomParserDriver {
  const DomParserDriver();

  /// Parses [Document] based on [mime] (e.g. 'text/html').
  ///
  /// The result is either [HtmlDocument] or [XmlDocument].
  Document parseDocument({
    required String content,
    required String mime,
    required Window window,
  }) {
    switch (mime) {
      case 'text/plain':
        final document = HtmlDocument.internal(
          window: window,
          contentType: mime,
          filled: true,
        );
        final body = document.body!;
        body.appendText(content);
        return document;

      // HTML
      case 'text/html':
        return parseHtml(
          window: window,
          content: content,
          mime: mime,
        );
      case 'application/html':
        return parseHtml(
          window: window,
          content: content,
          mime: mime,
        );

      // XHTML
      case 'application/xhtml+xml':
        return parseXml(
          window: window,
          content: content,
          mime: mime,
        );

      // SVG
      case 'text/svg':
        return parseSvg(
          window: window,
          content: content,
          mime: mime,
        );
      case 'application/svg':
        return parseSvg(
          window: window,
          content: content,
          mime: mime,
        );

      // XML
      case 'text/xml':
        return parseXml(
          window: window,
          content: content,
          mime: mime,
        );
      case 'application/xml':
        return parseXml(
          window: window,
          content: content,
          mime: mime,
        );

      default:
        throw ArgumentError.value(
          mime,
          'mime',
          'Unsupported MIME type',
        );
    }
  }

  DocumentFragment parseDocumentFragmentFromHtml({
    required Document ownerDocument,
    required String content,
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    return html.parseDocumentFragmentFromHtml(
      ownerDocument: ownerDocument,
      content: content,
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
    return html.parseDocumentFragmentFromSvg(
      ownerDocument: ownerDocument,
      content: content,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
  }

  HtmlDocument parseHtml({
    required Window window,
    required String content,
    String mime = 'text/html',
  }) {
    return html.parseHtml(
      window: window,
      content: content,
      mime: mime,
    );
  }

  /// Parses [HtmlDocument].
  ///
  /// If [parseDocument]  actually returns [XmlDocument] (e.g. XHTML, SVG,
  /// etc.), converts it to HTML document.
  ///
  /// Currently conversion happens by inserting the document element into the
  /// body of blank HTML document.
  HtmlDocument parseHtmlFromAnything({
    required Window window,
    required String content,
    String mime = 'text/html',
  }) {
    final document = parseDocument(
      window: window,
      content: content,
      mime: mime,
    );
    if (document is HtmlDocument) {
      return document;
    }
    if (document is XmlDocument) {
      // Convert XML document to HTML document
      final htmlDocument = HtmlDocument.internal(
        window: window,
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
    throw StateError('Invalid document type');
  }

  XmlDocument parseSvg({
    required Window window,
    required String content,
    String mime = 'application/svg',
  }) {
    return parseXml(
      window: window,
      content: content,
      mime: mime,
    );
  }

  XmlDocument parseXhtml({
    required Window window,
    required String content,
    String mime = 'application/xhtml+xml',
  }) {
    return parseXml(
      window: window,
      content: content,
      mime: mime,
    );
  }

  XmlDocument parseXml({
    required String content,
    required Window window,
    String mime = 'text/xml',
  }) {
    return xml.parseXml(
      content,
      mime: mime,
    );
  }
}
