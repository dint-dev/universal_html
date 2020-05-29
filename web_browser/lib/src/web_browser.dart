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

import 'package:flutter/widgets.dart' hide Element;
import 'package:meta/meta.dart';
import 'package:web_browser/html.dart' as html;
import 'package:web_browser/html.dart';

import 'web_browser_impl_default.dart'
    if (dart.library.html) 'web_browser_impl_browser.dart';

/// Renders a web page.
///
/// ## Example
/// ```
/// import 'package:web_browser/web_browser.dart';
///
/// const widget = WebBrowser(
///   initialUrl: 'https://dart.dev/',
///   javascript: true,
///   allowFullscreen: true,
/// );
/// ```
class WebBrowser extends StatelessWidget {
  final String initialUrl;
  final bool javascript;
  final bool allowFullscreen;

  const WebBrowser({
    @required this.initialUrl,
    this.javascript = false,
    this.allowFullscreen = false,
  })  : assert(initialUrl != null),
        assert(javascript != null),
        assert(allowFullscreen != null);

  @override
  Widget build(BuildContext context) {
    return buildWebBrowser(this);
  }
}

/// Renders _dart:html_ [Element].
///
/// ## Example
/// ```
/// import 'package:web_browser/html.dart';
/// import 'package:web_browser/web_browser.dart';
///
/// const widget = WebText(HeadingElement.h1()..appendText('Hello world!'));
/// ```
class WebNode extends StatelessWidget {
  final html.Element node;

  const WebNode(this.node) : assert(node != null);

  @override
  Widget build(BuildContext context) {
    return buildWebNode(this);
  }
}

/// Renders HTML source.
///
/// ## Example
/// ```
/// import 'package:web_browser/web_browser.dart';
///
/// const widget = WebText('<h1>Hello world!</h1>');
/// ```
class WebText extends StatelessWidget {
  final String content;

  const WebText(this.content) : assert(content != null);

  @override
  Widget build(BuildContext context) {
    return buildWebText(this);
  }
}
