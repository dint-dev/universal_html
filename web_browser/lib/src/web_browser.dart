// Copyright 2020 Gohilla Ltd.
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

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart' hide Element;
import 'package:meta/meta.dart';
import 'package:web_browser/web_browser.dart';
import 'package:webview_flutter/platform_interface.dart' show WebResourceError;

import 'web_browser_impl_default.dart'
    if (dart.library.html) 'web_browser_impl_browser.dart' as impl;

export 'package:webview_flutter/platform_interface.dart'
    show WebResourceError, WebResourceErrorType;
export 'package:webview_flutter/webview_flutter.dart' show CookieManager;

/// A widget for showing a web page.
///
/// Behavior by platform:
///   * In browsers, the widget uses `<iframe src="URL">`.
///   * In other platforms, the widget uses [webview_flutter](https://pub.dev/packages/webview_flutter),
///     which is a plugin maintained by Google.
///
/// ## Example
/// ```
/// import 'package:web_browser/web_browser.dart';
///
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return WebBrowser(
///       initialUrl: 'https://dart.dev/',
///       javascript: true,
///     );
///   }
/// }
/// ```
class WebBrowser extends StatefulWidget {
  static const Set<Factory<OneSequenceGestureRecognizer>>
      _defaultGestureRecognizers = {
    Factory<HorizontalDragGestureRecognizer>(
      _horizontalDragGestureRecognizerFactory,
    ),
    Factory<VerticalDragGestureRecognizer>(
      _verticalDragGestureRecognizerFactory,
    ),
    Factory<TapGestureRecognizer>(
      _tapGestureRecognizerFactory,
    ),
  };

  /// Initial URL.
  final String initialUrl;

  /// Specifies `<iframe>` attributes.
  final WebBrowserIFrameSettings iframeSettings;

  /// Specifies UI elements for interacting with the browser.
  final WebBrowserInteractionSettings interactionSettings;

  /// Whether debugging mode is enabled. Default is false.
  /// Only supported in Android and iOS.
  /// Ignored in other platforms.
  final bool debuggingEnabled;

  /// Gesture recognizers of the browser. By default, all gesture recognizers.
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  /// Whether Javascript is allowed. Default is false.
  /// Only supported in Android and iOS.
  /// Ignored in other platforms.
  final bool javascriptEnabled;

  /// Called when the web browser is ready.
  final void Function(WebBrowserController controller) onCreated;

  /// Called when an error occurs.
  final void Function(WebResourceError error) onError;

  /// User-agent string. Default is undefined.
  /// Only supported in Android and iOS.
  /// Ignored in other platforms.
  final String userAgent;

  const WebBrowser({
    Key key,
    @required this.initialUrl,
    this.iframeSettings = const WebBrowserIFrameSettings(),
    this.interactionSettings = const WebBrowserInteractionSettings(),
    this.debuggingEnabled = false,
    this.gestureRecognizers = _defaultGestureRecognizers,
    this.javascriptEnabled = false,
    this.onCreated,
    this.onError,
    this.userAgent,
  })  : assert(initialUrl != null),
        assert(iframeSettings != null),
        assert(debuggingEnabled != null),
        assert(gestureRecognizers != null),
        assert(javascriptEnabled != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return impl.WebBrowserState();
  }

  static HorizontalDragGestureRecognizer
      _horizontalDragGestureRecognizerFactory() =>
          HorizontalDragGestureRecognizer();

  static VerticalDragGestureRecognizer
      _verticalDragGestureRecognizerFactory() =>
          VerticalDragGestureRecognizer();

  static TapGestureRecognizer _tapGestureRecognizerFactory() =>
      TapGestureRecognizer();
}
