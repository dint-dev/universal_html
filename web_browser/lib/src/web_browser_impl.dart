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
import 'package:web_browser/web_browser.dart';

Widget wrapWebBrowser(
  BuildContext context,
  WebBrowser webBrowser,
  WebBrowserController controller,
  Widget widget,
) {
  assert(webBrowser != null);
  assert(controller != null);
  assert(widget != null);
  final columnChildren = <Widget>[];

  // Top bar
  final topBar = webBrowser.interactionSettings?.topBar;
  if (topBar != null) {
    columnChildren.add(topBar);
  }

  // Content
  columnChildren.add(
    Expanded(
      child: Focus(
        child: widget,
      ),
    ),
  );

  // Bottom bar
  final bottomBar = webBrowser.interactionSettings?.bottomBar;
  if (bottomBar != null) {
    columnChildren.add(Center(child: bottomBar));
  }

  Widget result = Column(
    children: columnChildren,
    mainAxisSize: MainAxisSize.max,
  );

  // Inherited
  return WebBrowserControllerWidget(
    controller: controller,
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: result,
    ),
  );
}
