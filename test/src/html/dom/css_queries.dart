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

void _testCss() {
  group('CSS-related tests for Element:', () {
    test('querySelector("")', () {
      final element = HeadingElement.h1();
      try {
        element.querySelector('');
      } on DomException catch (e) {
        expect(e.name, DomException.SYNTAX);
      }
    });

    test('querySelector("not found")', () {
      final element = HeadingElement.h1();
      final result = element.querySelector('not found');
      expect(result, isNull);
    });

    test('querySelectorAll("")', () {
      final element = HeadingElement.h1();
      try {
        element.querySelectorAll('');
      } on DomException catch (e) {
        expect(e.name, DomException.SYNTAX);
      }
    });

    test('querySelectorAll("not found")', () {
      final element = HeadingElement.h1();
      final result = element.querySelectorAll('not found');
      expect(result, []);
    });

    group('matches:', () {
      void expectMatches(Element element, String selector, Matcher matcher) {
        final root = element.getRootNode() as Element;
        final id = element.id;
        final idOrOuterHtml = id == '' ? element.outerHtml : '#$id';
        expect(
          element.matches(selector),
          matcher,
          reason: 'Element: "$idOrOuterHtml"\n'
              'Selector: "$selector"\n'
              'Tree: ${root.outerHtml}',
        );
      }

      test('blank string throws DomException', () {
        final e = DivElement();
        expect(() {
          e.matches('');
        }, throwsDomException);
      });
      test('element', () {
        final e = DivElement();
        expectMatches(e, 'div', isTrue);
      });
      test('#id', () {
        final e = DivElement()..setAttribute('id', 'x');
        expectMatches(e, '#x', isTrue);
      });
      test('.class (a single class name)', () {
        final e = DivElement()..className = 'a';
        expectMatches(e, '.a', isTrue);
        expectMatches(e, '.b', isFalse);
      });
      test('.class (multiple class names)', () {
        final e = DivElement()..className = 'a b';
        expectMatches(e, '.a', isTrue);
        expectMatches(e, '.b', isTrue);
        expectMatches(e, '.c', isFalse);
        expectMatches(e, '.a.a', isTrue);
        expectMatches(e, '.a.b', isTrue);
        expectMatches(e, '.a.c', isFalse);
        expectMatches(e, '.b.a', isTrue);
        expectMatches(e, '.b.c', isFalse);
      });
      test('.class (multiple class names)', () {
        final e = DivElement()..className = 'a b';
        expectMatches(e, '.a', isTrue);
        expectMatches(e, '.b', isTrue);
        expectMatches(e, '.c', isFalse);
        expectMatches(e, '.a.a', isTrue);
        expectMatches(e, '.a.b', isTrue);
        expectMatches(e, '.a.c', isFalse);
        expectMatches(e, '.b.a', isTrue);
        expectMatches(e, '.b.c', isFalse);
      });
      test(':not(...)', () {
        final e = DivElement();
        expectMatches(e, ':not(span)', isTrue);
        expectMatches(e, ':not(div)', isFalse);
      });
      test(':first-child', () {
        final e = DivElement()
          ..id = 'e0'
          ..append(DivElement()..id = 'e1')
          ..append(DivElement()..id = 'e2');
        expectMatches(e.firstChild as Element, ':first-child', isTrue);
        expectMatches(e.lastChild as Element, ':first-child', isFalse);
      });
      test(':last-child', () {
        final e = DivElement()
          ..id = 'e0'
          ..append(DivElement()..id = 'e1')
          ..append(DivElement()..id = 'e2');
        expectMatches(e.firstChild as Element, ':last-child', isFalse);
        expectMatches(e.lastChild as Element, ':last-child', isTrue);
      });
      test(':nth-child(2)', () {
        final e = DivElement()
          ..id = 'root'
          ..append(DivElement()
            ..id = 'child0'
            ..append(DivElement()..append(DivElement())))
          ..append(DivElement()..id = 'child1');
        expectMatches(e.childNodes[0] as Element, ':nth-child(1)', isTrue);
        expectMatches(e.childNodes[0] as Element, ':nth-child(2)', isFalse);
        expectMatches(e.childNodes[1] as Element, ':nth-child(1)', isFalse);
        expectMatches(e.childNodes[1] as Element, ':nth-child(2)', isTrue);
        expectMatches(e.childNodes[1] as Element, ':nth-child(3)', isFalse);

        final p = DivElement()..append(e);
        expect(p.querySelectorAll('#root'), hasLength(1));
        expect(p.querySelectorAll('#root div'), hasLength(4));
        expect(p.querySelectorAll('#root div:nth-child(0)'), hasLength(0));
        expect(p.querySelectorAll('#root div:nth-child(1)'), hasLength(3));
        expect(p.querySelectorAll('#root > div:nth-child(1)'), hasLength(1));
        expect(p.querySelectorAll('#root div:nth-child(2)'), hasLength(1));
        expect(p.querySelectorAll('#root div:nth-child(3)'), hasLength(0));
      });
      test(':nth-child(2n)', () {
        final e = DivElement()
          ..id = 'root'
          ..append(DivElement()..id = 'child0')
          ..append(DivElement()..id = 'child1')
          ..append(DivElement()..id = 'child2')
          ..append(DivElement()..id = 'child3');
        expectMatches(e.childNodes[0] as Element, ':nth-child(2n)', isFalse);
        expectMatches(e.childNodes[1] as Element, ':nth-child(2n)', isTrue);
        expectMatches(e.childNodes[2] as Element, ':nth-child(2n)', isFalse);
        expectMatches(e.childNodes[3] as Element, ':nth-child(2n)', isTrue);
      });
      test(':nth-child(2n+1)', () {
        final e = DivElement()
          ..id = 'root'
          ..append(DivElement()..id = 'child0')
          ..append(DivElement()..id = 'child1')
          ..append(DivElement()..id = 'child2')
          ..append(DivElement()..id = 'child3');
        expectMatches(e.childNodes[0] as Element, ':nth-child(2n+1)', isTrue);
        expectMatches(e.childNodes[1] as Element, ':nth-child(2n+1)', isFalse);
        expectMatches(e.childNodes[2] as Element, ':nth-child(2n+1)', isTrue);
        expectMatches(e.childNodes[3] as Element, ':nth-child(2n+1)', isFalse);
      });
      test('[name]', () {
        final e = DivElement()..setAttribute('k', '');
        expectMatches(e, '[k]', isTrue);

        // False selectors
        expectMatches(e, '[k2]', isFalse);
      });
      test("[name='value']", () {
        final e = DivElement()..setAttribute('k', 'aB');
        expectMatches(e, "[k='aB']", isTrue);

        // False selectors
        expectMatches(e, "[k='a']", isFalse);
        expectMatches(e, "[k='aBc']", isFalse);
        expectMatches(e, "[k='ab']", isFalse);
        expectMatches(e, "[k='AB']", isFalse);
      });
      test("[name^='value']", () {
        final e = DivElement()..setAttribute('k', 'aB');
        expectMatches(e, "[k^='a']", isTrue);
        expectMatches(e, "[k^='aB']", isTrue);

        // False selectors
        expectMatches(e, "[k^='b']", isFalse);
        expectMatches(e, "[k^='aBc']", isFalse);
        expectMatches(e, "[k^='ab']", isFalse);
        expectMatches(e, "[k^='AB']", isFalse);
      });
      test("[name\$='value']", () {
        final e = DivElement()..setAttribute('k', 'aB');
        expectMatches(e, "[k\$='B']", isTrue);
        expectMatches(e, "[k\$='aB']", isTrue);

        // False selectors
        expectMatches(e, "[k\$='a']", isFalse);
        expectMatches(e, "[k\$='aBc']", isFalse);
        expectMatches(e, "[k\$='ab']", isFalse);
        expectMatches(e, "[k\$='AB']", isFalse);
      });
      test("[name*='value']", () {
        final e = DivElement()..setAttribute('k', 'aB');
        expectMatches(e, "[k*='a']", isTrue);
        expectMatches(e, "[k*='B']", isTrue);
        expectMatches(e, "[k*='aB']", isTrue);

        // False selectors
        expectMatches(e, "[k*='aBc']", isFalse);
        expectMatches(e, "[k*='ab']", isFalse);
        expectMatches(e, "[k*='AB']", isFalse);
      });

      test('Complex example #1', () {
        final e0 = DivElement()
          ..id = 'e0'
          ..className = 'c0 all';
        final e0_0 = DivElement()
          ..id = 'e0_0'
          ..className = 'c0_0 all';
        final e0_1 = DivElement()
          ..id = 'e0_1'
          ..className = 'c0_1 all';
        final e0_2 = DivElement()
          ..id = 'e0_2'
          ..className = 'c0_2 all';
        final e0_2_0 = DivElement()
          ..id = 'e0_2_0'
          ..className = 'c0_2_0 all';
        e0.append((e0_0));
        e0.append(e0_1);
        e0.append(e0_2);
        e0_2.append(e0_2_0);

        // --------
        // Node: e0
        // --------
        // true
        expectMatches(e0, 'div.c0.all', isTrue);

        // false
        expectMatches(e0, '.c0 .c0_2', isFalse);
        expectMatches(e0, '.c0 .c0_2_0', isFalse);
        expectMatches(e0, '.c0 > .c0_2', isFalse);
        expectMatches(e0, '.c0 > .c0_2_0', isFalse);

        // --------
        // Node: e0_0
        // --------
        // true
        expectMatches(e0_0, '.c0 :first-child', isTrue);

        // false
        expectMatches(e0_0, '.c0 :last-child', isFalse);

        // --------
        // Node: e0_1
        // --------
        // false
        expectMatches(e0_1, '.c0 :first-child', isFalse);
        expectMatches(e0_1, '.c0 :last-child', isFalse);

        // --------
        // Node: e0_2
        // --------
        // true
        expectMatches(e0_2, '.c0 :last-child', isTrue);
        expectMatches(e0_2, '.c0 .c0_2', isTrue);
        expectMatches(e0_2, '.c0 > .c0_2', isTrue);

        // false
        expectMatches(e0_2, '.c0 :first-child', isFalse);
        expectMatches(e0_2, '.c0 .c0_2_0', isFalse);
        expectMatches(e0_2, '.c0 > .c0_2_0', isFalse);

        // --------
        // Node: e0_2_0
        // --------
        // true
        expectMatches(e0_2_0, 'div.c0 div.c0_2 div.c0_2_0', isTrue);
        expectMatches(e0_2_0, 'div.c0 > div.c0_2 > div.c0_2_0', isTrue);
        expectMatches(
            e0_2_0, 'div.c0 > div.c0_1 + div.c0_2 > div.c0_2_0', isTrue);
        expectMatches(
            e0_2_0, 'div.c0 > div.c0_0 ~ div.c0_2 > div.c0_2_0', isTrue);
        expectMatches(
            e0_2_0, 'div.c0 > div.c0_1 ~ div.c0_2 > div.c0_2_0', isTrue);
        expectMatches(e0_2_0, '.c0 div.c0_2_0', isTrue);
        expectMatches(e0_2_0, '.c0 .c0_2_0', isTrue);
        expectMatches(e0_2_0, '.c0_2 .c0_2_0', isTrue);
        expectMatches(e0_2_0, '.c0_2 > .c0_2_0', isTrue);

        // false
        expectMatches(
            e0_2_0, 'div.c0 > div.c0_0 + div.c0_2 > div.c0_2_0', isFalse);
        expectMatches(e0_2_0, '.c0 .c0_2', isFalse);
        expectMatches(e0_2_0, '.c0 > .c0_2', isFalse);
        expectMatches(e0_2_0, '.c0 > .c0_2_0', isFalse);
      });
    });

    group('querySelectorAll:', () {
      test('Complex example #1', () {
        final root = DivElement();

        final e0 = DivElement()
          ..id = 'e0'
          ..className = 'all';

        final e0_0 = DivElement()
          ..id = 'e0-0'
          ..className = 'all';

        final e0_1 = DivElement()
          ..id = 'e0-1'
          ..className = 'all';

        final e0_2 = Element.nav()
          ..id = 'e0-2'
          ..className = 'all';

        final e0_2_0 = DivElement()
          ..id = 'e0-2-0'
          ..className = 'all';

        final e1 = DivElement()
          ..id = 'e1'
          ..className = 'all last';

        root.append(e0);
        e0.append((e0_0));
        e0.append(e0_1);
        e0.append(e0_2);
        e0_2.append(e0_2_0);
        root.append(e1);

        expect(e0.childNodes, hasLength(equals(3)));
        expect(e0.childNodes[2].childNodes, hasLength(1));

        expect(root.querySelector('nav'), same(e0_2));
        expect(root.querySelectorAll('nav'), [e0_2]);
        expect(
            root.querySelectorAll('.all'), [e0, e0_0, e0_1, e0_2, e0_2_0, e1]);
        expect(root.querySelectorAll('.last'), [e1]);

        // e0
        expect(e0.querySelectorAll('.all'), [e0_0, e0_1, e0_2, e0_2_0]);
        expect(e0.querySelectorAll('#e0 *'), [e0_0, e0_1, e0_2, e0_2_0]);
        expect(e0.querySelectorAll('#e0-2 *'), [e0_2_0]);
        expect(e0.querySelectorAll('.last'), []);

        // e0_2
        expect(e0_2.querySelectorAll('div'), [e0_2_0]);
        expect(e0_2.querySelectorAll('.all'), [e0_2_0]);
        expect(e0_2.querySelectorAll('.last'), []);

        // e0_2_0
        expect(e0_2_0.querySelectorAll('div'), []);
        expect(e0_2_0.querySelectorAll('.all'), []);
        expect(e0_2_0.querySelectorAll('.last'), []);
      });
    });
  });
}
