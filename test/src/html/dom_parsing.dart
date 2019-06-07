part of main_test;

void _testParsing() {
  group("Parsing nodes: ", () {
    group("Example 1 (HTML):", () {
      test("`DocumentFragment.html", () {
        // It's a bit tricky to test
      });

      test("`DomParser, 'text/html'", () {
        final contentType = "text/html";
        const source = """
<div emptyname name="value" namespace:name="value2">
some text
<!--some comment-->
<h1>element #1</h1>
<img href="element #2">
</div>""";

        // Parse
        Node actual = DomParser()
            .parseFromString(source, contentType)
            .firstChild as Element;

        // ownerDocument
        expect(actual.ownerDocument, isNotNull);
        expect(actual.ownerDocument.contentType, contentType);

        // <html>...</html>
        expect(actual, isA<HtmlElement>());
        expect((actual as HtmlElement).tagName, "HTML");
        expect((actual as HtmlElement).childNodes, hasLength(2));
        expect((actual as HtmlElement).childNodes[0], isA<HeadElement>());
        expect((actual as HtmlElement).childNodes[1], isA<BodyElement>());

        // Get node
        actual = actual.childNodes[1].firstChild;

        // <div emptyname name="value" namespace:name="value2">
        {
          expect(actual, isA<DivElement>());

          final element = actual as DivElement;
          expect(element.tagName, "DIV");
          expect(element.getAttribute("emptyname"), "");
          expect(element.getAttribute("name"), "value");
        }

        // some text
        {
          final node = actual.childNodes[0];
          expect(node, isA<Text>());
          expect(node.nodeValue, "\nsome text\n");
        }

        // <!--some comment-->
        {
          final node = actual.childNodes[1];
          expect(node, isA<Comment>());
          expect(node.nodeValue, "some comment");
        }

        // (newline)
        {
          final node = actual.childNodes[2];
          expect(node, isA<Text>());
          expect(node.nodeValue, "\n");
        }

        // <h1>element #1</h1>
        {
          final node = actual.childNodes[3];
          expect(node, isA<HeadingElement>());

          final element = node as HeadingElement;
          expect(element.tagName, "H1");
          expect(element.text, "element #1");
        }

        // (newline)
        {
          final node = actual.childNodes[4];
          expect(node, isA<Text>());
          expect(node.nodeValue, "\n");
        }

        // <img href="element #2">
        {
          var node = actual.childNodes[5];
          expect(node, isA<ImageElement>());

          final element = node as ImageElement;
          expect(element.tagName, "IMG");
          expect(element.getAttribute("href"), "element #2");
        }
      });
    });
  });
}
