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

/// The type used by the
/// [Window.localStorage] and [Window.sessionStorage] properties.
/// Storage is implemented as a Map&lt;String, String>.
///
/// To store and get values, use Dart's built-in map syntax:
///
///     window.localStorage['key1'] = 'val1';
///     window.localStorage['key2'] = 'val2';
///     window.localStorage['key3'] = 'val3';
///     assert(window.localStorage['key3'] == 'val3');
///
/// You can use [Map](http://api.dartlang.org/dart_core/Map.html) APIs
/// such as containsValue(), clear(), and length:
///
///     assert(window.localStorage.containsValue('does not exist') == false);
///     window.localStorage.clear();
///     assert(window.localStorage.length == 0);
///
/// For more examples of using this API, see
/// [localstorage_test.dart](http://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/tests/html/localstorage_test.dart).
/// For details on using the Map API, see the
/// [Maps](https://www.dartlang.org/guides/libraries/library-tour#maps)
/// section of the library tour.
class Storage extends DelegatingMap<String, String> {
  final Window _window;

  Storage._(this._window) : super(<String, String>{});

  // We need to override this to ensure we dispatch StorageEvent events.
  @override
  void operator []=(String key, String value) {
    final oldValue = this[key];
    super[key] = value;
    final event = StorageEvent(
      'StorageEvent',
      key: key,
      oldValue: oldValue,
      newValue: value,
      storageArea: this,
    );
    _window.dispatchEvent(event);
  }

  // We need to override this to ensure we dispatch StorageEvent events.
  @override
  void addAll(Map<String, String> other) {
    for (var entry in other.entries.toList()) {
      this[entry.key] = entry.value;
    }
  }

  // We need to override this to ensure we dispatch StorageEvent events.
  @override
  void clear() {
    for (var key in keys.toList(growable: false)) {
      remove(key);
    }
  }

  // We need to override this to ensure we dispatch StorageEvent events.
  @override
  String? remove(Object? key) {
    if (key is String) {
      if (containsKey(key)) {
        final oldValue = super.remove(key);
        final event = StorageEvent(
          'StorageEvent',
          key: key,
          oldValue: oldValue,
          newValue: null,
          storageArea: this,
        );
        _window.dispatchEvent(event);
        return oldValue;
      }
    }
    return null;
  }

  // We need to override this to ensure we dispatch StorageEvent events.
  @override
  void removeWhere(bool Function(String key, String value) test) {
    for (var entry in entries.toList()) {
      if (test(entry.key, entry.value)) {
        remove(entry.key);
      }
    }
  }

  // We need to override this to ensure we dispatch StorageEvent events.
  @override
  String update(String key, String Function(String value) update,
      {String Function()? ifAbsent}) {
    var value = this[key];
    if (value == null) {
      if (ifAbsent == null) {
        return '';
      }
      final newValue = ifAbsent();
      this[key] = newValue;
      return newValue;
    }
    final newValue = update(value);
    this[key] = newValue;
    return newValue;
  }

  // We need to override this to ensure we dispatch StorageEvent events.
  @override
  void updateAll(String Function(String key, String value) update) {
    for (var entry in entries.toList()) {
      this[entry.key] = update(entry.key, entry.value);
    }
  }
}

class StorageEvent extends Event {
  final String? key;
  final String? newValue;
  final String? oldValue;
  final Storage? storageArea;
  final String? url;

  StorageEvent(
    String type, {
    this.key,
    this.newValue,
    this.oldValue,
    this.storageArea,
    this.url,
    bool canBubble = false,
    bool cancelable = false,
  }) : super.internal(
          type,
          canBubble: canBubble,
          cancelable: cancelable,
        );
}
