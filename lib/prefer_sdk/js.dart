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
/// Exports _dart:js_. In VM and Flutter, exports our implementation.
///
/// # Introduction
///
/// Support for interoperating with JavaScript.
///
/// This library provides access to JavaScript objects from Dart, allowing
/// Dart code to get and set properties, and call methods of JavaScript objects
/// and invoke JavaScript functions. The library takes care of converting
/// between Dart and JavaScript objects where possible, or providing proxies if
/// conversion isn't possible.
///
/// This library does not yet make Dart objects usable from JavaScript, their
/// methods and proeprties are not accessible, though it does allow Dart
/// functions to be passed into and called from JavaScript.
///
/// [JsObject] is the core type and represents a proxy of a JavaScript object.
/// JsObject gives access to the underlying JavaScript objects properties and
/// methods. `JsObject`s can be acquired by calls to JavaScript, or they can be
/// created from proxies to JavaScript constructors.
///
/// The top-level getter [context] provides a [JsObject] that represents the
/// global object in JavaScript, usually `window`.
///
/// The following example shows an alert dialog via a JavaScript call to the
/// global function `alert()`:
///
///     import 'package:universal_html/js.dart';
///
///     main() => context.callMethod('alert', ['Hello from Dart!']);
///
/// This example shows how to create a [JsObject] from a JavaScript constructor
/// and access its properties:
///
///     import 'package:universal_html/js.dart';
///
///     main() {
///       var object = new JsObject(context['Object']);
///       object['greeting'] = 'Hello';
///       object['greet'] = (name) => "${object['greeting']} $name";
///       var message = object.callMethod('greet', ['JavaScript']);
///       context['console'].callMethod('log', [message]);
///     }
///
/// ## Proxying and automatic conversion
///
/// When setting properties on a JsObject or passing arguments to a Javascript
/// method or function, Dart objects are automatically converted or proxied to
/// JavaScript objects. When accessing JavaScript properties, or when a Dart
/// closure is invoked from JavaScript, the JavaScript objects are also
/// converted to Dart.
///
/// Functions and closures are proxied in such a way that they are callable. A
/// Dart closure assigned to a JavaScript property is proxied by a function in
/// JavaScript. A JavaScript function accessed from Dart is proxied by a
/// [JsFunction], which has a [apply] method to invoke it.
///
/// The following types are transferred directly and not proxied:
///
///   * Basic types: `null`, `bool`, `num`, `String`, `DateTime`
///   * `TypedData`, including its subclasses like `Int32List`, but _not_
///     `ByteBuffer`
///   * When compiling for the web, also: `Blob`, `Event`, `ImageData`,
///     `KeyRange`, `Node`, and `Window`.
///
/// ## Converting collections with JsObject.jsify()
///
/// To create a JavaScript collection from a Dart collection use the
/// [JsObject.jsify] constructor, which converts Dart [Map]s and [Iterable]s
/// into JavaScript Objects and Arrays.
///
/// The following expression creates a new JavaScript object with the properties
/// `a` and `b` defined:
///
///     var jsMap = new JsObject.jsify({'a': 1, 'b': 2});
///
/// This expression creates a JavaScript array:
///
///     var jsArray = new JsObject.jsify([1, 2, 3]);=
///

export 'dart:js' if (dart.library.io) '../js.dart';
