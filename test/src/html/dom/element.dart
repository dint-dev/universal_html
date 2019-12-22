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
    test('"Element.tag" fails if the name is invalid', () {
      const invalidChars = ['<', '>', '"', ' ', '&'];
      for (var c in invalidChars) {
        expect(() {
          Element.tag('${c}');
        }, throwsDomException);

        expect(() {
          Element.tag('x${c}x');
        }, throwsDomException);
      }
    });

    test('tagName', () {
      expect(DivElement().tagName, 'DIV');
      expect(ImageElement().tagName, 'IMG');
      expect(ParagraphElement().tagName, 'P');
    });

    test('nodeName', () {
      expect(DivElement().nodeName, 'DIV');
      expect(ImageElement().nodeName, 'IMG');
      expect(ParagraphElement().nodeName, 'P');
    });

    group('innerHtml:', () {
      test('works with attributes', () {
        final input = Element.tag('a')
          ..setAttribute('someAttribute', 'someValue')
          ..appendText('a')
          ..appendText('b')
          ..appendText('c');
        final expected = 'abc';
        expect(input.innerHtml, equals(expected));
      });

      test('works with no attributes', () {
        final input = Element.tag('a')
          ..appendText('a')
          ..append(Comment('b'))
          ..appendText('c');
        final expected = 'a<!--b-->c';
        expect(input.innerHtml, equals(expected));
      });

      test('setting works', () {
        final input = DivElement();
        input.innerHtml = '<span>a</span><span>b</span>';
        expect(input.firstChild.text, 'a');
        expect(input.lastChild.text, 'b');
      });
    });

    group('outerHtml:', () {
      test('handles single tags like <br> and <img>', () {
        /// Empty elements from:
        /// https://developer.mozilla.org/en-US/docs/Glossary/empty_element
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

      test('prints element style, no quotes', () {
        final input = Element.tag('a')..style.fontSize = '1px';
        final expected = '<a style="font-size: 1px;"></a>';
        expect(input.outerHtml, equals(expected));
      });

      test('prints element style, quotes', () {
        final input = Element.tag('a')..style.fontFamily = 'Comic Sans';
        final expected = '<a style="font-family: &quot;Comic Sans&quot;;"></a>';
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

    group('Attributes', () {
      test('setAttribute(...)', () {
        final e = Element.tag('e');
        e.setAttribute('k0', 'v0');
        expect(e.getAttribute('k0'), equals('v0'));
        e.setAttribute('K1', 'v1');
        e.setAttribute('k2', 'v2');
        expect(e.getAttribute('k0'), equals('v0'));
        expect(e.getAttribute('k1'), equals('v1'));
        expect(e.getAttribute('k2'), equals('v2'));
        expect(e.getAttribute('style'), isNull);
        expect(e.attributes, hasLength(equals(3)));
        expect(e.attributes['k0'], equals('v0'));
        expect(e.attributes['k1'], equals('v1'));
        expect(e.attributes['k2'], equals('v2'));
        expect(e.attributes['style'], isNull);
        expect(e.outerHtml, equals('<e k0="v0" k1="v1" k2="v2"></e>'));
      });

      test('setAttribute(...), null value', () {
        final e = Element.tag('e');
        e.setAttribute('k0', null);
        expect(e.getAttribute('k0'), 'null');
        expect(e.attributes['k0'], 'null');
      });

      test('setAttribute(...) fails if the name is invalid', () {
        const invalidChars = ['<', '>', '"', ' ', '&'];
        for (var c in invalidChars) {
          expect(() {
            Element.tag('x').setAttribute(c, '');
          }, throwsDomException);
          expect(() {
            Element.tag('x').setAttribute('x${c}x', '');
          }, throwsDomException);
        }
      });

      test('removeAttribute(...)', () {
        final e = Element.tag('e');
        e.setAttribute('k0', 'v0');
        e.setAttribute('removed', 'removed_value');
        expect(e.attributes.containsKey('removed'), isTrue);
        e.removeAttribute('removed');
        expect(e.getAttribute('removed'), null);
        expect(e.attributes.containsKey('removed'), isFalse);
      });
    });

    group('style:', () {
      test('style.setProperty(..), null value', () {
        final e = Element.tag('a');
        final k = 'color';
        final v = 'blue';
        expect(e.style.getPropertyValue(k), equals(''));
        e.style.setProperty(k, v);
        expect(e.style.getPropertyValue(k), equals(v));
        expect(e.outerHtml, contains(v));
        e.style.setProperty(k, null);
        expect(e.style.getPropertyValue(k), equals(''));
        expect(e.outerHtml, isNot(contains(v)));
      });

      test('style.removeProperty(...)', () {
        final e = Element.tag('a');
        final k = 'color';
        final v = 'blue';
        expect(e.style.getPropertyValue(k), equals(''));
        e.style.setProperty(k, v);
        expect(e.style.getPropertyValue(k), equals(v));
        expect(e.outerHtml, contains(v));
        e.style.removeProperty(k);
        expect(e.style.getPropertyValue(k), equals(''));
        expect(e.outerHtml, isNot(contains(v)));
      });

      test('style.setProperty(...), changes result of element.getAttribute',
          () {
        final e = Element.tag('a');
        e.style.setProperty('color', 'blue');
        expect(e.getAttribute('style'), contains('blue'));
      });

      test('style.setProperty(...), changes result of element.attributes', () {
        final e = Element.tag('a');
        e.style.setProperty('color', 'blue');
        expect(e.attributes['style'], contains('blue'));
      });

      test(
          'style.setProperty(...), changes result of element.attributes, obtained before setting style',
          () {
        final e = Element.tag('a');
        final attributes = e.attributes;
        e.style.setProperty('color', 'blue');
        expect(attributes['style'], contains('blue'));
      });

      test('style.setProperty(...), changes result of element.outerHtml', () {
        final e = Element.tag('a');
        e.style.setProperty('color', 'blue');
        expect(e.outerHtml, contains('blue'));
      });

      test(
          'style.getProperty("font-size") returns non-quoted value when value is "90px"',
          () {
        final e = Element.tag('a');
        e.style.setProperty('font-size', '90px');
        expect(e.style.getPropertyValue('font-size'), '90px');
      });

      test('element.setAttribute("style", value), changes element.style', () {
        final variations = const [
          'color: blue',
          'color:blue;',
        ];
        for (var variation in variations) {
          final e = Element.tag('a');
          e.setAttribute('style', variation);
          expect(e.getAttribute('style'), equals(variation));
          expect(e.attributes['style'], equals(variation));
          expect(e.style.color, equals('blue'));
        }
      });

      test('element.attributes["style"]="color: blue", changes element.style',
          () {
        final e = Element.tag('a');
        final value = 'color: blue';
        e.attributes['style'] = value;
        expect(e.getAttribute('style'), value);
        expect(e.attributes['style'], value);
        expect(e.style.color, 'blue');
      });

      test(
          'element.attributes["style"]="color: blue; font-size: 2em", changes element.style',
          () {
        final e = Element.tag('a');
        final value = 'color: blue; font-size: 2em';
        e.attributes['style'] = value;
        expect(e.getAttribute('style'), value);
        expect(e.attributes['style'], value);
        expect(e.style.color, 'blue');
        expect(e.style.fontSize, '2em');
      });

      test('element.removeAttribute("style") removes style', () {
        final e = Element.tag('e');
        expect(e.style.getPropertyValue('font-family'), '');
        e.style.setProperty('font-family', 'Verdana');
        expect(e.style.getPropertyValue('font-family'), 'Verdana');
        e.removeAttribute('style');
        expect(e.style.getPropertyValue('font-family'), '');
      });
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
          ..setAttribute('k0', 'v0')
          ..appendText('abc');
        expect(node.toString(), '''<div k0="v0">abc</div>''');
      });
    }, testOn: 'vm');
  });
}
