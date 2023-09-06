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

import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:io';

import 'package:universal_html/controller.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/html.dart' hide File;
import 'package:universal_html/parsing.dart' as parsing;
import 'package:universal_io/io.dart' show newUniversalHttpClient;

/// Defines behavior of the browser APIs (such as navigation events).
///
/// # Example
/// ```
/// import 'package:universal_html/controller.dart';
/// import 'package:universal_html/parsing.dart';
///
/// Future<void> main() async {
///   final controller = WindowController();
///   await controller.openHttp(
///     method: 'GET',
///     uri: Uri.parse('https://www.ietf.org/'),
///   );
///   final document = controller.window.document;
///   // ...
/// }
/// ```
///
/// ## Testing
/// ```dart
/// import 'package:universal_html/controller.dart';
/// import 'package:test/test.dart';
///
/// void main() {
///   setUp(() {
///     WindowController.instance = WindowController();
///   });
///
///   test('test #1', () {
///     // ...
///   });
///
///   test('test #2', () {
///     // ...
///   });
/// }
/// ```
class WindowController {
  static final Object _zoneKey = Object();
  static final _rootScope = _WindowControllerScope(WindowController());

  static bool _hasChangedInstance = false;

  /// Zone-local, mutable [WindowController].
  static WindowController get instance {
    return _scope.windowController;
  }

  static set instance(WindowController instance) {
    _hasChangedInstance = true;
    _scope.windowController = instance;
  }

  /// Old alias for [instance].
  ///
  /// This could be deprecated in future.
  static WindowController get topLevel => instance;

  static set topLevel(WindowController value) {
    instance = value;
  }

  static _WindowControllerScope get _scope =>
      Zone.current[_zoneKey] as _WindowControllerScope? ?? _rootScope;

  late Window _window = windowBehavior.newWindow(windowController: this);

  /// Behavior of the window.
  final WindowBehavior windowBehavior = WindowBehavior();

  /// Default [HttpClient].
  ///
  /// If you want to create a new [HttpClient] instance for every request,
  /// change [onChooseHttpClient].
  late HttpClient defaultHttpClient = newUniversalHttpClient();

  /// Chooses HTTP client that will be used for the URL.
  ///
  /// The default callback returns [defaultHttpClient].
  late HttpClient Function(Uri uri) onChooseHttpClient =
      (url) => defaultHttpClient;

  /// Returns true if this controller for the top-level window inside a browser.
  ///
  /// Very limited features are available in browser.
  bool get isTopLevelWindowInsideBrowser =>
      !_hasChangedInstance &&
      !identical(html.window, _window) &&
      identical(instance, this);

  /// Gets window controlled by this [WindowController].
  ///
  /// Throws [StateError] if modified inside a browser.
  Window get window => _window;

  set window(Window window) {
    if (isTopLevelWindowInsideBrowser) {
      throw StateError('Failed to mutate the main window inside a browser');
    }
    _window = window;
  }

  /// Opens the content.
  ///
  /// Throws [StateError] if called inside a browser.
  ///
  /// ## Example
  /// ```dart
  /// import 'package:universal_html/controller.dart';
  ///
  /// void main() {
  ///   final controller = WindowController();
  ///   controller.openContent('<html><body>Hello</body></html>');
  /// }
  /// ```
  void openContent(String content, {ContentType? contentType}) {
    if (isTopLevelWindowInsideBrowser) {
      throw StateError('Failed to mutate the main window inside a browser');
    }

    if (contentType == null) {
      // Sniff MIME.
      final mime = const ContentTypeSniffer().sniffMime(content);
      if (mime != null) {
        contentType = ContentType.parse(mime);
      }
    }

    // Use HTML MIME by default
    contentType ??= ContentType.html;

    // Construct a new window
    final window = windowBehavior.newWindow(windowController: this);

    if (contentType.subType == 'xml' || contentType.subType == 'xhtml') {
      // Parse XML.
      final parsedDocument = parsing.parseXmlDocument(content, window: window);

      // Transfer XML nodes to the window.
      // (This is not necessary product what we want. Fix if you have time.)
      final documentElement = window.document.documentElement;
      for (var child in documentElement!.children.toList()) {
        child.remove();
      }
      for (var child in parsedDocument.documentElement!.children.toList()) {
        documentElement.append(child);
      }
    } else {
      // Parse HTML.
      final parsedDocument = parsing.parseHtmlDocument(content, window: window);

      // Transfer HTML nodes to the window.
      // (This is not necessary product what we want. Fix if you have time.)
      final documentElement = window.document.documentElement;
      for (var child in documentElement!.children.toList()) {
        child.remove();
      }
      for (var child in parsedDocument.documentElement!.children.toList()) {
        documentElement.append(child);
      }
    }

    // Set current window.
    this.window = window;
  }

