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

void _testAttribute<T extends Element>({
  required String name,
  required T element,
  required String? Function(T e) getter,
  required void Function(T element, String? value) setter,
  String? defaultValue = '',
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
    bool? Function(T e) getter, void Function(T element, bool value) setter) {
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

void _testAttributeBoolString<T extends Element>({
  required String name,
  required T element,
  required bool? Function(T e) getter,
  required void Function(T element, bool? value) setter,
  required bool? defaultValue,
  String falseString = 'false',
  String trueString = 'true',
}) {
  // Initial state
  expect(getter(element), defaultValue);

  // element.setAttribute('attribute', 'true')
  element.setAttribute(name, trueString);
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), trueString);
  expect(getter(element), true);

  // element.setAttribute('attribute', 'false')
  element.setAttribute(name, falseString);
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), falseString);
  expect(getter(element), false);

  // Reset
  element.removeAttribute(name);
  expect(element.hasAttribute(name), false);
  expect(element.getAttribute(name), null);
  expect(getter(element), defaultValue);

  // element.propertyName = true
  setter(element, true);
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), trueString);
  expect(getter(element), true);

  // element.propertyName = false
  setter(element, false);
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), falseString);
  expect(getter(element), false);
}

void _testAttributeNumber<T extends Element>({
  required String name,
  required T element,
  required int? Function(T e) getter,
  required void Function(T element, int? value) setter,
  int? defaultValue,
}) {
  // Initial value
  expect(element.getAttribute(name), null);
  expect(getter(element), defaultValue);

  // element.setAttribute('name', 'value')
  element.setAttribute(name, '42');
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), '42');
  expect(getter(element), 42);

  // element.removeAttribute('name')
  element.removeAttribute(name);
  expect(element.hasAttribute(name), false);
  expect(element.getAttribute(name), null);
  expect(getter(element), defaultValue);

  // element.propertyName=
  setter(element, 42);
  expect(element.hasAttribute(name), true);
  expect(element.getAttribute(name), '42');
  expect(getter(element), 42);
}

void _testAttributeResolvedUri<T extends Element>({
  required String name,
  required T element,
  required String? Function(T e) getter,
  required void Function(T element, String? value) setter,
}) {
  // Default value
  expect(getter(element), '');

  // Absolute URL
  final absoluteUri = 'https://absolute/path';
  element.setAttribute(name, absoluteUri);
  expect(getter(element), absoluteUri);
  expect(element.getAttribute(name), absoluteUri);

  // Base URL is required for resolving relative URLs
  expect(element.baseUri, isNotEmpty);

  // Relative URL
  final relativeUri = 'relative/example';
  setter(element, relativeUri);
  expect(element.getAttribute(name), 'relative/example');
  expect(
    getter(element),
    matches(r'^.+:(?://localhost(?::[0-9]+)?(?:/.+)*)?/relative/example$'),
  );
}

