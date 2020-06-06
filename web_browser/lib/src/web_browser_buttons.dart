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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

/// "Back" button used by [WebBrowserNavigationBar].
class WebBrowserBackButton extends StatelessWidget {
  const WebBrowserBackButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 20,
      ),
      onPressed: () {
        final controller = WebBrowserController.of(context);
        controller.goBack();
      },
    );
  }
}

/// "Forward" button used by [WebBrowserNavigationBar].
class WebBrowserForwardButton extends StatelessWidget {
  const WebBrowserForwardButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_forward,
        size: 20,
      ),
      onPressed: () {
        final controller = WebBrowserController.of(context);
        controller.goForward();
      },
    );
  }
}

class WebBrowserShareButton extends StatelessWidget {
  final IconData iconData;
  final FutureOr<void> Function(WebBrowserController controller, String url)
      onShare;

  const WebBrowserShareButton({
    this.iconData = CupertinoIcons.share,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: () async {
        final controller = WebBrowserController.of(context);
        final url = await controller.currentUrl();
        if (onShare != null) {
          onShare(controller, url);
          return;
        }
        await shareUrl(context, url);
      },
    );
  }
}
