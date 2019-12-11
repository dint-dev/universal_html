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

class Platform {
  /// Returns true if dart:typed_data types are supported on this
  /// browser.  If false, using these types will generate a runtime
  /// error.
  static final supportsTypedData = true;

  /// Returns true if SIMD types in dart:typed_data types are supported
  /// on this browser.  If false, using these types will generate a runtime
  /// error.
  static final supportsSimd = true;
}

/// Utils for device detection.
class _Device {
  static bool _isOpera;
  static bool _isIE;
  static bool _isFirefox;
  static bool _isWebKit;
  static String _cachedCssPrefix;
  static String _cachedPropertyPrefix;

  /// Gets the CSS property prefix for the current platform.
  static String get cssPrefix {
    var prefix = _cachedCssPrefix;
    if (prefix != null) return prefix;
    if (isFirefox) {
      prefix = '-moz-';
    } else if (isIE) {
      prefix = '-ms-';
    } else if (isOpera) {
      prefix = '-o-';
    } else {
      prefix = '-webkit-';
    }
    return _cachedCssPrefix = prefix;
  }

  /// Determines if the current device is running Firefox.
  static bool get isFirefox {
    return _isFirefox ??= userAgent.contains("Firefox", 0);
  }

  /// Determines if the current device is running Internet Explorer.
  static bool get isIE {
    return _isIE ??= !isOpera && userAgent.contains("Trident/", 0);
  }

  /// Determines if the current device is running Opera.
  static bool get isOpera {
    return _isOpera ??= userAgent.contains("Opera", 0);
  }

  /// Determines if the current device is running WebKit.
  static bool get isWebKit {
    return _isWebKit ??= !isOpera && userAgent.contains("WebKit", 0);
  }

  /// Prefix as used for JS property names.
  static String get propertyPrefix {
    var prefix = _cachedPropertyPrefix;
    if (prefix != null) return prefix;
    if (isFirefox) {
      prefix = 'moz';
    } else if (isIE) {
      prefix = 'ms';
    } else if (isOpera) {
      prefix = 'o';
    } else {
      prefix = 'webkit';
    }
    return _cachedPropertyPrefix = prefix;
  }

  /// Gets the browser's user agent. Using this function allows tests to inject
  /// the user agent.
  /// Returns the user agent.
  static String get userAgent => window.navigator.userAgent;

  /// Checks to see if the event class is supported by the current platform.
  static bool isEventTypeSupported(String eventType) {
    // Browsers throw for unsupported event names.
    try {
      var e = Event.eventType(eventType, '');
      return e is Event;
    } catch (_) {}
    return false;
  }
}
