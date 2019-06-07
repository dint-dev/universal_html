part of driver_test;

void _testDomParserDriver() {
  group("DomParserDriver", () {
    final parser = DomParserDriver();

    test("parseDocument(...), '<!DOCTYPE HTML>'", () {
      final source =
          "<!DOCTYPE HTML><html><body><div>Example</div></body></html>";
      final document = parser.parseDocument(source);
      expect(
        nodeToString(document),
        "<!doctype><html><head></head><body><div>Example</div></body></html>",
      );
      if (document is HtmlDocument) {
        expect(document.body, isNotNull);
        expect(document.body.children, hasLength(1));
        expect(document.body.children.single, TypeMatcher<DivElement>());
        expect(document.body.innerHtml, "<div>Example</div>");
      } else {
        expect(document, TypeMatcher<HtmlDocument>());
      }
    });

    test("parseDocument(...), '<html>...</html>'", () {
      final source = "<html><body><div>Example</div></body></html>";
      final document = parser.parseDocument(source);
      expect(
        nodeToString(document),
        "<html><head></head><body><div>Example</div></body></html>",
      );
      if (document is HtmlDocument) {
        expect(document.body, isNotNull);
        expect(document.body.children, hasLength(1));
        expect(document.body.children.single, TypeMatcher<DivElement>());
        expect(document.body.innerHtml, "<div>Example</div>");
      } else {
        expect(document, TypeMatcher<HtmlDocument>());
      }
    });

    test("parseHtmlDocument(...), '<!DOCTYPE HTML>'", () {
      final source =
          "<!DOCTYPE HTML><html><body><div>Example</div></body></html>";
      final document = parser.parseHtmlDocument(source);
      expect(
        nodeToString(document),
        "<!doctype><html><head></head><body><div>Example</div></body></html>",
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, "<div>Example</div>");
    });

    test("parseHtmlDocument(...), '<html>...</html>'", () {
      final source = "<html><body><div>Example</div></body></html>";
      final document = parser.parseHtmlDocument(source);
      expect(
        nodeToString(document),
        "<html><head></head><body><div>Example</div></body></html>",
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, "<div>Example</div>");
    });

    test("parseHtmlDocumentFromHtml(...), '<!DOCTYPE HTML>'", () {
      final source =
          "<!DOCTYPE HTML><html><body><div>Example</div></body></html>";
      final document = parser.parseHtmlDocumentFromHtml(source);
      expect(
        nodeToString(document),
        "<!doctype><html><head></head><body><div>Example</div></body></html>",
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, "<div>Example</div>");
    });

    test("parseHtmlDocumentFromHtml(...), '<html>...</html>')", () {
      final source = "<html><body><div>Example</div></body></html>";
      final document = parser.parseHtmlDocumentFromHtml(source);
      expect(
        nodeToString(document),
        "<html><head></head><body><div>Example</div></body></html>",
      );
      expect(document.body, isNotNull);
      expect(document.body.children, hasLength(1));
      expect(document.body.children.single, TypeMatcher<DivElement>());
      expect(document.body.innerHtml, "<div>Example</div>");
    });
  });
}
