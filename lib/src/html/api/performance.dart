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

abstract class MemoryInfo {
  factory MemoryInfo._() {
    throw UnimplementedError();
  }

  int get jsHeapSizeLimit;

  int get totalJSHeapSize;

  int get usedJSHeapSize;
}

@SupportedBrowser(SupportedBrowser.CHROME)
@SupportedBrowser(SupportedBrowser.FIREFOX)
@SupportedBrowser(SupportedBrowser.IE)
@Native('Performance')
class Performance extends EventTarget {
  /// Checks if this type is supported on the current platform.
  static bool get supported => false;

  // To suppress missing implicit constructor warnings.
  factory Performance._() {
    throw UnimplementedError();
  }

  MemoryInfo? get memory {
    throw UnimplementedError();
  }

  num? get timeOrigin {
    throw UnimplementedError();
  }

  void clearMarks(String? markName) {
    throw UnimplementedError();
  }

  void clearMeasures(String? measureName) {
    throw UnimplementedError();
  }

  void clearResourceTimings() {
    throw UnimplementedError();
  }

  List<PerformanceEntry> getEntries() {
    throw UnimplementedError();
  }

  List<PerformanceEntry> getEntriesByName(String name, String? entryType) {
    throw UnimplementedError();
  }

  List<PerformanceEntry> getEntriesByType(String entryType) {
    throw UnimplementedError();
  }

  void mark(String markName) {
    throw UnimplementedError();
  }

  void measure(String measureName, String? startMark, String? endMark) {
    throw UnimplementedError();
  }

  double now() {
    throw UnimplementedError();
  }

  void setResourceTimingBufferSize(int maxSize) {
    throw UnimplementedError();
  }
}

@Native('PerformanceEntry')
class PerformanceEntry {
  // To suppress missing implicit constructor warnings.
  factory PerformanceEntry._() {
    throw UnimplementedError();
  }

  num get duration {
    throw UnimplementedError();
  }

  String get entryType {
    throw UnimplementedError();
  }

  String get name {
    throw UnimplementedError();
  }

  num get startTime {
    throw UnimplementedError();
  }
}
