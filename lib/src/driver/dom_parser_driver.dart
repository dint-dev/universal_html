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

import 'package:meta/meta.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/src/html.dart';

import '_html_parser.dart' as html;
import '_xml_parser.dart' as xml;

/// Parses DOM trees.
class DomParserDriver {
  final HtmlDriver _htmlDriver;

  const DomParserDriver({HtmlDriver driver}) : _htmlDriver = driver;

  HtmlDriver get htmlDriver => _htmlDriver ?? HtmlDriver.current;

  /// Parses [Document] based on [mime] (e.g. 'text/html').
  ///
  /// The result is either [HtmlDocument] or [XmlDocument].
  Document parseDocument(
    String input, {
    @required String mime,
  }) {
    if (mime == null) {
      throw ArgumentError.notNull('mime');
    }
    switch (mime) {
      case 'text/plain':
        final document = BrowserImplementationUtils.newHtmlDocument(
          htmlDriver: htmlDriver,
          contentType: mime,
          filled: true,
        );
        document.body.appendText(input);
        return document;

      // HTML
      case 'text/html':
        return parseHtml(input, mime: mime);
      case 'application/html':
        return parseHtml(input, mime: mime);

      // XHTML
      case 'application/xhtml+xml':
        return parseXml(input, mime: mime);

      // SVG
      case 'text/svg':
        return parseSvg(input, mime: mime);
      case 'application/svg':
        return parseSvg(input, mime: mime);

      // XML
      case 'text/xml':
        return parseXml(input, mime: mime);
      case 'application/xml':
        return parseXml(input, mime: mime);

      default:
        throw ArgumentError.value(
          mime,
          'mime',
          'Unsupported MIME type',
        );
    }
  }

  DocumentFragment parseDocumentFragmentFromHtml(
      Document ownerDocument, String input,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    return html.parseDocumentFragmentFromHtml(
      ownerDocument,
      input,
      htmlDriver: htmlDriver,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
  }

  DocumentFragment parseDocumentFragmentFromSvg(
      Document ownerDocument, String input,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    return html.parseDocumentFragmentFromSvg(
      ownerDocument,
      input,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
  }

  HtmlDocument parseHtml(String input, {String mime = 'text/html'}) {
    return html.parseHtml(input, htmlDriver: htmlDriver, mime: mime);
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
    String mime = 'text/html',
  }) {
    final document = parseDocument(input, mime: mime);
    if (document is HtmlDocument) {
      return document;
    }
    if (document is XmlDocument) {
      // Convert XML document to HTML document
      final htmlDocument = BrowserImplementationUtils.newHtmlDocument(
        htmlDriver: htmlDriver,
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

  XmlDocument parseSvg(String input, {String mime = 'application/svg'}) {
    return parseXml(input, mime: mime);
  }

  XmlDocument parseXhtml(String input,
      {String mime = 'application/xhtml+xml'}) {
    return parseXml(input, mime: mime);
  }

  XmlDocument parseXml(String input, {String mime = 'text/xml'}) {
    return xml.parseXml(input, htmlDriver: htmlDriver, mime: mime);
  }
}
