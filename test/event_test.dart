import 'package:test/test.dart';
import 'package:universal_html/html.dart';

void main() {
  group("events:", () {
    List<String> registerStepListeners(List<Element> elements,
        {Element expectedTarget}) {
      final steps = <String>[];
      for (var i = 0; i < elements.length; i++) {
        // Add capturing phase listener
        final element = elements[i];
        element.id = "e$i";
        element.addEventListener("click", (event) {
          steps.add("e$i-c");
          expect((event.currentTarget as Element).id, equals(element.id),
              reason: "currentTarget is incorrect during capture phase");
          if (expectedTarget != null) {
            expect((event.target as Element).id, same(expectedTarget.id),
                reason: "target is incorrect during capture phase");
          }
        }, true);

        // Add bubbling phase listener
        element.addEventListener("click", (event) {
          steps.add("e$i-b");
          expect((event.currentTarget as Element).id, equals(element.id),
              reason: "currentTarget is incorrect during bubbling phase");
          if (expectedTarget != null) {
            expect((event.target as Element).id, equals(expectedTarget.id),
                reason: "target is incorrect during bubbling phase");
          }
        });
      }
      return steps;
    }

    test("propagation", () {
      final e2 = DivElement();
      final e1 = DivElement()..append(e2);
      final e0 = DivElement()..append(e1);

      // Collect order of steps here
      final steps = registerStepListeners([e0, e1, e2], expectedTarget: e2);

      // Click
      e2.click();

      // Expect
      expect(steps,
          orderedEquals(["e0-c", "e1-c", "e2-c", "e2-b", "e1-b", "e0-b"]));
    });
  });
}
