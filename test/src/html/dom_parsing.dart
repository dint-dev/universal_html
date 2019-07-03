part of main_test;

void _testParsing() {
  group("Parsing nodes: ", () {
    setUp(() {
      HtmlDriver.current.uri = Uri.parse("http://localhost:8080/");
    });
    test("`DomParser, 'text/html'", () {
      final contentType = "text/html";
      const source = """
<div emptyname name="value" ns:name="value2">
some text
<!--some comment-->
<h1>element #1</h1>
<Img src="image.jpeg">
</div>""";

      // Parse
      final document = DomParser().parseFromString(source, contentType);
      expect(document.contentType, contentType);
      expect(document.childNodes, hasLength(1));

      // <html>...</html>
      final root = document.documentElement;
      expect(root.ownerDocument, isNotNull);
      expect(root.ownerDocument.contentType, contentType);
      expect(root, isA<HtmlElement>());
      expect(root.tagName, "HTML");
      expect(root.childNodes, hasLength(2));
      expect(root.childNodes[0], isA<HeadElement>());
      expect(root.childNodes[1], isA<BodyElement>());

      // Get node
      final div = root.childNodes[1].firstChild;

      // <div emptyname name="value" ns:name="value2">
      {
        expect(div, isA<DivElement>());

        final element = div as DivElement;
        expect(element.tagName, "DIV");
        expect(element.getAttribute("emptyname"), "");
        expect(element.getAttribute("name"), "value");
      }

      // some text
      {
        final node = div.childNodes[0];
        expect(node, isA<Text>());
        expect(node.nodeValue, "\nsome text\n");
      }

      // <!--some comment-->
      {
        final node = div.childNodes[1];
        expect(node, isA<Comment>());
        expect(node.nodeValue, "some comment");
      }

      // (newline)
      {
        final node = div.childNodes[2];
        expect(node, isA<Text>());
        expect(node.nodeValue, "\n");
      }

      // <h1>element #1</h1>
      {
        final node = div.childNodes[3];
        expect(node, isA<HeadingElement>());

        final element = node as HeadingElement;
        expect(element.tagName, "H1");
        expect(element.text, "element #1");
      }

      // (newline)
      {
        final node = div.childNodes[4];
        expect(node, isA<Text>());
        expect(node.nodeValue, "\n");
      }

      // <img href="element #2">
      {
        var node = div.childNodes[5];
        expect(node, isA<ImageElement>());

        final element = node as ImageElement;
        expect(element.tagName, "IMG");
        expect(element.getAttribute("src"), "image.jpeg");
        expect(element.src, matches(RegExp(r"^http://.*/image.jpeg$")));
      }
    });

    test("`DomParser, 'application/xhtml+xml'", () {
      final contentType = "application/xhtml+xml";
      const source = """
<!DOCTYPE example>
<!-- comment -->
<html>
<body>
<div k0="v0" k1="v1">
some text
<!--some comment-->
<h1>element #1</h1>
<img src="image.jpeg"></img>
</div>
</body>
</html>
""";

      // Parse
      final document = DomParser().parseFromString(source, contentType);
      expect(document.contentType, contentType);
      expect(document.childNodes, hasLength(3));

      // <html>...</html>
      final html = document.documentElement;
      expect(html.ownerDocument, isNotNull);
      expect(html.ownerDocument.contentType, contentType);
      expect(html, isNot(isA<HtmlHtmlElement>()));
      expect(html.nodeName, "html");
      expect(html.tagName, "html");
      expect(html.children, hasLength(1));
      expect(html.children[0], isNot(isA<BodyElement>()));

      final body = html.children[0];
      expect(body.children, hasLength(1));

      // <div k0="v0" k1="v1">
      final div = body.children.first;
      {
        expect(div, isNot(isA<DivElement>()));
        expect(div.tagName, "div");
        expect(div.getAttribute("k0"), "v0");
        expect(div.getAttribute("k1"), "v1");
      }

      // some text
      {
        final node = div.childNodes[0];
        expect(node, isA<Text>());
        expect(node.nodeValue, "\nsome text\n");
      }

      // <!--some comment-->
      {
        final node = div.childNodes[1];
        expect(node, isA<Comment>());
        expect(node.nodeValue, "some comment");
      }

      // (newline)
      {
        final node = div.childNodes[2];
        expect(node, isA<Text>());
        expect(node.nodeValue, "\n");
      }

      // <h1>element #1</h1>
      {
        final node = div.childNodes[3];
        expect(node, isNot(isA<HeadingElement>()));

        final element = node as Element;
        expect(element.tagName, "h1");
        expect(element.text, "element #1");
      }

      // (newline)
      {
        final node = div.childNodes[4];
        expect(node, isA<Text>());
        expect(node.nodeValue, "\n");
      }

      // <img src="image.jpeg">
      {
        var node = div.childNodes[5];
        expect(node, isNot(isA<ImageElement>()));

        final element = node as Element;
        expect(element.tagName, "img");
        expect(element.getAttribute("src"), "image.jpeg");
      }
    });

    test("`DomParser, 'text/xml', 'application/xml'", () {
      for (var contentType in ["text/xml", "application/xml"]) {
        const source = """
<?xml version="1.0"?>
<!DOCTYPE example>
<!-- comment -->
<root xmlns:x="example_namespace">
<Child k0="v0" k1="v1">text</Child>
<x:Child x:k0="v0" x:k1="v1">text</x:Child>
</root>
""";

        // Parse
        final document = DomParser().parseFromString(source, contentType);
        expect(document.contentType, contentType);

        expect(document.documentElement.outerHtml, """
<root xmlns:x="example_namespace">
<Child k0="v0" k1="v1">text</Child>
<x:Child x:k0="v0" x:k1="v1">text</x:Child>
</root>""");

        final root = document.documentElement;
        expect(root.ownerDocument, isNotNull);
        expect(root.ownerDocument.contentType, contentType);
        expect(root, isA<Element>());
        expect(root.nodeName, "root");
        expect(root.tagName, "root");
        expect(root.childNodes, hasLength(5));
        expect(root.children, hasLength(2));

        // <child k0="v0" ns:k1="v1">text</child>
        final child0 = root.children[0];
        expect(child0.ownerDocument, isNotNull);
        expect(child0.ownerDocument.contentType, contentType);
        expect(child0.tagName, "Child");
        expect(child0.attributes, hasLength(2));
        expect(child0.attributes["k0"], "v0");
        expect(child0.attributes["k1"], "v1");
        expect(child0.childNodes, hasLength(1));
        expect(child0.text, "text");

        // <ns:child ns:k0="v0" ns:k1="v1">text</ns:child>
        final child1 = root.children[1];
        expect(child1.namespaceUri, "example_namespace");
        expect(child1.nodeName, "x:Child");
        expect(child1.tagName, "x:Child");
        expect(child1.attributes, isNot(contains("k0")));
        expect(child1.attributes, isNot(contains("k1")));
        expect(child1.getAttributeNS("example_namespace", "k0"), "v0");
        expect(child1.getAttributeNS("example_namespace", "k1"), "v1");
        expect(child1.childNodes, hasLength(1));
        expect(child1.text, "text");

        // ---------------------------------------------------------------------
        // Test various methods
        // ---------------------------------------------------------------------
        for (var child in root.children) {
          expect(child.parent, same(root));
        }
        expect(document.querySelector("root"), isNotNull);
        expect(document.querySelectorAll("not-found"), hasLength(0));
        expect(
          document.querySelectorAll("child"),
          hasLength(0),
          reason: "querySelectorAll",
        );
        expect(
          document.querySelectorAll("Child"),
          hasLength(2),
          reason: "querySelectorAll",
        );
        expect(
          document.getElementsByName("child"),
          hasLength(0),
          reason: "getElementsByName",
        );
        expect(
          document.getElementsByName("Child"),
          hasLength(0),
          reason: "getElementsByName",
        );
        expect(
          document.getElementsByTagName("child"),
          hasLength(0),
          reason: "getElementsByTagName",
        );
        expect(
          document.getElementsByTagName("Child"),
          hasLength(1),
          reason: "getElementsByTagName",
        );
      }
    });
  });
}
