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

final _CONTENT = 'content';

final _HEIGHT = ['top', 'bottom'];
final _MARGIN = 'margin';
final _PADDING = 'padding';
final _WIDTH = ['right', 'left'];

/// A class for representing CSS dimensions.
///
/// In contrast to the more general purpose [Rectangle] class, this class's
/// values are mutable, so one can change the height of an element
/// programmatically.
///
/// _Important_ _note_: use of these methods will perform CSS calculations that
/// can trigger a browser reflow. Therefore, use of these properties _during_ an
/// animation frame is discouraged. See also:
/// [Browser Reflow](https://developers.google.com/speed/articles/reflow)
abstract class CssRect implements Rectangle<num> {
  final Element _element;

  CssRect(this._element);

  /// The y-coordinate of the bottom edge.
  @override
  num get bottom => top + height;

  @override
  Point<num> get bottomLeft => Point<num>(left, top + height);

  @override
  Point<num> get bottomRight => Point<num>(left + width, top + height);

  @override
  int get hashCode => _JenkinsSmiHash.hash4(
      left.hashCode, top.hashCode, right.hashCode, bottom.hashCode);

  /// The height of this rectangle.
  ///
  /// This is equivalent to the `height` function in jQuery and the calculated
  /// `height` CSS value, converted to a dimensionless num in pixels. Unlike
  /// [getBoundingClientRect], `height` will return the same numerical width if
  /// the element is hidden or not.
  @override
  num get height;

  /// Set the height to `newHeight`.
  ///
  /// newHeight can be either a [num] representing the height in pixels or a
  /// [Dimension] object. Values of newHeight that are less than zero are
  /// converted to effectively setting the height to 0. This is equivalent to the
  /// `height` function in jQuery and the calculated `height` CSS value,
  /// converted to a num in pixels.
  ///
  /// Note that only the content height can actually be set via this method.
  set height(dynamic newHeight) {
    throw UnsupportedError('Can only set height for content rect.');
  }

  @override
  num get left;

  // TODO(jacobr): these methods are duplicated from _RectangleBase in dart:math
  // Ideally we would provide a RectangleMixin class that provides this implementation.
  // In an ideal world we would exp
  /// The x-coordinate of the right edge.
  @override
  num get right => left + width;

  @override
  num get top;

  @override
  Point<num> get topLeft => Point<num>(left, top);

  @override
  Point<num> get topRight => Point<num>(left + width, top);

  /// The width of this rectangle.
  ///
  /// This is equivalent to the `width` function in jQuery and the calculated
  /// `width` CSS value, converted to a dimensionless num in pixels. Unlike
  /// [getBoundingClientRect], `width` will return the same numerical width if
  /// the element is hidden or not.
  @override
  num get width;

  /// Set the current computed width in pixels of this element.
  ///
  /// newWidth can be either a [num] representing the width in pixels or a
  /// [Dimension] object. This is equivalent to the `width` function in jQuery
  /// and the calculated
  /// `width` CSS value, converted to a dimensionless num in pixels.
  ///
  /// Note that only the content width can be set via this method.
  set width(dynamic newWidth) {
    throw UnsupportedError('Can only set width for content rect.');
  }

  @override
  bool operator ==(other) {
    return other is Rectangle &&
        left == other.left &&
        top == other.top &&
        right == other.right &&
        bottom == other.bottom;
  }

  /// Returns a new rectangle which completely contains `this` and [other].
  @override
  Rectangle<num> boundingBox(Rectangle<num> other) {
    var right = max(this.left + width, other.left + other.width);
    var bottom = max(this.top + height, other.top + other.height);

    var left = min(this.left, other.left);
    var top = min(this.top, other.top);

    return Rectangle<num>(left, top, right - left, bottom - top);
  }

  /// Tests whether [another] is inside or along the edges of `this`.
  @override
  bool containsPoint(Point<num> another) {
    return another.x >= left &&
        another.x <= left + width &&
        another.y >= top &&
        another.y <= top + height;
  }

  /// Tests whether `this` entirely contains [another].
  @override
  bool containsRectangle(Rectangle<num> another) {
    return left <= another.left &&
        left + width >= another.left + another.width &&
        top <= another.top &&
        top + height >= another.top + another.height;
  }

