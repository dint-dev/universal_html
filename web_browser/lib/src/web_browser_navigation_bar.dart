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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

/// A web browser navigation bar. Contains "back" and "forward" buttons.
class WebBrowserNavigationBar extends StatefulWidget {
  /// Back button icon. Default is [Icons.arrow_back].
  ///
  /// If the value is null, back button is not shown.
  final Widget backButton;

  /// Forward button icon. Default is [Icons.arrow_forward].
  ///
  /// If the value is null, forward button is not shown.
  final Widget forwardButton;

  const WebBrowserNavigationBar({
    Key key,
    this.backButton = const WebBrowserBackButton(),
    this.forwardButton = const WebBrowserForwardButton(),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebBrowserNavigationBarState();
  }
}

class _WebBrowserNavigationBarState extends State<WebBrowserNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final controller = WebBrowserController.of(context);
    assert(controller != null);
    final rowChildren = <Widget>[];
    if (widget.backButton != null) {
      rowChildren.add(Padding(
        padding: EdgeInsets.all(2.0),
        child: widget.backButton,
      ));
    }
    if (widget.forwardButton != null) {
      rowChildren.add(Padding(
        padding: EdgeInsets.all(2.0),
        child: widget.forwardButton,
      ));
    }
    return Material(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      ),
    );
  }
}
