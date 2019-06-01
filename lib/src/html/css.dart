part of universal_html;

class CssImportRule extends CssRule {
  final String href;

  CssImportRule._(this.href);
}

abstract class CssRule {}

abstract class CssStyleDeclaration {
  CssStyleDeclaration._();

  String get alignContent => getPropertyValue("align-content");

  set alignContent(String newValue) {
    _setPropertyWithValidName("align-content", newValue);
  }

  String get alignItems => getPropertyValue("align-items");

  set alignItems(String newValue) {
    _setPropertyWithValidName("align-items", newValue);
  }

  String get alignSelf => getPropertyValue("align-self");

  set alignSelf(String newValue) {
    _setPropertyWithValidName("align-self", newValue);
  }

  String get animation => getPropertyValue("animation");

  set animation(String newValue) {
    _setPropertyWithValidName("animation", newValue);
  }

  String get animationDelay => getPropertyValue("animation-delay");

  set animationDelay(String newValue) {
    _setPropertyWithValidName("animation-delay", newValue);
  }

  String get animationDirection => getPropertyValue("animation-direction");

  set animationDirection(String newValue) {
    _setPropertyWithValidName("animation-direction", newValue);
  }

  String get animationDuration => getPropertyValue("animation-duration");

  set animationDuration(String newValue) {
    _setPropertyWithValidName("animation-duration", newValue);
  }

  String get animationIterationCount =>
      getPropertyValue("animation-iteration-count");

  set animationIterationCount(String newValue) {
    _setPropertyWithValidName("animation-iteration-count", newValue);
  }

  String get animationName => getPropertyValue("animation-name");

  set animationName(String newValue) {
    _setPropertyWithValidName("animation-name", newValue);
  }

  String get animationPlayState => getPropertyValue("animation-play-state");

  set animationPlayState(String newValue) {
    _setPropertyWithValidName("animation-paly-state", newValue);
  }

  String get animationTimingFunction =>
      getPropertyValue("animation-timing-function");

  set animationTimingFunction(String newValue) {
    _setPropertyWithValidName("animation-timing-function", newValue);
  }

  String get backgroundBlendMode => getPropertyValue("background-blend-mode");

  set backgroundBlendMode(String newValue) {
    _setPropertyWithValidName("background-blend-mode", newValue);
  }

  String get backgroundColor => getPropertyValue("background-color");

  set backgroundColor(String newValue) {
    _setPropertyWithValidName("background-color", newValue);
  }

  String get backgroundImage => getPropertyValue("background-image");

  set backgroundImage(String newValue) {
    _setPropertyWithValidName("background-image", newValue);
  }

  String get backgroundPosition => getPropertyValue("background-position");

  set backgroundPosition(String newValue) {
    _setPropertyWithValidName("background-position", newValue);
  }

  String get backgroundRepeat => getPropertyValue("background-repeat");

  set backgroundRepeat(String newValue) {
    _setPropertyWithValidName("background-repeat", newValue);
  }

  String get backgroundSize => getPropertyValue("background-size");

  set backgroundSize(String newValue) {
    _setPropertyWithValidName("background-size", newValue);
  }

  String get border => getPropertyValue("border");

  set border(String newValue) {
    _setPropertyWithValidName("border", newValue);
  }

  String get borderBottom => getPropertyValue("border-bottom");

  set borderBottom(String newValue) {
    _setPropertyWithValidName("border-bottom", newValue);
  }

  String get borderHeight => getPropertyValue("border-height");

  set borderHeight(String newValue) {
    _setPropertyWithValidName("border-height", newValue);
  }

  String get borderLeft => getPropertyValue("border-left");

  set borderLeft(String newValue) {
    _setPropertyWithValidName("border-left", newValue);
  }

  String get borderRadius => getPropertyValue("border-radius");

  set borderRadius(String newValue) {
    _setPropertyWithValidName("border-radius", newValue);
  }

  String get borderRight => getPropertyValue("border-right");

  set borderRight(String newValue) {
    _setPropertyWithValidName("border-right", newValue);
  }

  String get borderTop => getPropertyValue("border-top");

  set borderTop(String newValue) {
    _setPropertyWithValidName("border-top", newValue);
  }

  String get borderWidth => getPropertyValue("border-width");

  set borderWidth(String newValue) {
    _setPropertyWithValidName("border-width", newValue);
  }

  String get bottom => getPropertyValue("bottom");

  set bottom(String newValue) {
    _setPropertyWithValidName("bottom", newValue);
  }

