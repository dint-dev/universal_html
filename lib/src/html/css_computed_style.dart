part of universal_html;

class _ComputedStyle extends CssStyleDeclaration {
  final Element _element;
  final String _pseudoElement;

  _CssStyleDeclaration _style;

  _ComputedStyle._(this._element, this._pseudoElement) : super._();

  void _findStyleSheets(Node node, List<StyleSheet> result) {
    for (var child in node.childNodes) {
      if (child is StyleElement) {
        final sheet = child.sheet;
        if (sheet != null) {
          result.add(sheet);
        }
      }
    }
    if (node.parent == null) {
      for (var styleSheet in (node.ownerDocument as HtmlDocument).styleSheets) {
        if (!result.contains(styleSheet)) {
          result.add(styleSheet);
        }
      }
      return;
    } else {
      _findStyleSheets(node.parent, result);
    }
  }

  _CssStyleDeclaration compute() {
    final cachedStyle = this._style;
    if (cachedStyle != null) {
      return cachedStyle;
    }

    final sheets = <StyleSheet>[];
    _findStyleSheets(_element, sheets);

    final prioritizedRules = <_PriotizedCssStyleRule>[];

    for (final sheet in sheets) {
      // For each stylesheet
      if (sheet is CssStyleSheet) {
        // For each CSS rule
        for (var rule in sheet.cssRules) {
          if (rule is CssStyleRule) {
            // Find highest priority selector of this rule
            int highestPriority = 0;

            // For each selector
            for (var parsedSelector in rule._parsedSelectors) {
              final selector = parsedSelector.selector;
              if (_matchesSelector(
                  _element,
                  selector,
                  selector.simpleSelectorSequences.length - 1,
                  _pseudoElement)) {
                // Selector matches.
                // Is the priority the highest so far?
                final priority = parsedSelector.priority;
                if (priority > highestPriority) {
                  highestPriority = priority;
                }
              }
            }
            if (highestPriority > 0) {
              prioritizedRules
                  .add(_PriotizedCssStyleRule(highestPriority, rule));
            }
          }
        }
      }
    }

    // Sort rules
    prioritizedRules
        .sort((left, right) => -left.priority.compareTo(right.priority));

    // Create style
    final result = _element._getOrCreateStyle()._clone();

    // Set style properties
    for (var prioritizedRule in prioritizedRules) {
      final style = prioritizedRule.rule.style;
      final length = style.length;
      for (var i = 0; i < length; i++) {
        final name = style.item(i);
        result.setProperty(name, style.getPropertyValue(name));
      }
    }
    this._style = result;
    return result;
  }

  @override
  int get length => compute().length;

  @override
  void setProperty(String name, String value, [String priority]) {
    throw UnsupportedError("Computed style can't be modified.");
  }

  @override
  String removeProperty(String name) {
    throw UnsupportedError("Computed style can't be modified.");
  }

  @override
  String item(int index) => compute().item(index);

  @override
  String getPropertyValue(String name) => compute().getPropertyValue(name);

  @override
  CssRule get parentRule {
    throw UnimplementedError();
  }

  @override
  String getPropertyPriority(String property) {
    throw UnimplementedError();
  }
}

class _PriotizedCssStyleRule {
  final int priority;
  final CssStyleRule rule;

  _PriotizedCssStyleRule(this.priority, this.rule);
}
