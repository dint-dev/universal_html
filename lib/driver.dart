library universal_html.driver;

import 'dart:async';

import 'package:zone_local/zone_local.dart';

import 'html.dart';

/// Holds global state and controls various device-specific APIs such as
/// [Geolocation].
class HtmlDriver {
  static final ZoneLocal<HtmlDriver> zoneLocal = ZoneLocal<HtmlDriver>(defaultValue: HtmlDriver());

  static HtmlDriver get current => zoneLocal.value;

  final Map<String, Future<StyleSheet>> loadedStyleSheets =
      <String, Future<StyleSheet>>{};

  Window _window;

  HtmlDocument _document;

  HtmlDriver();

  HtmlDocument get document {
    var document = this._document;
    if (document == null) {
      this._document = document = newDocument();
    }
    return document;
  }

  Window get window {
    var window = this._window;
    if (window == null) {
      this._window = window = newWindow();
    }
    return window;
  }

  Blob newBlob(List blobParts, [String type, String encoding]) =>
      throw UnimplementedError();

  CanvasRenderingContext2D newCanvasRenderingContext2D(CanvasElement element) =>
      throw UnimplementedError();

  Document newDocument() => HtmlDocument.internal();

  Geolocation newGeolocation() => throw UnimplementedError();

  Navigator newNavigator() => Navigator.internal();

  Storage newStorage() => Storage.internal();

  Window newWindow() => Window.internal();

  /// Resets global state ([document], [window])
  void reset() {
    _document = null;
    _window = null;
  }
}