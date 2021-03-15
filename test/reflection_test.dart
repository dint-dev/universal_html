@TestOn('vm')
library reflection_test;

import 'package:test/test.dart';
import 'reflection_data.dart';

void main() {
  test('Does not introduce new APIs', () {
    final html = elementsForSdkHtml;
    final universalHtml = elementsForUniversalHtml;

    // Factories
    expect(html, contains('Element.p'));

    // Implicit constructors
    expect(html, contains('ElementList.ElementList'));

    // Find elements that exist in 'universal_html', but not in 'dart:html'
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
      'Found the following exports that are not exported by dart:html:\n'
      '  ${elements.join('\n  ')}',
    );
  });
}

final Set<String> elementsForSdkHtml =
    (reflectionData['dart.dom.html'] as Map<String, Object?>).keys.toSet();

final Set<String> elementsForUniversalHtml =
    (reflectionData['universal_html.internal'] as Map<String, Object?>)
        .keys
        .toSet();
