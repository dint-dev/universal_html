import 'package:collection/collection.dart';
import 'package:universal_html/src/html.dart';

/// An immutable instance of [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP).
class Csp {
  /// CSP declaration "default-src: *".
  static final Csp allowAny = Csp.parse("default-src: *");

  /// CSP declaration "default-src: 'self'".
  static final Csp allowSelf = Csp.parse("default-src: 'self'");

  /// CSP declaration "default-src: 'none'".
  static final Csp allowNone = Csp.parse("default-src: 'none'");

  final Map<String, List<String>> _rules;

  Csp._(this._rules);

  @override
  int get hashCode => const DeepCollectionEquality().hash(_rules);

  @override
  operator ==(other) =>
      other is Csp &&
      const DeepCollectionEquality().equals(_rules, other._rules);

  bool isAllowed(String type, Uri uri, {bool isSameOrigin = false}) {
    final ruleSet = this._rules[type] ?? this._rules["default-src"];
    if (ruleSet == null) {
      return false;
    }
    if (ruleSet.contains("'none'")) {
      return false;
    }
    if (isSameOrigin && ruleSet.contains("'self'")) {
      return true;
    }
    return ruleSet.any((pattern) {
      if (pattern == "*") {
        return true;
      }
      if (pattern.contains("://")) {
        final patternUri = Uri.parse(pattern);
        return _matches(uri.scheme, patternUri.scheme) &&
            _matches(uri.host, patternUri.host);
      }
      return _matches(uri.host, pattern);
    });
  }

  bool isNone(String type) {
    final ruleSet = this._rules[type] ?? this._rules["default-src"];
    if (ruleSet == null) {
      return false;
    }
    return ruleSet.contains("'none'");
  }

  CspBuilder toBuilder() {
    final builder = CspBuilder();
    builder.addContentSecurityPolicy(this);
    return builder;
  }

  @override
  String toString() {
    final keys = _rules.keys.toList(growable: false)..sort();
    final sb = StringBuffer();
    var isFirst = true;
    for (var key in keys.toList(growable: false)..sort()) {
      if (isFirst) {
        isFirst = false;
      } else {
        sb.write("; ");
      }
      sb.write(key);
      for (var item in _rules[key]) {
        sb.write(" ");
        sb.write(item);
      }
    }
    return sb.toString();
  }

  /// Reads CSP from the first element that looks like:
  ///     <meta http-equiv="Content-Security-Policy" content="default-src: *">
  static Csp fromHtmlDocument(HtmlDocument document) {
    final head = document.head;
    if (head != null) {
      for (var child in head.children) {
        if (child is MetaElement &&
            child.getAttribute("http-equiv") == "Content-Security-Policy") {
          final content = child.getAttribute("content");
          if (content != null) {
            final result = Csp.tryParse(content);
            if (result != null) {
              return result;
            }
          }
        }
      }
    }
    return null;
  }

  static Csp merge(Iterable<Csp> iterable) {
    final builder = CspBuilder();
    for (var item in iterable) {
      if (item == null) {
        continue;
      }
      builder.addContentSecurityPolicy(item);
    }
    return builder.build();
  }

  static Csp parse(String input) {
    final result = tryParse(input);
    if (result == null) {
      throw FormatException("Invalid CSP policy: '${input}'");
    }
    return result;
  }

  static Csp tryParse(String input) {
    final builder = CspBuilder();
    for (var directive in input.split("; ")) {
      final items = directive.split(" ");
      builder.addRule(items.first, items.skip(1));
    }
    return builder.build();
  }

  static bool _matches(String input, String pattern) {
    if (input == pattern) {
      return true;
    }
    if (pattern.endsWith("*") &&
        input.startsWith(pattern.substring(0, pattern.length - 1))) {
      return true;
    }
    if (pattern.startsWith("*") && input.endsWith(pattern.substring(1))) {
      return true;
    }
    return false;
  }
}

/// Builds instances of [Csp].
class CspBuilder {
  Map<String, List<String>> _rules = <String, List<String>>{};

  void addContentSecurityPolicy(Csp csp) {
    csp._rules.forEach((type, items) {
      addRule(type, items);
    });
  }

  void addRule(String type, [Iterable<String> args = const <String>[]]) {
    var set = _rules[type];
    if (set == null) {
      set = <String>[];
      _rules[type] = set;
    }
    set.addAll(args);
  }

  Csp build() {
    final result = Csp._(_rules);
    this._rules = null;
    return result;
  }
}
