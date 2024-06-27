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

@visibleForTesting
library universal_html.js_util.internal;

import 'package:meta/meta.dart';

dynamic callConstructor(Function constr, List arguments) {
  throw UnimplementedError();
}

dynamic callMethod(o, String method, List args) {
  throw UnimplementedError();
}

Object getProperty(o, name) {
  throw UnimplementedError();
}

bool hasProperty(o, name) {
  throw UnimplementedError();
}

bool instanceof(o, Function type) {
  throw UnimplementedError();
}

/// WARNING: performance of this method is much worse than other util
/// methods in this library. Only use this method as a last resort.
///
/// Recursively converts a JSON-like collection of Dart objects to a
/// collection of JavaScript objects and returns a [JsObject] proxy to it.
///
/// [object] must be a [Map] or [Iterable], the contents of which are also
/// converted. Maps and Iterables are copied to a new JavaScript object.
/// Primitives and other transferable values are directly converted to their
/// JavaScript type, and all other objects are proxied.
dynamic jsify(object) {
  throw UnimplementedError();
}

dynamic newObject() {
  throw UnimplementedError();
}

/// Converts a JavaScript Promise to a Dart [Future].
///
/// ```dart
/// @JS()
/// external Promise<num> get threePromise; // Resolves to 3
///
/// final Future<num> threeFuture = promiseToFuture(threePromise);
///
/// final three = await threeFuture; // == 3
/// ```
Future<T> promiseToFuture<T>(jsPromise) {
  throw UnimplementedError();
}

void setProperty(o, name, value) {
  throw UnimplementedError();
}

F allowInterop<F extends Function>(F f) {
  throw UnimplementedError();
}
