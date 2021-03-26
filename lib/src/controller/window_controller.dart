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

import 'package:universal_html/controller.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart' as parsing;
import 'package:universal_io/io.dart' show ContentType;
import 'package:universal_io/io.dart' as io;

/// Defines behavior of the browser APIs (such as navigation events).
///
/// # Example
/// ```
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
class WindowController {
  /// Instance returned by top-level `window` variable.
  static final WindowController topLevel = WindowController();

  late Window? _window = windowBehavior.newWindow(windowController: this);

  /// Behavior of the window.
  final WindowBehavior windowBehavior = WindowBehavior();

  /// Returns true if this controller for the top-level window inside a browser.
  ///
  /// Very limited features are available in browser.
  bool get isTopLevelWindowInsideBrowser =>
      identical(this, topLevel) && !identical(_window, window);

  /// Gets window controlled by this [WindowController].
  Window? get window => _window;

  /// Sets window.
  ///
  /// Attempt to replace top-level window inside browser will cause
  /// [StateError] to be thrown.
  set window(Window? window) {
    if (isTopLevelWindowInsideBrowser) {
      throw StateError('Failed to mutate the main window inside a browser');
    }
    _window = window;
  }

  /// Opens the content.
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
  Future<void> openFile(io.File file) async {
    if (isTopLevelWindowInsideBrowser) {
      throw StateError('Failed to mutate the main window inside a browser');
    }
    final content = await file.readAsString();
    return openContent(content);
  }

  /// Loads content using HTTP client.
  ///
  /// # Example
  /// ```
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
  Future<void> openHttp({
    String method = 'GET',
    required Uri uri,
    ContentType? contentType,
  }) async {
    if (isTopLevelWindowInsideBrowser) {
      throw StateError('Failed to mutate the main window inside a browser');
    }

    // Write HTTP request.
    final client = io.HttpClient();
    final request = await client.openUrl(method, uri);
    if (contentType != null) {
      request.headers.contentType = contentType;
    }

    // Read HTTP response.
    final response = await request.close();
    final content = await utf8.decodeStream(response);

    return openContent(content);
  }

  /// Loads content from "file", "http", or "https" URI.
  Future<void> openUri(Uri uri) {
    if (!uri.isAbsolute) {
      uri = Uri.parse(window!.location.href).resolveUri(uri);
    }
    if (uri.scheme == 'file') {
      return openFile(io.File.fromUri(uri));
    }
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return openHttp(uri: uri);
    }
    throw ArgumentError.value(uri, 'uri');
  }
}
