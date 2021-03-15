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
part of universal_html.internal;

/// Internally [Element] treats attributes as a linked list of these nodes.
class _Attribute {
  final bool _isNamespaced;
  final String _namespaceUri;
  final String _qualifiedName;
  final String _localName;
  String value;
  _Attribute? _next;

  _Attribute(
    this._isNamespaced,
    this._namespaceUri,
    this._qualifiedName,
    this._localName,
    this.value,
  );

  _Attribute cloneChain() {
    _Attribute? firstClone;
    _Attribute? previousClone;
    _Attribute? attribute = this;
    while (attribute != null) {
      final clone = _Attribute(
        attribute._isNamespaced,
        attribute._namespaceUri,
        attribute._qualifiedName,
        attribute._localName,
        attribute.value,
      );
      if (previousClone == null) {
        firstClone = clone;
      } else {
        previousClone._next = clone;
      }
      previousClone = clone;
      attribute = attribute._next;
    }
    return firstClone!;
  }
}

/// Exposes attributes (including up-to-date 'style') as a map.
class _Attributes extends MapBase<String, String> {
  final Element _element;
  final String _namespace;

  _Attributes(this._element, this._namespace);

  @override
  Iterable<String> get keys sync* {
    final namespace = _namespace;
    if (namespace == '') {
      final style = _element._style;
      if (style != null && style._map.isNotEmpty) {
        yield ('style');
      }
    }
    var attribute = _element._firstAttribute;
    while (attribute != null) {
      final next = attribute._next;
      if (attribute._namespaceUri == namespace) {
        yield (attribute._localName);
      }
      attribute = next;
    }
  }

  @override
  String? operator [](Object? key) {
    if (key is! String) {
      return null;
    }
    return _element.getAttributeNS(_namespace, key);
  }

  @override
  void operator []=(String key, String value) {
    _element.setAttributeNS(_namespace, key, value);
  }

  @override
  void clear() {
    final namespace = _namespace;
    if (namespace == '') {
      _element._style = null;
    }

    _Attribute? previous;
    var current = _element._firstAttribute;
    while (current != null) {
      final next = current._next;
      if (current._namespaceUri == namespace) {
        if (previous == null) {
          _element._firstAttribute = next;
        } else {
          previous._next = next;
        }
        current = next;
      } else {
        previous = current;
        current = next;
      }
    }
  }

  @override
  String? remove(Object? key) {
    if (key is String) {
      final oldValue = _element.getAttributeNS(_namespace, key);
      if (oldValue == null) {
        return null;
      }
      _element.removeAttributeNS(_namespace, key);
      return oldValue;
    }
    return null;
  }
}

/// Provides a Map abstraction on top of data-* attributes, similar to the
/// dataSet in the old DOM.
class _DataAttributeMap extends MapBase<String, String> {
  final Map<String, String> _attributes;

  _DataAttributeMap(this._attributes);

  // interface Map

  @override
  bool get isEmpty => length == 0;

  @override
  bool get isNotEmpty => !isEmpty;

  // TODO: Use lazy iterator when it is available on Map.
  @override
  Iterable<String> get keys {
    final keys = <String>[];
    _attributes.forEach((String key, String value) {
      if (_matches(key)) {
        keys.add(_strip(key));
      }
    });
    return keys;
  }

  @override
  int get length => keys.length;

  @override
  Iterable<String> get values {
    final values = <String>[];
    _attributes.forEach((String key, String value) {
      if (_matches(key)) {
        values.add(value);
      }
    });
    return values;
  }

  @override
  String? operator [](Object? key) =>
      key is! String ? null : _attributes[_attr(key)];

  @override
  void operator []=(String key, String value) {
    _attributes[_attr(key)] = value;
  }

  @override
  void addAll(Map<String, String> other) {
    other.forEach((k, v) {
      this[k] = v;
    });
  }

  @override
  Map<K, V> cast<K, V>() => Map.castFrom<String, String, K, V>(this);

  @override
  void clear() {
    // Needs to operate on a snapshot since we are mutating the collection.
    for (var key in keys) {
      remove(key);
    }
  }

  @override
  bool containsKey(Object? key) =>
      key is! String ? false : _attributes.containsKey(_attr(key));

  @override
  bool containsValue(Object? value) => values.any((v) => v == value);

  @override
  void forEach(void Function(String key, String value) f) {
    _attributes.forEach((String key, String value) {
      if (_matches(key)) {
        f(_strip(key), value);
      }
    });
  }

  // TODO: Use lazy iterator when it is available on Map.
  @override
  String putIfAbsent(String key, String Function() ifAbsent) =>
      _attributes.putIfAbsent(_attr(key), ifAbsent);

  @override
  String? remove(Object? key) {
    return key is! String ? null : _attributes.remove(_attr(key));
  }

  // Helpers.
  String _attr(String key) => 'data-${_toHyphenedName(key)}';

  bool _matches(String key) => key.startsWith('data-');

  String _strip(String key) => _toCamelCase(key.substring(5));

  /// Converts a string name with hyphens into an identifier, by removing hyphens
  /// and capitalizing the following letter. Optionally [startUppercase] to
  /// capitalize the first letter.
  String _toCamelCase(String hyphenedName, {bool startUppercase = false}) {
    var segments = hyphenedName.split('-');
    final start = startUppercase ? 0 : 1;
    for (var i = start; i < segments.length; i++) {
      var segment = segments[i];
      if (segment.isNotEmpty) {
        // Character between 'a'..'z' mapped to 'A'..'Z'
        segments[i] = '${segment[0].toUpperCase()}${segment.substring(1)}';
      }
    }
    return segments.join('');
  }

  /// Reverse of [toCamelCase].
  String _toHyphenedName(String word) {
    var sb = StringBuffer();
    for (var i = 0; i < word.length; i++) {
      var lower = word[i].toLowerCase();
      if (word[i] != lower && i > 0) sb.write('-');
      sb.write(lower);
    }
    return sb.toString();
  }
}
