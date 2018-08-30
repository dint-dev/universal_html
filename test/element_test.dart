import 'package:test/test.dart';
import 'package:universal_html/html.dart';

void main() {
  group("Element:", () {
    test("'Element.tag' fails if the name is invalid", () {
      const invalidChars = ["<", ">", '"', " ", "&"];
      for (var c in invalidChars) {
        try {
          Element.tag("${c}");
          fail("Should have thrown");
        } catch (e) {}
        try {
          Element.tag("x${c}x");
          fail("Should have thrown");
        } catch (e) {}
      }
    });

    group("innerHtml:", () {
      test("works with attributes", () {
        final input = Element.tag("a")
          ..setAttribute("someAttribute", "someValue")
          ..appendText("a")
          ..appendText("b")
          ..appendText("c");
        final expected = "abc";
        expect(input.innerHtml, equals(expected));
      });
      test("works with no attributes", () {
        final input = Element.tag("a")
          ..appendText("a")
          ..append(new Comment("b"))
          ..appendText("c");
        final expected = "a<!--b-->c";
        expect(input.innerHtml, equals(expected));
      });
    });

    group("outerHtml:", () {
      test("uses lowerCase for element/attribute names", () {
        final input = Element.tag("aA")
          ..setAttribute("bB", "cC")
          ..appendText("dD");
        final expected = '<aa bb="cC">dD</aa>';
        expect(input.outerHtml, equals(expected));
      });
      test("prints element style, no quotes", () {
        final input = Element.tag("a")..style.fontSize = '1px';
        final expected = '<a style="font-size: 1px;"></a>';
        expect(input.outerHtml, equals(expected));
      });
      test("prints element style, quotes", () {
        final input = Element.tag("a")..style.fontFamily = 'Comic Sans';
        final expected = '<a style="font-family: &quot;Comic Sans&quot;;"></a>';
        expect(input.outerHtml, equals(expected));
      });
      test("escapes text", () {
        final input = Element.tag("a")..appendText('&<>"');
        final expected = '<a>&amp;&lt;&gt;"</a>';
        expect(input.outerHtml, equals(expected));
      });
      test("escapes element class", () {
        final input = Element.tag("a")..className = '&"';
        final expected = '<a class="&amp;&quot;"></a>';
        expect(input.outerHtml, equals(expected));
      });
      test("escapes element id", () {
        final input = Element.tag("a")..id = '&"';
        final expected = '<a id="&amp;&quot;"></a>';
        expect(input.outerHtml, equals(expected));
      });
      test("escapes attribute value", () {
        final input = Element.tag("sometag")..setAttribute("k", '&"<>');
        final expected = '<sometag k="&amp;&quot;<>"></sometag>';
        expect(input.outerHtml, equals(expected));
      });
      test("supports multiple attributes", () {
        final input = Element.tag("a")
          ..className = "x"
          ..setAttribute("id", "y")
          ..setAttribute("href", "z");
        final expected = '<a class="x" id="y" href="z"></a>';
        expect(input.outerHtml, equals(expected));
      });
      test("supports multiple children", () {
        final input = Element.tag("sometag")
          ..appendText("a")
          ..append(Element.tag("b")..appendText("c"))
          ..append(Comment("d"));
        final expected = '<sometag>a<b>c</b><!--d--></sometag>';
        expect(input.outerHtml, equals(expected));
      });
      test("supports multiple attributes and multiple children", () {
        final input = Element.tag("sometag")
          ..className = "x"
          ..setAttribute("k0", "v0")
          ..setAttribute("k1", "v1")
          ..appendText("a")
          ..append(Element.tag("b")..appendText("c"))
          ..append(Comment("d"));
        final expected =
            '<sometag class="x" k0="v0" k1="v1">a<b>c</b><!--d--></sometag>';
        expect(input.outerHtml, equals(expected));
      });
    });

    group("setAttribute:", () {
      test("works", () {
        final e = Element.tag("e");
        e.setAttribute("k0", "v0");
        expect(e.getAttribute("k0"), equals("v0"));
        e.setAttribute("K1", "v1");
        e.setAttribute("k2", "v2");
        expect(e.getAttribute("k0"), equals("v0"));
        expect(e.getAttribute("k1"), equals("v1"));
        expect(e.getAttribute("k2"), equals("v2"));
        expect(e.getAttribute("style"), isNull);
        expect(e.attributes, hasLength(equals(3)));
        expect(e.attributes["k0"], equals("v0"));
        expect(e.attributes["k1"], equals("v1"));
        expect(e.attributes["k2"], equals("v2"));
        expect(e.attributes["style"], isNull);
        expect(e.outerHtml, equals('<e k0="v0" k1="v1" k2="v2"></e>'));
      });
      test("'setAttribute' fails if the name is invalid", () {
        const invalidChars = ["<", ">", '"', " ", "&"];
        for (var c in invalidChars) {
          try {
            Element.tag("x").setAttribute(c, "");
            fail("Should have thrown");
          } catch (e) {}
          try {
            Element.tag("x").setAttribute("x${c}x", "");
            fail("Should have thrown");
          } catch (e) {}
        }
      });
    });

    group("style:", () {
      test("set(k,v) -> get(k) -> set(k,null)", () {
        final e = Element.tag("a");
        final k = "color";
        final v = "blue";
        expect(e.style.getPropertyValue(k), equals(""));
        e.style.setProperty(k, v);
        expect(e.style.getPropertyValue(k), equals(v));
        expect(e.outerHtml, contains(v));
        e.style.setProperty(k, null);
        expect(e.style.getPropertyValue(k), equals(""));
        expect(e.outerHtml, isNot(contains(v)));
      });
      test("set(k,v) -> get(k) -> remove(k)", () {
        final e = Element.tag("a");
        final k = "color";
        final v = "blue";
        expect(e.style.getPropertyValue(k), equals(""));
        e.style.setProperty(k, v);
        expect(e.style.getPropertyValue(k), equals(v));
        expect(e.outerHtml, contains(v));
        e.style.removeProperty(k);
        expect(e.style.getPropertyValue(k), equals(""));
        expect(e.outerHtml, isNot(contains(v)));
      });
      test("is returned by element.getAttribute", () {
        final e = Element.tag("a");
        e.style.setProperty("color", "blue");
        expect(e.getAttribute("style"), contains("blue"));
      });
      test("is returned by element.attributes", () {
        final e = Element.tag("a");
        e.style.setProperty("color", "blue");
        expect(e.attributes["style"], contains("blue"));
      });
      test("is returned by previously created element.attributes", () {
        final e = Element.tag("a");
        final attributes = e.attributes;
        e.style.setProperty("color", "blue");
        expect(attributes["style"], contains("blue"));
      });
      test("is returned by element.outerHtml", () {
        final e = Element.tag("a");
        e.style.setProperty("color", "blue");
        expect(e.outerHtml, contains("blue"));
      });
      test("can be modified with setAttribute(name,value)", () {
        final variations = const [
          "color: blue",
          "color:blue;",
        ];
        for (var variation in variations) {
          final e = Element.tag("a");
          e.setAttribute("style", variation);
          expect(e.getAttribute("style"), equals(variation));
          expect(e.attributes["style"], equals(variation));
          expect(e.style.color, equals("blue"));
        }
      });
      test("can be modified with attributes[name]=value", () {
        final variations = const [
          "color: blue",
          "color:blue;",
        ];
        for (var variation in variations) {
          final e = Element.tag("a");
          e.attributes["style"] = variation;
          expect(e.getAttribute("style"), equals(variation));
          expect(e.attributes["style"], equals(variation));
          expect(e.style.color, equals("blue"),
              reason: "Variation: '${variation}'");
        }
      });
    });
  });
}
