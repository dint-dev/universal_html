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

/// A Set that stores the CSS class names for an element.
abstract class CssClassSet implements Set<String> {
  /// Returns [:true:] if classes cannot be added or removed from this
  /// [:CssClassSet:].
  bool get frozen;

  /// Add the class [value] to element.
  ///
  /// [add] and [addAll] are the Dart equivalent of jQuery's
  /// [addClass](http://api.jquery.com/addClass/).
  ///
  /// If this CssClassSet corresponds to one element. Returns true if [value] was
  /// added to the set, otherwise false.
  ///
  /// If this corresponds to many elements, `null` is always returned.
  ///
  /// [value] must be a valid 'token' representing a single class, i.e. a
  /// non-empty string containing no whitespace.  To add multiple classes use
  /// [addAll].
  bool add(String value);

  /// Add all classes specified in [iterable] to element.
  ///
  /// [add] and [addAll] are the Dart equivalent of jQuery's
  /// [addClass](http://api.jquery.com/addClass/).
  ///
  /// Each element of [iterable] must be a valid 'token' representing a single
  /// class, i.e. a non-empty string containing no whitespace.
  void addAll(Iterable<String> iterable);

  /// Determine if this element contains the class [value].
  ///
  /// This is the Dart equivalent of jQuery's
  /// [hasClass](http://api.jquery.com/hasClass/).
  ///
  /// [value] must be a valid 'token' representing a single class, i.e. a
  /// non-empty string containing no whitespace.
  bool contains(Object value);

  /// Remove the class [value] from element, and return true on successful
  /// removal.
  ///
  /// [remove] and [removeAll] are the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  ///
  /// [value] must be a valid 'token' representing a single class, i.e. a
  /// non-empty string containing no whitespace.  To remove multiple classes, use
  /// [removeAll].
  bool remove(Object value);

  /// Remove all classes specified in [iterable] from element.
  ///
  /// [remove] and [removeAll] are the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  ///
  /// Each element of [iterable] must be a valid 'token' representing a single
  /// class, i.e. a non-empty string containing no whitespace.
  void removeAll(Iterable<Object> iterable);

  /// Adds the class [value] to the element if it is not on it, removes it if it
  /// is.
  ///
  /// If [shouldAdd] is true, then we always add that [value] to the element. If
  /// [shouldAdd] is false then we always remove [value] from the element.
  ///
  /// If this corresponds to one element, returns `true` if [value] is present
  /// after the operation, and returns `false` if [value] is absent after the
  /// operation.
  ///
  /// If this corresponds to many elements, `null` is always returned.
  ///
  /// [value] must be a valid 'token' representing a single class, i.e. a
  /// non-empty string containing no whitespace.  To toggle multiple classes, use
  /// [toggleAll].
  bool toggle(String value, [bool shouldAdd]);

  /// Toggles all classes specified in [iterable] on element.
  ///
  /// Iterate through [iterable]'s items, and add it if it is not on it, or
  /// remove it if it is. This is the Dart equivalent of jQuery's
  /// [toggleClass](http://api.jquery.com/toggleClass/).
  /// If [shouldAdd] is true, then we always add all the classes in [iterable]
  /// element. If [shouldAdd] is false then we always remove all the classes in
  /// [iterable] from the element.
  ///
  /// Each element of [iterable] must be a valid 'token' representing a single
  /// class, i.e. a non-empty string containing no whitespace.
  void toggleAll(Iterable<String> iterable, [bool shouldAdd]);
}

abstract class CssClassSetImpl extends SetBase<String> implements CssClassSet {
  static final RegExp _validTokenRE = RegExp(r'^\S+$');

  String get first => readClasses().first;

  /// Returns [:true:] if classes cannot be added or removed from this
  /// [:CssClassSet:].
  bool get frozen => false;

  bool get isEmpty => readClasses().isEmpty;

  bool get isNotEmpty => readClasses().isNotEmpty;

  // interface Iterable - BEGIN
  Iterator<String> get iterator => readClasses().iterator;
  // interface Iterable - END

  // interface Collection - BEGIN
  String get last => readClasses().last;

  int get length => readClasses().length;

  String get single => readClasses().single;

  /// Add the class [value] to element.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [addClass](http://api.jquery.com/addClass/).
  bool add(String value) {
    _validateToken(value);
    // TODO - figure out if we need to do any validation here
    // or if the browser natively does enough.
    return modify((s) => s.add(value));
  }

