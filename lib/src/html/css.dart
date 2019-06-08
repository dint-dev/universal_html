part of universal_html;

class CssImportRule extends CssRule {
  final String href;

  CssImportRule._(this.href);
}

abstract class CssRule {}

class CssStyleRule extends CssRule {
  final CssStyleSheet parentStyleSheet;
  final String selectorText;
  final _CssStyleDeclaration _style;
  final List<_PriotizedSelector> _parsedSelectors;

  factory CssStyleRule._(CssStyleSheet parentStyleSheet, css.RuleSet node) {
    final selectorText = node.selectorGroup.span.text;
    final List<_PriotizedSelector> priotizedSelectors = <_PriotizedSelector>[];
    for (var selector in node.selectorGroup.selectors) {
      priotizedSelectors.add(_PriotizedSelector(selector));
    }
    final styleDeclaration = _CssStyleDeclaration._();
    for (var declaration in node.declarationGroup.declarations) {
      if (declaration is css.Declaration) {
        styleDeclaration.setProperty(
            declaration.property, declaration.expression.span.text);
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
  );

  CssStyleDeclaration get style => _style;
}

class CssStyleSheet extends StyleSheet {
  final String href;
  final CssStyleSheet parentStyleSheet;
  final List<CssRule> cssRules = [];

  CssStyleSheet._({this.href, this.parentStyleSheet});

  void deleteRule(int index) {
    cssRules.removeAt(index);
  }

  void insertRule(int index) {
    cssRules.insert(
      index,
      CssStyleRule._constructor(this, "", _CssStyleDeclaration._(), []),
    );
  }
}

class CssViewportRule extends CssRule {
  final CssStyleDeclaration style;

  CssViewportRule._(this.style);
}

abstract class StyleSheet {}

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
    int sum = 0;
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
        "Unsupported selector: '${selector.span.text}'",
      );
    }
  }
}

/// Class representing a
/// [length measurement](https://developer.mozilla.org/en-US/docs/Web/CSS/length)
/// in CSS.
class Dimension {
  num _value;
  String _unit;

  /// Set this CSS Dimension to a percentage `value`.
  Dimension.percent(this._value) : _unit = '%';

  /// Set this CSS Dimension to a pixel `value`.
  Dimension.px(this._value) : _unit = 'px';

  /// Set this CSS Dimension to a pica `value`.
  Dimension.pc(this._value) : _unit = 'pc';

  /// Set this CSS Dimension to a point `value`.
  Dimension.pt(this._value) : _unit = 'pt';

  /// Set this CSS Dimension to an inch `value`.
  Dimension.inch(this._value) : _unit = 'in';

  /// Set this CSS Dimension to a centimeter `value`.
  Dimension.cm(this._value) : _unit = 'cm';

  /// Set this CSS Dimension to a millimeter `value`.
  Dimension.mm(this._value) : _unit = 'mm';

  /// Set this CSS Dimension to the specified number of ems.
  ///
  /// 1em is equal to the current font size. (So 2ems is equal to double the font
  /// size). This is useful for producing website layouts that scale nicely with
  /// the user's desired font size.
  Dimension.em(this._value) : _unit = 'em';

  /// Set this CSS Dimension to the specified number of x-heights.
  ///
  /// One ex is equal to the x-height of a font's baseline to its mean line,
  /// generally the height of the letter "x" in the font, which is usually about
  /// half the font-size.
  Dimension.ex(this._value) : _unit = 'ex';

  /// Construct a Dimension object from the valid, simple CSS string `cssValue`
  /// that represents a distance measurement.
  ///
  /// This constructor is intended as a convenience method for working with
  /// simplistic CSS length measurements. Non-numeric values such as `auto` or
  /// `inherit` or invalid CSS will cause this constructor to throw a
  /// FormatError.
  Dimension.css(String cssValue) {
    if (cssValue == '') cssValue = '0px';
    if (cssValue.endsWith('%')) {
      _unit = '%';
    } else {
      _unit = cssValue.substring(cssValue.length - 2);
    }
    if (cssValue.contains('.')) {
      _value =
          double.parse(cssValue.substring(0, cssValue.length - _unit.length));
    } else {
      _value = int.parse(cssValue.substring(0, cssValue.length - _unit.length));
    }
  }

  /// Print out the CSS String representation of this value.
  String toString() {
    return '${_value}${_unit}';
  }

  /// Return a unitless, numerical value of this CSS value.
  num get value => this._value;
}
