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

library parsing_test;

import 'package:test/test.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

void main() {
  test('parseHtmlDocument()', () {
    final document = parseHtmlDocument('<html><body>abc</body></html>');
    expect(document, isA<HtmlDocument>());
    expect(document.body.firstChild.text, 'abc');
  });

  test('parseXmlDocument()', () {
    final document = parseXmlDocument('<e0><e1>abc</e1></e0>');
    expect(document, isA<XmlDocument>());
    expect(document.documentElement.children.first.text, 'abc');
  });
}
