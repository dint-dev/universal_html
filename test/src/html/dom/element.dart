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

final throwsDomException = throwsA(isA<DomException>());

void _testElement() {
  group('Element:', () {
    group('Element.tag:', () {
      test('simple', () {
        expect(Element.tag('div'), isA<DivElement>());
        expect(Element.tag('Tag'), isA<Element>());
      });
      test('fails if the name is invalid', () {
        const invalidChars = ['<', '>', '"', ' ', '&'];
        for (var c in invalidChars) {
          expect(() {
            Element.tag(c);
          }, throwsDomException);

          expect(() {
            Element.tag('x${c}x');
          }, throwsDomException);
        }
      });
    });

    test('tagName', () {
      expect(DivElement().tagName, 'DIV');
      expect(ImageElement().tagName, 'IMG');
      expect(ParagraphElement().tagName, 'P');
      expect(Element.tag('Tag').tagName, 'TAG');
    });

    test('nodeName', () {
      expect(DivElement().nodeName, 'DIV');
      expect(ImageElement().nodeName, 'IMG');
      expect(ParagraphElement().nodeName, 'P');
      expect(Element.tag('Tag').nodeName, 'TAG');
    });

    test('localName', () {
      expect(DivElement().localName, 'div');
      expect(ImageElement().localName, 'img');
      expect(ParagraphElement().localName, 'p');
      expect(Element.tag('Tag').localName, 'tag');
    });

    group('innerHtml:', () {
      test('attributes', () {
        final input = Element.tag('a')
          ..setAttribute('someAttribute', 'someValue')
          ..appendText('a')
          ..appendText('b')
          ..appendText('c');
        expect(input.innerHtml, 'abc');
      });

      test('text, comments', () {
        final input = Element.tag('a')
          ..appendText('a')
          ..append(Comment('b'))
          ..appendText('c');
        expect(input.innerHtml, 'a<!--b-->c');
      });
    });

    group('innerHtml=:', () {
      test('null', () {
        final input = DivElement()..text = 'old text';
        input.innerHtml = null;
        expect(input.innerHtml, 'null');
      });
      test('elements, text', () {
        final input = DivElement();
        input.innerHtml = '<span>a</span><span>b</span>';
        expect(input.firstChild!.text, 'a');
        expect(input.lastChild!.text, 'b');
      });
    });

    group('outerHtml:', () {
      test('handles single tags like <br> and <img>', () {
        // Empty elements from:
        // https://developer.mozilla.org/en-US/docs/Glossary/empty_element
        final tags = const [
          'area',
          'base',
          'br',
          'col',
          'embed',
          'hr',
          'img',
          'input',
          'link',
          'meta',
          'param',
          'source',
          'track',
          'wbr',
        ];

        for (var tag in tags) {
          final element = Element.tag(tag);
          expect(element.outerHtml, '<$tag>');

          element.setAttribute('k0', 'v0');
          expect(element.outerHtml, '<$tag k0="v0">');

          element.setAttribute('k1', 'v1');
          expect(element.outerHtml, '<$tag k0="v0" k1="v1">');
        }
      });

      test('uses lowerCase for element/attribute names', () {
        final input = Element.tag('aA')
          ..setAttribute('bB', 'cC')
          ..appendText('dD');
        final expected = '<aa bb="cC">dD</aa>';
        expect(input.outerHtml, equals(expected));
      });

      test('prints element style: font-size', () {
        final input = Element.tag('a')..style.fontSize = '1px';
        final expected = '<a style="font-size: 1px;"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('prints element style: font-family: "Times New Roman"', () {
        final input = Element.tag('a')..style.fontFamily = '"Times New Roman"';
        final expected =
            '<a style="font-family: &quot;Times New Roman&quot;;"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('prints element style: font-family: serif', () {
        final input = Element.tag('a')..style.fontFamily = 'serif';
        final expected = '<a style="font-family: serif;"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('prints element style: color: #ffFFFF', () {
        final input = Element.tag('a')..style.color = '#ffFFFF';
        final expected = '<a style="color: #ffFFFF;"></a>';
        expect(input.outerHtml, equals(expected));
      }, testOn: 'vm'); // <-- DIFFERENCE: Chrome prints: rgb(255,255,255)

      test('prints element style: color: rgb(0, 0, 99)', () {
        final input = Element.tag('a')..style.color = 'rgb(0, 0, 99)';
        final expected = '<a style="color: rgb(0, 0, 99);"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('prints element style: content: none', () {
        final input = Element.tag('a')..style.content = r'none';
        final expected = r'<a style="content: none;"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('prints element style: content: quotes', () {
        final input = Element.tag('a')..style.content = r'"example\"\\"';
        final expected =
            r'<a style="content: &quot;example\&quot;\\&quot;;"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('escapes text', () {
        final input = Element.tag('a')..appendText('&<>"');
        final expected = '<a>&amp;&lt;&gt;"</a>';
        expect(input.outerHtml, equals(expected));
      });

      test('escapes element class', () {
        final input = Element.tag('a')..className = '&"';
        final expected = '<a class="&amp;&quot;"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('escapes element id', () {
        final input = Element.tag('a')..id = '&"';
        final expected = '<a id="&amp;&quot;"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('escapes attribute value', () {
        final input = Element.tag('sometag')..setAttribute('k', '&"<>');
        final expected = '<sometag k="&amp;&quot;<>"></sometag>';
        expect(input.outerHtml, equals(expected));
      });

      test('supports multiple attributes', () {
        final input = Element.tag('a')
          ..className = 'x'
          ..setAttribute('id', 'y')
          ..setAttribute('href', 'z');
        final expected = '<a class="x" id="y" href="z"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('supports multiple children', () {
        final input = Element.tag('sometag')
          ..appendText('a')
          ..append(Element.tag('b')..appendText('c'))
          ..append(Comment('d'));
        final expected = '<sometag>a<b>c</b><!--d--></sometag>';
        expect(input.outerHtml, equals(expected));
      });

      test('supports multiple attributes and multiple children', () {
        final input = Element.tag('sometag')
          ..className = 'x'
          ..setAttribute('k0', 'v0')
          ..setAttribute('k1', 'v1')
          ..appendText('a')
          ..append(Element.tag('b')..appendText('c'))
          ..append(Comment('d'));
        final expected =
            '<sometag class="x" k0="v0" k1="v1">a<b>c</b><!--d--></sometag>';
        expect(input.outerHtml, equals(expected));
      });
    });

    group('Attributes:', () {
      _testElementAttributes();
    });

    // toString()
    //
    // We test toString() only in the VM, because Chrome implementation is not
    // good for debugging, which is the main purpose of toString().
    group('toString()', () {
      test('empty element', () {
        final node = Element.div();
        expect(node.toString(), '<div></div>');
      });
      test('complex element', () {
        final node = Element.div()
          ..setAttribute('data-k0', 'v0')
          ..appendText('abc');
        expect(node.toString(), '''<div data-k0="v0">abc</div>''');
      });
    }, testOn: 'vm');
  });
}
