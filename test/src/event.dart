import 'dart:async';

import 'package:test/test.dart';
import 'package:universal_html/html.dart';

void main() {
  group("events:", () {
    List<String> registerStepListeners(List<Element> elements,
        {Element expectedTarget}) {
      // The list of steps will be built by listeners
      final steps = <String>[];

      // For each element
      for (var i = 0; i < elements.length; i++) {
        // Get element
        final element = elements[i];

        // Choose an ID for debugging
        element.id = "e$i";

        // Add capturing listener
        element.addEventListener("click", (event) {
          steps.add("e$i-capturing");
          expect(event.currentTarget, same(element));
          expect(event.target, same(expectedTarget));
        }, true);

        // Add bubbling listener
        element.addEventListener("click", (event) {
          steps.add("e$i-bubbling");
          expect(event.currentTarget, same(element));
          expect(event.target, same(expectedTarget));
        });
      }
      return steps;
    }

    test("propagation", () async {
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
          "e0-capturing",
          "e1-capturing",
          "e2-capturing",
          "e2-bubbling",
          "e1-bubbling",
          "e0-bubbling",
        ],
      );
    });
  });
}
