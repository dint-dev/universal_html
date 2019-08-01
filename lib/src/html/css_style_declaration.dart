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

abstract class CssStyleDeclaration extends CssStyleDeclarationBase {
  /// Checks to see if CSS Transitions are supported.
  static bool get supportsTransitions {
    return false;
  }

  String cssFloat;

  factory CssStyleDeclaration() => CssStyleDeclaration.css('');

  factory CssStyleDeclaration.css(String css) {
    final style = DivElement().style;
    style.cssText = css;
    return style;
  }

  CssStyleDeclaration._() : super._();

  String get cssText {
    throw UnimplementedError();
  }

  set cssText(String value) {
    throw UnimplementedError();
  }

  int get length;

  CssRule get parentRule;

  String getPropertyPriority(String property);

  /// Returns the value of the property if the provided *CSS* property
  /// name is supported on this element and if the value is set. Otherwise
  /// returns an empty string.
  ///
  /// Please note the property name uses camelCase, not-hyphens.
  String getPropertyValue(String propertyName);

  String item(int index);

  String removeProperty(String property);

  void setProperty(String propertyName, String value, [String priority]);

  /// Returns true if the provided *CSS* property name is supported on this
  /// element.
  ///
  /// Please note the property name camelCase, not-hyphens. This
  /// method returns true if the property is accessible via an unprefixed _or_
  /// prefixed property.
  bool supportsProperty(String propertyName) {
    return true;
  }

  String toString();
}

class _CssStyleDeclaration extends CssStyleDeclaration {
  /// Regular expression for values that will be printed without quotes.
  static final _noQuotesRegExp = RegExp(r"^[a-zA-Z0-9]+$");

  final LinkedHashMap<String, String> _map = LinkedHashMap<String, String>();
  String _source;
  bool _sourceIsLatest = false;

  _CssStyleDeclaration._() : super._();

  @override
  int get length => this._map.length;

  @override
  CssRule get parentRule {
    throw UnimplementedError();
  }

  @override
  String getPropertyPriority(String property) {
    throw UnimplementedError();
  }

  @override
  String getPropertyValue(String name) {
    final value = this._map[name];
    if (value == null) {
      return "";
    }
    return value;
  }

  @override
  String item(int index) {
    return _map.keys.skip(index).first;
  }

  @override
  String removeProperty(String name) {
    this._sourceIsLatest = false;
    return _map.remove(name);
  }

  @override
  void setProperty(String propertyName, String value, [String priority]) {
    this._sourceIsLatest = false;
    this._map[propertyName] = (value ?? "");
  }

  @override
  String toString() {
    if (_sourceIsLatest) {
      return _source;
    }
    final map = this._map;
    if (map.isEmpty) {
      return null;
    }
    final sb = StringBuffer();
    map.forEach((name, value) {
      sb.write(name);
      sb.write(': ');
      final quotes = !_noQuotesRegExp.hasMatch(value);
      if (quotes) {
        sb.write('"');
      }
      sb.write(value);
      if (quotes) {
        sb.write('"');
      }
      sb.write(";");
    });
    final source = sb.toString();
    this._source = source;
    this._sourceIsLatest = true;
    return source;
  }

  CssStyleDeclaration _clone() {
    final result = _CssStyleDeclaration._();
    result._source = this._source;
    result._sourceIsLatest = this._sourceIsLatest;
    final resultMap = result._map;
    this._map?.forEach((k, v) {
      resultMap[k] = v;
    });
    return result;
  }

  void _parse(String source) {
    this._source = source;
    this._sourceIsLatest = true;
    final map = this._map;
    map.clear();
    if (source == null) {
      return;
    }
    int offset = 0;
    while (offset < source.length) {
      final endOfName = source.indexOf(":", offset);
      if (endOfName < 0) {
        return;
      }
      final name = source.substring(offset, endOfName).trim();
      offset = endOfName + 1;
      String value;
      final endOfValue = source.indexOf(";", offset);
      if (endOfValue < 0) {
        value = source.substring(offset).trim();
        offset = source.length;
      } else {
        value = source.substring(offset, endOfValue).trim();
        offset = endOfValue + 1;
      }
      if (value.length > 2 && value.startsWith("\"") && value.endsWith('"')) {
        value = value.substring(1, value.length - 1);
      }
      map[name] = value;
    }
  }
}
