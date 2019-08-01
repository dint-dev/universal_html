@TestOn("vm")
library reflection_test;

import 'dart:mirrors';
import 'package:test/test.dart';
import 'package:universal_html/src/html.dart' as html;
import 'package:meta/meta.dart';
import 'reflection_data.dart';

void main() {
  test("Does not introduce new APIs", () {
    final html = elementsForSdkHtml;
    final universalHtml = elementsForUniversalHtml;

    // Factories
    expect(html, contains("Element.p"));

    // Implicit constructors
    expect(html, contains("ElementList.ElementList"));

    // Find elements that exist in "universal_html", but not in "dart:html"
    final elements = universalHtml.where((name) {
      return !html.contains(name);
    }).toList();

    // Are we mismatch-free?
    if (elements.isEmpty) {
      return;
    }

    // Sort
    elements.sort();

    // Describe mismatches
    fail(
      "Found the following exports that are not exported by dart:html:\n"
      "  ${elements.join('\n  ')}",
    );
  });
}

final elementsForSdkHtml = (reflectionData["dart.dom.html"] as Map<String,Object>).keys.toSet();

final elementsForUniversalHtml = (reflectionData["universal_html.without_internals"] as Map<String,Object>).keys.toSet();