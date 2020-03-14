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

void _testAttribute<T extends Element>(
  String name,
  T element,
  String Function(T e) getter,
  void Function(T element, String value) setter, {
  String defaultValue = '',
  String value = 'x',
}) {
  // Test expectations
  expect(
    getter(element),
    defaultValue,
    reason: 'Default value is incorrect',
  );

  // Use element.setAttribute
  element.setAttribute(name, value);

  // Test expectations
  expect(
    element.getAttribute(name),
    value,
    reason: 'Setting with setAttribute fails (getAttribute)',
  );
  expect(
    getter(element),
    value,
    reason: 'Setting with setAttribute fails (getter)',
  );

  // Reset
  element.removeAttribute(name);

  // Test expectations
  expect(
    element.getAttribute(name),
    null,
    reason: 'Removing fails (getAttribute)',
  );
  expect(
    getter(element),
    defaultValue,
    reason: 'Removing fails (getter)',
  );

  // Use element.propertyName=
  setter(element, value);

  // Test expectations
  expect(
    getter(element),
    value,
    reason: 'Setting with setter fails (getter',
  );
  expect(
    element.getAttribute(name),
    value,
    reason: 'Setting with setter fails (getAttribute)',
  );
}

void _testAttributeBool<T extends Element>(String name, T element,
    bool Function(T e) getter, void Function(T element, bool value) setter) {
  // Test expectations
  expect(getter(element), false);

  // element.setAttribute
  element.setAttribute(name, '');

  // Test expectations
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), '');
  expect(getter(element), true);

  // Reset
  element.removeAttribute(name);

  // Test expectations
  expect(element.hasAttribute(name), false);
  expect(element.getAttribute(name), null);
  expect(getter(element), false);

  // element.propertyName=
  setter(element, true);

  // Test expectations
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), '');
  expect(getter(element), true);
}

void _testAttributeBoolString<T extends Element>(String name, T element,
    bool Function(T e) getter, void Function(T element, bool value) setter,
    {String falseValue = 'false', String trueValue = 'true'}) {
  final defaultValue = getter(element);
  if (defaultValue == false) {
    // Test expectations
    expect(getter(element), false);

    // element.setAttribute
    element.setAttribute(name, trueValue);

    // Test expectations
    expect(element.hasAttribute(name), true);
    expect(element.getAttribute(name), trueValue);
    expect(getter(element), true);

    // Reset
    element.removeAttribute(name);

    // Test expectations
    expect(element.hasAttribute(name), false);
    expect(element.getAttribute(name), null);
    expect(getter(element), false);

    // element.propertyName=
    setter(element, true);

    // Test expectations
    expect(element.hasAttribute(name), true);
    expect(element.getAttribute(name), trueValue);
    expect(getter(element), true);
  } else {
    // Test expectations
    expect(getter(element), true);

    // element.setAttribute
    element.setAttribute(name, falseValue);

    // Test expectations
    expect(element.hasAttribute(name), true);
    expect(element.getAttribute(name), falseValue);
    expect(getter(element), false);

    // Reset
    element.removeAttribute(name);

    // Test expectations
    expect(element.hasAttribute(name), false);
    expect(element.getAttribute(name), null);
    expect(getter(element), true);

    // element.propertyName=
    setter(element, false);

    // Test expectations
    expect(element.hasAttribute(name), true);
    expect(element.getAttribute(name), falseValue);
    expect(getter(element), false);
  }
}

void _testAttributeNumber<T extends Element>(String name, T element,
    int Function(T e) getter, void Function(T element, int value) setter,
    {int defaultValue}) {
  // Test expectations
  expect(element.getAttribute(name), null);
  expect(getter(element), defaultValue);

  // element.setAttribute
  element.setAttribute(name, '42');

  // Test expectations
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), '42');
  expect(getter(element), 42);

  // Reset
  element.removeAttribute(name);

  // Test expectations
  expect(element.hasAttribute(name), false);
  expect(element.getAttribute(name), null);
  expect(getter(element), defaultValue);

  // element.propertyName=
  setter(element, 42);

  // Test expectations
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), '42');
  expect(getter(element), 42);
}

