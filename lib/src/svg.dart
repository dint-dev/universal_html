/*
This file was derived from the Dart SDK.

The original files in the Dart SDK had the following license:

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

library universal_svg;

import 'html.dart';

// Declared because this is needed by 'html.dart'.
abstract class Matrix {
  Matrix flipX();

  Matrix flipY();

  Matrix inverse();

  Matrix multiply(Matrix secondMatrix);

  Matrix rotate(num angle);

  Matrix rotateFromVector(num x, num y);

  Matrix scale(num scaleFactor);

  Matrix scaleNonUniform(num scaleFactorX, num scaleFactorY);

  Matrix skewX(num angle);

  Matrix skewY(num angle);

  Matrix translate(num x, num y);
}

class SvgElement extends Element {
  factory SvgElement.svg(String svg,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    throw UnimplementedError();
  }

  factory SvgElement.tag(String tag) {
    return SvgElement.internal(null, tag);
  }

  /// IMPORTANT: Not part of 'dart:svg'.
  factory SvgElement.internal(Document document, String tag) {
    switch (tag) {
      case "script":
        return ScriptElement();
      default:
        return SvgElement._(document, tag);
    }
  }

  /// IMPORTANT: Not part of 'dart:svg'.
  SvgElement._(Document document, String tagName)
      // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
      : super.internal(document, tagName);

  // We need to reimplement this because superclass implementation depends
  // on implementing a private method.
  @override
  SvgElement internalCloneWithOwnerDocument(Document document, bool deep) {
    // Create a new instance of the same class
    final clone = SvgElement.tag(tagName);

    // Clone attributes
    this.attributes.forEach((name, value) {
      clone.setAttribute(name, value);
    });

    // Clone children
    if (deep != false) {
      for (var childNode in this.childNodes) {
        // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
        clone.append(childNode.internalCloneWithOwnerDocument(document, deep));
      }
    }

    return clone;
  }
}

// Declared because this is needed by 'html.dart'.
class ScriptElement extends SvgElement {
  ScriptElement() : super._(null, "script");
}
