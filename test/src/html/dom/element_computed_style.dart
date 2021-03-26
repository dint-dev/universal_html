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

void _testElementComputedStyle() {
  group('element.computedStyle():', () {
    final document = universal_html.document;

    test('Case #1', () {
      _temporarilyRemoveChildrenFromDocument(root: document.body!);

      final styleElement = StyleElement()..appendText('''
.exampleClass {
  font-family: exampleFont
}''');
      addTearDown(() {
        styleElement.remove();
      });
      document.head!.insertBefore(styleElement, null);

      final element = DivElement()..className = 'exampleClass';
      document.body!.insertBefore(element, null);
      addTearDown(() {
        element.remove();
      });

      expect(element.getComputedStyle().fontFamily, 'exampleFont');
    });
  });
}
