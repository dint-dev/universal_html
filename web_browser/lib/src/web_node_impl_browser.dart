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

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:web_browser/web_browser.dart';

import 'web_node.dart';

int _htmlViewCounter = 0;

class WebNodeState extends State<WebNode> {
  html.Element _node;
  Widget _builtWidget;

  @override
  Widget build(BuildContext context) {
    if (_builtWidget == null) {
      final htmlViewId = 'HtmlView-$_htmlViewCounter';
      _htmlViewCounter++;
      ui.platformViewRegistry.registerViewFactory(htmlViewId, (int viewId) {
        return _node;
      });
      _builtWidget = HtmlElementView(
        viewType: htmlViewId,
      );
    }
    return _builtWidget;
  }

  @override
  void didUpdateWidget(WebNode oldWidget) {
    _node = widget.node;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _node = widget.node;
    super.initState();
  }
}