  /// Computes the intersection of `this` and [other].
  ///
  /// The intersection of two axis-aligned rectangles, if any, is always another
  /// axis-aligned rectangle.
  ///
  /// Returns the intersection of this and `other`, or `null` if they don't
  /// intersect.
  @override
  Rectangle<num>? intersection(Rectangle<num> other) {
    var x0 = max(left, other.left);
    var x1 = min(left + width, other.left + other.width);

    if (x0 <= x1) {
      var y0 = max(top, other.top);
      var y1 = min(top + height, other.top + other.height);

      if (y0 <= y1) {
        return Rectangle<num>(x0, y0, x1 - x0, y1 - y0);
      }
    }
    return null;
  }

  /// Returns true if `this` intersects [other].
  @override
  bool intersects(Rectangle<num> other) {
    return (left <= other.left + other.width &&
        other.left <= left + width &&
        top <= other.top + other.height &&
        other.top <= top + height);
  }

  @override
  String toString() {
    return 'Rectangle ($left, $top) $width x $height';
  }

  /// Return a value that is used to modify the initial height or width
  /// measurement of an element. Depending on the value (ideally an enum) passed
  /// to augmentingMeasurement, we may need to add or subtract margin, padding,
  /// or border values, depending on the measurement we're trying to obtain.
  num _addOrSubtractToBoxModel(
      List<String> dimensions, String augmentingMeasurement) {
    // getComputedStyle always returns pixel values (hence, computed), so we're
    // always dealing with pixels in this method.
    var styles = _element.getComputedStyle();

    num val = 0.0;

    for (var measurement in dimensions) {
      // The border-box and default box model both exclude margin in the regular
      // height/width calculation, so add it if we want it for this measurement.
      if (augmentingMeasurement == _MARGIN) {
        val += Dimension.css(
                styles.getPropertyValue('$augmentingMeasurement-$measurement'))
            .value;
      }

      // The border-box includes padding and border, so remove it if we want
      // just the content itself.
      if (augmentingMeasurement == _CONTENT) {
        val -= Dimension.css(styles.getPropertyValue('$_PADDING-$measurement'))
            .value;
      }

      // At this point, we don't wan't to augment with border or margin,
      // so remove border.
      if (augmentingMeasurement != _MARGIN) {
        val -=
            Dimension.css(styles.getPropertyValue('border-$measurement-width'))
                .value;
      }
    }
    return val;
  }
}

/// A rectangle representing the dimensions of the space occupied by the
/// element's content + padding + border in the
/// [box model](http://www.w3.org/TR/CSS2/box.html).
class _BorderCssRect extends CssRect {
  _BorderCssRect(element) : super(element);
  @override
  num get height => _element.offsetHeight;

  @override
  num get left => _element.getBoundingClientRect().left;

  @override
  num get top => _element.getBoundingClientRect().top;

  @override
  num get width => _element.offsetWidth;
}

/// A list of element content rectangles in the
/// [box model](http://www.w3.org/TR/CSS2/box.html).
class _ContentCssListRect extends _ContentCssRect {
  final List<Element> _elementList;

  _ContentCssListRect(List<Element> elementList)
      : _elementList = elementList,
        super(elementList.first);

  /// Set the height to `newHeight`.
  ///
  /// Values of newHeight that are less than zero are converted to effectively
  /// setting the height to 0. This is equivalent to the `height`
  /// function in jQuery and the calculated `height` CSS value, converted to a
  /// num in pixels.
  @override
  set height(Object? newHeight) {
    for (var e in _elementList) {
      e.contentEdge.height = newHeight;
    }
  }

  /// Set the current computed width in pixels of this element.
  ///
  /// This is equivalent to the `width` function in jQuery and the calculated
  /// `width` CSS value, converted to a dimensionless num in pixels.
  @override
  set width(Object? newWidth) {
    for (var e in _elementList) {
      e.contentEdge.width = newWidth;
    }
  }
}

/// A rectangle representing all the content of the element in the
/// [box model](http://www.w3.org/TR/CSS2/box.html).
class _ContentCssRect extends CssRect {
  _ContentCssRect(Element element) : super(element);

  @override
  num get height =>
      _element.offsetHeight + _addOrSubtractToBoxModel(_HEIGHT, _CONTENT);

