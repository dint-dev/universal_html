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

/// Helpers for parsing HTML / XML.
library universal_html.parsing;

import 'package:universal_html/html.dart';

import 'src/parsing/parsing_impl_browser.dart'
    if (dart.library.io) 'src/parsing/parsing_impl_vm.dart' as impl;

/// Parses a [HtmlDocument].
///
/// ```
/// import 'package:universal_html/parsing.dart';
///
/// void main() {
///   final document = parseHtmlDocument('<html>...</html>');
/// }
/// ```
HtmlDocument parseHtmlDocument(String content) {
  ArgumentError.checkNotNull(content, 'content');
  return impl.parseHtmlDocument(content);
}

/// Parses an [XmlDocument].
///
/// ```
/// import 'package:universal_html/parsing.dart';
///
/// void main() {
///   final document = parseXmlDocument('<xml>...</xml>');
/// }
/// ```
XmlDocument parseXmlDocument(String content, {String mime = 'text/xml'}) {
  ArgumentError.checkNotNull(content, 'content');
  ArgumentError.checkNotNull(mime, 'mime');
  return impl.parseXmlDocument(content, mime: mime);
}
