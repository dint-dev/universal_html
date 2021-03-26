// Copyright 2019 terrier989@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
