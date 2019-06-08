part of universal_html;

class _CssStyleDeclarationSet extends Object with CssStyleDeclarationBase {
  final Iterable<Element> _elementIterable;
  Iterable<CssStyleDeclaration> _elementCssStyleDeclarationSetIterable;

  _CssStyleDeclarationSet(this._elementIterable) {
    _elementCssStyleDeclarationSetIterable =
        List.from(_elementIterable).map((e) => e.style);
  }

  String getPropertyValue(String propertyName) =>
      _elementCssStyleDeclarationSetIterable.first
          .getPropertyValue(propertyName);

  void setProperty(String propertyName, String value, [String priority]) {
    _elementCssStyleDeclarationSetIterable
        .forEach((e) => e.setProperty(propertyName, value, priority));
  }

  void _setAll(String propertyName, String value) {
    value = value == null ? '' : value;
    for (Element element in _elementIterable) {
      element.style.setProperty(propertyName, value);
    }
  }

  /// Sets the value of "background"
  set background(String value) {
    _setAll('background', value);
  }

  /// Sets the value of "background-attachment"
  set backgroundAttachment(String value) {
    _setAll('backgroundAttachment', value);
  }

  /// Sets the value of "background-color"
  set backgroundColor(String value) {
    _setAll('backgroundColor', value);
  }

  /// Sets the value of "background-image"
  set backgroundImage(String value) {
    _setAll('backgroundImage', value);
  }

  /// Sets the value of "background-position"
  set backgroundPosition(String value) {
    _setAll('backgroundPosition', value);
  }

  /// Sets the value of "background-repeat"
  set backgroundRepeat(String value) {
    _setAll('backgroundRepeat', value);
  }

  /// Sets the value of "border"
  set border(String value) {
    _setAll('border', value);
  }

  /// Sets the value of "border-bottom"
  set borderBottom(String value) {
    _setAll('borderBottom', value);
  }

  /// Sets the value of "border-bottom-color"
  set borderBottomColor(String value) {
    _setAll('borderBottomColor', value);
  }

  /// Sets the value of "border-bottom-style"
  set borderBottomStyle(String value) {
    _setAll('borderBottomStyle', value);
  }

  /// Sets the value of "border-bottom-width"
  set borderBottomWidth(String value) {
    _setAll('borderBottomWidth', value);
  }

  /// Sets the value of "border-collapse"
  set borderCollapse(String value) {
    _setAll('borderCollapse', value);
  }

  /// Sets the value of "border-color"
  set borderColor(String value) {
    _setAll('borderColor', value);
  }

  /// Sets the value of "border-left"
  set borderLeft(String value) {
    _setAll('borderLeft', value);
  }

  /// Sets the value of "border-left-color"
  set borderLeftColor(String value) {
    _setAll('borderLeftColor', value);
  }

  /// Sets the value of "border-left-style"
  set borderLeftStyle(String value) {
    _setAll('borderLeftStyle', value);
  }

  /// Sets the value of "border-left-width"
  set borderLeftWidth(String value) {
    _setAll('borderLeftWidth', value);
  }

  /// Sets the value of "border-right"
  set borderRight(String value) {
    _setAll('borderRight', value);
  }

  /// Sets the value of "border-right-color"
  set borderRightColor(String value) {
    _setAll('borderRightColor', value);
  }

  /// Sets the value of "border-right-style"
  set borderRightStyle(String value) {
    _setAll('borderRightStyle', value);
  }

  /// Sets the value of "border-right-width"
  set borderRightWidth(String value) {
    _setAll('borderRightWidth', value);
  }

  /// Sets the value of "border-spacing"
  set borderSpacing(String value) {
    _setAll('borderSpacing', value);
  }

  /// Sets the value of "border-style"
  set borderStyle(String value) {
    _setAll('borderStyle', value);
  }

  /// Sets the value of "border-top"
  set borderTop(String value) {
    _setAll('borderTop', value);
  }

