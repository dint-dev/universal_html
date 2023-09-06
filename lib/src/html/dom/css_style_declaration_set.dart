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
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
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

class _CssStyleDeclarationSet extends CssStyleDeclarationBase {
  final Iterable<Element> _elementIterable;
  late Iterable<CssStyleDeclaration> _elementCssStyleDeclarationSetIterable;

  _CssStyleDeclarationSet(this._elementIterable) : super._() {
    _elementCssStyleDeclarationSetIterable =
        List.from(_elementIterable).map((e) => e.style);
  }

  /// Sets the value of "background"
  @override
  set background(String? value) {
    _setAll('background', value);
  }

  /// Sets the value of "background-attachment"
  @override
  set backgroundAttachment(String? value) {
    _setAll('backgroundAttachment', value);
  }

  /// Sets the value of "background-color"
  @override
  set backgroundColor(String? value) {
    _setAll('backgroundColor', value);
  }

  /// Sets the value of "background-image"
  @override
  set backgroundImage(String? value) {
    _setAll('backgroundImage', value);
  }

  /// Sets the value of "background-position"
  @override
  set backgroundPosition(String? value) {
    _setAll('backgroundPosition', value);
  }

  /// Sets the value of "background-repeat"
  @override
  set backgroundRepeat(String? value) {
    _setAll('backgroundRepeat', value);
  }

  /// Sets the value of "border"
  @override
  set border(String? value) {
    _setAll('border', value);
  }

  /// Sets the value of "border-bottom"
  @override
  set borderBottom(String? value) {
    _setAll('borderBottom', value);
  }

  /// Sets the value of "border-bottom-color"
  @override
  set borderBottomColor(String? value) {
    _setAll('borderBottomColor', value);
  }

  /// Sets the value of "border-bottom-style"
  @override
  set borderBottomStyle(String? value) {
    _setAll('borderBottomStyle', value);
  }

  /// Sets the value of "border-bottom-width"
  @override
  set borderBottomWidth(String? value) {
    _setAll('borderBottomWidth', value);
  }

  /// Sets the value of "border-collapse"
  @override
  set borderCollapse(String? value) {
    _setAll('borderCollapse', value);
  }

  /// Sets the value of "border-color"
  @override
  set borderColor(String? value) {
    _setAll('borderColor', value);
  }

  /// Sets the value of "border-left"
  @override
  set borderLeft(String? value) {
    _setAll('borderLeft', value);
  }

  /// Sets the value of "border-left-color"
  @override
  set borderLeftColor(String? value) {
    _setAll('borderLeftColor', value);
  }

  /// Sets the value of "border-left-style"
  @override
  set borderLeftStyle(String? value) {
    _setAll('borderLeftStyle', value);
  }

  /// Sets the value of "border-left-width"
  @override
  set borderLeftWidth(String? value) {
    _setAll('borderLeftWidth', value);
  }

  /// Sets the value of "border-right"
  @override
  set borderRight(String? value) {
    _setAll('borderRight', value);
  }

  /// Sets the value of "border-right-color"
  @override
  set borderRightColor(String? value) {
    _setAll('borderRightColor', value);
  }

  /// Sets the value of "border-right-style"
  @override
  set borderRightStyle(String? value) {
    _setAll('borderRightStyle', value);
  }

  /// Sets the value of "border-right-width"
  @override
  set borderRightWidth(String? value) {
    _setAll('borderRightWidth', value);
  }

  /// Sets the value of "border-spacing"
  @override
  set borderSpacing(String? value) {
    _setAll('borderSpacing', value);
  }

  /// Sets the value of "border-style"
  @override
  set borderStyle(String? value) {
    _setAll('borderStyle', value);
  }

  /// Sets the value of "border-top"
  @override
  set borderTop(String? value) {
    _setAll('borderTop', value);
  }

  /// Sets the value of "border-top-color"
  @override
  set borderTopColor(String? value) {
    _setAll('borderTopColor', value);
  }

  /// Sets the value of "border-top-style"
  @override
  set borderTopStyle(String? value) {
    _setAll('borderTopStyle', value);
  }

  /// Sets the value of "border-top-width"
  @override
  set borderTopWidth(String? value) {
    _setAll('borderTopWidth', value);
  }

  /// Sets the value of "border-width"
  @override
  set borderWidth(String? value) {
    _setAll('borderWidth', value);
  }

