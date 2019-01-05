part of universal_html;

class _ComputedStyle extends CssStyleDeclaration {
  final Element _element;
  final String _pseudoElement;

  _CssStyleDeclaration _cachedStyle;

  _ComputedStyle._(this._element, this._pseudoElement) : super._();

  _CssStyleDeclaration compute() {
    final cachedStyle = this._cachedStyle;
    if (cachedStyle != null) {
      return cachedStyle;
    }

    List<_PriotizedCssStyleRule> rules;
    for (final stylesheet in _element.ownerDocument.styleSheets) {
      // For each stylesheet
      if (stylesheet is CssStyleSheet) {
        // For each CSS rule
        for (var rule in stylesheet.cssRules) {
          if (rule is CssStyleRule) {
            // If matches selector
            int bestPriority = 0;
            for (var parsedSelector in rule._parsedSelectors) {
              final selector = parsedSelector.selector;
              if (_matchesSelector(
                  _element,
                  selector,
                  selector.simpleSelectorSequences.length - 1,
                  _pseudoElement)) {
                final priority = parsedSelector.priority;
                if (priority > bestPriority) {
                  bestPriority = priority;
                }
              }
            }
            if (bestPriority > 0) {
              if (rules == null) {
                rules = <_PriotizedCssStyleRule>[];
              }
              rules.add(new _PriotizedCssStyleRule(bestPriority, rule));
            }
          }
        }
      }
    }
    final style = _element._getOrCreateStyle()._clone();
    rules.sort((a, b) => -a.priority.compareTo(b.priority));
    for (var rule in rules) {
      rule.rule._style._map?.forEach((name, value) {
        if (style.getPropertyValue(name) == null) {
          style.setProperty(name, value);
        }
      });
    }
    this._cachedStyle = style;
    return style;
  }

  @override
  int get length => compute().length;

  @override
  void _setPropertyWithValidName(String name, String value) {
    throw new UnsupportedError("Computed style can't be modified.");
  }

  @override
  void removeProperty(String name) {
    throw new UnsupportedError("Computed style can't be modified.");
  }

  @override
  String item(int index) => compute().item(index);

  @override
  String getPropertyValue(String name) => compute().getPropertyValue(name);
}

class _PriotizedCssStyleRule {
  final int priority;
  final CssStyleRule rule;
  _PriotizedCssStyleRule(this.priority, this.rule);
}
