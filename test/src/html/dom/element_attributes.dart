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

void _testElementAttributes() {
  group('element.hasAttribute', () {
    test('existing attribute is lowercase', () {
      final e = Element.tag('e');
      expect(e.hasAttribute('k'), isFalse);
      e.setAttribute('k', 'v');
      expect(e.hasAttribute('k'), isTrue);
      expect(e.hasAttribute('K'), isTrue);
    });

    test('existing attribute is uppercase', () {
      final e = Element.tag('e');
      expect(e.hasAttribute('k'), isFalse);
      e.setAttribute('K', 'v');
      expect(e.hasAttribute('k'), isTrue);
      expect(e.hasAttribute('K'), isTrue);
    });
  });
  group('element.setAttribute(...):', () {
    test('name is lowercase', () {
      final e = Element.tag('e');
      e.setAttribute('k0', 'v0');
      expect(e.getAttribute('k0'), 'v0');
      expect(e.getAttribute('K0'), 'v0');
    });

    test('name is uppercase', () {
      final e = Element.tag('e');
      e.setAttribute('K0', 'v0');
      expect(e.getAttribute('k0'), 'v0');
      expect(e.getAttribute('K0'), 'v0');
    });

    test('name is "style"', () {
      final e = Element.tag('e');
      e.setAttribute('style', 'v0');
      expect(e.getAttribute('style'), 'v0');
      e.setAttribute('style', 'v1');
      expect(e.getAttribute('style'), 'v1');
    });

    test('name is "STYLE"', () {
      final e = Element.tag('e');
      e.setAttribute('STYLE', 'v0');
      expect(e.getAttribute('style'), 'v0');
      e.setAttribute('style', 'v1');
      expect(e.getAttribute('style'), 'v1');
    });

    test('affects outerHtml', () {
      final e = Element.tag('e');
      e.setAttribute('k0', 'v0');
      e.setAttribute('K1', 'v1');
      e.setAttribute('k2', 'V2');
      expect(e.outerHtml, equals('<e k0="v0" k1="v1" k2="V2"></e>'));
    });

    test('replaces namespaced attribute with the same name', () {
      // setAttributeNS('NAMESPACE', 'k', ...)
      final e = Element.tag('e');
      e.setAttributeNS('https://ns/', 'k', 'v0');
      expect(e.getAttributeNS('https://ns/', 'k'), 'v0');
      expect(e.getAttribute('k'), 'v0');

      // setAttribute('k', ...)
      e.setAttribute('k', 'v1');
      expect(e.getAttribute('k'), 'v1');
      expect(e.getAttributeNS('https://ns/', 'k'), 'v1');
      expect(e.hasAttribute('k'), isTrue);
      expect(e.hasAttributeNS('https://ns/', 'k'), isTrue);
    });

    test('fails if the name is invalid', () {
      // Always invalid attribute characters
      const invalidChars = ['<', '>', '"', ' ', '\n', '&'];

      for (var invalidChar in invalidChars) {
        expect(
          () {
            Element.tag('x').setAttribute(invalidChar, '');
          },
          throwsDomException,
          reason: 'setAttribute("$invalidChar", _)',
        );
        expect(
          () {
            Element.tag('x').setAttribute('x${invalidChar}x', '');
          },
          throwsDomException,
          reason: 'setAttribute("x${invalidChar}x", _)',
        );
        expect(
          () {
            Element.tag('x').setAttributeNS('', invalidChar, '');
          },
          throwsDomException,
          reason: 'setAttributeNS(_, "$invalidChar", _)',
        );
      }

      // Invalid attribute starts
      const invalidStarts = ['0', '9', '.', '-'];

      for (var invalidStart in invalidStarts) {
        // setAttribute("-", _)
        expect(
          () {
            Element.tag('x').setAttribute(invalidStart, '');
          },
          throwsDomException,
          reason: 'setAttribute("$invalidStart", _)',
        );

        // setAttributeNS(_, "-", _)
        expect(
          () {
            Element.tag('x').setAttributeNS('', invalidStart, '');
          },
          throwsDomException,
          reason: 'setAttributeNS(_, "$invalidStart", _)',
        );

        // setAttributeNS(_, "prefix:-", _)
        expect(
          () {
            Element.tag('x').setAttributeNS('', 'prefix:$invalidStart', '');
          },
          throwsDomException,
          reason: 'setAttributeNS(_, "prefix:$invalidStart", _)',
        );
      }

      // setAttributeNS(_, "a:b:c", _)
      expect(
        () {
          Element.tag('x').setAttributeNS('exampleNS', 'a:b:c', '');
        },
        throwsDomException,
        reason: 'setAttributeNS(_, "a:b:c", _)',
      );

      // The following attributes look special, but they are allowed.
      DivElement().setAttribute('x', 'value');
      DivElement().setAttribute('X', 'value');
      DivElement().setAttribute('_', 'value');
      DivElement().setAttribute(':', 'value');
      DivElement().setAttribute('prefix:-', 'value');
      DivElement().setAttribute('x-X.09:_', 'value');

      DivElement().setAttributeNS('exampleNS', 'x', 'value');
      DivElement().setAttributeNS('exampleNS', 'X', 'value');
      DivElement().setAttributeNS('exampleNS', '_', 'value');
      DivElement().setAttributeNS('exampleNS', 'prefix:xX-_.09', 'value');
    });
  });

  group('element.setAttributeNS(...)', () {
    test('normal', () {
      final e = Element.tag('e');
      e.setAttributeNS('https://ns/', 'k0', 'v0');
      expect(e.getAttributeNS('https://ns/', 'k0'), 'v0');
      expect(
        e.getNamespacedAttributes('https://ns/'),
        {'k0': 'v0'},
      );
    });

    test('null namespace', () {
      final e = Element.tag('e');
      e.setAttributeNS(null, 'k0', 'v0');
      expect(e.getAttributeNS(null, 'other'), isNull);
      expect(e.getAttributeNS(null, 'k0'), 'v0');
      expect(
        e.getNamespacedAttributes(''),
        {'k0': 'v0'},
      );
      expect(e.getAttribute('other'), isNull);
      expect(e.getAttribute('k0'), 'v0');
    });

    test('fails if the name is invalid', () {
      const invalidChars = ['<', '>', '"', ' ', '&'];
      for (var c in invalidChars) {
        expect(() {
          Element.tag('x').setAttributeNS('namespace', c, '');
        }, throwsDomException);
        expect(() {
          Element.tag('x').setAttributeNS('namespace', 'x${c}x', '');
        }, throwsDomException);
      }
    });

    test('xmlns:prefix is defined before element is created', () {
      final element = DivElement();
      // Add parent that defines the namespace
      final parent = DivElement();
      parent.setAttribute('xmlns:prefix', 'example');
      parent.append(element);

      element.setAttributeNS('example', 'data-k', 'v');
      expect(element.outerHtml, '<div data-k="v"></div>');
    });

    test('xmlns:prefix is defined after element is created', () {
      final element = DivElement();
      element.setAttributeNS('example', 'data-k0', 'v0');
      expect(element.outerHtml, '<div data-k0="v0"></div>');

      // Add parent that defines the namespace
      final parent = DivElement();
      parent.setAttribute('xmlns:prefix', 'example');
      parent.append(element);

      expect(element.outerHtml, '<div data-k0="v0"></div>');
    });
  });

  group('element.removeAttribute(...):', () {
    test('name is wrong', () {
      final e = Element.tag('e');
      e.setAttribute('k', 'v0');
      e.removeAttribute('other key');
      expect(e.getAttribute('k'), 'v0');
      expect(e.attributes, hasLength(1));
    });

    test('name is lowercase', () {
      final e = Element.tag('e');
      e.setAttribute('k', 'v0');
      e.removeAttribute('k');
      expect(e.getAttribute('k'), isNull);
      expect(e.attributes, hasLength(0));
    });

    test('name is lowercase, existing is uppercase', () {
      final e = Element.tag('e');
      e.setAttribute('K', 'v0');
      e.removeAttribute('k');
      expect(e.getAttribute('k'), isNull);
      expect(e.attributes, hasLength(0));
    });

    test('name is uppercase', () {
      final e = Element.tag('e');
      e.setAttribute('K', 'v0');
      e.removeAttribute('K');
      expect(e.getAttribute('K'), isNull);
      expect(e.attributes, hasLength(0));
    });

    test('name is uppercase, existing is lowercase', () {
      final e = Element.tag('e');
      e.setAttribute('k', 'v0');
      e.removeAttribute('K');
      expect(e.getAttribute('K'), isNull);
      expect(e.attributes, hasLength(0));
    });

    test('name without prefix, existing attribute has prefix', () {
      final e = Element.tag('e');
      e.setAttribute('prefix:k', 'v0');
      expect(e.getAttribute('k'), isNull);
      expect(e.getAttributeNS('', 'k'), isNull);
      expect(e.getAttribute('prefix:k'), 'v0');
      expect(e.getAttributeNS('', 'prefix:k'), 'v0');

      // Prefix is needed for removing
      e.removeAttribute('k');
      expect(e.getAttribute('prefix:k'), 'v0');
      expect(e.getAttributeNS('', 'prefix:k'), 'v0');
    });

    test('name with a prefix', () {
      final e = Element.tag('e');
      e.setAttribute('prefix:k', 'v0');
      expect(e.getAttribute('prefix:k'), 'v0');
      expect(e.getAttributeNS('', 'prefix:k'), 'v0');

      // Remove
      e.removeAttribute('prefix:k');
      expect(e.getAttribute('prefix:k'), isNull);
      expect(e.getAttributeNS('', 'prefix:k'), isNull);
    });

    test('simple name, existing attribute was set with setAttribute(...)', () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttribute('k', 'v0');
      expect(e.getAttribute('k'), 'v0');

      // Remove
      e.removeAttribute('k');
      expect(e.getAttribute('k'), isNull);
    });

    test(
        'simple name, existing attribute was set with setAttributeNS(null, ...)',
        () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttributeNS(null, 'k', 'v0');
      expect(e.getAttribute('k'), 'v0');

      // Remove
      e.removeAttribute('k');
      expect(e.getAttribute('k'), isNull);
    });

    test(
        'simple name, existing attribute was set with setAttributeNS("ns", ...)',
        () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttributeNS('ns', 'k', 'v0');
      expect(e.getAttribute('k'), 'v0');
      expect(e.getAttributeNS(null, 'k'), isNull);
      expect(e.getAttributeNS('', 'k'), isNull);
      expect(e.getAttributeNS('ns', 'k'), 'v0');

      // Remove
      e.removeAttribute('k');
      expect(e.getAttribute('k'), isNull);
      expect(e.getAttributeNS(null, 'k'), isNull);
      expect(e.getAttributeNS('', 'k'), isNull);
      expect(e.getAttributeNS('ns', 'k'), isNull);
    });
  });

  group('element.removeAttributeNS(...):', () {
    test('normal', () {
      // Set three attributes
      final e = Element.tag('e');
      e.setAttribute('k', 'v0');
      e.setAttributeNS('https://ns0/', 'k', 'v1');
      e.setAttributeNS('https://ns1/', 'k', 'v2');
      expect(e.getAttribute('k'), 'v0');
      expect(e.getAttributeNS('https://ns0/', 'k'), 'v1');
      expect(e.getAttributeNS('https://ns1/', 'k'), 'v2');

      // Remove second one
      e.removeAttributeNS('https://ns0/', 'k');
      expect(e.getAttribute('k'), 'v0');
      expect(e.getAttributeNS('https://ns0/', 'k'), isNull);
      expect(e.getAttributeNS('https://ns1/', 'k'), 'v2');
    });

    test('null namespace, removed attribute was set with setAttribute', () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttribute('k0', 'v0');
      expect(e.getAttribute('k0'), 'v0');

      // Remove
      e.removeAttributeNS(null, 'k0');
      expect(e.getAttribute('k0'), isNull);
    });

    test('null namespace, removed attribute has namespace null', () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttributeNS(null, 'k0', 'v0');
      expect(e.getAttribute('k0'), 'v0');

      // Remove
      e.removeAttributeNS(null, 'k0');
      expect(e.getAttribute('k0'), isNull);
    });

    test('null namespace, removed attribute has namespace "ns"', () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttributeNS('ns', 'k0', 'v0');
      expect(e.getAttribute('k0'), 'v0');

      // Remove
      e.removeAttributeNS(null, 'k0');
      expect(e.getAttribute('k0'), 'v0');
    });

    test('empty namespace, removed attribute was set with setAttribute', () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttribute('k0', 'v0');
      expect(e.getAttribute('k0'), 'v0');

      // Remove
      e.removeAttributeNS('', 'k0');
      expect(e.getAttribute('k0'), isNull);
    });

    test('empty namespace, remoted attribute has null namespace', () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttributeNS(null, 'k0', 'v0');
      expect(e.getAttribute('k0'), 'v0');

      // Remove
      e.removeAttributeNS('', 'k0');
      expect(e.getAttribute('k0'), isNull);
    });

    test('empty namespace, removed attribute has empty namespace', () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttributeNS('', 'k0', 'v0');
      expect(e.getAttribute('k0'), 'v0');

      // Remove
      e.removeAttributeNS('', 'k0');
      expect(e.getAttribute('k0'), isNull);
    });

    test('empty namespace, removed attribute has namespace "ns"', () {
      // Set two attributes
      final e = Element.tag('e');
      e.setAttributeNS('ns', 'k', 'v0');
      expect(e.getAttribute('k'), 'v0');

      // Remove
      e.removeAttributeNS('', 'k');
      expect(e.getAttribute('k'), 'v0');
    });
  });

  group('element.classes', () {
    test('add(...), contains(...), toList(...)', () {
      final element = DivElement();
      element.classes.add('c0');
      expect(element.classes, contains('c0'));
      expect(element.classes.toList(), ['c0']);
      expect(element.outerHtml, '<div class="c0"></div>');

      element.classes.add('c1');
      expect(element.classes, contains('c0'));
      expect(element.classes, contains('c1'));
      expect(element.classes.toList(), ['c0', 'c1']);
      expect(element.outerHtml, '<div class="c0 c1"></div>');
    });

    test('remove(...)', () {
      final element = DivElement();
      element.classes.add('c0');
      element.classes.add('c1');
      expect(element.outerHtml, '<div class="c0 c1"></div>');

      element.classes.remove('c0');
      expect(element.classes, isNot(contains('c0')));
      expect(element.classes, contains('c1'));
      expect(element.classes.toList(), ['c1']);
      expect(element.outerHtml, '<div class="c1"></div>');

      element.classes.remove('c1');
      expect(element.outerHtml, '<div class=""></div>');
    });

    test('clear(...)', () {
      final element = DivElement();
      element.classes.add('c0');
      element.classes.add('c1');
      element.classes.clear();
      expect(element.outerHtml, '<div class=""></div>');
    });
  });

  group('element.style:', () {
    group('element.style.setProperty(name, value):', () {
      test('null value removes the property', () {
        final e = Element.tag('a');
        final name = 'color';
        final value = 'blue';
        // Set non-null
        e.style.setProperty(name, value);
        expect(e.style.getPropertyValue(name), value);
        expect(e.outerHtml, contains(value));

        // Set null
        e.style.setProperty(name, null);
        expect(e.style.getPropertyValue(name), '');
        expect(e.outerHtml, isNot(contains(value)));
      });

      test('affects element.getAttribute(name)', () {
        final e = Element.tag('a');
        e.style.setProperty('color', 'blue');
        expect(e.getAttribute('style'), contains('blue'));
      });

      test('affects element.attributes', () {
        final e = Element.tag('a');
        e.style.setProperty('color', 'blue');
        expect(e.attributes['style'], contains('blue'));
      });

      test(
          'changes result of element.attributes, obtained before setting style',
          () {
        final e = Element.tag('a');
        final attributes = e.attributes;
        e.style.setProperty('color', 'blue');
        expect(attributes['style'], contains('blue'));
      });

      test('changes result of element.outerHtml', () {
        final e = Element.tag('a');
        e.style.setProperty('color', 'blue');
        expect(e.outerHtml, contains('blue'));
      });
    });

    test('element.style.removeProperty(...)', () {
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

    test(
        'element.style.getProperty("font-size") returns non-quoted value when value is "90px"',
        () {
      final e = Element.tag('a');
      e.style.setProperty('font-size', '90px');
      expect(e.style.getPropertyValue('font-size'), '90px');
    });

    test(
        'element.setAttribute("style", "invalid value"), changes attribute value',
        () {
      final e = Element.tag('a');
      final value = 'invalid value';
      e.setAttribute('style', value);
      expect(e.getAttribute('style'), value);
      expect(e.attributes['style'], value);
    });

    test('element.setAttribute("style", "color: blue"), changes element.style',
        () {
      final e = Element.tag('a');
      final value = 'color: blue';
      e.setAttribute('style', value);
      expect(e.getAttribute('style'), value);
      expect(e.attributes['style'], value);
      expect(e.style.color, 'blue');
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
}
