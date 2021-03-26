part of main_test;

void _testCssStyleDeclaration() {
  group('CssStyleDeclaration:', () {
    test('style.supportsProperty("color")', () {
      final element = DivElement();
      expect(element.style.supportsProperty('color'), isTrue);
    });

    test('style.color = "red"', () {
      final element = DivElement();
      element.style.color = 'red';
      expect(element.style.color, 'red');
      expect(element.style.getPropertyValue('color'), 'red');
      expect(element.style.getPropertyPriority('color'), '');
    });

    test('style.color = null', () {
      final element = DivElement();
      element.style.color = null;
      expect(element.style.color, '');
      expect(element.style.getPropertyValue('color'), '');
      expect(element.style.getPropertyPriority('color'), '');
    });

    test('style.setProperty("color", "red")', () {
      final element = DivElement();
      element.style.setProperty('color', 'red');
      expect(element.style.color, 'red');
      expect(element.style.getPropertyValue('color'), 'red');
      expect(element.style.getPropertyPriority('color'), '');
    });

    test('style.setProperty("color", null)', () {
      final element = DivElement();
      element.style.setProperty('color', null);
      expect(element.style.color, '');
      expect(element.style.getPropertyValue('color'), '');
      expect(element.style.getPropertyPriority('color'), '');
    });
  });
}
