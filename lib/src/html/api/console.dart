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

class Console {
  Console.internal();

  MemoryInfo? get memory => null;

  // Even though many of the following JS methods can take in multiple
  // arguments, we historically and currently limit the number of variable
  // arguments to 1. Depending on the need, these methods may be updated to
  // allow for more.

  // We rename assert to assertCondition here.
  void assertCondition([bool? condition, Object? arg]) {
    if (condition != true) {
      debug(arg);
    }
  }

  // clear no longer takes in an argument, but we keep this as optional to
  // maintain backwards compatibility.
  void clear([Object? arg]) {}

  // count takes in a String instead, but we keep this as an Object for
  // backwards compatibility.
  void count([Object? arg]) {}

  void countReset([String? arg]) {}

  void debug(Object? arg) {}

  void dir([Object? item, Object? options]) {}

  void dirxml(Object? arg) {}

  void error(Object? arg) {}

  void group(Object? arg) {}

  void groupCollapsed(Object? arg) {}

  void groupEnd() {}

  void info(Object? arg) {}

  void log(Object? arg) {}

  // The following is deprecated and should be removed once we drop support for
  // older Safari browsers.
  void markTimeline(Object? arg) {}

  // The following are non-standard methods.
  void profile([String? title]) {}

  void profileEnd([String? title]) {}

  void table([Object? tabularData, List<String>? properties]) {}

  void time([String? label]) {}

  void timeEnd([String? label]) {}

  void timeLog([String? label, Object? arg]) {}

  void timeStamp([Object? arg]) {}

  void trace(Object? arg) {}

  void warn(Object? arg) {}
}
