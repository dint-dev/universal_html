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
import 'package:webview_flutter/webview_flutter.dart' as web_view;

import 'web_browser.dart';

Widget buildWebBrowser(WebBrowser widget) {
  return _WebBrowser(
    initialUrl: widget.initialUrl,
    javascript: widget.javascript,
  );
}

Widget buildWebNode(WebNode widget) {
  return WebBrowser(
    initialUrl: Uri.dataFromString(
      widget.node.outerHtml,
      mimeType: 'text/html',
    ).toString(),
  );
}

Widget buildWebText(WebText widget) {
  return WebBrowser(
    initialUrl: Uri.dataFromString(
      widget.content,
      mimeType: 'text/html',
    ).toString(),
  );
}

class _WebBrowser extends StatefulWidget {
  final String initialUrl;
  final bool javascript;

  _WebBrowser({@required this.initialUrl, @required this.javascript})
      : assert(initialUrl != null),
        assert(javascript != null);

  @override
  State<StatefulWidget> createState() {
    return _WebBrowserState();
  }
}

class _WebBrowserState extends State<_WebBrowser> {
  Widget _builtWidget;

  @override
  Widget build(BuildContext context) {
    _builtWidget ??= web_view.WebView(
      initialUrl: widget.initialUrl,
      javascriptMode: widget.javascript
          ? web_view.JavascriptMode.unrestricted
          : web_view.JavascriptMode.disabled,
    );
    return _builtWidget;
  }

  @override
  void didUpdateWidget(_WebBrowser oldWidget) {
    if (!(widget.initialUrl == oldWidget.initialUrl)) {
      _builtWidget = null;
    }
    super.didUpdateWidget(oldWidget);
  }
}