  String get clear => getPropertyValue("clear");

  set clear(String newValue) {
    _setPropertyWithValidName("clear", newValue);
  }

  String get color => getPropertyValue("color");

  set color(String newValue) {
    _setPropertyWithValidName("color", newValue);
  }

  String get content => getPropertyValue("content");

  set content(String newValue) {
    _setPropertyWithValidName("content", newValue);
  }

  String get cursor => getPropertyValue("cursor");

  set cursor(String newValue) {
    _setPropertyWithValidName("cursor", newValue);
  }

  String get direction => getPropertyValue("direction");

  set direction(String newValue) {
    _setPropertyWithValidName("direction", newValue);
  }

  String get display => getPropertyValue("display");

  set display(String newValue) {
    _setPropertyWithValidName("display", newValue);
  }

  String get flex => getPropertyValue("flex");

  set flex(String newValue) {
    _setPropertyWithValidName("flex", newValue);
  }

  String get flexBasis => getPropertyValue("flex-basis");

  set flexBasis(String newValue) {
    _setPropertyWithValidName("flex-basis", newValue);
  }

  String get flexDirection => getPropertyValue("flex-direction");

  set flexDirection(String newValue) {
    _setPropertyWithValidName("flex-direction", newValue);
  }

  String get flexShrink => getPropertyValue("flex-shrink");

  set flexShrink(String newValue) {
    _setPropertyWithValidName("flex-shrink", newValue);
  }

  String get flexWrap => getPropertyValue("flex-wrap");

  set flexWrap(String newValue) {
    _setPropertyWithValidName("flex-wrap", newValue);
  }

  String get float => getPropertyValue("float");

  set float(String newValue) {
    _setPropertyWithValidName("float", newValue);
  }

  String get font => getPropertyValue("font");

  set font(String newValue) {
    _setPropertyWithValidName("font", newValue);
  }

  String get fontFamily => getPropertyValue("font-family");

  set fontFamily(String newValue) {
    _setPropertyWithValidName("font-family", newValue);
  }

  String get fontSize => getPropertyValue("font-size");

  set fontSize(String newValue) {
    _setPropertyWithValidName("font-size", newValue);
  }

  String get fontSmoothing => getPropertyValue("font-smoothing");

  set fontSmoothing(String newValue) {
    _setPropertyWithValidName("font-smoothing", newValue);
  }

  String get fontStyle => getPropertyValue("font-style");

  set fontStyle(String newValue) {
    _setPropertyWithValidName("font-style", newValue);
  }

  String get fontVariant => getPropertyValue("font-variant");

  set fontVariant(String newValue) {
    _setPropertyWithValidName("font-variant", newValue);
  }

  String get fontWeight => getPropertyValue("font-weight");

  set fontWeight(String newValue) {
    _setPropertyWithValidName("font-weight", newValue);
  }

  String get grid => getPropertyValue("grid");

  set grid(String newValue) {
    _setPropertyWithValidName("grid", newValue);
  }

  String get gridColumn => getPropertyValue("grid-column");

  set gridColumn(String newValue) {
    _setPropertyWithValidName("grid-column", newValue);
  }

  String get gridRow => getPropertyValue("grid-row");

  set gridRow(String newValue) {
    _setPropertyWithValidName("grid-row", newValue);
  }

  String get height => getPropertyValue("height");

  set height(String newValue) {
    _setPropertyWithValidName("height", newValue);
  }

  String get isolation => getPropertyValue("isolation");

  set isolation(String newValue) {
    _setPropertyWithValidName("isolation", newValue);
  }

  String get left => getPropertyValue("left");

  set left(String newValue) {
    _setPropertyWithValidName("left", newValue);
  }

  int get length;

  String get letterSpacing => getPropertyValue("letter-spacing");

  set letterSpacing(String newValue) {
    _setPropertyWithValidName("letter-spacing", newValue);
  }

  String get locale => getPropertyValue("locale");

  set locale(String newValue) {
    _setPropertyWithValidName("locale", newValue);
  }

  String get margin => getPropertyValue("margin");

  set margin(String newValue) {
    _setPropertyWithValidName("margin", newValue);
  }

  String get marginBottom => getPropertyValue("margin-bottom");

  set marginBottom(String newValue) {
    _setPropertyWithValidName("margin-bottom", newValue);
  }

  String get marginLeft => getPropertyValue("margin-left");