  /// Add all classes specified in [iterable] to element.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [addClass](http://api.jquery.com/addClass/).
  void addAll(Iterable<String> iterable) {
    // TODO - see comment above about validation.
    modify((s) => s.addAll(iterable.map(_validateToken)));
  }

  bool any(bool f(String element)) => readClasses().any(f);

  void clear() {
    // TODO(sra): Do this without reading the classes.
    modify((s) => s.clear());
  }

  /// Determine if this element contains the class [value].
  ///
  /// This is the Dart equivalent of jQuery's
  /// [hasClass](http://api.jquery.com/hasClass/).
  bool contains(Object value) {
    if (value is! String) return false;
    _validateToken(value);
    return readClasses().contains(value);
  }

  bool containsAll(Iterable<Object> collection) =>
      readClasses().containsAll(collection);

  Set<String> difference(Set<Object> other) => readClasses().difference(other);

  String elementAt(int index) => readClasses().elementAt(index);

  bool every(bool f(String element)) => readClasses().every(f);

  // interface Collection - END

  // interface Set - BEGIN
  Iterable<T> expand<T>(Iterable<T> f(String element)) =>
      readClasses().expand<T>(f);

  String firstWhere(bool test(String value), {String orElse()}) =>
      readClasses().firstWhere(test, orElse: orElse);

  T fold<T>(T initialValue, T combine(T previousValue, String element)) {
    return readClasses().fold<T>(initialValue, combine);
  }

  void forEach(void f(String element)) {
    readClasses().forEach(f);
  }

  Set<String> intersection(Set<Object> other) =>
      readClasses().intersection(other);

  String join([String separator = ""]) => readClasses().join(separator);

  String lastWhere(bool test(String value), {String orElse()}) =>
      readClasses().lastWhere(test, orElse: orElse);

  /// Lookup from the Set interface. Not interesting for a String set.
  String lookup(Object value) => contains(value) ? value : null;

  Iterable<T> map<T>(T f(String e)) => readClasses().map<T>(f);

  /// Helper method used to modify the set of css classes on this element.
  ///
  ///   f - callback with:
  ///   s - a Set of all the css class name currently on this element.
  ///
  ///   After f returns, the modified set is written to the
  ///       className property of this element.
  modify(f(Set<String> s)) {
    Set<String> s = readClasses();
    var ret = f(s);
    writeClasses(s);
    return ret;
  }

  /// Read the class names from the Element class property,
  /// and put them into a set (duplicates are discarded).
  /// This is intended to be overridden by specific implementations.
  Set<String> readClasses();

  String reduce(String combine(String value, String element)) {
    return readClasses().reduce(combine);
  }

  /// Remove the class [value] from element, and return true on successful
  /// removal.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  bool remove(Object value) {
    _validateToken(value);
    if (value is! String) return false;
    Set<String> s = readClasses();
    bool result = s.remove(value);
    writeClasses(s);
    return result;
  }

  /// Remove all classes specified in [iterable] from element.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  void removeAll(Iterable<Object> iterable) {
    modify((s) => s.removeAll(iterable));
  }

  void removeWhere(bool test(String name)) {
    modify((s) => s.removeWhere(test));
  }

  void retainAll(Iterable<Object> iterable) {
    modify((s) => s.retainAll(iterable));
  }

  void retainWhere(bool test(String name)) {
    modify((s) => s.retainWhere(test));
  }

  String singleWhere(bool test(String value), {String orElse()}) =>
      readClasses().singleWhere(test, orElse: orElse);
  Iterable<String> skip(int n) => readClasses().skip(n);
  Iterable<String> skipWhile(bool test(String value)) =>
      readClasses().skipWhile(test);
  Iterable<String> take(int n) => readClasses().take(n);
  Iterable<String> takeWhile(bool test(String value)) =>
      readClasses().takeWhile(test);

  /// Adds the class [value] to the element if it is not on it, removes it if it
  /// is.
  ///
  /// If [shouldAdd] is true, then we always add that [value] to the element. If
  /// [shouldAdd] is false then we always remove [value] from the element.
  bool toggle(String value, [bool shouldAdd]) {
    _validateToken(value);
    Set<String> s = readClasses();
    bool result = false;
    if (shouldAdd == null) shouldAdd = !s.contains(value);
    if (shouldAdd) {
      s.add(value);
      result = true;
    } else {
      s.remove(value);
    }
    writeClasses(s);
    return result;
  }

  /// Toggles all classes specified in [iterable] on element.
  ///
  /// Iterate through [iterable]'s items, and add it if it is not on it, or
  /// remove it if it is. This is the Dart equivalent of jQuery's
  /// [toggleClass](http://api.jquery.com/toggleClass/).
  /// If [shouldAdd] is true, then we always add all the classes in [iterable]
  /// element. If [shouldAdd] is false then we always remove all the classes in
  /// [iterable] from the element.
  void toggleAll(Iterable<String> iterable, [bool shouldAdd]) {
    iterable.forEach((e) => toggle(e, shouldAdd));
  }

  List<String> toList({bool growable = true}) =>
      readClasses().toList(growable: growable);
  Set<String> toSet() => readClasses().toSet();
  String toString() {
    return readClasses().join(' ');
  }

  Set<String> union(Set<String> other) => readClasses().union(other);
  // interface Set - END

  Iterable<String> where(bool f(String element)) => readClasses().where(f);

  /// Join all the elements of a set into one string and write
  /// back to the element.
  /// This is intended to be overridden by specific implementations.
  void writeClasses(Set<String> s);

  String _validateToken(String value) {
    if (_validTokenRE.hasMatch(value)) return value;
    throw ArgumentError.value(value, 'value', 'Not a valid class token');
  }
}