  /// Opens the file.
  ///
  /// Throws [StateError] if called inside a browser.
  ///
  /// ## Example
  /// ```dart
  /// import 'dart:io';
  /// import 'package:universal_html/controller.dart';
  ///
  /// void main() {
  ///   final controller = WindowController();
  ///   controller.openFile(File('index.html'));
  /// }
  /// ```
  Future<void> openFile(File file) async {
    if (isTopLevelWindowInsideBrowser) {
      throw StateError('Failed to mutate the main window inside a browser');
    }
    final content = await file.readAsString();
    return openContent(content);
  }

  /// Loads content using HTTP client.
  ///
  /// Throws [StateError] if called inside a browser.
  ///
  /// # Example
  /// ```
  /// import 'dart:io' show Cookie;
  /// import 'package:universal_html/controller.dart';
  ///
  /// Future main() async {
  ///   // Load a document.
  ///   final controller = WindowController();
  ///   controller.defaultHttpClient.userAgent = 'My Hacker News client';
  ///   await controller.openHttp(
  ///     method: 'GET',
  ///     uri: Uri.parse("https://news.ycombinator.com/"),
  ///     onRequest: (HttpClientRequest request) {
  ///       // Add custom headers
  ///       request.headers.set('Authorization', 'headerValue');
  ///       request.cookies.add(Cookie('cookieName', 'cookieValue'));
  ///     },
  ///     onResponse: (HttpClientResponse response) {
  ///       print('Status code: ${response.statusCode}');
  ///     },
  ///   );
  ///
  ///   // Select the top story using a CSS query
  ///   final titleElements = controller.document.querySelectorAll(".athing > .title");
  ///   final topStoryTitle = titleElements.first.text;
  ///
  ///   // Print result
  ///   print("Top Hacker News story is: $topStoryTitle");
  /// }
  /// }
  /// ```
  Future<void> openHttp({
    String method = 'GET',
    required Uri uri,
    ContentType? contentType,
    void Function(HttpClientRequest request)? onRequest,
    void Function(HttpClientResponse response)? onResponse,
  }) async {
    if (isTopLevelWindowInsideBrowser) {
      throw StateError('Failed to mutate the main window inside a browser');
    }

    // Write HTTP request.
    final client = onChooseHttpClient(uri);
    final request = await client.openUrl(method, uri);
    if (onRequest != null) {
      onRequest(request);
    }
    if (contentType != null) {
      request.headers.contentType = contentType;
    }

    // Read HTTP response.
    final response = await request.close();
    final future = utf8.decodeStream(response);
    if (onResponse != null) {
      onResponse(response);
    }
    final content = await future;

    return openContent(content, contentType: response.headers.contentType);
  }

  /// Loads content from a file or network URI.
  ///
  /// Supported input patterns:
  ///   * "file:///path/to/file"
  ///   * "file://localhost/path/to/file"
  ///   * "http://example.com/path?query=1"
  ///   * "https://example.com/path?query=1"
  Future<void> openUri(Uri uri) {
    final originalUri = uri;
    if (!uri.isAbsolute) {
      uri = Uri.parse(window.location.href).resolveUri(uri);
    }
    if (uri.scheme == 'file' && (uri.host.isEmpty || uri.host == 'localhost')) {
      return openFile(File.fromUri(uri));
    }
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return openHttp(uri: uri);
    }
    throw ArgumentError.value(originalUri, 'uri', 'Invalid URI scheme');
  }

  /// Enables zone-local [WindowController] instances.
  ///
  /// ## Example
  /// ```
  /// import 'package:universal_html/html.dart;
  ///
  /// void main() {
  ///   final zone = WindowController.newZone();
  ///   final outerWindow = window;
  ///   zone.run(() {
  ///     final innerWindow = window;
  ///     print(identical(outerWindow, innerWindow)); // --> false
  ///   });
  /// }
  /// ```
  static Zone newZone() {
    return newZoneWith(WindowController());
  }

  /// Returns a new [Zone] with the given [windowController].
  ///
  /// ## Example
  ///
  /// See [WindowController.newZone].
  static Zone newZoneWith(WindowController windowController) {
    _hasChangedInstance = true;
    return Zone.current
        .fork(zoneValues: {_zoneKey: _WindowControllerScope(windowController)});
  }
}

class _WindowControllerScope {
  WindowController windowController;

  _WindowControllerScope(this.windowController);
}