void _testAttributeResolvedUri<T extends Element>(
  String name,
  T element,
  String Function(T e) getter,
  void Function(T element, String value) setter,
) {
  expect(element.baseUri, isNotEmpty);
  expect(getter(element), '');

  // Test absolute
  final absoluteUri = 'https://absolute/path';
  element.setAttribute(name, absoluteUri);
  expect(getter(element), absoluteUri);
  expect(element.getAttribute(name), absoluteUri);

  final relativeUri = 'relative/example';
  setter(element, relativeUri);
  expect(element.getAttribute(name), 'relative/example');
  expect(
    getter(element),
    matches(r'^.+:(?://localhost:[0-9]+(?:/.+)*)?/relative/example$'),
  );
}

void _testElementSubclasses() {
  // ---------------------------------------------------------------------------
  // AnchorElement
  // ---------------------------------------------------------------------------
  group('AnchorElement:', () {
    AnchorElement element;
    setUp(() {
      element = AnchorElement();
    });

    test('href', () {
      _testAttributeResolvedUri<AnchorElement>(
        'href',
        element,
        (e) => e.href,
        (e, v) => e.href = v,
      );
    });

    test('hreflang', () {
      _testAttribute<AnchorElement>(
        'hreflang',
        element,
        (e) => e.hreflang,
        (e, v) => e.hreflang = v,
      );
    });

    test('hash', () {
      expect(element.hash, '');
      element.href = 'https://host/path#x';
      expect(element.hash, '#x');
    });

    test('pathname', () {
      expect(element.pathname, '');
      element.href = 'https://host/x#hash';
      expect(element.pathname, '/x');
    });

    test('referrerpolicy', () {
      _testAttribute<AnchorElement>(
        'referrerpolicy',
        element,
        (e) => e.referrerPolicy,
        (e, v) => e.referrerPolicy = v,
        value: 'origin',
      );
    });

    test('target', () {
      _testAttribute<AnchorElement>(
        'target',
        element,
        (e) => e.target,
        (e, v) => e.target = v,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // AreaElement
  // ---------------------------------------------------------------------------
  group('AreaElement: ', () {
    AreaElement element;
    setUp(() {
      element = AreaElement();
    });

    test('href', () {
      _testAttributeResolvedUri<AreaElement>(
        'href',
        element,
        (e) => e.href,
        (e, v) => e.href = v,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // AudioElement
  // ---------------------------------------------------------------------------
  group('AudioElement: ', () {
    AudioElement element;
    setUp(() {
      element = AudioElement();
    });

    test('src', () {
      _testAttributeResolvedUri<AudioElement>(
        'src',
        element,
        (e) => e.src,
        (e, v) => e.src = v,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // ButtonElement
  // ---------------------------------------------------------------------------
  group('ButtonElement: ', () {
    ButtonElement element;

    setUp(() {
      element = ButtonElement();
    });

    test('click', () {
      element.onClick.listen(expectAsync1((event) => null));
      element.click();
    });

    test('type', () {
      _testAttribute<ButtonElement>(
        'type',
        element,
        (e) => e.type,
        (e, v) => e.type = v,
        defaultValue: 'submit',
        value: 'reset',
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Element
  // ---------------------------------------------------------------------------
  group('Element: ', () {
    Element element;
    setUp(() {
      element = DivElement();
    });

    test('className', () {
      _testAttribute<DivElement>(
        'class',
        element,
        (e) => e.className,
        (e, v) => e.className = v,
      );
    });

    test('dir', () {
      _testAttribute<DivElement>(
        'dir',
        element,
        (e) => e.dir,
        (e, v) => e.dir = v,
        value: 'rtl',
      );
    });

    test('draggable', () {
      _testAttributeBoolString<DivElement>(
        'draggable',
        element,
        (e) => e.draggable,
        (e, v) => e.draggable = v,
      );
    });

    test('id', () {
      _testAttribute<DivElement>(
        'id',
        element,
        (e) => e.id,
        (e, v) => e.id = v,
      );
    });

    test('slot', () {
      _testAttribute<DivElement>(
        'slot',
        element,
        (e) => e.slot,
        (e, v) => e.slot = v,
      );
    });

    test('spellcheck', () {
      _testAttributeBoolString<DivElement>(
        'spellcheck',
        element,
        (e) => e.spellcheck,
        (e, v) => e.spellcheck = v,
      );
    });

    test('tabIndex', () {
      _testAttributeNumber<DivElement>(
        'tabindex',
        element,
        (e) => e.tabIndex,
        (e, v) => e.tabIndex = v,
        defaultValue: -1,
      );
    });

    test('translate', () {
      _testAttributeBoolString<DivElement>(
        'translate',
        element,
        (e) => e.translate,
        (e, v) => e.translate = v,
        falseValue: 'no',
        trueValue: 'yes',
      );
    });
  });

  // ---------------------------------------------------------------------------
  // IFrameElement
  // ---------------------------------------------------------------------------
  group('IFrameElement: ', () {
    IFrameElement element;
    setUp(() {
      element = IFrameElement();
    });

    test('allow', () {
      _testAttribute<IFrameElement>(
        'allow',
        element,
        (e) => e.allow,
        (e, v) => e.allow = v,
      );
    });

    test('height', () {
      _testAttribute<IFrameElement>(
        'height',
        element,
        (e) => e.height,
        (e, v) => e.height = v,
      );
    });

    test('src', () {
      _testAttributeResolvedUri<IFrameElement>(
        'src',
        element,
        (e) => e.src,
        (e, v) => e.src = v,
      );
    });

    test('width', () {
      _testAttribute<IFrameElement>(
        'width',
        element,
        (e) => e.width,
        (e, v) => e.width = v,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // ImageElement
  // ---------------------------------------------------------------------------
  group('ImageElement: ', () {
    ImageElement element;
    setUp(() {
      element = ImageElement();
    });

    test('alt', () {
      _testAttribute<ImageElement>(
        'alt',
        element,
        (e) => e.alt,
        (e, v) => e.alt = v,
      );
    });

    test('height', () {
      expect(element.height, 0);
      element.height = 32;
      expect(element.height, 32);
    });

    test('src', () {
      _testAttributeResolvedUri<ImageElement>(
        'src',
        element,
        (e) => e.src,
        (e, v) => e.src = v,
      );
    });

    test('width', () {
      expect(element.width, 0);
      element.width = 32;
      expect(element.width, 32);
    });
  });

  // ---------------------------------------------------------------------------
  // InputElement
  // ---------------------------------------------------------------------------
  group('InputElement: ', () {
    InputElement element;
    setUp(() {
      element = InputElement();
    });

    test('autofocus', () {
      _testAttributeBool<InputElement>(
        'autofocus',
        element,
        (e) => e.autofocus,
        (e, v) => e.autofocus = v,
      );
    });

    test('checked', () {
      expect(element.checked, false);
      expect(element.getAttribute('checked'), null);

      element.checked = true;
      expect(element.checked, true);
      expect(element.getAttribute('checked'), null);

      element.checked = false;
      expect(element.checked, false);
      expect(element.getAttribute('checked'), null);
    });

    test('defaultValue', () {
      _testAttribute<InputElement>(
        'value',
        element,
        (e) => e.defaultValue,
        (e, v) => e.defaultValue = v,
      );
    });

    test('defaultChecked', () {
      _testAttributeBool<InputElement>(
        'checked',
        element,
        (e) => e.defaultChecked,
        (e, v) => e.defaultChecked = v,
      );
    });

    test('pattern', () {
      _testAttribute<InputElement>(
        'pattern',
        element,
        (e) => e.pattern,
        (e, v) => e.pattern = v,
      );
    });

    test('type', () {
      _testAttribute<InputElement>(
        'type',
        element,
        (e) => e.type,
        (e, v) => e.type = v,
        defaultValue: 'text',
        value: 'number',
      );
    });

    test('value', () {
      final element = InputElement();
      expect(element.value, '');
      expect(element.getAttribute('value'), null);

      element.value = 'x';
      expect(element.value, 'x');
      expect(element.getAttribute('value'), null);

      element.value = null;
      expect(element.value, '');
      expect(element.getAttribute('value'), null);
    });
  });

  // ---------------------------------------------------------------------------
  // LinkElement
  // ---------------------------------------------------------------------------
  group('LinkElement: ', () {
    LinkElement element;
    setUp(() {
      element = LinkElement();
    });

    test('href', () {
      _testAttributeResolvedUri<LinkElement>(
        'href',
        element,
        (e) => e.href,
        (e, v) => e.href = v,
      );
    });

    test('rel', () {
      _testAttribute<LinkElement>(
        'rel',
        element,
        (e) => e.rel,
        (e, v) => e.rel = v,
      );
    });

    test('type', () {
      _testAttribute<LinkElement>(
        'type',
        element,
        (e) => e.type,
        (e, v) => e.type = v,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // MediaElement
  // ---------------------------------------------------------------------------
  group('MediaElement: ', () {
    MediaElement element;
    setUp(() {
      element = AudioElement();
    });

    test('defaultMuted', () {
      _testAttributeBool<MediaElement>(
        'muted',
        element,
        (e) => e.defaultMuted,
        (e, v) => e.defaultMuted = v,
      );
    });

    test('muted', () {
      expect(element.muted, isFalse);
      element.defaultMuted = true;
      expect(element.defaultMuted, true);
      expect(element.muted, isFalse);
      element.muted = true;
      expect(element.muted, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // OptionElement
  // ---------------------------------------------------------------------------
  group('OptionElement: ', () {
    OptionElement element;
    setUp(() {
      element = OptionElement();
    });

    test('defaultSelected', () {
      _testAttributeBool<OptionElement>(
        'selected',
        element,
        (e) => e.defaultSelected,
        (e, v) => e.defaultSelected = v,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // SelectElement
  // ---------------------------------------------------------------------------
  group('SelectElement: ', () {
    SelectElement element;
    setUp(() {
      element = SelectElement();
    });

    test('length', () {
      expect(element.length, 0);
      element.append(OptionElement());
      expect(element.length, 1);
      element.append(OptionElement());
      expect(element.length, 2);
    });

    test('length=', () {
      element.append(OptionElement());
      element.append(OptionElement());
      expect(element.length, 2);
      element.length = 1;
      expect(element.length, 1);
      expect(element.children.length, 1);
    });

    test('multiple', () {
      _testAttributeBool<SelectElement>(
        'multiple',
        element,
        (e) => e.multiple,
        (e, v) => e.multiple = v,
      );
    });

    test('options', () {
      final option0 = OptionElement()..appendText('example');
      element.append(option0);

      element.append(DivElement());

      final option1 = OptionElement()..appendText('example');
      element.append(option1);

      expect(element.options, [
        option0,
        option1,
      ]);
    });

    test('selectedIndex (single)', () {
      final options = [
        OptionElement()
          ..appendText('text0')
          ..value = 'value0',
        OptionElement()
          ..appendText('text1')
          ..value = 'value1',
        OptionElement()
          ..appendText('text2')
          ..value = 'value2',
      ];
      for (var option in options) {
        element.append(option);
      }
      expect(element.selectedIndex, 0);
      options[1].selected = true;
      expect(element.selectedIndex, 1);
    });

    test('selectedIndex (multiple)', () {
      final options = [
        OptionElement()
          ..appendText('text0')
          ..value = 'value0',
        OptionElement()
          ..appendText('text1')
          ..value = 'value1',
        OptionElement()
          ..appendText('text2')
          ..value = 'value2',
      ];
      element.multiple = true;
      for (var option in options) {
        element.append(option);
      }
      expect(element.selectedIndex, -1);
      options[1].selected = true;
      expect(element.selectedIndex, 1);
      options[2].selected = true;
      expect(element.selectedIndex, 1);
    });

    test('selectedOptions (single)', () {
      final options = [
        OptionElement()
          ..appendText('text0')
          ..value = 'value0',
        OptionElement()
          ..appendText('text1')
          ..value = 'value1',
        OptionElement()
          ..appendText('text2')
          ..value = 'value2',
      ];
      for (var option in options) {
        element.append(option);
      }
      expect(element.selectedOptions, hasLength(1));
      expect(element.selectedOptions[0], same(options[0]));
      options[1].selected = true;
      expect(element.selectedOptions, hasLength(1));
      expect(element.selectedOptions[0], same(options[1]));
      options[2].selected = true;
      expect(element.selectedOptions, hasLength(1));
      expect(element.selectedOptions[0], same(options[2]));
    });

    test('selectedOptions (multiple)', () {
      final options = [
        OptionElement()
          ..appendText('text0')
          ..value = 'value0',
        OptionElement()
          ..appendText('text1')
          ..value = 'value1',
        OptionElement()
          ..appendText('text2')
          ..value = 'value2',
      ];
      element.multiple = true;
      for (var option in options) {
        element.append(option);
      }
      expect(element.selectedOptions, hasLength(0));
      options[1].selected = true;
      expect(element.selectedOptions, hasLength(1));
      expect(element.selectedOptions[0], same(options[1]));
      options[2].selected = true;
      expect(element.selectedOptions, hasLength(2));
      expect(element.selectedOptions[0], same(options[1]));
      expect(element.selectedOptions[1], same(options[2]));
    });

    test('type: select-multiple', () {
      expect(element.type, 'select-one');
    });

    test('type: select-one', () {
      element.multiple = true;
      expect(element.type, 'select-multiple');
    });

    test('value (single)', () {
      final options = [
        OptionElement()
          ..appendText('text0')
          ..value = 'value0',
        OptionElement()
          ..appendText('text1')
          ..value = 'value1',
        OptionElement()
          ..appendText('text2')
          ..value = 'value2',
      ];
      for (var option in options) {
        element.append(option);
      }
      expect(element.value, 'value0');
      options[1].selected = true;
      expect(element.value, 'value1');
    });

    test('value (multiple)', () {
      final options = [
        OptionElement()
          ..appendText('text0')
          ..value = 'value0',
        OptionElement()
          ..appendText('text1')
          ..value = 'value1',
        OptionElement()
          ..appendText('text2')
          ..value = 'value2',
      ];
      element.multiple = true;
      for (var option in options) {
        element.append(option);
      }
      expect(element.value, '');
      options[1].selected = true;
      expect(element.value, 'value1');
      options[2].selected = true;
      expect(element.value, 'value1');
    });

    test('value (no value attributes)', () {
      final options = [
        OptionElement()..appendText('text0'),
        OptionElement()..appendText('text1'),
        OptionElement()..appendText('text2'),
      ];
      for (var option in options) {
        element.append(option);
      }
      expect(element.value, '');
      options[1].selected = true;
      expect(element.value, '');
    });
  });

  // ---------------------------------------------------------------------------
  // ScriptElement
  // ---------------------------------------------------------------------------
  group('ScriptElement: ', () {
    ScriptElement element;
    setUp(() {
      element = ScriptElement();
    });

    test('src', () {
      _testAttributeResolvedUri<ScriptElement>(
        'src',
        element,
        (e) => e.src,
        (e, v) => e.src = v,
      );
    });

    test('type', () {
      _testAttribute<ScriptElement>(
        'type',
        element,
        (e) => e.type,
        (e, v) => e.type = v,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // TextArea
  // ---------------------------------------------------------------------------
  group('TextAreaElement: ', () {
    TextAreaElement element;
    setUp(() {
      element = TextAreaElement();
    });

    test('cols', () {
      _testAttributeNumber<TextAreaElement>(
        'cols',
        element,
        (e) => e.cols,
        (e, v) => e.cols = v?.toInt(),
        defaultValue: 20,
      );
    });

    test('defaultValue', () {
      expect(element.value, '');
      element.appendText('a');
      expect(element.value, 'a');
      element.appendText('b');
      expect(element.value, 'ab');
      element.value = 'abc';
      expect(element.value, 'abc');
    });

    test('maxLength', () {
      _testAttributeNumber<TextAreaElement>(
        'maxlength',
        element,
        (e) => e.maxLength,
        (e, v) => e.maxLength = v?.toInt(),
        defaultValue: -1,
      );
    });

    test('minLength', () {
      _testAttributeNumber<TextAreaElement>(
        'minlength',
        element,
        (e) => e.minLength,
        (e, v) => e.minLength = v?.toInt(),
        defaultValue: -1,
      );
    });

    test('placeholder', () {
      _testAttribute<TextAreaElement>(
        'placeholder',
        element,
        (e) => e.placeholder,
        (e, v) => e.placeholder = v,
      );
    });

    test('rows', () {
      _testAttributeNumber<TextAreaElement>(
        'rows',
        element,
        (e) => e.rows,
        (e, v) => e.rows = v?.toInt(),
        defaultValue: 2,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // VideoElement
  // ---------------------------------------------------------------------------
  group('VideoElement: ', () {
    VideoElement element;
    setUp(() {
      element = VideoElement();
    });

    test('src', () {
      _testAttributeResolvedUri<VideoElement>(
        'src',
        element,
        (e) => e.src,
        (e, v) => e.src = v,
      );
    });
  });
}
