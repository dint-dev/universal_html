import 'package:test/test.dart';
import 'package:universal_html/html.dart';

void main() {
  group("Node:", () {
    test("append:", () {
      final e = Element.tag("e");
      e.append(Text("a"));
      expect(e.outerHtml, equals('<e>a</e>'));
      e.append(Text("b"));
      expect(e.outerHtml, equals('<e>ab</e>'));
      e.append(Text("c"));
      expect(e.outerHtml, equals('<e>abc</e>'));
    });
    test("appendText:", () {
      final input = Element.tag("a")..appendText("abc");
      final expected = '<a>abc</a>';
      expect(input.outerHtml, equals(expected));
    });
    test("replaceWith:", () {
      final e0 = Element.tag("e0")..appendText("e0-text");
      final e1 = Element.tag("e1")..appendText("e1-text");
      final e2 = Element.tag("e2")..appendText("e2-text");
      final root = Element.tag("sometag")
        ..setAttribute("k", "v")
        ..append(e0)
        ..append(e1)
        ..append(e2);

      // Initial tree
      expect(
          root.outerHtml,
          equals(
              '<sometag k="v"><e0>e0-text</e0><e1>e1-text</e1><e2>e2-text</e2></sometag>'));

      // Replace child #1 of 'e1'
      {
        final replaced = e1.firstChild;
        final replacement = Text("e1-text-replaced");
        expect(replaced.parent, same(e1));

        replaced.replaceWith(replacement);

        expect(replaced.parent, isNull);
        expect(e1.firstChild, same(replacement));
        expect(e1.firstChild.parent, same(e1));
        expect(
            root.outerHtml,
            equals(
                '<sometag k="v"><e0>e0-text</e0><e1>e1-text-replaced</e1><e2>e2-text</e2></sometag>'));
      }

      // Replace child #2 of root ('e1')
      {
        final replacement = Text("e1-replaced");
        expect(e0.nextNode, same(e1));
        expect(e1.nextNode, same(e2));

        e1.replaceWith(replacement);

        expect(e0.nextNode, same(replacement));
        expect(e1.parent, isNull);
        expect(e1.nextNode, isNull);
        expect(replacement.parent, same(root));
        expect(replacement.nextNode, same(e2));
        expect(
            root.outerHtml,
            equals(
                '<sometag k="v"><e0>e0-text</e0>e1-replaced<e2>e2-text</e2></sometag>'));
      }
    });
    test("remove:", () {
      final e0 = Element.tag("e0")..appendText("e0-text");
      final e1 = Element.tag("e1")..appendText("e1-text");
      final e2 = Element.tag("e2")..appendText("e2-text");
      final root = Element.tag("sometag")
        ..setAttribute("k", "v")
        ..append(e0)
        ..append(e1)
        ..append(e2);

      // Initial tree
      expect(
          root.outerHtml,
          equals(
              '<sometag k="v"><e0>e0-text</e0><e1>e1-text</e1><e2>e2-text</e2></sometag>'));

      // Remove child #1 of 'e1'
      {
        final removed = e1.firstChild;
        removed.remove();

        expect(removed.parent, isNull);
        expect(removed.nextNode, isNull);
        expect(e1.firstChild, isNull);
        expect(
            root.outerHtml,
            equals(
                '<sometag k="v"><e0>e0-text</e0><e1></e1><e2>e2-text</e2></sometag>'));
      }

      // Remove child #2 of root ('e1')
      {
        e1.remove();

        expect(e0.nextNode, same(e2));
        expect(e1.parent, isNull);
        expect(e1.nextNode, isNull);
        expect(
            root.outerHtml,
            equals(
                '<sometag k="v"><e0>e0-text</e0><e2>e2-text</e2></sometag>'));
      }
    });
    test("text:", () {
      final e = Element.tag("e");
      expect(e.text, equals(''));
      e.append(Text("a"));
      expect(e.text, equals('a'));
      e.append(Element.tag("innerElement")..appendText("")..appendText("b"));
      e.append(Comment("not text"));
      expect(e.text, equals('ab'));
      e.append(Text("c"));
      expect(e.text, equals('abc'));
    });
  });

  group("Comment", () {
    test("Comment()", () {
      final node = Comment();
      expect(node.nodeValue, "");
    });
    test("Comment('<text>')", () {
      final node = Comment("<text>");
      expect(node.nodeValue, "<text>");
    });
  });
}