  /// Sets the value of "bottom"
  @override
  set bottom(String? value) {
    _setAll('bottom', value);
  }

  /// Sets the value of "caption-side"
  @override
  set captionSide(String? value) {
    _setAll('captionSide', value);
  }

  /// Sets the value of "clear"
  @override
  set clear(String? value) {
    _setAll('clear', value);
  }

  /// Sets the value of "clip"
  @override
  set clip(String? value) {
    _setAll('clip', value);
  }

  /// Sets the value of "color"
  @override
  set color(String? value) {
    _setAll('color', value);
  }

  /// Sets the value of "content"
  @override
  set content(String? value) {
    _setAll('content', value);
  }

  /// Sets the value of "cursor"
  @override
  set cursor(String? value) {
    _setAll('cursor', value);
  }

  /// Sets the value of "direction"
  @override
  set direction(String? value) {
    _setAll('direction', value);
  }

  /// Sets the value of "display"
  @override
  set display(String? value) {
    _setAll('display', value);
  }

  /// Sets the value of "empty-cells"
  @override
  set emptyCells(String? value) {
    _setAll('emptyCells', value);
  }

  /// Sets the value of "font"
  @override
  set font(String? value) {
    _setAll('font', value);
  }

  /// Sets the value of "font-family"
  @override
  set fontFamily(String? value) {
    _setAll('fontFamily', value);
  }

  /// Sets the value of "font-size"
  @override
  set fontSize(String? value) {
    _setAll('fontSize', value);
  }

  /// Sets the value of "font-style"
  @override
  set fontStyle(String? value) {
    _setAll('fontStyle', value);
  }

  /// Sets the value of "font-variant"
  @override
  set fontVariant(String? value) {
    _setAll('fontVariant', value);
  }

  /// Sets the value of "font-weight"
  @override
  set fontWeight(String? value) {
    _setAll('fontWeight', value);
  }

  /// Sets the value of "height"
  @override
  set height(String? value) {
    _setAll('height', value);
  }

  /// Sets the value of "left"
  @override
  set left(String? value) {
    _setAll('left', value);
  }

  /// Sets the value of "letter-spacing"
  @override
  set letterSpacing(String? value) {
    _setAll('letterSpacing', value);
  }

  /// Sets the value of "line-height"
  @override
  set lineHeight(String? value) {
    _setAll('lineHeight', value);
  }

  /// Sets the value of "list-style"
  @override
  set listStyle(String? value) {
    _setAll('listStyle', value);
  }

  /// Sets the value of "list-style-image"
  @override
  set listStyleImage(String? value) {
    _setAll('listStyleImage', value);
  }

  /// Sets the value of "list-style-position"
  @override
  set listStylePosition(String? value) {
    _setAll('listStylePosition', value);
  }

  /// Sets the value of "list-style-type"
  @override
  set listStyleType(String? value) {
    _setAll('listStyleType', value);
  }

  /// Sets the value of "margin"
  @override
  set margin(String? value) {
    _setAll('margin', value);
  }

  /// Sets the value of "margin-bottom"
  @override
  set marginBottom(String? value) {
    _setAll('marginBottom', value);
  }

  /// Sets the value of "margin-left"
  @override
  set marginLeft(String? value) {
    _setAll('marginLeft', value);
  }

  /// Sets the value of "margin-right"
  @override
  set marginRight(String? value) {
    _setAll('marginRight', value);
  }

  /// Sets the value of "margin-top"
  @override
  set marginTop(String? value) {
    _setAll('marginTop', value);
  }

  /// Sets the value of "max-height"
  @override
  set maxHeight(String? value) {
    _setAll('maxHeight', value);
  }

  /// Sets the value of "max-width"
  @override
  set maxWidth(String? value) {
    _setAll('maxWidth', value);
  }

  /// Sets the value of "min-height"
  @override
  set minHeight(String? value) {
    _setAll('minHeight', value);
  }

  /// Sets the value of "min-width"
  @override
  @override
  set minWidth(String? value) {
    _setAll('minWidth', value);
  }

  /// Sets the value of "outline"
  @override
  @override
  set outline(String? value) {
    _setAll('outline', value);
  }

  /// Sets the value of "outline-color"
  @override
  set outlineColor(String? value) {
    _setAll('outlineColor', value);
  }