  set marginLeft(String newValue) {
    _setPropertyWithValidName("margin-left", newValue);
  }

  String get marginRight => getPropertyValue("margin-right");

  set marginRight(String newValue) {
    _setPropertyWithValidName("margin-right", newValue);
  }

  String get marginTop => getPropertyValue("margin-top");

  set marginTop(String newValue) {
    _setPropertyWithValidName("margin-top", newValue);
  }

  String get maxHeight => getPropertyValue("max-height");

  set maxHeight(String newValue) {
    _setPropertyWithValidName("max-height", newValue);
  }

  String get maxWidth => getPropertyValue("max-width");

  set maxWidth(String newValue) {
    _setPropertyWithValidName("max-width", newValue);
  }

  String get minHeight => getPropertyValue("min-height");

  set minHeight(String newValue) {
    _setPropertyWithValidName("min-height", newValue);
  }

  String get minWidth => getPropertyValue("min-width");

  set minWidth(String newValue) {
    _setPropertyWithValidName("min-width", newValue);
  }

  String get mixBlendMode => getPropertyValue("mix-blend-mode");

  set mixBlendMode(String newValue) {
    _setPropertyWithValidName("mix-blend-mode", newValue);
  }

  String get opacity => getPropertyValue("opacity");

  set opacity(String newValue) {
    _setPropertyWithValidName("opacity", newValue);
  }

  String get outline => getPropertyValue("outline");

  set outline(String newValue) {
    _setPropertyWithValidName("outline", newValue);
  }

  String get outlineColor => getPropertyValue("outline-color");

  set outlineColor(String newValue) {
    _setPropertyWithValidName("outline-color", newValue);
  }

  String get outlineStyle => getPropertyValue("outline-style");

  set outlineStyle(String newValue) {
    _setPropertyWithValidName("outline-style", newValue);
  }

  String get outlineWidth => getPropertyValue("outline-width");

  set outlineWidth(String newValue) {
    _setPropertyWithValidName("outline-width", newValue);
  }

  String get overflow => getPropertyValue("overflow");

  set overflow(String newValue) {
    _setPropertyWithValidName("overflow", newValue);
  }

  String get padding => getPropertyValue("padding");

  set padding(String newValue) {
    _setPropertyWithValidName("padding", newValue);
  }

  String get paddingBottom => getPropertyValue("padding-bottom");

  set paddingBottom(String newValue) {
    _setPropertyWithValidName("padding-bottom", newValue);
  }

  String get paddingLeft => getPropertyValue("padding-left");

  set paddingLeft(String newValue) {
    _setPropertyWithValidName("padding-left", newValue);
  }

  String get paddingRight => getPropertyValue("padding-right");

  set paddingRight(String newValue) {
    _setPropertyWithValidName("padding-right", newValue);
  }

  String get paddingTop => getPropertyValue("padding-top");

  set paddingTop(String newValue) {
    _setPropertyWithValidName("padding-top", newValue);
  }

  String get position => getPropertyValue("position");

  set position(String newValue) {
    _setPropertyWithValidName("position", newValue);
  }

  String get resize => getPropertyValue("resize");

  set resize(String newValue) {
    _setPropertyWithValidName("resize", newValue);
  }

  String get right => getPropertyValue("right");

  set right(String newValue) {
    _setPropertyWithValidName("right", newValue);
  }

  String get scale => getPropertyValue("scale");

  set scale(String newValue) {
    _setPropertyWithValidName("scale", newValue);
  }

  String get textAlign => getPropertyValue("text-align");

  set textAlign(String newValue) {
    _setPropertyWithValidName("text-align", newValue);
  }

  String get textDecoration => getPropertyValue("text-decoration");

  set textDecoration(String newValue) {
    _setPropertyWithValidName("text-decoration", newValue);
  }

  String get textJustify => getPropertyValue("text-justify");

  set textJustify(String newValue) {
    _setPropertyWithValidName("text-justify", newValue);
  }

  String get textOverflow => getPropertyValue("text-overflow");

  set textOverflow(String newValue) {
    _setPropertyWithValidName("text-overflow", newValue);
  }

  String get textTransform => getPropertyValue("text-transform");

  set textTransform(String newValue) {
    _setPropertyWithValidName("text-transform", newValue);
  }

  String get top => getPropertyValue("top");

  set top(String newValue) {
    _setPropertyWithValidName("top", newValue);
  }

  String get touchAction => getPropertyValue("touch-action");

  set touchAction(String newValue) {
    _setPropertyWithValidName("touch-action", newValue);
  }