void _testElementSubclasses() {
  // ---------------------------------------------------------------------------
  // AnchorElement
  // ---------------------------------------------------------------------------
  group('AnchorElement:', () {
    late AnchorElement element;
    setUp(() {
      element = AnchorElement();
    });

    test('href', () {
      _testAttributeResolvedUri<AnchorElement>(
        name: 'href',
        element: element,
        getter: (e) => e.href,
        setter: (e, v) => e.href = v,
      );
    });

    test('hreflang', () {
      _testAttribute<AnchorElement>(
        name: 'hreflang',
        element: element,
        getter: (e) => e.hreflang,
        setter: (e, v) => e.hreflang = v!,
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
        name: 'referrerpolicy',
        element: element,
        getter: (e) => e.referrerPolicy,
        setter: (e, v) => e.referrerPolicy = v,
        value: 'origin',
      );
    });

    test('target', () {
      _testAttribute<AnchorElement>(
        name: 'target',
        element: element,
        getter: (e) => e.target,
        setter: (e, v) => e.target = v!,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // AreaElement
  // ---------------------------------------------------------------------------
  group('AreaElement: ', () {
    late AreaElement element;
    setUp(() {
      element = AreaElement();
    });

    test('href', () {
      _testAttributeResolvedUri<AreaElement>(
        name: 'href',
        element: element,
        getter: (e) => e.href,
        setter: (e, v) => e.href = v,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // AudioElement
  // ---------------------------------------------------------------------------
  group('AudioElement: ', () {
    late AudioElement element;
    setUp(() {
      element = AudioElement();
    });

    test('src', () {
      _testAttributeResolvedUri<AudioElement>(
        name: 'src',
        element: element,
        getter: (e) => e.src,
        setter: (e, v) => e.src = v!,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // ButtonElement
  // ---------------------------------------------------------------------------
  group('ButtonElement: ', () {
    late ButtonElement element;

    setUp(() {
      element = ButtonElement();
    });

    test('click', () {
      element.onClick.listen(expectAsync1((event) {}));
      element.click();
    });

    test('type', () {
      _testAttribute<ButtonElement>(
        name: 'type',
        element: element,
        getter: (e) => e.type,
        setter: (e, v) => e.type = v!,
        defaultValue: 'submit',
        value: 'reset',
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Element
  // ---------------------------------------------------------------------------
  group('Element: ', () {
    late DivElement element;
    setUp(() {
      element = DivElement();
    });

    test('className', () {
      _testAttribute<DivElement>(
        name: 'class',
        element: element,
        getter: (e) => e.className,
        setter: (e, v) => e.className = v!,
      );
    });

    test('dir', () {
      _testAttribute<DivElement>(
        name: 'dir',
        element: element,
        getter: (e) => e.dir,
        setter: (e, v) => e.dir = v,
        value: 'rtl',
      );
    });

    test('draggable', () {
      _testAttributeBoolString<DivElement>(
        name: 'draggable',
        element: element,
        getter: (e) => e.draggable,
        setter: (e, v) => e.draggable = v!,
        defaultValue: false,
      );
    });

    test('id', () {
      _testNonNullableAttribute<DivElement>(
        'id',
        element,
        (e) => e.id,
        (e, v) => e.id = v,
      );
    });

    test('slot', () {
      _testAttribute<DivElement>(
        name: 'slot',
        element: element,
        getter: (e) => e.slot,
        setter: (e, v) => e.slot = v,
      );
    });

    test('spellcheck', () {
      _testAttributeBoolString<DivElement>(
        name: 'spellcheck',
        element: element,
        getter: (e) => e.spellcheck,
        setter: (e, v) => e.spellcheck = v,
        defaultValue: true,
      );
    });

    test('tabIndex', () {
      _testAttributeNumber<DivElement>(
        name: 'tabindex',
        element: element,
        getter: (e) => e.tabIndex,
        setter: (e, v) => e.tabIndex = v,
        defaultValue: -1,
      );
    });

    test('translate', () {
      _testAttributeBoolString<DivElement>(
        name: 'translate',
        element: element,
        getter: (e) => e.translate,
        setter: (e, v) => e.translate = v,
        falseString: 'no',
        trueString: 'yes',
        defaultValue: true,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // IFrameElement
  // ---------------------------------------------------------------------------
  group('IFrameElement: ', () {
    late IFrameElement element;
    setUp(() {
      element = IFrameElement();
    });

    test('allow', () {
      _testAttribute<IFrameElement>(
        name: 'allow',
        element: element,
        getter: (e) => e.allow,
        setter: (e, v) => e.allow = v,
      );
    });

    test('allowFullScreen', () {
      _testAttributeBool<IFrameElement>(
        'allowFullscreen',
        element,
        (e) => e.allowFullscreen,
        (e, v) => e.allowFullscreen = v,
      );
    });

    test('allowPaymentRequest', () {
      _testAttributeBool<IFrameElement>(
        'allowPaymentRequest',
        element,
        (e) => e.allowPaymentRequest,
        (e, v) => e.allowPaymentRequest = v,
      );
    });

    test('height', () {
      _testAttribute<IFrameElement>(
        name: 'height',
        element: element,
        getter: (e) => e.height,
        setter: (e, v) => e.height = v,
      );
    });

    test('referrerPolicy', () {
      _testAttribute<IFrameElement>(
        name: 'referrerPolicy',
        element: element,
        getter: (e) => e.referrerPolicy,
        setter: (e, v) => e.referrerPolicy = v,
        value: 'no-referrer',
      );
    });

    test('sandbox', () {
      expect(element.sandbox?.length, 0);
      element.sandbox?.add('x');
      expect(element.sandbox?.length, 1);
      element.sandbox?.remove('x');
      expect(element.sandbox?.length, 0);
    });

    test('src', () {
      _testAttributeResolvedUri<IFrameElement>(
        name: 'src',
        element: element,
        getter: (e) => e.src,
        setter: (e, v) => e.src = v,
      );
    });

    test('width', () {
      _testAttribute<IFrameElement>(
        name: 'width',
        element: element,
        getter: (e) => e.width,
        setter: (e, v) => e.width = v,
      );
    });

    test('children after setting innerHtml', () {
      final innerHtml =
          '<html><body><a href="url">&amp;&lt;&gt;</a></body></html>';
      final iframe = IFrameElement()
        ..className = 'example'
        ..innerHtml = innerHtml;
      expect(iframe.children, hasLength(0));
      expect(iframe.childNodes, hasLength(1));
      expect(iframe.text, innerHtml);
      expect(iframe.outerHtml, '<iframe class="example">$innerHtml</iframe>');
    });

    test('outerHtml after setting innerHtml', () {
      final innerHtml =
          '<html><body><a href="url">&amp;&lt;&gt;</a></body></html>';
      final iframe = IFrameElement()
        ..className = 'example'
        ..innerHtml = innerHtml;
      expect(iframe.outerHtml, '<iframe class="example">$innerHtml</iframe>');
    });

    test('children after parsing document', () {
      final innerHtml =
          '<html><body><a href="url">&amp;&lt;&gt;</a></body></html>';
      final html = '<html><body><iframe>$innerHtml</iframe></body></html>';
      final doc = parseHtmlDocument(html);
      final iframe = doc.body!.children.single;
      expect(iframe.children, hasLength(0));
      expect(iframe.childNodes, hasLength(1));
      expect(iframe.childNodes.single.childNodes, hasLength(0));
      expect(iframe.childNodes.single.text, innerHtml);
    });

    test('outerHtml after parsing document', () {
      final innerHtml =
          '<html><body><a href="url">&amp;&lt;&gt;</a></body></html>';
      final html = '<html><body><iframe>$innerHtml</iframe></body></html>';
      final doc = parseHtmlDocument(html);
      expect(
          doc.body?.children.single.outerHtml, '<iframe>$innerHtml</iframe>');
      expect(doc.body?.outerHtml, '<body><iframe>$innerHtml</iframe></body>');
    });
  });

  // ---------------------------------------------------------------------------
  // ImageElement
  // ---------------------------------------------------------------------------
  group('ImageElement: ', () {
    late ImageElement element;
    setUp(() {
      element = ImageElement();
    });

    test('alt', () {
      _testAttribute<ImageElement>(
        name: 'alt',
        element: element,
        getter: (e) => e.alt,
        setter: (e, v) => e.alt = v,
      );
    });

    test('height', () {
      expect(element.height, 0);
      element.height = 32;
      expect(element.height, 32);
    });

    test('src', () {
      _testAttributeResolvedUri<ImageElement>(
        name: 'src',
        element: element,
        getter: (e) => e.src,
        setter: (e, v) => e.src = v,
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
    late InputElement element;
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
        name: 'value',
        element: element,
        getter: (e) => e.defaultValue,
        setter: (e, v) => e.defaultValue = v,
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
        name: 'pattern',
        element: element,
        getter: (e) => e.pattern,
        setter: (e, v) => e.pattern = v!,
      );
    });

    test('type', () {
      _testAttribute<InputElement>(
        name: 'type',
        element: element,
        getter: (e) => e.type,
        setter: (e, v) => e.type = v,
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
    late LinkElement element;
    setUp(() {
      element = LinkElement();
    });

    test('href', () {
      _testAttributeResolvedUri<LinkElement>(
        name: 'href',
        element: element,
        getter: (e) => e.href,
        setter: (e, v) => e.href = v!,
      );
    });

    test('rel', () {
      _testAttribute<LinkElement>(
        name: 'rel',
        element: element,
        getter: (e) => e.rel,
        setter: (e, v) => e.rel = v!,
      );
    });

    test('type', () {
      _testAttribute<LinkElement>(
        name: 'type',
        element: element,
        getter: (e) => e.type,
        setter: (e, v) => e.type = v!,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // MediaElement
  // ---------------------------------------------------------------------------
  group('MediaElement: ', () {
    late MediaElement element;
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
    late OptionElement element;
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
    late SelectElement element;
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
    late ScriptElement element;
    setUp(() {
      element = ScriptElement();
    });

    test('src', () {
      _testAttributeResolvedUri<ScriptElement>(
        name: 'src',
        element: element,
        getter: (e) => e.src,
        setter: (e, v) => e.src = v!,
      );
    });

    test('type', () {
      _testAttribute<ScriptElement>(
        name: 'type',
        element: element,
        getter: (e) => e.type,
        setter: (e, v) => e.type = v!,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // TextArea
  // ---------------------------------------------------------------------------
  group('TextAreaElement: ', () {
    late TextAreaElement element;
    setUp(() {
      element = TextAreaElement();
    });

    test('cols', () {
      _testAttributeNumber<TextAreaElement>(
        name: 'cols',
        element: element,
        getter: (e) => e.cols,
        setter: (e, v) => e.cols = v!,
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
        name: 'maxlength',
        element: element,
        getter: (e) => e.maxLength,
        setter: (e, v) => e.maxLength = v!.toInt(),
        defaultValue: -1,
      );
    });

    test('minLength', () {
      _testAttributeNumber<TextAreaElement>(
        name: 'minlength',
        element: element,
        getter: (e) => e.minLength,
        setter: (e, v) => e.minLength = v!.toInt(),
        defaultValue: -1,
      );
    });

    test('placeholder', () {
      _testAttribute<TextAreaElement>(
        name: 'placeholder',
        element: element,
        getter: (e) => e.placeholder,
        setter: (e, v) => e.placeholder = v!,
      );
    });

    test('rows', () {
      _testAttributeNumber<TextAreaElement>(
        name: 'rows',
        element: element,
        getter: (e) => e.rows,
        setter: (e, v) => e.rows = v!.toInt(),
        defaultValue: 2,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // VideoElement
  // ---------------------------------------------------------------------------
  group('VideoElement: ', () {
    late VideoElement element;
    setUp(() {
      element = VideoElement();
    });

    test('src', () {
      _testAttributeResolvedUri<VideoElement>(
        name: 'src',
        element: element,
        getter: (e) => e.src,
        setter: (e, v) => e.src = v!,
      );
    });
  });
}

void _testNonNullableAttribute<T extends Element>(
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
