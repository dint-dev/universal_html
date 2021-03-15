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

@visibleForTesting
library universal_html.svg.internal;

import 'package:meta/meta.dart';

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

abstract class ScriptElement implements SvgElement {
  ScriptElement._();
}

// Declared because this is needed by 'html.dart'.
abstract class SvgElement extends Element {
  /// IMPORTANT: Not part of 'dart:svg'.
  factory SvgElement.internal(Document? document, String tag) {
    throw UnimplementedError();
  }

  factory SvgElement.svg(
    String svg, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    throw UnimplementedError();
  }

  factory SvgElement.tag(String tag) {
    return SvgElement.internal(null, tag);
  }

  // We need to reimplement this because superclass implementation depends
  // on implementing a private method.
  @override
  SvgElement internalCloneWithOwnerDocument(Document ownerDocument, bool deep) {
    // Create a new instance of the same class
    final clone = SvgElement.tag(tagName);

    // Clone attributes
    attributes.forEach((name, value) {
      clone.setAttribute(name, value);
    });

    // Clone children
    if (deep != false) {
      for (var childNode in childNodes) {
        clone.append(
          // ignore: invalid_use_of_visible_for_testing_member
          childNode.internalCloneWithOwnerDocument(ownerDocument, deep),
        );
      }
    }

    return clone;
  }
}