  /// Sets the value of "outline-style"
  @override
  set outlineStyle(String? value) {
    _setAll('outlineStyle', value);
  }

  /// Sets the value of "outline-width"
  @override
  set outlineWidth(String? value) {
    _setAll('outlineWidth', value);
  }

  /// Sets the value of "overflow"
  @override
  set overflow(String? value) {
    _setAll('overflow', value);
  }

  /// Sets the value of "padding"
  @override
  set padding(String? value) {
    _setAll('padding', value);
  }

  /// Sets the value of "padding-bottom"
  @override
  set paddingBottom(String? value) {
    _setAll('paddingBottom', value);
  }

  /// Sets the value of "padding-left"
  @override
  set paddingLeft(String? value) {
    _setAll('paddingLeft', value);
  }

  /// Sets the value of "padding-right"
  @override
  set paddingRight(String? value) {
    _setAll('paddingRight', value);
  }

  /// Sets the value of "padding-top"
  @override
  set paddingTop(String? value) {
    _setAll('paddingTop', value);
  }

  /// Sets the value of "page-break-after"
  @override
  set pageBreakAfter(String? value) {
    _setAll('pageBreakAfter', value);
  }

  /// Sets the value of "page-break-before"
  @override
  set pageBreakBefore(String? value) {
    _setAll('pageBreakBefore', value);
  }

  /// Sets the value of "page-break-inside"
  @override
  set pageBreakInside(String? value) {
    _setAll('pageBreakInside', value);
  }

  /// Sets the value of "position"
  @override
  set position(String? value) {
    _setAll('position', value);
  }

  /// Sets the value of "quotes"
  @override
  set quotes(String? value) {
    _setAll('quotes', value);
  }

  /// Sets the value of "right"
  @override
  set right(String? value) {
    _setAll('right', value);
  }

  /// Sets the value of "table-layout"
  @override
  set tableLayout(String? value) {
    _setAll('tableLayout', value);
  }

  /// Sets the value of "text-align"
  @override
  set textAlign(String? value) {
    _setAll('textAlign', value);
  }

  /// Sets the value of "text-decoration"
  @override
  set textDecoration(String? value) {
    _setAll('textDecoration', value);
  }

  /// Sets the value of "text-indent"
  @override
  set textIndent(String? value) {
    _setAll('textIndent', value);
  }

  /// Sets the value of "text-transform"
  @override
  set textTransform(String? value) {
    _setAll('textTransform', value);
  }

  /// Sets the value of "top"
  @override
  set top(String? value) {
    _setAll('top', value);
  }

  /// Sets the value of "unicode-bidi"
  @override
  set unicodeBidi(String? value) {
    _setAll('unicodeBidi', value);
  }

  /// Sets the value of "vertical-align"
  @override
  set verticalAlign(String? value) {
    _setAll('verticalAlign', value);
  }

  /// Sets the value of "visibility"
  @override
  set visibility(String? value) {
    _setAll('visibility', value);
  }

  /// Sets the value of "white-space"
  @override
  @override
  set whiteSpace(String? value) {
    _setAll('whiteSpace', value);
  }

  /// Sets the value of "width"
  @override
  @override
  set width(String? value) {
    _setAll('width', value);
  }

  /// Sets the value of "word-spacing"
  @override
  set wordSpacing(String? value) {
    _setAll('wordSpacing', value);
  }

  /// Sets the value of "z-index"
  @override
  set zIndex(String? value) {
    _setAll('zIndex', value);
  }

  @override
  String getPropertyValue(String propertyName) =>
      _elementCssStyleDeclarationSetIterable.first
          .getPropertyValue(propertyName);

  @override
  void setProperty(String propertyName, String? value, [String? priority]) {
    for (var e in _elementCssStyleDeclarationSetIterable) {
      e.setProperty(propertyName, value, priority);
    }
  }

  void _setAll(String propertyName, String? value) {
    for (var element in _elementIterable) {
      element.style.setProperty(propertyName, value);
    }
  }

// Important note: CssStyleDeclarationSet does NOT implement every method
// available in CssStyleDeclaration. Some of the methods don't make so much
// sense in terms of having a resonable value to return when you're
// considering a list of Elements. You will need to manually add any of the
// items in the MEMBERS set if you want that functionality.
}
