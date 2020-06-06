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

import 'package:flutter/widgets.dart';

class WebBrowserNavigationEvent {
  final WebBrowserController controller;
  final String url;
  WebBrowserNavigationEvent(this.controller, this.url);
}

/// A web browser controller obtained from [WebBrowser.onCreated].
abstract class WebBrowserController {
  Stream<WebBrowserNavigationEvent> get onNavigation;

  /// Returns the current URL. May return null when `<iframe>` is used.
  Future<String> currentUrl();

  /// Evaluates a Javascript source string. Ignored when `<iframe>` is used.
  Future<void> evaluateJavascript(String javascriptString);

  /// Goes backward in history.
  Future<void> goBack();

  /// Goes forward in history.
  Future<void> goForward();

  /// Loads an URL.
  ///
  /// You can optionally define headers, but they will be ignored when
  /// `<iframe>` is used.
  Future<void> loadUrl(String url, {Map<String, String> headers});

  /// Posts a message in the window. Currently works only when `<iframe>` is
  /// used.
  Future<void> postMessage(dynamic message, String targetOrigin);

  /// Reloads the current URL.
  Future<void> reload();

  static WebBrowserController of(BuildContext context) {
    final webBrowserControllerWidget = context
        .dependOnInheritedWidgetOfExactType<WebBrowserControllerWidget>();
    return webBrowserControllerWidget.controller;
  }
}

/// Sets default
class WebBrowserControllerWidget extends InheritedWidget {
  final WebBrowserController controller;

  WebBrowserControllerWidget({
    Key key,
    @required this.controller,
    @required Widget child,
  })  : assert(controller != null),
        assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    if (oldWidget is WebBrowserControllerWidget) {
      return controller != oldWidget.controller;
    } else {
      return false;
    }
  }
}
