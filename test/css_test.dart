import 'package:test/test.dart';
import 'package:universal_html/html.dart';

import 'helpers.dart';

void main() {
  group("CSS-related tests for Element:", () {
    test("computedStyle", () {
      temporarilyRemoveChildrenFromDocument(root: document.body);

      final source = """
          <div>
            <style>
            .c0{
              font-family:"v0"
            }
            .c1{
              font-family:"v1 by earlier style is incorrect"
            }
            </style>
            <style>
            .c1{
              font-family:"v1 by first rule is incorrect";
            }
            .c1{
              font-family:"v1";
            }
            </style>
            <style>
            e2{
              font-family:"v2 by element rule is incorrect";
            }
            #e2{
              font-family:"v2";
            }
            .c2{
              font-family:"v2 by class rule is incorrect";
            }
            </style>
            <e0 id="e0" class="c0"></e0>
            <e1 id="e1" class="c0 c1"></e1>
            <e2 id="e2" class="c0 c1 c2"></e2>
          </div>
      """;
      final fragment = new DocumentFragment.html(
        source,
        treeSanitizer: NodeTreeSanitizer.trusted,
      );

      final firstDiv = fragment.querySelector("div");
      expect(firstDiv, isNotNull);
      expect(firstDiv.querySelectorAll("style"), hasLength(greaterThan(2)));
      expect(firstDiv.querySelectorAll("e0"), hasLength(greaterThan(0)));
      expect(firstDiv.querySelectorAll("e1"), hasLength(greaterThan(0)));
      expect(firstDiv.querySelectorAll("e2"), hasLength(greaterThan(0)));
      document.body.append(firstDiv);

      final elements = new List<Element>.generate(3, (i) {
        final id = "e$i";
        final element = document.querySelector("#$id");
        if (element == null) {
          fail("Element '#$id' could not be found.");
        }
        return element;
      });

      final styles = new List<CssStyleDeclaration>.from(elements.map((e) {
        return e.getComputedStyle();
      }));

      // Values
      expect(styles[0].fontFamily, equals("v0"));
      expect(styles[1].fontFamily, equals("v1"));
      expect(styles[2].fontFamily, equals("v2"));
    });

    group("'matches':", () {
      void expectMatches(Element element, String selector, Matcher matcher) {
        final root = element.getRootNode() as Element;
        final idOrOuterHtml =
            element.id == null ? element.outerHtml : "#${element.id}";
        expect(element.matches(selector), matcher,
            reason:
                "Element: '${idOrOuterHtml}'\nSelector: '${selector}'\nTree: '${root.outerHtml}'");
      }

      test("blank string throws error", () {
        final e = DivElement();
        try {
          e.matches("");
          fail("Should have thrown an error");
        } catch (e) {}
      });
      test("element", () {
        final e = DivElement();
        expectMatches(e, "div", isTrue);
      });
      test("#id", () {
        final e = DivElement()..setAttribute("id", "x");
        expectMatches(e, "#x", isTrue);
      });
      test(".class (a single class name)", () {
        final e = DivElement()..className = "a";
        expectMatches(e, ".a", isTrue);
        expectMatches(e, ".b", isFalse);
      });
      test(".class (multiple class names)", () {
        final e = DivElement()..className = "a b";
        expectMatches(e, ".a", isTrue);
        expectMatches(e, ".b", isTrue);
        expectMatches(e, ".c", isFalse);
        expectMatches(e, ".a.a", isTrue);
        expectMatches(e, ".a.b", isTrue);
        expectMatches(e, ".a.c", isFalse);
        expectMatches(e, ".b.a", isTrue);
        expectMatches(e, ".b.c", isFalse);
      });
      test(".class (multiple class names)", () {
        final e = DivElement()..className = "a b";
        expectMatches(e, ".a", isTrue);
        expectMatches(e, ".b", isTrue);
        expectMatches(e, ".c", isFalse);
        expectMatches(e, ".a.a", isTrue);
        expectMatches(e, ".a.b", isTrue);
        expectMatches(e, ".a.c", isFalse);
        expectMatches(e, ".b.a", isTrue);
        expectMatches(e, ".b.c", isFalse);
      });
      test(':not(...)', () {
        final e = DivElement();
        expectMatches(e, ':not(span)', isTrue);
        expectMatches(e, ':not(div)', isFalse);
      });
      test(':first-child', () {
        final e = DivElement()
          ..id = "e0"
          ..append(new DivElement()..id = "e1")
          ..append(DivElement()..id = "e2");
        expectMatches(e.firstChild, ':first-child', isTrue);
        expectMatches(e.lastChild, ':first-child', isFalse);
      });
      test(':last-child', () {
        final e = DivElement()
          ..id = "e0"
          ..append(new DivElement()..id = "e1")
          ..append(DivElement()..id = "e2");
        expectMatches(e.firstChild, ':last-child', isFalse);
        expectMatches(e.lastChild, ':last-child', isTrue);
      });
      test(':nth-child(2)', () {
        final e = DivElement()
          ..id = "root"
          ..append(new DivElement()..id = "child0")
          ..append(DivElement()..id = "child1");
        expectMatches(e.childNodes[0], ':nth-child(1)', isTrue);
        expectMatches(e.childNodes[0], ':nth-child(2)', isFalse);
        expectMatches(e.childNodes[1], ':nth-child(1)', isFalse);
        expectMatches(e.childNodes[1], ':nth-child(2)', isTrue);
        expectMatches(e.childNodes[1], ':nth-child(3)', isFalse);
      });
      test(':nth-child(2n)', () {
        final e = DivElement()
          ..id = "root"
          ..append(new DivElement()..id = "child0")
          ..append(DivElement()..id = "child1")
          ..append(DivElement()..id = "child2")
          ..append(DivElement()..id = "child3");
        expectMatches(e.childNodes[0], ':nth-child(2n)', isFalse);
        expectMatches(e.childNodes[1], ':nth-child(2n)', isTrue);
        expectMatches(e.childNodes[2], ':nth-child(2n)', isFalse);
        expectMatches(e.childNodes[3], ':nth-child(2n)', isTrue);
      });
      test(':nth-child(2n+1)', () {
        final e = DivElement()
          ..id = "root"
          ..append(new DivElement()..id = "child0")
          ..append(DivElement()..id = "child1")
          ..append(DivElement()..id = "child2")
          ..append(DivElement()..id = "child3");
        expectMatches(e.childNodes[0], ':nth-child(2n+1)', isTrue);
        expectMatches(e.childNodes[1], ':nth-child(2n+1)', isFalse);
        expectMatches(e.childNodes[2], ':nth-child(2n+1)', isTrue);
        expectMatches(e.childNodes[3], ':nth-child(2n+1)', isFalse);
      });
      test('[name]', () {
        final e = DivElement()..setAttribute("k", "");
        expectMatches(e, '[k]', isTrue);

        // False selectors
        expectMatches(e, '[k2]', isFalse);
      });
      test('[name="value"]', () {
        final e = DivElement()..setAttribute("k", "aB");
        expectMatches(e, '[k="aB"]', isTrue);

        // False selectors
        expectMatches(e, '[k="a"]', isFalse);
        expectMatches(e, '[k="aBc"]', isFalse);
        expectMatches(e, '[k="ab"]', isFalse);
        expectMatches(e, '[k="AB"]', isFalse);
      });
      test('[name^="value"]', () {
        final e = DivElement()..setAttribute("k", "aB");
        expectMatches(e, '[k^="a"]', isTrue);
        expectMatches(e, '[k^="aB"]', isTrue);

        // False selectors
        expectMatches(e, '[k^="b"]', isFalse);
        expectMatches(e, '[k^="aBc"]', isFalse);
        expectMatches(e, '[k^="ab"]', isFalse);
        expectMatches(e, '[k^="AB"]', isFalse);
      });
      test(r'[name$="value"]', () {
        final e = DivElement()..setAttribute("k", "aB");
        expectMatches(e, r'[k$="B"]', isTrue);
        expectMatches(e, r'[k$="aB"]', isTrue);

        // False selectors
        expectMatches(e, r'[k$="a"]', isFalse);
        expectMatches(e, r'[k$="aBc"]', isFalse);
        expectMatches(e, r'[k$="ab"]', isFalse);
        expectMatches(e, r'[k$="AB"]', isFalse);
      });
      test('[name*="value"]', () {
        final e = DivElement()..setAttribute("k", "aB");
        expectMatches(e, '[k*="a"]', isTrue);
        expectMatches(e, '[k*="B"]', isTrue);
        expectMatches(e, '[k*="aB"]', isTrue);

        // False selectors
        expectMatches(e, '[k*="aBc"]', isFalse);
        expectMatches(e, '[k*="ab"]', isFalse);
        expectMatches(e, '[k*="AB"]', isFalse);
      });

      test("Complex example #1", () {
        final e0 = DivElement()
          ..id = 'e0'
          ..className = "c0 all";
        final e0_0 = DivElement()
          ..id = "e0_0"
          ..className = "c0_0 all";
        final e0_1 = DivElement()
          ..id = "e0_1"
          ..className = "c0_1 all";
        final e0_2 = DivElement()
          ..id = "e0_2"
          ..className = "c0_2 all";
        final e0_2_0 = DivElement()
          ..id = "e0_2_0"
          ..className = "c0_2_0 all";
        e0.append((e0_0));
        e0.append(e0_1);
        e0.append(e0_2);
        e0_2.append(e0_2_0);

        // --------
        // Node: e0
        // --------
        // true
        expectMatches(e0, "div.c0.all", isTrue);

        // false
        expectMatches(e0, ".c0 .c0_2", isFalse);
        expectMatches(e0, ".c0 .c0_2_0", isFalse);
        expectMatches(e0, ".c0 > .c0_2", isFalse);
        expectMatches(e0, ".c0 > .c0_2_0", isFalse);

        // --------
        // Node: e0_0
        // --------
        // true
        expectMatches(e0_0, ".c0 :first-child", isTrue);

        // false
        expectMatches(e0_0, ".c0 :last-child", isFalse);

        // --------
        // Node: e0_1
        // --------
        // false
        expectMatches(e0_1, ".c0 :first-child", isFalse);
        expectMatches(e0_1, ".c0 :last-child", isFalse);

        // --------
        // Node: e0_2
        // --------
        // true
        expectMatches(e0_2, ".c0 :last-child", isTrue);
        expectMatches(e0_2, ".c0 .c0_2", isTrue);
        expectMatches(e0_2, ".c0 > .c0_2", isTrue);

        // false
        expectMatches(e0_2, ".c0 :first-child", isFalse);
        expectMatches(e0_2, ".c0 .c0_2_0", isFalse);
        expectMatches(e0_2, ".c0 > .c0_2_0", isFalse);

        // --------
        // Node: e0_2_0
        // --------
        // true
        expectMatches(e0_2_0, "div.c0 div.c0_2 div.c0_2_0", isTrue);
        expectMatches(e0_2_0, "div.c0 > div.c0_2 > div.c0_2_0", isTrue);
        expectMatches(
            e0_2_0, "div.c0 > div.c0_1 + div.c0_2 > div.c0_2_0", isTrue);
        expectMatches(
            e0_2_0, "div.c0 > div.c0_0 ~ div.c0_2 > div.c0_2_0", isTrue);
        expectMatches(
            e0_2_0, "div.c0 > div.c0_1 ~ div.c0_2 > div.c0_2_0", isTrue);
        expectMatches(e0_2_0, ".c0 div.c0_2_0", isTrue);
        expectMatches(e0_2_0, ".c0 .c0_2_0", isTrue);
        expectMatches(e0_2_0, ".c0_2 .c0_2_0", isTrue);
        expectMatches(e0_2_0, ".c0_2 > .c0_2_0", isTrue);

        // false
        expectMatches(
            e0_2_0, "div.c0 > div.c0_0 + div.c0_2 > div.c0_2_0", isFalse);
        expectMatches(e0_2_0, ".c0 .c0_2", isFalse);
        expectMatches(e0_2_0, ".c0 > .c0_2", isFalse);
        expectMatches(e0_2_0, ".c0 > .c0_2_0", isFalse);
      });
    });

    group("'querySelectorAll':", () {
      void expectQuery(
          Element root, String selector, List<Element> expectedElements) {
        final actual = root
            .querySelectorAll(selector)
            .map((item) => "#${item.id}")
            .join(", ");
        final expected =
            expectedElements.map((item) => "#${item.id}").join(", ");
        expect(actual, equals(expected),
            reason:
                "Root: '#${root.id}'\nSelector: '${selector}'\nTree: ${root.outerHtml}");
      }

      test("Complex example #1", () {
        final e0 = DivElement()
          ..id = "e0"
          ..className = "all";

        final e0_0 = DivElement()
          ..id = "e0-0"
          ..className = "all";

        final e0_1 = DivElement()
          ..id = "e0-1"
          ..className = "all";

        final e0_2 = DivElement()
          ..id = "e0-2"
          ..className = "all";

        final e0_2_0 = DivElement()
          ..id = "e0-2-0"
          ..className = "all";

        e0.append((e0_0));
        e0.append(e0_1);
        e0.append(e0_2);
        e0_2.append(e0_2_0);

        expect(e0.childNodes, hasLength(equals(3)));
        expect(e0.childNodes[2].childNodes, hasLength(1));

        expectQuery(e0, ".all", [e0_0, e0_1, e0_2, e0_2_0]);
        expectQuery(e0, "#e0 *", [e0_0, e0_1, e0_2, e0_2_0]);
      });
    });
  });
}
