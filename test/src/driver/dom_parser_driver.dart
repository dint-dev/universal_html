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

part of driver_test;

void _testDomParserDriver() {
  final nodeToString = BrowserImplementationUtils.nodeToString;

  group('DomParserDriver', () {
    final parser = DomParserDriver();

    test('parseDocument(...), <!DOCTYPE HTML>', () {
      final source =
          '<!DOCTYPE HTML><html><body><div>Example</div></body></html>';
      final document = parser.parseHtml(source);
      expect(
        nodeToString(document),
        '<!doctype><html><head></head><body><div>Example</div></body></html>',
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, '<div>Example</div>');
    });

    test('parseDocument(...), <html>...</html>', () {
      final source = '<html><body><div>Example</div></body></html>';
      final document = parser.parseHtml(source);
      expect(
        nodeToString(document),
        '<html><head></head><body><div>Example</div></body></html>',
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, '<div>Example</div>');
    });

    test('parseHtmlDocument(...), <!DOCTYPE HTML>', () {
      final source =
          '<!DOCTYPE HTML><html><body><div>Example</div></body></html>';
      final document = parser.parseHtmlFromAnything(source);
      expect(
        nodeToString(document),
        '<!doctype><html><head></head><body><div>Example</div></body></html>',
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, '<div>Example</div>');
    });

    test('parseHtmlDocument(...), <html>...</html>', () {
      final source = '<html><body><div>Example</div></body></html>';
      final document = parser.parseHtmlFromAnything(source);
      expect(
        nodeToString(document),
        '<html><head></head><body><div>Example</div></body></html>',
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, '<div>Example</div>');
    });

    test('parseHtmlDocumentFromHtml(...), <!DOCTYPE HTML>', () {
      final source =
          '<!DOCTYPE HTML><html><body><div>Example</div></body></html>';
      final document = parser.parseHtml(source);
      expect(
        nodeToString(document),
        '<!doctype><html><head></head><body><div>Example</div></body></html>',
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, '<div>Example</div>');
    });

    test('parseHtmlDocumentFromHtml(...), <html>...</html>', () {
      final source = '<html><body><div>Example</div></body></html>';
      final document = parser.parseHtml(source);
      expect(
        nodeToString(document),
        '<html><head></head><body><div>Example</div></body></html>',
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, '<div>Example</div>');
    });
  });
}
