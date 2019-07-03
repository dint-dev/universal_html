part of driver_test;

void _testHtmlDriver() {
  group("HtmlDriver", () {
    test("setDocument(null) resets the state", () {
      final driver = HtmlDriver();
      final oldDocument = driver.document;
      final oldWindow = driver.window;
      driver.setDocument(null);
      expect(driver.document, isNot(same(oldDocument)));
      expect(driver.window, isNot(same(oldWindow)));
    });

    test("setDocumentFromContent(...) supports HTML", () {
      final driver = HtmlDriver();
      driver.setDocumentFromContent(
        "<html><body><div>Example</div></body></html>",
      );
      expect(driver.document.body, isNotNull);
      expect(driver.document.body.children, hasLength(1));
      expect(driver.document.body.children.single, TypeMatcher<DivElement>());
      expect(driver.document.body.innerHtml, "<div>Example</div>");
    });

    test("setDocumentFromContent(...) supports XML", () {
      final driver = HtmlDriver();
      driver.setDocumentFromContent(
        """
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<root><product>Example</product></root>
""",
      );
      final document = driver.document;
      expect(
        nodeToString(document),
        "<root><product>Example</product></root>",
      );
      expect(
        driver.document.documentElement.outerHtml,
        "<root><product>Example</product></root>",
      );
    });

    test("newHttpClient() uses htmlDriver.userAgent", () {
      final driver = HtmlDriver(userAgent: "Example");
      expect(driver.userAgent, "Example");
      expect(driver.newHttpClient().userAgent, "Example");
    });

    test("window.navigator.userAgent uses htmlDriver.userAgent", () {
      final driver = HtmlDriver(userAgent: "Example");
      expect(driver.userAgent, "Example");
      expect(driver.window.navigator.userAgent, "Example");
    });
  });
}