  /// Sets the value of "border-top-color"
  set borderTopColor(String value) {
    _setAll('borderTopColor', value);
  }

  /// Sets the value of "border-top-style"
  set borderTopStyle(String value) {
    _setAll('borderTopStyle', value);
  }

  /// Sets the value of "border-top-width"
  set borderTopWidth(String value) {
    _setAll('borderTopWidth', value);
  }

  /// Sets the value of "border-width"
  set borderWidth(String value) {
    _setAll('borderWidth', value);
  }

  /// Sets the value of "bottom"
  set bottom(String value) {
    _setAll('bottom', value);
  }

  /// Sets the value of "caption-side"
  set captionSide(String value) {
    _setAll('captionSide', value);
  }

  /// Sets the value of "clear"
  set clear(String value) {
    _setAll('clear', value);
  }

  /// Sets the value of "clip"
  set clip(String value) {
    _setAll('clip', value);
  }

  /// Sets the value of "color"
  set color(String value) {
    _setAll('color', value);
  }

  /// Sets the value of "content"
  set content(String value) {
    _setAll('content', value);
  }

  /// Sets the value of "cursor"
  set cursor(String value) {
    _setAll('cursor', value);
  }

  /// Sets the value of "direction"
  set direction(String value) {
    _setAll('direction', value);
  }

  /// Sets the value of "display"
  set display(String value) {
    _setAll('display', value);
  }

  /// Sets the value of "empty-cells"
  set emptyCells(String value) {
    _setAll('emptyCells', value);
  }

  /// Sets the value of "font"
  set font(String value) {
    _setAll('font', value);
  }

  /// Sets the value of "font-family"
  set fontFamily(String value) {
    _setAll('fontFamily', value);
  }

  /// Sets the value of "font-size"
  set fontSize(String value) {
    _setAll('fontSize', value);
  }

  /// Sets the value of "font-style"
  set fontStyle(String value) {
    _setAll('fontStyle', value);
  }

  /// Sets the value of "font-variant"
  set fontVariant(String value) {
    _setAll('fontVariant', value);
  }

  /// Sets the value of "font-weight"
  set fontWeight(String value) {
    _setAll('fontWeight', value);
  }

  /// Sets the value of "height"
  set height(String value) {
    _setAll('height', value);
  }

  /// Sets the value of "left"
  set left(String value) {
    _setAll('left', value);
  }

  /// Sets the value of "letter-spacing"
  set letterSpacing(String value) {
    _setAll('letterSpacing', value);
  }

  /// Sets the value of "line-height"
  set lineHeight(String value) {
    _setAll('lineHeight', value);
  }

  /// Sets the value of "list-style"
  set listStyle(String value) {
    _setAll('listStyle', value);
  }

  /// Sets the value of "list-style-image"
  set listStyleImage(String value) {
    _setAll('listStyleImage', value);
  }

  /// Sets the value of "list-style-position"
  set listStylePosition(String value) {
    _setAll('listStylePosition', value);
  }

  /// Sets the value of "list-style-type"
  set listStyleType(String value) {
    _setAll('listStyleType', value);
  }

  /// Sets the value of "margin"
  set margin(String value) {
    _setAll('margin', value);
  }

  /// Sets the value of "margin-bottom"
  set marginBottom(String value) {
    _setAll('marginBottom', value);
  }

  /// Sets the value of "margin-left"
  set marginLeft(String value) {
    _setAll('marginLeft', value);
  }

  /// Sets the value of "margin-right"
  set marginRight(String value) {
    _setAll('marginRight', value);
  }

  /// Sets the value of "margin-top"
  set marginTop(String value) {
    _setAll('marginTop', value);
  }

  /// Sets the value of "max-height"
  set maxHeight(String value) {
    _setAll('maxHeight', value);
  }

  /// Sets the value of "max-width"
  set maxWidth(String value) {
    _setAll('maxWidth', value);
  }

