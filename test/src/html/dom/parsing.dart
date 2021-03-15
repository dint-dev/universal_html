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

part of main_test;

void _testParsing() {
  group('Parsing nodes:', () {
    test('`DomParser, "text/html"', () {
      final contentType = 'text/html';
      const source = '''
<div k0 k1="v1" K2="v2" ns:k3="v3" :k4="v4" @k5="v5" [k6]="v6">
some text
<!--some comment-->
<h1>element #1</h1>
<Img src="image.jpeg">
<COMPLEX-element.name />
</div>''';

      // Parse
      final document = DomParser().parseFromString(source, contentType);
      expect(document, isA<HtmlDocument>());
      expect(document.contentType, contentType);
      expect(document.childNodes, hasLength(1));

      // <html>...</html>
      final root = document.documentElement!;
      expect(root.ownerDocument, same(document));
      expect(root.ownerDocument!.contentType, contentType);
      expect(root, isA<HtmlElement>());
      expect(root.tagName, 'HTML');
      expect(root.childNodes, hasLength(2));

      // <head></head>
      expect(root.childNodes[0], isA<HeadElement>());

      // <body></body>
      expect(root.childNodes[1], isA<BodyElement>());

      // <div k0 k1="" ...>
      final div = root.childNodes[1].firstChild;
      {
        expect(div, isA<DivElement>());

        final element = div as DivElement;
        expect(element.tagName, 'DIV');

        // Attribute values
        expect(element.getAttribute('k0'), '');
        expect(element.getAttribute('k1'), 'v1'); // Lowercase
        expect(element.getAttribute('K1'), 'v1'); // Uppercase
        expect(element.getAttribute('k2'), 'v2'); // Lowercase
        expect(element.getAttribute('K2'), 'v2'); // Uppercase
        expect(element.getAttribute('ns:k3'), 'v3');
        expect(element.getAttribute(':k4'), 'v4');
        expect(element.getAttribute('@k5'), 'v5');
        expect(element.getAttribute('[k6]'), 'v6');
      }

      // some text
      {
        final node = div.childNodes[0];
        expect(node, isA<Text>());
        expect(node.nodeValue, '\nsome text\n');
      }

      // <!--some comment-->
      {
        final node = div.childNodes[1];
        expect(node, isA<Comment>());
        expect(node.nodeValue, 'some comment');
      }

      // (newline)
      {
        final node = div.childNodes[2];
        expect(node, isA<Text>());
        expect(node.nodeValue, '\n');
      }

      // <h1>element #1</h1>
      {
        final node = div.childNodes[3];
        expect(node, isA<HeadingElement>());

        final element = node as HeadingElement;
        expect(element.tagName, 'H1');
        expect(element.text, 'element #1');
      }

      // (newline)
      {
        final node = div.childNodes[4];
        expect(node, isA<Text>());
        expect(node.nodeValue, '\n');
      }

      // <img href="element #2">
      {
        var node = div.childNodes[5];
        expect(node, isA<ImageElement>());

        final element = node as ImageElement;
        expect(element.tagName, 'IMG');
        expect(element.getAttribute('src'), 'image.jpeg');
      }

      // (newline)
      {
        final node = div.childNodes[6];
        expect(node, isA<Text>());
        expect(node.nodeValue, '\n');
      }

      // <COMPLEX-element.name />
      {
        var node = div.childNodes[7];
        expect(node, isA<Element>());

        final element = node as Element;
        expect(element.ownerDocument, same(document));
        expect(element.tagName, 'COMPLEX-ELEMENT.NAME');
        expect(element.localName, 'complex-element.name');
        expect(element.nodeName, 'COMPLEX-ELEMENT.NAME');
        expect(element.computedName, isNull);
        expect(element.namespaceUri, 'http://www.w3.org/1999/xhtml');
      }

      // Clone
      expect((root.clone(true) as Element).innerHtml, root.innerHtml);
      expect((root.clone(true) as Element).outerHtml, root.outerHtml);
    });

    group('XML content types:', () {
      test('`DomParser, "application/xhtml+xml"', () {
        final contentType = 'application/xhtml+xml';
        const source = '''
<!DOCTYPE example>
<!-- comment -->
<html>
<body>
<div k0="v0" k1="v1">
some text
<!--some comment-->
<h1>element #1</h1>
<img src="image.jpeg"></img>
</div>
</body>
</html>
''';

        // Parse
        final document = DomParser().parseFromString(source, contentType);
        expect(document.contentType, contentType);
        expect(document.childNodes, hasLength(3));

        // <html>...</html>
        final root = document.documentElement!;
        expect(root.ownerDocument, isNotNull);
        expect(root.ownerDocument!.contentType, contentType);
        expect(root, isNot(isA<HtmlHtmlElement>()));
        expect(root.nodeName, 'html');
        expect(root.tagName, 'html');
        expect(root.children, hasLength(1));
        expect(root.children[0], isNot(isA<BodyElement>()));

        final body = root.children[0];
        expect(body.children, hasLength(1));

        // <div k0="v0" k1="v1">
        final div = body.children.first;
        {
          expect(div, isNot(isA<DivElement>()));
          expect(div.tagName, 'div');
          expect(div.getAttribute('k0'), 'v0');
          expect(div.getAttribute('k1'), 'v1');
        }

        // some text
        {
          final node = div.childNodes[0];
          expect(node, isA<Text>());
          expect(node.nodeValue, '\nsome text\n');
        }

        // <!--some comment-->
        {
          final node = div.childNodes[1];
          expect(node, isA<Comment>());
          expect(node.nodeValue, 'some comment');
        }

        // (newline)
        {
          final node = div.childNodes[2];
          expect(node, isA<Text>());
          expect(node.nodeValue, '\n');
        }

        // <h1>element #1</h1>
        {
          final node = div.childNodes[3];
          expect(node, isNot(isA<HeadingElement>()));

          final element = node as Element;
          expect(element.tagName, 'h1');
          expect(element.text, 'element #1');
        }

        // (newline)
        {
          final node = div.childNodes[4];
          expect(node, isA<Text>());
          expect(node.nodeValue, '\n');
        }

        // <img src="image.jpeg">
        {
          var node = div.childNodes[5];
          expect(node, isNot(isA<ImageElement>()));

          final element = node as Element;
          expect(element.tagName, 'img');
          expect(element.getAttribute('src'), 'image.jpeg');
        }

        // Clone
        expect((root.clone(true) as Element).innerHtml, root.innerHtml);
        expect((root.clone(true) as Element).outerHtml, root.outerHtml);
      });

      for (var contentType in ['text/xml', 'application/xml']) {
        group('DomParser, "$contentType":', () {
          const source = '''
<root xmlns:x="test/ns">
<Child k0="v0" k1="v1">text</Child>
<x:Child x:k0="v0" x:k1="v1">text</x:Child>
</root>''';

          late Document document;
          late Element root;

          setUp(() {
            // Parse
            document = DomParser().parseFromString(source, contentType);
            expect(document.contentType, contentType);
            expect(document.documentElement!.outerHtml, source);
            root = document.documentElement!;
          });

          test('root', () {
            expect(root.ownerDocument, isNotNull);
            expect(root.ownerDocument!.contentType, contentType);
            expect(root, isA<Element>());
            expect(root.nodeName, 'root');
            expect(root.tagName, 'root');
            expect(root.childNodes, hasLength(5));
            expect(root.children, hasLength(2));
          });

          // <Child k0="v0" k1="v1">text</child>
          test('child #0', () {
            final element = root.children[0];
            expect(element.ownerDocument, isNotNull);
            expect(element.ownerDocument!.contentType, contentType);
            expect(element.tagName, 'Child', reason: 'tagName');
            expect(element.nodeName, 'Child', reason: 'nodeName');
            expect(element.localName, 'Child', reason: 'localName');
            expect(element.namespaceUri, isNull);
            expect(element.getAttributeNames().toList()..sort(), ['k0', 'k1']);
            expect(element.getAttribute('k0'), 'v0');
            expect(element.getAttributeNS(null, 'k0'), 'v0');
            expect(element.getAttributeNS('', 'k0'), 'v0');
            expect(element.attributes, hasLength(2));
            expect(element.attributes['k0'], 'v0');
            expect(element.attributes['k1'], 'v1');
            expect(
              element.getNamespacedAttributes('test/ns'),
              hasLength(0),
            );
//          expect(
//            element.getNamespacedAttributes(null),
//            hasLength(0),
//          );
            expect(element.getAttribute('k0'), 'v0');
            expect(element.getAttribute('k1'), 'v1');
            expect(element.getAttributeNS(null, 'k0'), 'v0');
            expect(element.getAttributeNS(null, 'k1'), 'v1');
            expect(element.childNodes, hasLength(1));
            expect(element.text, 'text');
          });

          // <x:Child x:k0="v0" x:k1="v1">text</x:child>
          //
          // Note that we have earlier declared:
          //   xmlns:x="test/ns"
          test('child #1', () {
            final element = root.children[1];
            expect(element.namespaceUri, 'test/ns');
            expect(element.tagName, 'x:Child', reason: 'tagName');
            expect(element.nodeName, 'x:Child', reason: 'nodeName');
            expect(element.localName, 'Child', reason: 'localName');
            expect(element.namespaceUri, 'test/ns');
            expect(element.attributes, isEmpty);
            expect(element.getNamespacedAttributes('test/ns'), hasLength(2));
            expect(element.getNamespacedAttributes(''), hasLength(0));
            expect(element.getAttributeNS('test/ns', 'k0'), 'v0');
            expect(element.getAttributeNS('test/ns', 'k1'), 'v1');
            expect(element.childNodes, hasLength(1));
            expect(element.text, 'text');
          });

          test('consistency', () {
            for (var element in root.children) {
              expect(element.parent, same(root));
            }
          });

          test('selectors', () {
            // ---------------------------------------------------------------------
            // Test various methods
            // ---------------------------------------------------------------------
            expect(document.querySelector('root'), isNotNull);
            expect(document.querySelectorAll('not-found'), hasLength(0));
            expect(
              document.querySelectorAll('child'),
              hasLength(0),
              reason: 'querySelectorAll("child")',
            );
            expect(
              document.querySelectorAll('Child'),
              hasLength(2),
              reason: 'querySelectorAll("Child")',
            );
            expect(
              document.getElementsByName('child'),
              hasLength(0),
              reason: 'getElementsByName("child")',
            );
            expect(
              document.getElementsByName('Child'),
              hasLength(0),
              reason: 'getElementsByName("Child")',
            );
            expect(
              document.getElementsByTagName('child'),
              hasLength(0),
              reason: 'getElementsByTagName("child")',
            );
            expect(
              document.getElementsByTagName('Child'),
              hasLength(1),
              reason: 'getElementsByTagName("Child")',
            );
          });

          test('cloning', () {
            expect((root.clone(true) as Element).innerHtml, root.innerHtml);
            expect((root.clone(true) as Element).outerHtml, root.outerHtml);
          });
        }); // HALTS FOR SOME REASONS :/
      }

      test('`DomParser, "text/xml" (default namespace)', () {
        const source = '''<a xmlns="example"><b>&amp;&lt;&gt;</b></a>''';
        final document = DomParser().parseFromString(source, 'text/xml');
        expect(document.documentElement!.outerHtml, source);
      });

      test('`DomParser, "text/xml" (comment before element)', () {
        const source = '''<!-- x --><a></a>''';
        final document = DomParser().parseFromString(source, 'text/xml');
        expect(document.childNodes, hasLength(2));
        expect(document.documentElement!.outerHtml, '<a/>');
      });

      test('`DomParser, "text/xml" (XML processing instruction)', () {
        const source = '''<?xml version="1.0"?><a></a>''';
        final document = DomParser().parseFromString(source, 'text/xml');
        expect(document.childNodes, hasLength(1));
        expect(document.documentElement!.outerHtml, '<a/>');
      });

      test('`DomParser, "text/xml" (doctype)', () {
        const source = '''<!DOCTYPE example><a></a>''';
        final document = DomParser().parseFromString(source, 'text/xml');
        expect(document.childNodes, hasLength(2));
        expect(document.documentElement!.outerHtml, '<a/>');
      });

      test('`DomParser, "text/xml" (special characters)', () {
        const source = '''<a>&amp;&lt;&gt;</a>''';
        final document = DomParser().parseFromString(source, 'text/xml');
        expect(document.documentElement!.outerHtml, source);
      });

      test(
          'DomParser, "text/xml" (element that doesn\'t have closing tag in HTML)',
          () {
        const source = '''<img>text</img>''';
        final document = DomParser().parseFromString(source, 'text/xml');
        expect(document.documentElement!.outerHtml, source);
      });

      test(
          'DomParser, "text/xml" (element that doesn\'t have closing tag in HTML, no content)',
          () {
        const source = '''<img/>''';
        final document = DomParser().parseFromString(source, 'text/xml');
        expect(document.documentElement!.outerHtml, source);
      });
    });
  });
}
