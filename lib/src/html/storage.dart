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

part of universal_html;

class Storage {
  /// IMPORTANT: Not part of 'dart:html' API.
  Storage.internal();

  final Map<String, String> _map = <String, String>{};

  void addAll(Map<String, String> other) {
    _map.addAll(other);
  }

  String remove(Object key) {
    return _map.remove(key);
  }

  String putIfAbsent(String key, String ifAbsent()) {
    return _map.putIfAbsent(key, ifAbsent);
  }

  void forEach(void f(String key, String value)) {
    _map.forEach(f);
  }

  bool containsValue(Object value) {
    return _map.containsValue(value);
  }

  bool containsKey(Object key) {
    return _map.containsKey(key);
  }

  void clear() {
    _map.clear();
  }
}

class StorageEvent extends Event {
  final String key;
  final String newValue;
  final String oldValue;
  final Storage storageArea;
  final String url;

  StorageEvent(String type,
      {this.key, this.newValue, this.oldValue, this.storageArea, this.url})
      : super.internalConstructor(type);
}
