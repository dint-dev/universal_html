part of main_test;

void _testCssStyleDeclaration() {
  group('CssStyleDeclaration:', () {
    test('style.color = "red', () {
      final element = DivElement();
      element.style.color = 'red';
      expect(element.style.color, 'red');
    });

    test('style.color = null', () {
      final element = DivElement();
      element.style.color = null;
      expect(element.style.color, '');
    });

    test('style.setProperty("color", "red)', () {
      final element = DivElement();
      element.style.setProperty('color', 'red');
      expect(element.style.color, 'red');
    });

    test('style.setProperty("color", null)', () {
      final element = DivElement();
      element.style.setProperty('color', null);
      expect(element.style.color, '');
    });
  });
}
