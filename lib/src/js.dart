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

library dart.js;

import 'dart:collection' show ListMixin;

bool isBrowserObject(dynamic o) => false;

Object convertFromBrowserObject(dynamic o) => o;

final JsObject context = JsObject(null);

/// Proxies a JavaScript object to Dart.
///
/// The properties of the JavaScript object are accessible via the `[]` and
/// `[]=` operators. Methods are callable via [callMethod].
class JsObject {
  /// Constructs a new JavaScript object from [constructor] and returns a proxy
  /// to it.
  factory JsObject(JsFunction constructor, [List arguments]) {
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
      throw ArgumentError("object cannot be a num, string, bool, or null");
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
      throw ArgumentError("object must be a Map or Iterable");
    }
    throw UnimplementedError();
  }

  /// Returns the value associated with [property] from the proxied JavaScript
  /// object.
  ///
  /// The type of [property] must be either [String] or [num].
  dynamic operator [](property) {
    if (property is! String && property is! num) {
      throw ArgumentError("property is not a String or num");
    }
    throw UnimplementedError();
  }

  /// Sets the value associated with [property] on the proxied JavaScript
  /// object.
  ///
  /// The type of [property] must be either [String] or [num].
  operator []=(dynamic property, dynamic value) {
    if (property is! String && property is! num) {
      throw ArgumentError("property is not a String or num");
    }
    throw UnimplementedError();
  }

  int get hashCode => 0;

  /// Returns `true` if the JavaScript object contains the specified property
  /// either directly or though its prototype chain.
  ///
  /// This is the equivalent of the `in` operator in JavaScript.
  bool hasProperty(property) {
    if (property is! String && property is! num) {
      throw ArgumentError("property is not a String or num");
    }
    throw UnimplementedError();
  }

  /// Removes [property] from the JavaScript object.
  ///
  /// This is the equivalent of the `delete` operator in JavaScript.
  void deleteProperty(property) {
    if (property is! String && property is! num) {
      throw ArgumentError("property is not a String or num");
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
  String toString() {
    throw UnimplementedError();
  }

  /// Calls [method] on the JavaScript object with the arguments [args] and
  /// returns the result.
  ///
  /// The type of [method] must be either [String] or [num].
  dynamic callMethod(method, [List args]) {
    if (method is! String && method is! num) {
      throw ArgumentError("method is not a String or num");
    }
    throw UnimplementedError();
  }
}

/// Proxies a JavaScript Function object.
class JsFunction extends JsObject {
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

/// A [List] that proxies a JavaScript array.
class JsArray<E> extends JsObject with ListMixin<E> {
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

  E operator [](dynamic index) {
    throw UnimplementedError();
  }

  void operator []=(dynamic index, dynamic value) {
    throw UnimplementedError();
  }

  int get length {
    throw UnimplementedError();
  }

  set length(int length) {
    throw UnimplementedError();
  }

  void add(E value) {
    throw UnimplementedError();
  }

  void addAll(Iterable<E> iterable) {
    throw UnimplementedError();
  }

  void insert(int index, E element) {
    throw UnimplementedError();
  }

  E removeAt(int index) {
    throw UnimplementedError();
  }

  E removeLast() {
    throw UnimplementedError();
  }

  void removeRange(int start, int end) {
    throw UnimplementedError();
  }

  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    throw UnimplementedError();
  }

  void sort([int compare(E a, E b)]) {
    throw UnimplementedError();
  }
}

F allowInterop<F extends Function>(F f) {
  throw UnimplementedError();
}

Function allowInteropCaptureThis(Function f) {
  throw UnimplementedError();
}
