part of driver_test;

void _testContentSecurityPolicy() {
  group("ContentSecurityPolicy", () {
    test("tryParse: default-src *", () {
      final csp = Csp.tryParse("default-src *");
      expect(
        csp.isAllowed(
          "image-src",
          Uri.parse("http://example.com/"),
        ),
        isTrue,
        reason: "CSP is: \"$csp\"",
      );
    });

    test("tryParse: script-src 'self'", () {
      final csp = Csp.tryParse("script-src 'self'");
      expect(
        csp.isAllowed(
          "image-src",
          Uri.parse("http://example.com/"),
        ),
        isFalse,
        reason: "CSP is: '$csp'",
      );
      expect(
        csp.isAllowed(
          "script-src",
          Uri.parse("http://example.com/"),
          isSameOrigin: true,
        ),
        isTrue,
        reason: "CSP is: \"$csp\"",
      );
    });

    test("toString(), empty", () {
      final csp = Csp.tryParse("");
      expect(csp, isNotNull);
      expect(csp.toString(), "");
    });

    test("toString(), one item", () {
      final b = CspBuilder();
      b.addRule("script-src", ["'self'"]);
      b.addRule("default-src", ["'none'"]);
      expect(b.build().toString(), "default-src 'none'; script-src 'self'");
    });

    test("toString(), two items", () {
      final b = CspBuilder();
      b.addRule("default-src", ["a.com", "b.com"]);
      expect(b.build().toString(), "default-src a.com b.com");
    });
  });
}
