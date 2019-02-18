import 'package:test/test.dart';
import 'package:universal_html/html.dart';

void main() {
  group("Parsing nodes: ", () {
    // A helper
    Document getDocumentOfType(String contentType) {
      if (contentType == null) {
        return document;
      } else {
        final document =
            DomParser().parseFromString("<html></html>", contentType);
        return document;
      }
    }

    String documentToString(Node document) {
      return (document.firstChild as Element).outerHtml;
    }

    group("Example 1 (HTML):", () {
      // We test:
      // - attribute, with no value
      // - attribute, normal
      // - attribute, with namespace
      // - child text
      // - child comment
      // - child element
      // - child element, without ending
      const exampleSource =
          """<div emptyname name="value" namespace:name="value2">a<!--b--><h1></h1><img></div>""";

      Document newExampleDom(String contentType) {
        final document = getDocumentOfType(contentType);
        document.createElement("div")
          ..setAttribute("emptyname", "")
          ..setAttribute("name", "value")
          ..setAttributeNS("namespace", "name", "value2")
          ..appendText("a")
          ..append(Comment("b"))
          ..append(HeadingElement.h1())
          ..append(ImageElement());
        return document;
      }

      test("`DocumentFragment.html", () {
        // It's a bit tricky to test because of HTML will be validated

//        final contentType = "text/html";
//        final Document expected = newExampleDom(contentType);
//
//        // Parse
//        final DocumentFragment actual = DocumentFragment.html(exampleSource);
//
//        // document.contentType
//        expect(actual.ownerDocument.contentType, contentType);
//        expect(expected.ownerDocument.contentType, contentType);
//
//        // Print
//        expect(documentToString(actual), equals(documentToString(expected)));
      });

      test("`DomParser, 'text/html'", () {
        final contentType = "text/html";
        final expected = newExampleDom(contentType);

        // Parse
        final actual = DomParser()
            .parseFromString(exampleSource, contentType)
            .firstChild as Element;

        // document.contentType
        expect(actual.ownerDocument, isNotNull);
        expect(actual.ownerDocument.contentType, contentType);
        expect(expected.ownerDocument, isNotNull);
        expect(expected.ownerDocument.contentType, contentType);

        // Print
        expect(documentToString(actual), equals(documentToString(expected)));
      });
    });

    group("Example 1 (XHTML):", () {
      // We test:
      // - attribute, normal
      // - attribute, with namespace
      // - child text
      // - child comment
      // - child element
      // - child element, without ending
      const exampleSource =
          """<example name="value" namespace:name="value2">a<!--b--><div></div><img></example>""";

      Document newExampleDom(String contentType) {
        final document = getDocumentOfType(contentType);
        document.append(document.createElement("example")
          ..setAttribute("xmlns", "http://www.w3.org/1999/xhtml")
          ..setAttribute("name", "value")
          ..setAttributeNS("namespace", "name", "value2")
          ..appendText("a")
          ..append(Comment("b"))
          ..append(DivElement())
          ..append(ImageElement()));
        return document;
      }

      test("DomParser, 'application/xhtml+xml", () {
        final contentType = "application/xhtml+xml";
        final Document expected = newExampleDom(contentType);

        // Parse
        final Document actual =
            DomParser().parseFromString(exampleSource, contentType);

        // document.contentType
        expect(actual.contentType, contentType);
        expect(expected..contentType, contentType);

        // Print
        expect(documentToString(actual), equals(documentToString(expected)));
      });
    });

    group("Example 2 (XML):", () {
      // We test:
      // - attribute, normal
      // - attribute, with namespace
      // - child text
      // - child comment
      // - child element
      // - child element, without ending
      const exampleSource =
          """<example name="value" namespace:name="value2">a<!--b--><div></div><img></example>""";

      Document newExampleDom(String contentType) {
        final document = getDocumentOfType(contentType);
        document.append(
          document.createElement("example")
            ..setAttribute("name", "value")
            ..setAttributeNS("namespace", "name", "value2")
            ..appendText("a")
            ..append(Comment("b"))
            ..append(DivElement())
            ..append(ImageElement()),
        );
        return document;
      }

      test("DomParser, 'text/xml'", () {
        final contentType = "text/xml";
        final Document expected = newExampleDom(contentType);

        // Parse
        final Document actual =
            DomParser().parseFromString(exampleSource, contentType);

        // document.contentType
        expect(actual.contentType, contentType);
        expect(expected.contentType, contentType);

        // Print
        expect(documentToString(actual), equals(documentToString(expected)));
      });

      test("DomParser, contentType", () {
        final input = "<!doctype html>";
        final actual = DomParser().parseFromString(input, "text/html");
        expect(actual.firstChild.nodeType, equals(Node.DOCUMENT_TYPE_NODE));
      });
    });
  });
}
