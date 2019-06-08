part of universal_html;

abstract class CssStyleDeclaration extends CssStyleDeclarationBase {
  CssStyleDeclaration._();

  String toString();

  factory CssStyleDeclaration() => CssStyleDeclaration.css('');

  factory CssStyleDeclaration.css(String css) {
    final style = DivElement().style;
    style.cssText = css;
    return style;
  }

  /// Returns the value of the property if the provided *CSS* property
  /// name is supported on this element and if the value is set. Otherwise
  /// returns an empty string.
  ///
  /// Please note the property name uses camelCase, not-hyphens.
  String getPropertyValue(String propertyName);

  /// Returns true if the provided *CSS* property name is supported on this
  /// element.
  ///
  /// Please note the property name camelCase, not-hyphens. This
  /// method returns true if the property is accessible via an unprefixed _or_
  /// prefixed property.
  bool supportsProperty(String propertyName) {
    return true;
  }

  void setProperty(String propertyName, String value, [String priority]);

  /// Checks to see if CSS Transitions are supported.
  static bool get supportsTransitions {
    return false;
  }

  String cssFloat;

  String get cssText {
    throw UnimplementedError();
  }

  set cssText(String value) {
    throw UnimplementedError();
  }

  int get length;

  CssRule get parentRule;

  String getPropertyPriority(String property);

  String item(int index);

  String removeProperty(String property);
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

  @override
  void setProperty(String propertyName, String value, [String priority]) {
    this._sourceIsLatest = false;
    this._map[propertyName] = (value ?? "");
  }

  @override
  CssRule get parentRule {
    throw UnimplementedError();
  }

  @override
  String getPropertyPriority(String property) {
    throw UnimplementedError();
  }
}