  /// Set the height to `newHeight`.
  ///
  /// newHeight can be either a [num] representing the height in pixels or a
  /// [Dimension] object. Values of newHeight that are less than zero are
  /// converted to effectively setting the height to 0. This is equivalent to the
  /// `height` function in jQuery and the calculated `height` CSS value,
  /// converted to a num in pixels.
  @override
  set height(dynamic newHeight) {
    if (newHeight is Dimension) {
      var newHeightAsDimension = newHeight;
      if (newHeightAsDimension.value < 0) newHeight = Dimension.px(0);
      _element.style.height = newHeight.toString();
    } else if (newHeight is num) {
      if (newHeight < 0) newHeight = 0;
      _element.style.height = '${newHeight}px';
    } else {
      throw ArgumentError('newHeight is not a Dimension or num');
    }
  }

  @override
  num get left =>
      _element.getBoundingClientRect().left -
      _addOrSubtractToBoxModel(['left'], _CONTENT);

  @override
  num get top =>
      _element.getBoundingClientRect().top -
      _addOrSubtractToBoxModel(['top'], _CONTENT);

  @override
  num get width =>
      _element.offsetWidth + _addOrSubtractToBoxModel(_WIDTH, _CONTENT);

  /// Set the current computed width in pixels of this element.
  ///
  /// newWidth can be either a [num] representing the width in pixels or a
  /// [Dimension] object. This is equivalent to the `width` function in jQuery
  /// and the calculated
  /// `width` CSS value, converted to a dimensionless num in pixels.
  @override
  set width(dynamic newWidth) {
    if (newWidth is Dimension) {
      var newWidthAsDimension = newWidth;
      if (newWidthAsDimension.value < 0) newWidth = Dimension.px(0);
      _element.style.width = newWidth.toString();
    } else if (newWidth is num) {
      if (newWidth < 0) newWidth = 0;
      _element.style.width = '${newWidth}px';
    } else {
      throw ArgumentError('newWidth is not a Dimension or num');
    }
  }
}

/// This is the [Jenkins hash function][1] but using masking to keep
/// values in SMI range.
///
/// [1]: http://en.wikipedia.org/wiki/Jenkins_hash_function
///
/// Use:
/// Hash each value with the hash of the previous value, then get the final
/// hash by calling finish.
///
///     var hash = 0;
///     for (var value in values) {
///       hash = JenkinsSmiHash.combine(hash, value.hashCode);
///     }
///     hash = JenkinsSmiHash.finish(hash);
class _JenkinsSmiHash {
  // TODO(11617): This class should be optimized and standardized elsewhere.

  static int combine(int hash, int value) {
    hash = 0x1fffffff & (hash + value);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }

  static int hash4(a, b, c, d) =>
      finish(combine(combine(combine(combine(0, a), b), c), d));
}

/// A rectangle representing the dimensions of the space occupied by the
/// element's content + padding + border + margin in the
/// [box model](http://www.w3.org/TR/CSS2/box.html).
class _MarginCssRect extends CssRect {
  _MarginCssRect(element) : super(element);
  @override
  num get height =>
      _element.offsetHeight + _addOrSubtractToBoxModel(_HEIGHT, _MARGIN);

  @override
  num get left =>
      _element.getBoundingClientRect().left -
      _addOrSubtractToBoxModel(['left'], _MARGIN);

  @override
  num get top =>
      _element.getBoundingClientRect().top -
      _addOrSubtractToBoxModel(['top'], _MARGIN);

  @override
  num get width =>
      _element.offsetWidth + _addOrSubtractToBoxModel(_WIDTH, _MARGIN);
}

/// A rectangle representing the dimensions of the space occupied by the
/// element's content + padding in the
/// [box model](http://www.w3.org/TR/CSS2/box.html).
class _PaddingCssRect extends CssRect {
  _PaddingCssRect(element) : super(element);

  @override
  num get height =>
      _element.offsetHeight + _addOrSubtractToBoxModel(_HEIGHT, _PADDING);

  @override
  num get left =>
      _element.getBoundingClientRect().left -
      _addOrSubtractToBoxModel(['left'], _PADDING);

  @override
  num get top =>
      _element.getBoundingClientRect().top -
      _addOrSubtractToBoxModel(['top'], _PADDING);

  @override
  num get width =>
      _element.offsetWidth + _addOrSubtractToBoxModel(_WIDTH, _PADDING);
}
