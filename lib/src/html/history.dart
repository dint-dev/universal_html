part of universal_html;

class History {
  final List<_HistoryState> _stack = [
    _HistoryState(null, "", window.location.href),
  ];
  int _index = 0;
  dynamic _state;

  factory History() {
    throw UnimplementedError();
  }

  History._();

  int get length => _stack.length;

  String get scrollRestoration {
    throw UnimplementedError();
  }

  dynamic get state => _state;

  void back() {
    go(-1);
  }

  void forward() {
    go(1);
  }

  void go(int delta) {
    final newIndex = this._index + delta;
    if (newIndex < 0 || newIndex >= _stack.length) {
      // Fail silently
      return;
    }
    _setStateAndDispatchEvent(_stack[newIndex]);
    _index = newIndex;
  }

  void pushState(dynamic data, String title, String url) {
    url = _resolve(url);
    final state = _HistoryState(data, title, url);
    _stack.add(state);
    _index = _stack.length - 1;
    _setStateAndDispatchEvent(state);
  }

  void replaceState(dynamic data, String title, String url) {
    url = _resolve(url);
    final state = _HistoryState(data, title, url);
    _stack.removeLast();
    _stack.add(state);
    _setStateAndDispatchEvent(state);
  }

  void _setStateAndDispatchEvent(_HistoryState state) {
    this._state = state.data;
    window.location.replace(state.url);
    window.dispatchEvent(PopStateEvent(state: state.data));
  }

  static String _resolve(String url) {
    var parsedUrl = Uri.parse(url);
    if (parsedUrl.isAbsolute) {
      return url;
    }
    return Uri.parse(window.location.href).resolve(url).toString();
  }
}

class Location extends Object with _UrlBase {
  List<String> ancestorOrigins;

  /// For [_UrlBase]
  @override
  Uri _uri;

  String _href;

  Location._() {
    replace("http://localhost/");
  }

  String get href => _href;

  set href(String value) {
    this._uri = Uri.parse(value);
    this._href = value;
  }

  void assign([String url]) {
    if (url == null) {
      return;
    }
    replace(url);
  }

  void reload() {}

  void replace(String url) {
    this.href = url;
  }
}

class Url extends _UrlBase {
  static String createObjectUrl(dynamic blob_OR_source_OR_stream) {
    throw UnimplementedError();
  }

  static String createObjectUrlFromBlob(Blob blob) {
    throw UnimplementedError();
  }

  static String createObjectUrlFromSource(MediaSource source) {
    throw UnimplementedError();
  }

  static String createObjectUrlFromStream(MediaStream stream) {
    throw UnimplementedError();
  }

  static void revokeObjectUrl(String url) {}

  final Uri _uri;

  Url._(this._uri);
}

class _HistoryState {
  final dynamic data;
  final String title;
  final String url;

  _HistoryState(this.data, this.title, this.url);
}

abstract class _UrlBase {
  String get hash => _uri?.fragment ?? "";

  String get host {
    final uri = this._uri;
    if (uri == null) return "";
    final hostname = _uri.host ?? "";
    final port = _uri.port;
    return port == null ? hostname : "${hostname}:${port}";
  }

  String get hostname => _uri?.host ?? "";

  String get origin => _uri?.origin;

  String get password => throw UnimplementedError();

  String get pathname => _uri?.path ?? "";

  String get port {
    final uri = this._uri;
    if (uri == null) return "";
    final port = uri.port;
    return port == 0 ? "" : port.toString();
  }

  String get protocol {
    final scheme = _uri?.scheme;
    if (scheme == null) return ":";
    return "$scheme:";
  }

  String get search => _uri?.query ?? "";

  String get username => throw UnimplementedError();

  Uri get _uri;
}
