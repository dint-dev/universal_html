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

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:web_browser/src/web_browser_impl.dart';
import 'package:web_browser/web_browser.dart';
import 'package:webview_flutter/webview_flutter.dart' as web_view;

class WebBrowserState extends State<WebBrowser> {
  Widget _builtWidget;
  _WebBrowserController _controller;

  @override
  Widget build(BuildContext context) {
    if (_builtWidget == null) {
      _controller = _WebBrowserController(this);
      final webView = web_view.WebView(
        initialMediaPlaybackPolicy:
            widget.interactionSettings?.initialMediaPlaybackPolicy ??
                AutoMediaPlaybackPolicy.always_allow,
        initialUrl: widget.initialUrl,
        debuggingEnabled: widget.debuggingEnabled,
        gestureNavigationEnabled:
            widget.interactionSettings?.gestureNavigationEnabled ?? false,
        gestureRecognizers: widget.gestureRecognizers,
        javascriptMode: widget.javascriptEnabled
            ? web_view.JavascriptMode.unrestricted
            : web_view.JavascriptMode.disabled,
        onWebViewCreated: (webViewController) {
          _controller._controller = webViewController;
          if (widget.onCreated != null) {
            widget.onCreated(_controller);
          }
        },
        onWebResourceError: widget.onError,
        navigationDelegate: (request) {
          if (widget.interactionSettings == null && request.isForMainFrame) {
            final parsedUrl = Uri.parse(request.url);
            if (!parsedUrl.isScheme('data')) {
              if (request.url != widget.initialUrl) {
                return web_view.NavigationDecision.prevent;
              }
            }
          }
          if (request.isForMainFrame) {
            _controller._dispatchNavigation(request.url);
          }
          return web_view.NavigationDecision.navigate;
        },
      );
      _builtWidget = wrapWebBrowser(
        context,
        widget,
        _controller,
        webView,
      );
    }
    return _builtWidget;
  }

  @override
  void didUpdateWidget(WebBrowser oldWidget) {
    if (widget.initialUrl != oldWidget.initialUrl ||
        widget.debuggingEnabled != oldWidget.debuggingEnabled ||
        widget.iframeSettings != oldWidget.iframeSettings ||
        widget.interactionSettings != oldWidget.interactionSettings ||
        widget.javascriptEnabled != oldWidget.javascriptEnabled ||
        !identical(widget.onCreated, oldWidget.onCreated) ||
        !identical(widget.onError, oldWidget.onError)) {
      _builtWidget = null;
    }
    super.didUpdateWidget(oldWidget);
  }
}

class _WebBrowserController extends WebBrowserController {
  final WebBrowserState state;
  web_view.WebViewController _controller;

  final _webNavigationEventController =
      StreamController<WebBrowserNavigationEvent>.broadcast();

  // ignore: close_sinks
  _WebBrowserController(this.state);

  @override
  Stream<WebBrowserNavigationEvent> get onNavigation =>
      _webNavigationEventController.stream;

  @override
  Future<String> currentUrl() {
    if (_controller == null) {
      return Future<String>.value(state.widget?.initialUrl);
    }
    return _controller.currentUrl();
  }

  @override
  Future<void> evaluateJavascript(String javascriptString) {
    return _controller?.evaluateJavascript(javascriptString);
  }

  @override
  Future<void> goBack() {
    return _controller?.goBack();
  }

  @override
  Future<void> goForward() {
    return _controller?.goForward();
  }

  @override
  Future<void> loadUrl(String url, {Map<String, String> headers}) async {
    // ignore: unawaited_futures
    _controller.loadUrl(url, headers: headers).then((value) {
      _dispatchNavigation(url);
    });
  }

  @override
  Future<void> postMessage(dynamic message, String targetOrigin) async {
    throw UnimplementedError();
  }

  @override
  Future<void> reload() {
    return _controller?.reload();
  }

  void _dispatchNavigation(String url) {
    _webNavigationEventController.add(WebBrowserNavigationEvent(this, url));
  }
}
