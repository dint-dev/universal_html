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

const _ = '';

void main() {
  test('parseHtmlDocument()', () {
    final document = parseHtmlDocument('<html><body>abc</body></html>');
    expect(document, isA<HtmlDocument>());
    expect(document.body!.firstChild!.text, 'abc');
  });

  group('parseXmlDocument():', () {
    test('a simple example', () {
      final document = parseXmlDocument('<e0><e1>abc</e1></e0>');
      expect(document, isA<XmlDocument>());
      expect(document.documentElement!.children.first.text, 'abc');
    });

    group('<?xml?>:', () {
      test('<?xml version="1.0" encoding="UTF-8"?>', () {
        final document = parseXmlDocument(
          '<?xml version="1.0" encoding="UTF-8"?><doc></doc>',
        );
        expect(document, isA<XmlDocument>());

        final node = document.documentElement!;
        expect(node.tagName, 'doc');
        expect(node.firstChild, isNull);
      });
    });

    group('doctype:', () {
      test('<!DOCTYPE x>', () {
        final document = parseXmlDocument(
          '<?xml version="1.0" encoding="UTF-8"?>\n'
          '<!DOCTYPE x>\n'
          '<doc></doc>',
        );

        expect(document, isA<XmlDocument>());
        expect(
          document.childNodes[0].nodeType,
          Node.DOCUMENT_TYPE_NODE,
        );
        expect(
          document.childNodes[1].nodeType,
          Node.ELEMENT_NODE,
        );

        final docType = document.firstChild!;
        expect(docType.nodeType, Node.DOCUMENT_TYPE_NODE);
        expect(docType.nodeName, 'x');
        expect(docType.nodeValue, isNull);
        expect(docType.text, isNull);

        final node = document.documentElement!;
        expect(node.tagName, 'doc');
        expect(node.firstChild, isNull);
      });
      test('long', () {
        final document = parseXmlDocument(
          '<?xml version="1.0" encoding="UTF-8"?>\n'
          '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">\n'
          '<doc></doc>',
        );

        expect(document, isA<XmlDocument>());
        expect(
          document.childNodes[0].nodeType,
          Node.DOCUMENT_TYPE_NODE,
        );
        expect(
          document.childNodes[1].nodeType,
          Node.ELEMENT_NODE,
        );

        final docType = document.firstChild!;
        expect(docType.nodeType, Node.DOCUMENT_TYPE_NODE);
        expect(docType.nodeName, 'html');
        expect(docType.nodeValue, isNull);
        expect(docType.text, isNull);

        final node = document.documentElement!;
        expect(node.tagName, 'doc');
        expect(node.firstChild, isNull);
      });
    });

    group('comments:', () {
      test('<!-- value -->', () {
        final document = parseXmlDocument('<xml><!-- value --></xml>');
        expect(document, isA<XmlDocument>());
        final node = document.firstChild!.firstChild!;
        expect(node, isA<Comment>());
        expect(node.nodeValue, ' value ');
        expect(node.text, ' value ');
      });

      test(r'<!--\n\t-->', () {
        final document = parseXmlDocument('<xml><!--\n\t--></xml>');
        expect(document, isA<XmlDocument>());
        final node = document.firstChild!.firstChild!;
        expect(node, isA<Comment>());
        expect(node.nodeValue, '\n\t');
        expect(node.text, '\n\t');
      });

      // $_ prevents HTML warnings
      test('<!--$_->-->', () {
        final document = parseXmlDocument('<xml><!--$_->--></xml>');
        expect(document, isA<XmlDocument>());
        final node = document.firstChild!.firstChild!;
        expect(node, isA<Comment>());
        expect(node.nodeValue, '->');
        expect(node.text, '->');
      });
    });

    test('cdata', () {
      // $_ prevents HTML warnings
      final document = parseXmlDocument('<xml><![CDATA[ value ]$_]></xml>');
      expect(document, isA<XmlDocument>());
      final node = document.firstChild!.firstChild!;
      expect(node, isA<Text>());
      expect(node.text, ' value ');
    });

    group('entities in text:', () {
      test('&amp;', () {
        final document = parseXmlDocument('<xml>&amp;</xml>');
        expect(document.firstChild!.text, '&');
      });
      test('a&amp;b', () {
        final document = parseXmlDocument('<xml>a&amp;b</xml>');
        expect(document.firstChild!.text, 'a&b');
      });
      test('&quot;', () {
        final document = parseXmlDocument('<xml>&quot;</xml>');
        expect(document.firstChild!.text, '"');
      });
      test('&lt;', () {
        final document = parseXmlDocument('<xml>&lt;</xml>');
        expect(document.firstChild!.text, '<');
      });
      test('&gt;', () {
        final document = parseXmlDocument('<xml>&gt;</xml>');
        expect(document.firstChild!.text, '>');
      });
      test('&nabla;', () {
        final document = parseXmlDocument('<xml>&nabla;</xml>');
        expect(
          document.firstChild!.text,
          contains('Entity \'nabla\' not defined'),
        );
      });
    });

    group('entities in attributes:', () {
      test('&amp;', () {
        final document = parseXmlDocument('<xml><e k="&amp;"/></xml>');
        final element = document.firstChild!.firstChild as Element;
        expect(element.getAttribute('k'), '&');
      });
      test('a&amp;b', () {
        final document = parseXmlDocument('<xml><e k="a&amp;b"/></xml>');
        final element = document.firstChild!.firstChild as Element;
        expect(element.getAttribute('k'), 'a&b');
      });
      test('&quot;', () {
        final document = parseXmlDocument('<xml><e k="&quot;"/></xml>');
        final element = document.firstChild!.firstChild as Element;
        expect(element.getAttribute('k'), '"');
      });
      test('&lt;', () {
        final document = parseXmlDocument('<xml><e k="&lt;"/></xml>');
        final element = document.firstChild!.firstChild as Element;
        expect(element.getAttribute('k'), '<');
      });
      test('&gt;', () {
        final document = parseXmlDocument('<xml><e k="&gt;"/></xml>');
        final element = document.firstChild!.firstChild as Element;
        expect(element.getAttribute('k'), '>');
      });
      test('&nabla;', () {
        final document = parseXmlDocument('<xml><e k="&nabla;"/></xml>');
        final element = document.firstChild!.firstChild as Element;
        expect(
          element.text,
          contains('Entity \'nabla\' not defined'),
        );
      });
    });

    group('elements:', () {
      test('<x/>', () {
        final document = parseXmlDocument('<xml><x/></xml>');
        expect(document, isA<XmlDocument>());
        final element = document.firstChild!.firstChild as Element;
        expect(element.tagName, 'x');
        expect(element.attributes.keys, isEmpty);
      });
      test('<x/><y/>', () {
        final document = parseXmlDocument('<xml><x/><y/></xml>');
        expect(document, isA<XmlDocument>());
        final element = document.firstChild!.firstChild as Element;
        expect(element.tagName, 'x');
        expect(element.attributes.keys, isEmpty);
      });
      test('<x />', () {
        final document = parseXmlDocument('<xml><x /></xml>');
        expect(document, isA<XmlDocument>());
        final element = document.firstChild!.firstChild as Element;
        expect(element.tagName, 'x');
        expect(element.attributes.keys, isEmpty);
      });
      test('<x k0="v0" k1="v1"/>', () {
        final document = parseXmlDocument('<xml><x k0="v0" k1="v1"/></xml>');
        expect(document, isA<XmlDocument>());
        final element = document.firstChild!.firstChild as Element;
        expect(element.tagName, 'x');
        expect(element.attributes.keys.toList()..sort(), ['k0', 'k1']);
        expect(element.getAttribute('k0'), 'v0');
        expect(element.getAttribute('k1'), 'v1');
      });
      test('<x k=" a b c " />', () {
        final document = parseXmlDocument('<xml><x k=" a b c " /></xml>');
        expect(document, isA<XmlDocument>());
        final element = document.firstChild!.firstChild as Element;
        expect(element.tagName, 'x');
        expect(element.attributes.keys.toList(), ['k']);
        expect(element.getAttribute('k'), ' a b c ');
      });
      test('<x k0="v0" k1="v1">abc</x>', () {
        final document =
            parseXmlDocument('<xml><x k0="v0" k1="v1">abc</x></xml>');
        expect(document, isA<XmlDocument>());
        final element = document.firstChild!.firstChild as Element;
        expect(element.tagName, 'x');
        expect(element.attributes.keys.toList()..sort(), ['k0', 'k1']);
        expect(element.getAttribute('k0'), 'v0');
        expect(element.getAttribute('k1'), 'v1');
        expect(element.childNodes, hasLength(1));
        expect(element.firstChild, isA<Text>());
        expect(element.firstChild!.text, 'abc');
      });
      test('<x k="v" >abc</x>', () {
        final document = parseXmlDocument('<xml><x k="v" >abc</x></xml>');
        expect(document, isA<XmlDocument>());
        final element = document.firstChild!.firstChild as Element;
        expect(element.tagName, 'x');
        expect(element.attributes.keys.toList(), ['k']);
        expect(element.childNodes, hasLength(1));
        expect(element.firstChild, isA<Text>());
        expect(element.firstChild!.text, 'abc');
      });
      test('<x></x><y></y>', () {
        final document = parseXmlDocument('<xml><x></x><y></y></xml>');
        expect(document, isA<XmlDocument>());

        final x = document.firstChild!.firstChild as Element;
        expect(x.tagName, 'x');
        expect(x.attributes.keys.toList(), []);
        expect(x.childNodes, hasLength(0));

        final y = document.firstChild!.firstChild!.nextNode as Element;
        expect(y.tagName, 'y');
        expect(y.attributes.keys.toList(), []);
        expect(y.childNodes, hasLength(0));
      });

      test('<x><y>abc</y></x>', () {
        final document = parseXmlDocument('<xml><x><y>abc</y></x></xml>');
        expect(document, isA<XmlDocument>());

        final x = document.firstChild!.firstChild as Element;
        expect(x.tagName, 'x');
        expect(x.attributes.keys.toList(), []);
        expect(x.childNodes, hasLength(1));

        final y = x.firstChild as Element;
        expect(y.tagName, 'y');
        expect(y.attributes.keys.toList(), []);
        expect(y.childNodes, hasLength(1));

        expect(y.firstChild, isA<Text>());
        expect(y.firstChild!.text, 'abc');
      });
    });
  });
}
