part of universal_html;

// IMPORTANT: Members of this file will be hidden by 'package:universal_html/html.dart.

abstract class NodeParserDriver {
  const NodeParserDriver();

  /// A helper for building parsers.
  static Comment newTrustedComment(Document ownerDocument, String text) {
    return new Comment._(ownerDocument, text);
  }

  /// A helper for building parsers.
  static Node newTrustedDocumentType(Document ownerDocument, String name) {
    return new _DocumentType(ownerDocument, name);
  }

  /// A helper for building parsers.
  static Element newTrustedHtmlElement(Document ownerDocument, String tagName) {
    return new Element._tag(ownerDocument, tagName);
  }

  /// A helper for building parsers.
  static Element newTrustedHtmlElementNS(
      Document ownerDocument, String namespace, String tagName) {
    return new Element._tagNS(ownerDocument, namespace, tagName);
  }

  /// A helper for building parsers.
  static Element newTrustedHtmlInputElement(
      Document ownerDocument, String type) {
    return new InputElementBase._fromType(ownerDocument, type);
  }

  /// A helper for building parsers.
  static Text newTrustedText(Document ownerDocument, String text) {
    return new Text._(ownerDocument, text);
  }

  /// A helper for building parsers.
  static Element newTrustedXmlElement(Document ownerDocument, String tagName) {
    return new _XmlElement._tag(ownerDocument, tagName);
  }

  /// A helper for building parsers.
  static Element newTrustedXmlElementNS(
      Document ownerDocument, String namespace, String tagName) {
    return new UnknownElement._(ownerDocument, namespace, tagName);
  }

  DocumentFragment parseFragmentWithHtml(Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer});

  DocumentFragment parseFragmentWithSvg(Document ownerDocument, String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer});

  HtmlDocument parseHtmlDocument(String source);

  XmlDocument parseXhtmlDocument(String source);

  XmlDocument parseSvgDocument(String source);

  XmlDocument parseXmlDocument(String source);
}

class HtmlDriver {
  static final ZoneLocal<HtmlDriver> zoneLocal = new ZoneLocal<HtmlDriver>()
    ..root = HtmlDriver();

  static HtmlDriver get current => zoneLocal.current;

  Blob newBlob(List blobParts, [String type, String encoding]) =>
      throw UnimplementedError();

  CanvasRenderingContext2D newCanvasRenderingContext2D(CanvasElement element) =>
      throw UnimplementedError();

  Geolocation newGeolocation() => throw UnimplementedError();

  Navigator newNavigator() => Navigator.constructor();

  Storage newStorage() => Storage.constructor();

  Window newWindow() => Window.constructor();
}

class HtmlIsolate {
  static final ZoneLocal<HtmlIsolate> zoneLocal = new ZoneLocal<HtmlIsolate>()
    ..root = HtmlIsolate();

  static HtmlIsolate get current => zoneLocal.current;

  final Map<String, Future<StyleSheet>> loadedStyleSheets =
      <String, Future<StyleSheet>>{};

  Window _window;

  HtmlDocument _document;

  HtmlIsolate();

  HtmlDocument get document {
    var document = this._document;
    if (document == null) {
      this._document = document = new HtmlDocument._normal();
    }
    return document;
  }

  Window get window {
    var window = this._window;
    if (window == null) {
      this._window = window = new Window._();
    }
    return window;
  }

  void clear() {
    _document = null;
    _window = null;
  }
}

/// A helper for making values of static variables zone-scoped.
///
/// Used by:
///   * [HtmlIsolate.current]
///   * [HtmlDriver.current]
class ZoneLocal<T> {
  /// Value of the root zone.
  T root;

  /// Key for use with [Zone.fork].
  /// If null, we know that we can use [root]. That's much faster than
  /// doing lookups for every zone in the zone stack.
  Object _keyOrNull;

  T get current {
    final key = this._keyOrNull;
    if (key != null) {
      final value = Zone.current[key];
      if (value != null) {
        return value;
      }
    }
    return root;
  }

  /// Returns key for using with [Zone.fork].
  Object get key {
    return _keyOrNull ?? (_keyOrNull = Object());
  }

  /// Creates a new zone with [Zone.fork].
  Zone forkWithValue(T value) {
    return Zone.current.fork(zoneValues: {
      key: value,
    });
  }
}
