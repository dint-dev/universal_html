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
import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/widgets.dart';
import 'package:web_browser/src/web_browser_impl.dart';
import 'package:web_browser/web_browser.dart';

class WebBrowserState extends State<WebBrowser> {
  Widget _builtWidget;
  html.IFrameElement _element;
  bool _didUpdate = true;

  @override
  Widget build(BuildContext context) {
    if (_builtWidget == null) {
      // Construct iframe
      _element = html.IFrameElement();
      _element.style.backgroundColor = 'white';

      // Construct controller
      final controller = _WebBrowserController(_element);

      // Wrap iframe with navigation
      _builtWidget = wrapWebBrowser(
        context,
        widget,
        controller,
        WebNode(node: _element),
      );

      final onCreated = widget.onCreated;
      if (onCreated != null) {
        scheduleMicrotask(() {
          onCreated(_WebBrowserController(_element));
        });
      }
    }
    if (_didUpdate) {
      _didUpdate = false;
      final element = _element;
      element.src = widget.initialUrl;
      widget.iframeSettings?.applyToIFrameElement(element);
      final size = MediaQuery.of(context).size;
      element.height ??= '${size.height.toInt() - 100}';
      element.width ??= '${size.width.toInt()}';
    }
    return _builtWidget;
  }

  @override
  void didUpdateWidget(WebBrowser oldWidget) {
    if (!(widget.initialUrl == oldWidget.initialUrl ||
        widget.iframeSettings != oldWidget.iframeSettings ||
        widget.interactionSettings != oldWidget.interactionSettings ||
        !identical(widget.onCreated, oldWidget.onCreated) ||
        !identical(widget.onError, oldWidget.onError))) {
      // Invalidate cached widget
      _didUpdate = true;
    }
    super.didUpdateWidget(oldWidget);
  }
}

class _WebBrowserController extends WebBrowserController {
  final html.IFrameElement _element;
  final _webNavigationEventController =
      StreamController<WebBrowserNavigationEvent>.broadcast();
  String _url;

  _WebBrowserController(this._element) {
    _url = _element.src;
  }

  @override
  Stream<WebBrowserNavigationEvent> get onNavigation =>
      _webNavigationEventController.stream;

  @override
  Future<String> currentUrl() async {
    return _url;
  }

  @override
  Future<void> evaluateJavascript(String javascriptString) async {
    final window = _element.contentWindow as js.JsObject;
    window.callMethod('eval', [javascriptString]);
  }

  @override
  Future<void> goBack() async {
    _element.contentWindow.history.back();
  }

  @override
  Future<void> goForward() async {
    _element.contentWindow.history.forward();
  }

  @override
  Future<void> loadUrl(String url, {Map<String, String> headers}) async {
    _element.src = url;
    _url = url;
    _webNavigationEventController.add(WebBrowserNavigationEvent(this, url));
  }

  @override
  Future<void> postMessage(dynamic message, String targetOrigin) async {
    _element.contentWindow.postMessage(message, targetOrigin);
  }

  @override
  Future<void> reload() async {
    _element?.contentWindow?.history?.go(0);
  }
}