  /// Sets the value of "min-height"
  set minHeight(String value) {
    _setAll('minHeight', value);
  }

  /// Sets the value of "min-width"
  set minWidth(String value) {
    _setAll('minWidth', value);
  }

  /// Sets the value of "outline"
  set outline(String value) {
    _setAll('outline', value);
  }

  /// Sets the value of "outline-color"
  set outlineColor(String value) {
    _setAll('outlineColor', value);
  }

  /// Sets the value of "outline-style"
  set outlineStyle(String value) {
    _setAll('outlineStyle', value);
  }

  /// Sets the value of "outline-width"
  set outlineWidth(String value) {
    _setAll('outlineWidth', value);
  }

  /// Sets the value of "overflow"
  set overflow(String value) {
    _setAll('overflow', value);
  }

  /// Sets the value of "padding"
  set padding(String value) {
    _setAll('padding', value);
  }

  /// Sets the value of "padding-bottom"
  set paddingBottom(String value) {
    _setAll('paddingBottom', value);
  }

  /// Sets the value of "padding-left"
  set paddingLeft(String value) {
    _setAll('paddingLeft', value);
  }

  /// Sets the value of "padding-right"
  set paddingRight(String value) {
    _setAll('paddingRight', value);
  }

  /// Sets the value of "padding-top"
  set paddingTop(String value) {
    _setAll('paddingTop', value);
  }

  /// Sets the value of "page-break-after"
  set pageBreakAfter(String value) {
    _setAll('pageBreakAfter', value);
  }

  /// Sets the value of "page-break-before"
  set pageBreakBefore(String value) {
    _setAll('pageBreakBefore', value);
  }

  /// Sets the value of "page-break-inside"
  set pageBreakInside(String value) {
    _setAll('pageBreakInside', value);
  }

  /// Sets the value of "position"
  set position(String value) {
    _setAll('position', value);
  }

  /// Sets the value of "quotes"
  set quotes(String value) {
    _setAll('quotes', value);
  }

  /// Sets the value of "right"
  set right(String value) {
    _setAll('right', value);
  }

  /// Sets the value of "table-layout"
  set tableLayout(String value) {
    _setAll('tableLayout', value);
  }

  /// Sets the value of "text-align"
  set textAlign(String value) {
    _setAll('textAlign', value);
  }

  /// Sets the value of "text-decoration"
  set textDecoration(String value) {
    _setAll('textDecoration', value);
  }

  /// Sets the value of "text-indent"
  set textIndent(String value) {
    _setAll('textIndent', value);
  }

  /// Sets the value of "text-transform"
  set textTransform(String value) {
    _setAll('textTransform', value);
  }

  /// Sets the value of "top"
  set top(String value) {
    _setAll('top', value);
  }

  /// Sets the value of "unicode-bidi"
  set unicodeBidi(String value) {
    _setAll('unicodeBidi', value);
  }

  /// Sets the value of "vertical-align"
  set verticalAlign(String value) {
    _setAll('verticalAlign', value);
  }

  /// Sets the value of "visibility"
  set visibility(String value) {
    _setAll('visibility', value);
  }

  /// Sets the value of "white-space"
  set whiteSpace(String value) {
    _setAll('whiteSpace', value);
  }

  /// Sets the value of "width"
  set width(String value) {
    _setAll('width', value);
  }

  /// Sets the value of "word-spacing"
  set wordSpacing(String value) {
    _setAll('wordSpacing', value);
  }

  /// Sets the value of "z-index"
  set zIndex(String value) {
    _setAll('zIndex', value);
  }

// Important note: CssStyleDeclarationSet does NOT implement every method
// available in CssStyleDeclaration. Some of the methods don't make so much
// sense in terms of having a resonable value to return when you're
// considering a list of Elements. You will need to manually add any of the
// items in the MEMBERS set if you want that functionality.
}
