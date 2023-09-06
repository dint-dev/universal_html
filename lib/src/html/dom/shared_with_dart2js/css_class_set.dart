/*
Source code in this file was adopted from 'dart:html' in Dart SDK. See:
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
  @override
  bool add(String value);

  /// Add all classes specified in [iterable] to element.
  ///
  /// [add] and [addAll] are the Dart equivalent of jQuery's
  /// [addClass](http://api.jquery.com/addClass/).
  ///
  /// Each element of [iterable] must be a valid 'token' representing a single
  /// class, i.e. a non-empty string containing no whitespace.
  @override
  void addAll(Iterable<String> iterable);

  /// Determine if this element contains the class [value].
  ///
  /// This is the Dart equivalent of jQuery's
  /// [hasClass](http://api.jquery.com/hasClass/).
  ///
  /// [value] must be a valid 'token' representing a single class, i.e. a
  /// non-empty string containing no whitespace.
  @override
  bool contains(Object? value);

  /// Remove the class [value] from element, and return true on successful
  /// removal.
  ///
  /// [remove] and [removeAll] are the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  ///
  /// [value] must be a valid 'token' representing a single class, i.e. a
  /// non-empty string containing no whitespace.  To remove multiple classes, use
  /// [removeAll].
  @override
  bool remove(Object? value);

  /// Remove all classes specified in [iterable] from element.
  ///
  /// [remove] and [removeAll] are the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  ///
  /// Each element of [iterable] must be a valid 'token' representing a single
  /// class, i.e. a non-empty string containing no whitespace.
  @override
  void removeAll(Iterable<Object?> iterable);

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

abstract class _CssClassSetImpl extends SetBase<String> implements CssClassSet {
  static final RegExp _validTokenRE = RegExp(r'^\S+$');

  @override
  String get first => readClasses().first;

  /// Returns [:true:] if classes cannot be added or removed from this
  /// [:CssClassSet:].
  @override
  bool get frozen => false;

  @override
  bool get isEmpty => readClasses().isEmpty;

  @override
  bool get isNotEmpty => readClasses().isNotEmpty;

  @override
  Iterator<String> get iterator => readClasses().iterator;

  @override
  String get last => readClasses().last;

  @override
  int get length => readClasses().length;

  @override
  String get single => readClasses().single;

  /// Add the class [value] to element.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [addClass](http://api.jquery.com/addClass/).
  @override
  bool add(String value) {
    _validateToken(value);
    // TODO - figure out if we need to do any validation here
    // or if the browser natively does enough.
    return modify<bool>((s) => s.add(value)) ?? false;
  }

  /// Add all classes specified in [iterable] to element.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [addClass](http://api.jquery.com/addClass/).
  @override
  void addAll(Iterable<String> iterable) {
    // TODO - see comment above about validation.
    modify((s) => s.addAll(iterable.map(_validateToken)));
  }

  @override
  bool any(bool Function(String element) f) => readClasses().any(f);

  @override
  void clear() {
    // TODO(sra): Do this without reading the classes.
    modify((s) => s.clear());
  }

  /// Determine if this element contains the class [value].
  ///
  /// This is the Dart equivalent of jQuery's
  /// [hasClass](http://api.jquery.com/hasClass/).
  @override
  bool contains(Object? value) {
    if (value is! String) return false;
    _validateToken(value);
    return readClasses().contains(value);
  }

  @override
  bool containsAll(Iterable<Object?> collection) =>
      readClasses().containsAll(collection);

  @override
  Set<String> difference(Set<Object?> other) => readClasses().difference(other);

  @override
  String elementAt(int index) => readClasses().elementAt(index);

  @override
  bool every(bool Function(String element) f) => readClasses().every(f);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(String element) f) =>
      readClasses().expand<T>(f);

  @override
  String firstWhere(bool Function(String value) test,
          {String Function()? orElse}) =>
      readClasses().firstWhere(test, orElse: orElse);

  @override
  T fold<T>(
      T initialValue, T Function(T previousValue, String element) combine) {
    return readClasses().fold<T>(initialValue, combine);
  }

  @override
  void forEach(void Function(String element) f) {
    readClasses().forEach(f);
  }

  @override
  Set<String> intersection(Set<Object?> other) =>
      readClasses().intersection(other);

  @override
  String join([String separator = '']) => readClasses().join(separator);

  @override
  String lastWhere(bool Function(String value) test,
          {String Function()? orElse}) =>
      readClasses().lastWhere(test, orElse: orElse);

  /// Lookup from the Set interface. Not interesting for a String set.
  @override
  String? lookup(Object? value) =>
      value is! String ? null : (contains(value) ? value : null);

  @override
  Iterable<T> map<T>(T Function(String e) f) => readClasses().map<T>(f);

  /// Helper method used to modify the set of css classes on this element.
  ///
  ///   f - callback with:
  ///   s - a Set of all the css class name currently on this element.
  ///
  ///   After f returns, the modified set is written to the
  ///       className property of this element.
  R? modify<R>(R Function(Set<String> s) f) {
    final s = readClasses();
    var ret = f(s);
    writeClasses(s);
    return ret;
  }

  /// Read the class names from the Element class property,
  /// and put them into a set (duplicates are discarded).
  /// This is intended to be overridden by specific implementations.
  Set<String> readClasses();

  @override
  String reduce(String Function(String value, String element) combine) {
    return readClasses().reduce(combine);
  }

  /// Remove the class [value] from element, and return true on successful
  /// removal.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  @override
  bool remove(Object? value) {
    if (value is! String) {
      return false;
    }
    _validateToken(value);
    final s = readClasses();
    final result = s.remove(value);
    writeClasses(s);
    return result;
  }

  /// Remove all classes specified in [iterable] from element.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  @override
  void removeAll(Iterable<Object?> iterable) {
    modify((s) => s.removeAll(iterable));
  }

  @override
  void removeWhere(bool Function(String name) test) {
    modify((s) => s.removeWhere(test));
  }

  @override
  void retainAll(Iterable<Object?> iterable) {
    modify((s) => s.retainAll(iterable));
  }

  @override
  void retainWhere(bool Function(String name) test) {
    modify((s) => s.retainWhere(test));
  }

  @override
  String singleWhere(bool Function(String value) test,
          {String Function()? orElse}) =>
      readClasses().singleWhere(test, orElse: orElse);

  @override
  Iterable<String> skip(int n) => readClasses().skip(n);

  @override
  Iterable<String> skipWhile(bool Function(String value) test) =>
      readClasses().skipWhile(test);

  @override
  Iterable<String> take(int n) => readClasses().take(n);

  @override
  Iterable<String> takeWhile(bool Function(String value) test) =>
      readClasses().takeWhile(test);

  /// Adds the class [value] to the element if it is not on it, removes it if it
  /// is.
  ///
  /// If [shouldAdd] is true, then we always add that [value] to the element. If
  /// [shouldAdd] is false then we always remove [value] from the element.
  @override
  bool toggle(String value, [bool? shouldAdd]) {
    _validateToken(value);
    final s = readClasses();
    var result = false;
    shouldAdd ??= !s.contains(value);
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
  @override
  void toggleAll(Iterable<String> iterable, [bool? shouldAdd]) {
    for (var e in iterable) {
      toggle(e, shouldAdd);
    }
  }

  @override
  List<String> toList({bool growable = true}) =>
      readClasses().toList(growable: growable);

  @override
  Set<String> toSet() => readClasses().toSet();

  @override
  String toString() {
    return readClasses().join(' ');
  }

  @override
  Set<String> union(Set<String> other) => readClasses().union(other);
  // interface Set - END

  @override
  Iterable<String> where(bool Function(String element) f) =>
      readClasses().where(f);

  /// Join all the elements of a set into one string and write
  /// back to the element.
  /// This is intended to be overridden by specific implementations.
  void writeClasses(Set<String> s);

  String _validateToken(String value) {
    if (_validTokenRE.hasMatch(value)) return value;
    throw ArgumentError.value(value, 'value', 'Not a valid class token');
  }
}

class _ElementCssClassSet extends _CssClassSetImpl {
  final Element _element;

  _ElementCssClassSet(this._element);

  @override
  void clear() {
    _element.className = '';
  }

  @override
  Set<String> readClasses() {
    var s = <String>{};
    var classname = _element.className!;

    for (final name in classname.split(' ')) {
      final trimmed = name.trim();
      if (trimmed.isNotEmpty) {
        s.add(trimmed);
      }
    }
    return s;
  }

  @override
  void writeClasses(Set<String> classNames) {
    _element.className = classNames.join(' ');
  }
}

/// A set (union) of the CSS classes that are present in a set of elements.
/// Implemented separately from _ElementCssClassSet for performance.
class _MultiElementCssClassSet extends _CssClassSetImpl {
  final Iterable<Element> _elementIterable;

  // TODO(sra): Perhaps we should store the DomTokenList instead.
  final List<_CssClassSetImpl> _sets;

  factory _MultiElementCssClassSet(Iterable<Element> elements) {
    return _MultiElementCssClassSet._(elements,
        List<_CssClassSetImpl>.from(elements.map((Element e) => e.classes)));
  }

  _MultiElementCssClassSet._(this._elementIterable, this._sets);

  /// Helper method used to modify the set of css classes on this element.
  ///
  ///   f - callback with:
  ///   s - a Set of all the css class name currently on this element.
  ///
  ///   After f returns, the modified set is written to the
  ///       className property of this element.
  @override
  R? modify<R>(R Function(Set<String> s) f) {
    for (var e in _sets) {
      e.modify(f);
    }
    return null;
  }

  @override
  Set<String> readClasses() {
    var s = <String>{};
    for (var e in _sets) {
      s.addAll(e.readClasses());
    }
    return s;
  }

  /// Remove the class [value] from element, and return true on successful
  /// removal.
  ///
  /// This is the Dart equivalent of jQuery's
  /// [removeClass](http://api.jquery.com/removeClass/).
  @override
  bool remove(Object? value) => _sets.fold(
      false, (bool changed, _CssClassSetImpl e) => e.remove(value) || changed);

  /// Adds the class [value] to the element if it is not on it, removes it if it
  /// is.
  ///
  /// TODO(sra): It seems wrong to collect a 'changed' flag like this when the
  /// underlying toggle returns an 'is set' flag.
  @override
  bool toggle(String value, [bool? shouldAdd]) => _sets.fold(
      false,
      (bool changed, _CssClassSetImpl e) =>
          e.toggle(value, shouldAdd) || changed);

  @override
  void writeClasses(Set<String> s) {
    var classes = s.join(' ');
    for (var e in _elementIterable) {
      e.className = classes;
    }
  }
}
