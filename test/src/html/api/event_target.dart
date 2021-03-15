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

part of main_test;

void _testEvents() {
  group('events:', () {
    List<String> registerStepListeners(List<Element> elements,
        {Element? expectedTarget}) {
      // The list of steps will be built by listeners
      final steps = <String>[];

      // For each element
      for (var i = 0; i < elements.length; i++) {
        // Get element
        final element = elements[i];

        // Choose an ID for debugging
        element.id = 'e$i';

        // Add capturing listener
        element.addEventListener('click', (event) {
          steps.add('e$i-capturing');
          expect(event.currentTarget, same(element));
          expect(event.target, same(expectedTarget));
        }, true);

        // Add bubbling listener
        element.addEventListener('click', (event) {
          steps.add('e$i-bubbling');
          expect(event.currentTarget, same(element));
          expect(event.target, same(expectedTarget));
        });
      }
      return steps;
    }

    test('propagation', () async {
      final e2 = DivElement();
      final e1 = DivElement()..append(e2);
      final e0 = DivElement()..append(e1);

      // Collect order of steps here
      final steps = registerStepListeners([e0, e1, e2], expectedTarget: e2);

      // Click
      e2.click();

      await Future.delayed(const Duration(milliseconds: 10));

      // Expect
      expect(
        steps,
        [
          'e0-capturing',
          'e1-capturing',
          'e2-capturing',
          'e2-bubbling',
          'e1-bubbling',
          'e0-bubbling',
        ],
      );
    });
  });
}
