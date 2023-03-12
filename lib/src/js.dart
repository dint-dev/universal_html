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
library universal_html.js.internal;

import 'package:meta/meta.dart';

final JsObject context = JsObject(null);

F allowInterop<F extends Function>(F f) {
  throw UnimplementedError();
}

Function allowInteropCaptureThis(Function f) {
  throw UnimplementedError();
}

Object convertFromBrowserObject(dynamic o) => o;

bool isBrowserObject(dynamic o) => false;

/// A [List] that proxies a JavaScript array.
abstract class JsArray<E> implements JsObject, List<E> {
  /// Creates a new JavaScript array.
  factory JsArray() {
    throw UnimplementedError();
  }

  /// Creates a new JavaScript array and initializes it to the contents of
  /// [other].
  factory JsArray.from(Iterable<E> other) {
    throw UnimplementedError();
  }

  // Methods required by ListMixin

  @override
  int get length {
    throw UnimplementedError();
  }

  @override
  set length(int length) {
    throw UnimplementedError();
  }

  E operator [](dynamic index) {
    throw UnimplementedError();
  }

  @override
  void operator []=(dynamic index, dynamic value) {
    throw UnimplementedError();
  }

  @override
  void add(E value) {
    throw UnimplementedError();
  }

  @override
  void addAll(Iterable<E> iterable) {
    throw UnimplementedError();
  }

  @override
  void insert(int index, E element) {
    throw UnimplementedError();
  }

  @override
  E removeAt(int index) {
    throw UnimplementedError();
  }

  @override
  E removeLast() {
    throw UnimplementedError();
  }

  @override
  void removeRange(int start, int end) {
    throw UnimplementedError();
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    throw UnimplementedError();
  }

  @override
  void sort([int Function(E a, E b)? compare]) {
    throw UnimplementedError();
  }
}

/// Proxies a JavaScript Function object.
abstract class JsFunction extends JsObject {
  /// Returns a [JsFunction] that captures its 'this' binding and calls [f]
  /// with the value of this passed as the first argument.
  factory JsFunction.withThis(Function f) {
    throw UnimplementedError();
  }

  /// Invokes the JavaScript function with arguments [args]. If [thisArg] is
  /// supplied it is the value of `this` for the invocation.
  dynamic apply(List args, {thisArg}) {
    throw UnimplementedError();
  }
}

/// Proxies a JavaScript object to Dart.
///
/// The properties of the JavaScript object are accessible via the `[]` and
/// `[]=` operators. Methods are callable via [callMethod].
abstract class JsObject {
  /// Constructs a new JavaScript object from [constructor] and returns a proxy
  /// to it.
  factory JsObject(JsFunction? constructor, [List? arguments]) {
    throw UnimplementedError();
  }

  /// Constructs a [JsObject] that proxies a native Dart object; _for expert use
  /// only_.
  ///
  /// Use this constructor only if you wish to get access to JavaScript
  /// properties attached to a browser host object, such as a Node or Blob, that
  /// is normally automatically converted into a native Dart object.
  ///
  /// An exception will be thrown if [object] either is `null` or has the type
  /// `bool`, `num`, or `String`.
  factory JsObject.fromBrowserObject(object) {
    if (object is num || object is String || object is bool || object == null) {
      throw ArgumentError('object cannot be a num, string, bool, or null');
    }
    throw UnimplementedError();
  }

  /// Recursively converts a JSON-like collection of Dart objects to a
  /// collection of JavaScript objects and returns a [JsObject] proxy to it.
  ///
  /// [object] must be a [Map] or [Iterable], the contents of which are also
  /// converted. Maps and Iterables are copied to a new JavaScript object.
  /// Primitives and other transferrable values are directly converted to their
  /// JavaScript type, and all other objects are proxied.
  factory JsObject.jsify(object) {
    if ((object is! Map) && (object is! Iterable)) {
      throw ArgumentError('object must be a Map or Iterable');
    }
    throw UnimplementedError();
  }

  /// Returns the value associated with [property] from the proxied JavaScript
  /// object.
  ///
  /// The type of [property] must be either [String] or [num].
  Object? operator [](Object property) {
    if (property is! String && property is! num) {
      throw ArgumentError('property is not a String or num');
    }
    throw UnimplementedError();
  }

  /// Sets the value associated with [property] on the proxied JavaScript
  /// object.
  ///
  /// The type of [property] must be either [String] or [num].
  void operator []=(Object property, dynamic value) {
    if (property is! String && property is! num) {
      throw ArgumentError('property is not a String or num');
    }
    throw UnimplementedError();
  }

  /// Calls [method] on the JavaScript object with the arguments [args] and
  /// returns the result.
  ///
  /// The type of [method] must be either [String] or [num].
  dynamic callMethod(Object method, [List? args]) {
    if (method is! String && method is! num) {
      throw ArgumentError('method is not a String or num');
    }
    throw UnimplementedError();
  }

  /// Removes [property] from the JavaScript object.
  ///
  /// This is the equivalent of the `delete` operator in JavaScript.
  void deleteProperty(property) {
    if (property is! String && property is! num) {
      throw ArgumentError('property is not a String or num');
    }
    throw UnimplementedError();
  }

  /// Returns `true` if the JavaScript object contains the specified property
  /// either directly or though its prototype chain.
  ///
  /// This is the equivalent of the `in` operator in JavaScript.
  bool hasProperty(Object property) {
    if (property is! String && property is! num) {
      throw ArgumentError('property is not a String or num');
    }
    throw UnimplementedError();
  }

  /// Returns `true` if the JavaScript object has [type] in its prototype chain.
  ///
  /// This is the equivalent of the `instanceof` operator in JavaScript.
  bool instanceof(JsFunction type) {
    throw UnimplementedError();
  }

  /// Returns the result of the JavaScript objects `toString` method.
  @override
  String toString() {
    throw UnimplementedError();
  }
}
