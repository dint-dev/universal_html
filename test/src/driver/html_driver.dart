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

void _testHtmlDriver() {
  final nodeToString = BrowserImplementationUtils.nodeToString;
  group('HtmlDriver', () {
    test('setDocument(null) resets the state', () {
      final driver = HtmlDriver();
      final oldDocument = driver.document;
      final oldWindow = driver.window;
      driver.setDocument(null);
      expect(driver.document, isNot(same(oldDocument)));
      expect(driver.window, isNot(same(oldWindow)));
    });

    test('setDocumentFromContent(...) supports HTML', () {
      final driver = HtmlDriver();
      driver.setDocumentFromContent(
        '<html><body><div>Example</div></body></html>',
      );
      expect(driver.document.body, isNotNull);
      expect(driver.document.body.children, hasLength(1));
      expect(driver.document.body.children.single, TypeMatcher<DivElement>());
      expect(driver.document.body.innerHtml, '<div>Example</div>');
    });

    test('setDocumentFromContent(...) supports XML', () {
      final driver = HtmlDriver();
      driver.setDocumentFromContent(
        '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<root><product>Example</product></root>
''',
      );
      final document = driver.document;
      expect(
        nodeToString(document),
        '<root><product>Example</product></root>',
      );
      expect(
        driver.document.documentElement.outerHtml,
        '<root><product>Example</product></root>',
      );
    });

    test('newHttpClient() uses htmlDriver.userAgent', () {
      final userAgent = UserAgent('Example');
      final driver = HtmlDriver(userAgent: userAgent);
      expect(driver.userAgent, userAgent);
      expect(driver.browserImplementation.newHttpClient().userAgent, 'Example');
    });

    test('window.navigator.userAgent uses htmlDriver.userAgent', () {
      final userAgent = UserAgent('Example');
      final driver = HtmlDriver(userAgent: userAgent);
      expect(driver.userAgent, userAgent);
      expect(driver.window.navigator.userAgent, 'Example');
    });
  });
}