  String get transform => getPropertyValue("transform");

  set transform(String newValue) {
    _setPropertyWithValidName("transform", newValue);
  }

  String get transformOrigin => getPropertyValue("transform-origin");

  set transformOrigin(String newValue) {
    _setPropertyWithValidName("transform-origin", newValue);
  }

  String get verticalAlign => getPropertyValue("vertical-align");

  set verticalAlign(String newValue) {
    _setPropertyWithValidName("vertical-align", newValue);
  }

  String get whitespace => getPropertyValue("whitespace");

  set whitespace(String newValue) {
    _setPropertyWithValidName("whitespace", newValue);
  }

  String get width => getPropertyValue("width");

  set width(String newValue) {
    _setPropertyWithValidName("width", newValue);
  }

  String get wordSpacing => getPropertyValue("word-spacing");

  set wordSpacing(String newValue) {
    _setPropertyWithValidName("word-spacing", newValue);
  }

  String get wordWrap => getPropertyValue("word-wrap");

  set wordWrap(String newValue) {
    _setPropertyWithValidName("word-wrap", newValue);
  }

  String get zIndex => getPropertyValue("z-index");

  set zIndex(String newValue) {
    _setPropertyWithValidName("z-index", newValue);
  }

  String get zoom => getPropertyValue("zoom");

  set zoom(String newValue) {
    _setPropertyWithValidName("zoom", newValue);
  }

  String getPropertyValue(String name);

  String item(int index);

  void removeProperty(String name);

  void setProperty(String name, String value, [String priority]) {
    this._setPropertyWithValidName(name, value);
  }

  bool supportsProperty(String propertyName) => true;

  String toString();

  void _setPropertyWithValidName(String name, String value);
}

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

class _CssStyleDeclaration extends CssStyleDeclaration {
  /// Regular expression for values that will be printed without quotes.
  static final _noQuotesRegExp = RegExp(r"^[a-zA-Z0-9]+$");

  final LinkedHashMap<String, String> _map = LinkedHashMap<String, String>();
  String _source;
  bool _sourceIsLatest = false;

  _CssStyleDeclaration._() : super._();

  @override
  int get length => this._map.length;

  @override
  String getPropertyValue(String name) {
    final value = this._map[name];
    if (value==null) {
      return "";
    }
    return value;
  }

  @override
  String item(int index) {
    return _map.keys.skip(index).first;
  }

  @override
  void removeProperty(String name) {
    this._sourceIsLatest = false;
    _map.remove(name);
  }

  @override
  String toString() {
    if (_sourceIsLatest) {
      return _source;
    }
    final map = this._map;
    if (map.isEmpty) {
      return null;
    }
    final sb = StringBuffer();
    map.forEach((name, value) {
      sb.write(name);
      sb.write(': ');
      final quotes = !_noQuotesRegExp.hasMatch(value);
      if (quotes) {
        sb.write('"');
      }
      sb.write(value);
      if (quotes) {
        sb.write('"');
      }
      sb.write(";");
    });
    final source = sb.toString();
    this._source = source;
    this._sourceIsLatest = true;
    return source;
  }

  CssStyleDeclaration _clone() {
    final result = _CssStyleDeclaration._();
    result._source = this._source;
    result._sourceIsLatest = this._sourceIsLatest;
    final resultMap = result._map;
    this._map?.forEach((k, v) {
      resultMap[k] = v;
    });
    return result;
  }

  void _parse(String source) {
    this._source = source;
    this._sourceIsLatest = true;
    final map = this._map;
    map.clear();
    if (source == null) {
      return;
    }
    int offset = 0;
    while (offset < source.length) {
      final endOfName = source.indexOf(":", offset);
      if (endOfName < 0) {
        return;
      }
      final name = source.substring(offset, endOfName).trim();
      offset = endOfName + 1;
      String value;
      final endOfValue = source.indexOf(";", offset);
      if (endOfValue < 0) {
        value = source.substring(offset).trim();
        offset = source.length;
      } else {
        value = source.substring(offset, endOfValue).trim();
        offset = endOfValue + 1;
      }
      if (value.length > 2 && value.startsWith("\"") && value.endsWith('"')) {
        value = value.substring(1, value.length - 1);
      }
      map[name] = value;
    }
  }

  @override
  void _setPropertyWithValidName(String name, String value) {
    this._sourceIsLatest = false;
    this._map[name] = (value ?? "");
  }
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
