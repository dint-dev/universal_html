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

void _testNode() {
  group('Node:', () {
    test('append', () {
      final e = Element.tag('e');
      e.append(Text('a'));
      expect(e.outerHtml, '<e>a</e>');
      e.append(Text('b'));
      expect(e.outerHtml, '<e>ab</e>');
      e.append(Text('c'));
      expect(e.outerHtml, '<e>abc</e>');
    });
    test('append self fails', () {
      final e = Element.tag('e');
      expect(() => e.append(e), throwsA(anything));
    });
    test('appendText', () {
      final input = Element.tag('a')..appendText('abc');
      final expected = '<a>abc</a>';
      expect(input.outerHtml, expected);
    });
    test('replaceWith', () {
      final e0 = Element.tag('e0')..appendText('e0-text');
      final e1 = Element.tag('e1')..appendText('e1-text');
      final e2 = Element.tag('e2')..append(
          Element.tag('e2c1')
      )..append(
          Element.tag('e2c2')
      );
      final root = Element.tag('sometag')
        ..setAttribute('k', 'v')
        ..append(e0)
        ..append(e1)
        ..append(e2);

      // Initial tree
      expect(
          root.outerHtml,
          equals(
              '<sometag k="v"><e0>e0-text</e0><e1>e1-text</e1><e2><e2c1></e2c1><e2c2></e2c2></e2></sometag>'));

      // Replace child #1 of 'e1'
      {
        final replaced = e1.firstChild!;
        final replacement = Text('e1-text-replaced');
        expect(replaced.parent, same(e1));

        replaced.replaceWith(replacement);

        expect(replaced.parent, isNull);
        expect(e1.firstChild, same(replacement));
        expect(e1.firstChild!.parent, same(e1));
        expect(
            root.outerHtml,
            equals(
                '<sometag k="v"><e0>e0-text</e0><e1>e1-text-replaced</e1><e2><e2c1></e2c1><e2c2></e2c2></e2></sometag>'));
      }

      // Replace child #2 of root ('e1')
      {
        final replacement = Text('e1-replaced');
        expect(e0.nextNode, same(e1));
        expect(e1.nextNode, same(e2));

        e1.replaceWith(replacement);

        expect(e0.nextNode, same(replacement));
        expect(e1.parent, isNull);
        expect(e1.nextNode, isNull);
        expect(replacement.parent, same(root));
        expect(replacement.nextNode, same(e2));
        expect(
            root.outerHtml,
            equals(
                '<sometag k="v"><e0>e0-text</e0>e1-replaced<e2><e2c1></e2c1><e2c2></e2c2></e2></sometag>'));
      }
      // Replace with existing node to check if it moved properly
      {
        final replacement = e2.children.first;
        e0.replaceWith(replacement);

        expect(e0.nextNode, isNull);
        expect(e0.previousNode, isNull);
        expect(e0.parent, isNull);
        expect(replacement.parent, same(root));
        expect(replacement.previousNode, isNull);
        expect(replacement.nextNode, isNotNull);
        expect(
          root.outerHtml,
          equals(
            '<sometag k="v"><e2c1></e2c1>e1-replaced<e2><e2c2></e2c2></e2></sometag>'));
      }
    });
    test('replaceWith when the node has no parent', () {
      final e0 = Element.tag('e0')..appendText('e0-text');
      final e1 = Element.tag('e1')..appendText('e1-text');
      e0.replaceWith(e1);
    });

    test('remove', () {
      final e0 = Element.tag('e0')..appendText('e0-text');
      final e1 = Element.tag('e1')..appendText('e1-text');
      final e2 = Element.tag('e2')..appendText('e2-text');
      final root = Element.tag('sometag')
        ..setAttribute('k', 'v')
        ..append(e0)
        ..append(e1)
        ..append(e2);

      // Initial tree
      expect(root.outerHtml,
          '<sometag k="v"><e0>e0-text</e0><e1>e1-text</e1><e2>e2-text</e2></sometag>');

      // Remove child #1 of 'e1'
      {
        final removed = e1.firstChild!;
        removed.remove();

        expect(removed.parent, isNull);
        expect(removed.nextNode, isNull);
        expect(e1.firstChild, isNull);
        expect(root.outerHtml,
            '<sometag k="v"><e0>e0-text</e0><e1></e1><e2>e2-text</e2></sometag>');
      }

      // Remove child #2 of root ('e1')
      {
        e1.remove();

        expect(e0.nextNode, same(e2));
        expect(e1.parent, isNull);
        expect(e1.nextNode, isNull);
        expect(root.outerHtml,
            '<sometag k="v"><e0>e0-text</e0><e2>e2-text</e2></sometag>');
      }
    });
    test('remove fails when the node has parent', () {
      final e0 = Element.tag('e0')..appendText('e0-text');
      e0.remove();
    });

    test('text', () {
      final e = Element.tag('e');
      expect(e.text, '');
      e.appendText('a');
      expect(e.text, 'a');
      e.append(Element.tag('innerElement')
        ..appendText('')
        ..appendText('b'));
      expect(e.text, 'ab');
      e.append(Comment('not text'));
      expect(e.text, 'ab');
      e.append(Text('c'));
      expect(e.text, 'abc');
    });

    test('text: comments', () {
      final e = Element.tag('e');
      e.appendText('a');
      e.append(Comment('not text'));
      e.appendText('b');
      expect(e.text, 'ab');
    });

    test('text: style', () {
      final e = Element.tag('e');
      e.appendText('a');
      e.append(StyleElement()..appendText('[style]'));
      e.appendText('b');
      expect(e.text, 'a[style]b');
    });

    test('text: style', () {
      final e = Element.tag('e');
      e.appendText('a');
      e.append(ScriptElement()..appendText('[script]'));
      e.appendText('b');
      expect(e.text, 'a[script]b');
    });

    test('text: "a\\nb"', () {
      final e = Element.tag('e');
      e.appendText('a\nb');
      expect(e.text, 'a\nb');
    });

    test('text: "a\\tb"', () {
      final e = Element.tag('e');
      e.appendText('a\tb');
      expect(e.text, 'a\tb');
    });

    test('text: "a  b"', () {
      final e = Element.tag('e');
      e.appendText('a  b');
      expect(e.text, 'a  b');
    });

    test('innerText', () {
      final e = Element.tag('e');
      expect(e.innerText, '');

      e.appendText('a');
      expect(e.innerText, 'a');

      e.appendText('b');
      expect(e.innerText, 'ab');
    });

    test('innerText: comments', () {
      final e = Element.tag('e');
      expect(e.innerText, '');

      e.appendText('a');
      e.append(Comment('not in innerText'));
      e.appendText('b');
      expect(e.innerText, 'ab');
    });

    test('innerText: <br>', () {
      final e = Element.tag('e');
      expect(e.innerText, '');

      e.appendText('a');
      e.append(BRElement());
      e.appendText('b');
      expect(e.innerText, 'ab');
    });

    test('innerText: non-visible elements', () {
      final e = Element.tag('e');
      expect(e.innerText, '');

      // Mozilla documentation says <style> content should be ignored,
      // but Chrome doesn't do so.
      e.appendText('a');
      e.append(StyleElement()..appendText('[style]'));
      e.append(ScriptElement()..appendText('[script]'));
      e.appendText('b');
      expect(e.innerText, 'a[style][script]b');

      e.innerText = 'xyz';
      expect(e.innerText, 'xyz');
    });

    test('innerText = "ab"', () {
      final e = Element.tag('e');
      expect(e.innerText, '');
      e.innerText = 'a';
      expect(e.innerText, 'a');
      e.innerText = 'ab';
      expect(e.innerText, 'ab');
    });

    test('innerText = "a\\nb"', () {
      final e = Element.tag('e');
      e.innerText = 'a\nb';
      expect(e.innerText, 'ab');
    });

    test(r'innerText = "a\tb"', () {
      final e = Element.tag('e');
      e.innerText = 'a\tb';
      expect(e.innerText, 'a\tb');
    });

    test('innerText = "a  b"', () {
      final e = Element.tag('e');
      e.innerText = 'a  b';
      expect(e.innerText, 'a  b');
    });
  });

  group('CharacterData', () {
    late CharacterData node;
    setUp(() {
      node = Text('abc');
    });
    test('deleteData', () {
      node.deleteData(2, 1);
      expect(node.nodeValue, 'ab');
    });
    test('insertData', () {
      node.insertData(2, 'c');
      expect(node.nodeValue, 'abcc');
    });
    test('replaceData', () {
      node.replaceData(2, 1, 'c');
      expect(node.nodeValue, 'abc');
    });
    test('text', () {
      node.text = 'abXde';
      expect(node.text, 'abXde');
    });
    test('text', () {
      expect(node.data, 'abc');
      node.data = null;
      expect(node.data, '');
    });
  });

  group('Comment', () {
    test('Comment()', () {
      final node = Comment();
      expect(node.nodeValue, '');
    });

    test('Comment("abc")', () {
      final node = Comment('abc');
      expect(node.nodeValue, 'abc');
    });

    test('toString()', () {
      final node = Comment('abc');
      expect(node.toString(), 'abc');
    });
  });

  group('Text', () {
    test('Text("abc")', () {
      final node = Text('abc');
      expect(node.nodeValue, 'abc');
    });

    test('toString()', () {
      final node = Text('abc');
      expect(node.toString(), 'abc');
    });
    test('text', () {
      final node = Text('abc');
      node.text = 'hjkyu';
      expect(node.nodeValue, 'hjkyu');
    });
  });
}
