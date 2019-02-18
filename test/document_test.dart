import 'package:test/test.dart';
import 'package:universal_html/html.dart';

import 'helpers.dart';

void main() {
  group("Document:", () {
    test("initial state", () {
      expect(document, isNotNull);
      expectSaneDocument(document);

      final docType = document.firstChild;
      expect(docType, isNotNull);
      expect(docType.nodeType, equals(Node.DOCUMENT_TYPE_NODE));
      expect(docType.nodeName, equals("html"));

      final htmlHtml = docType.nextNode;
      expect(htmlHtml, const TypeMatcher<HtmlHtmlElement>());

      // Helper that skips text nodes
      Node _nonText(Node node) {
        while (node != null && node.nodeType == Node.TEXT_NODE) {
          node = node.nextNode;
        }
        return node;
      }

      final head = _nonText(htmlHtml.firstChild);
      expect(head, const TypeMatcher<HeadElement>());
      expect(document.head, same(head));

      final body = _nonText(head.nextNode);
      expect(body, const TypeMatcher<BodyElement>());
      expect(document.body, same(body));
    });

    test("inserting and removing succeeds", () {
      // Remove existing children
      temporarilyRemoveChildrenFromDocument();

      // Check initial state
      expectSaneDocument(document);

      // Insert
      final n0 = HtmlHtmlElement();
      document.append(n0);

      // Document:
      //   n0
      expect(document.firstChild, same(n0));
      expect(document.lastChild, same(n0));
      expect(n0.parent, isNull);
      expect(n0.parentNode, same(document));
      expect(n0.nextNode, isNull);
      expect(n0.getRootNode(), document);
      expectSaneDocument(document);

      // Insert
      final n0_n2 = Element.tag("div");
      n0.append(n0_n2);

      // Document:
      //   n0
      //     n0_n2
      expect(n0.parent, isNull);
      expect(n0.parentNode, same(document));
      expect(n0.firstChild, same(n0_n2));
      expect(n0.lastChild, same(n0_n2));
      expect(n0.nextNode, isNull);
      expect(n0.getRootNode(), document);

      expect(n0_n2.parent, same(n0));
      expect(n0_n2.parentNode, same(n0));
      expect(n0_n2.firstChild, isNull);
      expect(n0_n2.lastChild, isNull);
      expect(n0_n2.nextNode, isNull);
      expect(n0_n2.getRootNode(), document);
      expectSaneDocument(document);

      // Insert
      final n0_n0 = Element.tag("div");
      n0.insertBefore(n0_n0, n0_n2);

      // Document:
      //   n0
      //     n0_n0
      //     n0_n2
      expect(n0.firstChild, same(n0_n0));
      expect(n0.lastChild, same(n0_n2));

      expect(n0_n0.parent, same(n0));
      expect(n0_n0.parentNode, same(n0));
      expect(n0_n0.firstChild, isNull);
      expect(n0_n0.nextNode, n0_n2);
      expect(n0_n2.previousNode, n0_n0);
      expectSaneDocument(document);

      // Insert
      final n0_n1 = Element.tag("div");
      n0.insertBefore(n0_n1, n0_n2);

      // Document:
      //   n0
      //     n0_n0
      //     n0_n1
      //     n0_n2
      expect(n0.firstChild, same(n0_n0));
      expect(n0.lastChild, same(n0_n2));
      expect(n0_n0.parent, same(n0));
      expect(n0_n0.parentNode, same(n0));
      expect(n0_n0.nextNode, n0_n1);
      expect(n0_n1.parent, same(n0));
      expect(n0_n1.parentNode, same(n0));
      expect(n0_n1.nextNode, n0_n2);
      expectSaneDocument(document);

      // Remove
      n0_n1.remove();

      // Document:
      //   n0
      //     n0_n0
      //     n0_n2
      expect(n0_n1.parent, isNull);
      expect(n0_n1.parentNode, isNull);
      expect(n0_n1.getRootNode(), same(n0_n1));
      expect(document.firstChild, n0);
      expect(document.lastChild, n0);
      expect(n0.firstChild, n0_n0);
      expect(n0.lastChild, n0_n2);
      expectSaneDocument(document);
      expectSaneTree(n0_n1);

      // Remove
      n0_n2.remove();

      // Document:
      //   n0
      //     n0_n0
      expect(n0_n2.parent, isNull);
      expect(n0_n2.parentNode, isNull);
      expect(n0_n2.getRootNode(), same(n0_n2));
      expect(document.firstChild, n0);
      expect(document.lastChild, n0);
      expect(n0.firstChild, n0_n0);
      expect(n0.lastChild, n0_n0);
      expectSaneDocument(document);
      expectSaneTree(n0_n2);

      // Remove
      n0_n0.remove();

      // Document:
      //   n0
      expect(n0_n0.parent, isNull);
      expect(n0_n0.parentNode, isNull);
      expect(n0_n0.getRootNode(), same(n0_n0));
      expect(document.firstChild, n0);
      expect(document.lastChild, n0);
      expect(n0.firstChild, isNull);
      expect(n0.lastChild, isNull);
      expectSaneDocument(document);
      expectSaneTree(n0_n0);

      // Remove
      n0.remove();

      // Document: (empty)
      expect(n0.parent, isNull);
      expect(n0.parentNode, isNull);
      expect(n0.getRootNode(), same(n0));
      expect(document.firstChild, isNull);
      expect(document.lastChild, isNull);
      expectSaneDocument(document);
      expectSaneTree(n0);
    });

    test("inserting text shoulding fails", () {
      // Remove existing children
      temporarilyRemoveChildrenFromDocument();

      // Test that throws
      expectLater(() {
        document.append(Text("a"));
      }, throwsA(anything));

      // Test the exception message
      try {
        document.append(Text("c"));
      } catch (e) {
        expect(
            e.toString(),
            contains(
                "Nodes of type '#text' may not be inserted inside nodes of type '#document'."));
      }
    });

    test("inserting two elements should fail", () {
      // Remove existing children
      temporarilyRemoveChildrenFromDocument();

      // First child
      document.append(HtmlHtmlElement());

      // Second child fails
      expectLater(() {
        document.append(HtmlHtmlElement());
      }, throwsA(anything));

      // Test the exception message
      try {
        document.append(HtmlHtmlElement());
      } catch (e) {
        expect(e.toString(), contains("Only one element on document allowed."));
      }
    });

    test("'body'", () {
      expect(document.body, isNotNull);
    });

    test("'getElementById(...)'", () {
      temporarilyRemoveChildrenFromDocument();

      final n0 = Element.tag("div")..id = "n0";
      final n0_n0 = Element.tag("div")..id = "n0_n0";
      final n0_n1 = Element.tag("div")..id = "n0_n1";
      final n0_n2 = Element.tag("div")..id = "n0_n2";
      n0.append(n0_n0);
      n0.append(n0_n1);
      n0.append(n0_n2);
      document.append(n0);

      // Check getElementById
      expect(document.getElementById(n0.id), same(n0));
      expect(document.getElementById(n0_n0.id), same(n0_n0));
      expect(document.getElementById(n0_n1.id), same(n0_n1));
      expect(document.getElementById(n0_n2.id), same(n0_n2));
      expect(document.getElementById('nonExistingId'), isNull);
    });

    test("'head'", () {
      expect(document.head, isNotNull);
    });
  });
}
