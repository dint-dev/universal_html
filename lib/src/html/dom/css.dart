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
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
part of universal_html.internal;

class CssImportRule extends CssRule {
  final String href;

  CssImportRule._(this.href) : super._();
}

abstract class CssRule {
  CssRule._();
}

class CssStyleRule extends CssRule {
  final CssStyleSheet parentStyleSheet;
  final String selectorText;
  final _CssStyleDeclaration _style;
  final List<_PriotizedSelector> _parsedSelectors;

  factory CssStyleRule.internal(
      CssStyleSheet parentStyleSheet, css.RuleSet node) {
    final selectorGroup = node.selectorGroup!;
    final selectorText = selectorGroup.span!.text;
    final priotizedSelectors = <_PriotizedSelector>[];
    for (var selector in selectorGroup.selectors) {
      priotizedSelectors.add(_PriotizedSelector(selector));
    }
    final styleDeclaration = _CssStyleDeclaration._();
    for (var declaration in node.declarationGroup.declarations) {
      if (declaration is css.Declaration) {
        final expression = declaration.expression!;
        styleDeclaration.setProperty(
          declaration.property,
          expression.span!.text,
        );
      }
    }
    return CssStyleRule._constructor(
      parentStyleSheet,
      selectorText,
      styleDeclaration,
      priotizedSelectors,
    );
  }

  CssStyleRule._constructor(
    this.parentStyleSheet,
    this.selectorText,
    this._style,
    this._parsedSelectors,
  ) : super._();

  CssStyleDeclaration get style => _style;
}

class CssStyleSheet extends StyleSheet {
  final String? href;
  final CssStyleSheet? parentStyleSheet;
  final List<CssRule> cssRules = [];

  CssStyleSheet.constructor({
    this.href,
    this.parentStyleSheet,
  }) : super._();

  void deleteRule(int index) {
    cssRules.removeAt(index);
  }

  void insertRule(int index) {
    cssRules.insert(
      index,
      CssStyleRule._constructor(this, '', _CssStyleDeclaration._(), []),
    );
  }
}

class CssStyleValue {
  CssStyleValue._();

  static Object parse(String property, String cssText) {
    throw UnimplementedError();
  }
}

class CssViewportRule extends CssRule {
  final CssStyleDeclaration style;

  CssViewportRule._(this.style) : super._();
}

/// Class representing a
/// [length measurement](https://developer.mozilla.org/en-US/docs/Web/CSS/length)
/// in CSS.
class Dimension {
  /// Return a unitless, numerical value of this CSS value.
  final num value;

  final String _unit;

  /// Set this CSS Dimension to a centimeter `value`.
  Dimension.cm(this.value) : _unit = 'cm';

  /// Construct a Dimension object from the valid, simple CSS string `cssValue`
  /// that represents a distance measurement.
  ///
  /// This constructor is intended as a convenience method for working with
  /// simplistic CSS length measurements. Non-numeric values such as `auto` or
  /// `inherit` or invalid CSS will cause this constructor to throw a
  /// FormatError.
  factory Dimension.css(String cssValue) {
    late num value;
    var unit = '';
    if (cssValue == '') cssValue = '0px';
    if (cssValue.endsWith('%')) {
      unit = '%';
    } else {
      // All other units are assumed to have length 2
      unit = cssValue.substring(cssValue.length - 2);
    }
    if (cssValue.contains('.')) {
      final s = cssValue.substring(0, cssValue.length - unit.length);
      value = double.parse(s);
    } else {
      final s = cssValue.substring(0, cssValue.length - unit.length);
      value = int.parse(s);
    }
    return Dimension._(value, unit);
  }

  /// Set this CSS Dimension to the specified number of ems.
  ///
  /// 1em is equal to the current font size. (So 2ems is equal to double the font
  /// size). This is useful for producing website layouts that scale nicely with
  /// the user's desired font size.
  Dimension.em(this.value) : _unit = 'em';

  /// Set this CSS Dimension to the specified number of x-heights.
  ///
  /// One ex is equal to the x-height of a font's baseline to its mean line,
  /// generally the height of the letter 'x' in the font, which is usually about
  /// half the font-size.
  Dimension.ex(this.value) : _unit = 'ex';

  /// Set this CSS Dimension to an inch `value`.
  Dimension.inch(this.value) : _unit = 'in';

  /// Set this CSS Dimension to a millimeter `value`.
  Dimension.mm(this.value) : _unit = 'mm';

  /// Set this CSS Dimension to a pica `value`.
  Dimension.pc(this.value) : _unit = 'pc';

  /// Set this CSS Dimension to a percentage `value`.
  Dimension.percent(this.value) : _unit = '%';

  /// Set this CSS Dimension to a point `value`.
  Dimension.pt(this.value) : _unit = 'pt';

  /// Set this CSS Dimension to a pixel `value`.
  Dimension.px(this.value) : _unit = 'px';

  Dimension._(this.value, this._unit);

  /// NOT part of 'dart:html'.
  String get internalUnit => _unit;

  /// Print out the CSS String representation of this value.
  @override
  String toString() {
    return '$value$_unit';
  }
}

class StylePropertyMap extends StylePropertyMapReadonly {
  StylePropertyMap._() : super._();

  void append(String property, Object value) {
    throw UnimplementedError();
  }

  void delete(String property) {
    throw UnimplementedError();
  }

  void set(String property, Object value) {
    throw UnimplementedError();
  }
}

class StylePropertyMapReadonly {
  StylePropertyMapReadonly._();

  CssStyleValue get(String property) {
    throw UnimplementedError();
  }

  List<CssStyleValue> getAll(String property) {
    throw UnimplementedError();
  }

  List<String> getProperties() {
    throw UnimplementedError();
  }

  bool has(String property) {
    throw UnimplementedError();
  }
}

abstract class StyleSheet {
  StyleSheet._();
}

class _PriotizedSelector {
  final css.Selector selector;
  final int priority;

  factory _PriotizedSelector(css.Selector selector) {
    return _PriotizedSelector._(selector, _priorityForSelector(selector));
  }

  _PriotizedSelector._(this.selector, this.priority);

  // This is NOT the correct algorithm.
  // Just a quick, ad-hoc implementation.
  static int _priorityForSelector(css.Selector selector) {
    final sequences = selector.simpleSelectorSequences;
    var sum = 0;
    for (var i = sequences.length - 1; i >= 0; i--) {
      final sequence = sequences[i];
      if (sequence.combinator == css.TokenKind.COMBINATOR_NONE) {
        sum += _priorityForSimpleSelector(sequence.simpleSelector);
      } else {
        break;
      }
    }
    return sum;
  }

  static int _priorityForSimpleSelector(css.SimpleSelector selector) {
    // CSS specificity rules in the ascending order:
    //   - Element type
    //   - Element attributes and pseudo-selectors
    //   - Element id

    if (selector.isWildcard) {
      return 1;
    } else if (selector is css.ElementSelector) {
      return 2;
    } else if (selector is css.ClassSelector ||
        selector is css.AttributeSelector ||
        selector is css.NegationSelector ||
        selector is css.PseudoClassSelector ||
        selector is css.PseudoClassFunctionSelector ||
        selector is css.PseudoElementSelector ||
        selector is css.PseudoElementFunctionSelector) {
      return 3;
    } else if (selector is css.IdSelector) {
      return 4;
    } else {
      throw UnsupportedError(
        'Unsupported selector: "${selector.span!.text}"',
      );
    }
  }
}
