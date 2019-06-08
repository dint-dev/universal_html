import 'dart:async';
import 'dart:convert';

import 'package:universal_html/src/html.dart';
import 'package:universal_io/io.dart' show HttpClient, HttpClientResponse;
import 'package:zone_local/zone_local.dart';

import 'content_type_sniffer.dart';
import 'csp.dart';
import 'dom_parser_driver.dart';

// TODO: Refactoring: Split into two classes ("Browser" and "HtmlDriver")?

/// Simulates a browser window.
class HtmlDriver {
  static final ZoneLocal<HtmlDriver> zoneLocal =
      ZoneLocal<HtmlDriver>(defaultValue: HtmlDriver());

  static final Uri defaultUri = Uri(scheme: "memory", path: "/");

  static HtmlDriver get current => zoneLocal.value;

  final Map<String, Future<StyleSheet>> loadedStyleSheets =
      <String, Future<StyleSheet>>{};

  Uri _uri = defaultUri;

  Window _window;

  HtmlDocument _document;

  /// Forced CSP rules. These can't be overridden by content.
  Csp forcedContentSecurityPolicy = Csp.allowNone;

  /// CSP attached to the content.
  Csp contentSecurityPolicy;

  /// Used by 'dart:html' _window.languages_.
  final List<String> languages;

  /// Used for parsing HTML/XHTML/SVG/XML.
  final DomParserDriver domParserDriver = DomParserDriver();

  /// User agent string.
  ///
  /// Method [newHttpClient] returns a HTTP client that uses this string. This
  /// is also returned by _navigator.userAgent_.
  final String userAgent;

  HtmlDriver({
    this.languages = const <String>["en-US"],
    this.userAgent,
  });

  /// Used by 'dart:html' _document_.
  HtmlDocument get document {
    var document = this._document;
    if (document == null) {
      this._document = document = HtmlDocument.internal(this);
    }
    return document;
  }

  Uri get uri => _uri;

  /// Used by 'dart:html' _window_.
  Window get window {
    var window = this._window;
    if (window == null) {
      this._window = window = newWindow();
    }
    return window;
  }

  RenderData layoutDataFor(Element element) {
    return RenderData();
  }

  ApplicationCache newApplicationCache() => throw UnimplementedError();

  CanvasRenderingContext2D newCanvasRenderingContext2D(CanvasElement element) =>
      throw UnimplementedError();

  /// Constructs 'dart:html' _window.console_.
  Console newConsole() => Console.internal();

  /// Constructs 'dart:html' _navigator.geolocation_.
  Geolocation newGeolocation() => Geolocation.internal();

  /// Constructs 'dart:html' _window.history_.
  History newHistory() => History.internal();

  /// Constructs HTTP client used by 'dart:html' APIs that require network
  /// access.
  ///
  /// Examples of such APIs:
  ///   * [HttpClient]
  ///   * [EventSource]
  HttpClient newHttpClient() {
    final httpClient = HttpClient();
    httpClient.userAgent = userAgent;
    return httpClient;
  }

  /// Constructs 'dart:html' _window.location_.
  Location newLocation() => Location.internal(this, uri: uri);

  /// Constructs 'dart:html' _navigator_.
  Navigator newNavigator() => Navigator.internal(this);

  /// Constructs 'dart:html' _window.storage_ / _window.sessionStorage_.
  Storage newStorage({bool sessionStorage = false}) => Storage.internal();

  /// Constructs 'dart:html' _WebSocket_.
  WebSocket newWebSocket(String url, [Object protocols]) {
    throw UnimplementedError();
  }

  /// Constructs 'dart:html' _window_.
  Window newWindow() => Window.internal(this);

  /// Replaces current document.
  ///
  /// Sets:
  ///   * [uri]
  ///   * [document]
  ///   * [window] (using [newWindow])
  ///   * [contentSecurityPolicy] (using null)
  void setDocument(HtmlDocument document, {Uri uri}) {
    this._uri = uri ?? defaultUri;
    this._document = document; // If null, it will be lazily initialized.
    this._window = null; // It will be lazily initialized.
    this.contentSecurityPolicy = null;
    if (document == null) {
      this.contentSecurityPolicy = null;
    } else {
      this.contentSecurityPolicy = Csp.fromHtmlDocument(
        document,
      );
    }
  }

  /// Loads document from the string and calls [setDocument].
  void setDocumentFromContent(
    String input, {
    Uri uri,
    String mime,
    ContentTypeSniffer contentTypeSniffer = const ContentTypeSniffer(),
  }) async {
    mime ??= contentTypeSniffer.sniffMime(input) ?? "text/html";
    final document = domParserDriver.parseHtmlDocument(input, mime: mime);
    setDocument(document, uri: uri);
  }

  /// Loads document from the URI and calls [setDocumentFromContent].
  Future<void> setDocumentFromUri(
    Uri uri, {
    FutureOr<void> onHttpResponse(HttpClientResponse response),
    String mime,
    ContentTypeSniffer contentTypeSniffer = const ContentTypeSniffer(),
  }) async {
    final httpClient = newHttpClient();
    final httpRequest = await httpClient.getUrl(uri);
    final httpResponse = await httpRequest.close();
    if (onHttpResponse != null) {
      await onHttpResponse(httpResponse);
    }
    final content = await utf8.decodeStream(httpResponse);
    mime ??= httpResponse.headers.contentType.mimeType;
    setDocumentFromContent(
      content,
      uri: uri,
      mime: mime,
      contentTypeSniffer: contentTypeSniffer,
    );
    final cspHeader = httpResponse.headers.value("Content-Security-Policy");
    if (cspHeader != null) {
      this.contentSecurityPolicy = Csp.parse(cspHeader);
    }
  }
}