class _ElementCssClassSet extends CssClassSetImpl {
  final Element _element;

  _ElementCssClassSet(this._element);

  bool get isEmpty => length == 0;

  bool get isNotEmpty => length != 0;

  int get length => throw UnimplementedError();
  bool add(String value) {
    throw UnimplementedError();
  }

  void addAll(Iterable<String> iterable) {}

  void clear() {
    _element.className = '';
  }

  bool contains(Object value) {
    throw UnimplementedError();
  }

  Set<String> readClasses() {
    var s = LinkedHashSet<String>();
    var classname = _element.className;

    for (String name in classname.split(' ')) {
      String trimmed = name.trim();
      if (trimmed.isNotEmpty) {
        s.add(trimmed);
      }
    }
    return s;
  }

  bool remove(Object value) {
    throw UnimplementedError();
  }

  void removeAll(Iterable<Object> iterable) {}

  void removeWhere(bool test(String name)) {}

  void retainAll(Iterable<Object> iterable) {}

  void retainWhere(bool test(String name)) {}

  bool toggle(String value, [bool shouldAdd]) {
    throw UnimplementedError();
  }

  void writeClasses(Set<String> s) {
    _element.className = s.join(' ');
  }
}

/// A set (union) of the CSS classes that are present in a set of elements.
/// Implemented separately from _ElementCssClassSet for performance.
class _MultiElementCssClassSet extends CssClassSetImpl {
  final Iterable<Element> _elementIterable;

  // TODO(sra): Perhaps we should store the DomTokenList instead.
  final List<CssClassSetImpl> _sets;

  factory _MultiElementCssClassSet(Iterable<Element> elements) {
    return _MultiElementCssClassSet._(elements,
        List<CssClassSetImpl>.from(elements.map((Element e) => e.classes)));
  }

  _MultiElementCssClassSet._(this._elementIterable, this._sets);

  /// Helper method used to modify the set of css classes on this element.
  ///
  ///   f - callback with:
  ///   s - a Set of all the css class name currently on this element.
  ///
  ///   After f returns, the modified set is written to the
  ///       className property of this element.
  modify(f(Set<String> s)) {
    _sets.forEach((CssClassSetImpl e) => e.modify(f));
  }

  Set<String> readClasses() {
    var s = LinkedHashSet<String>();
    _sets.forEach((CssClassSetImpl e) => s.addAll(e.readClasses()));
    return s;
  }

  /// Remove the class [value] from element, and return true on successful
  /// removal.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  bool remove(Object value) => _sets.fold(
      false, (bool changed, CssClassSetImpl e) => e.remove(value) || changed);

  /// Adds the class [value] to the element if it is not on it, removes it if it
  /// is.
  ///
  /// TODO(sra): It seems wrong to collect a 'changed' flag like this when the
  /// underlying toggle returns an 'is set' flag.
  bool toggle(String value, [bool shouldAdd]) => _sets.fold(
      false,
      (bool changed, CssClassSetImpl e) =>
          e.toggle(value, shouldAdd) || changed);

  void writeClasses(Set<String> s) {
    var classes = s.join(' ');
    for (Element e in _elementIterable) {
      e.className = classes;
    }
  }
}
