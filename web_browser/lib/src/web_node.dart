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
import 'package:web_browser/html.dart' as html;
import 'package:web_browser/html.dart' show Element;

import 'web_node_impl_default.dart'
    if (dart.library.html) 'web_node_impl_browser.dart' as impl;

/// A widget for rendering any _dart:html_ [Element].
///
/// Behavior by platform:
///   * In browsers, the element is directly inserted into the current document.
///   * In Android, iOS, and other platforms, HTML source is constructed from
///     the DOM tree and the source is shown using
///     [webview_flutter](https://pub.dev/packages/webview_flutter), which is
///     maintained by Google.
///
/// WebNode attempts to convert some properties of the parent Flutter style to
/// CSS properties. These include background color, text color, font family,
/// and font size.
///
/// ## Example
/// ```
/// import 'package:web_browser/html.dart';
/// import 'package:web_browser/web_browser.dart';
///
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     // Construct a DOM tree
///     final element = HeadingElement.h1();
///     element.appendText('Hello world!');
///     element.style.color = 'red';
///
///     // Render it in Flutter
///     return WebNode(element);
///   }
/// }
/// ```
class WebNode extends StatefulWidget {
  /// Rendered DOM node.
  final html.Node node;
  final Color backgroundColor;
  final bool iframeInBrowser;

  const WebNode({
    @required this.node,
    Key key,
    this.backgroundColor,
    this.iframeInBrowser = false,
  })  : assert(node != null),
        assert(iframeInBrowser != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return impl.WebNodeState();
  }
}

/// {@nodoc}
@deprecated
class WebText extends StatelessWidget {
  final String content;

  const WebText(this.content) : assert(content != null);

  @override
  Widget build(BuildContext context) {
    return WebNode(node: html.DivElement()..innerHtml = content);
  }
}
