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

export 'package:webview_flutter/webview_flutter.dart'
    show AutoMediaPlaybackPolicy;

class WebBrowserInteractionSettings {
  /// Top bar. By default, [WebBrowserAddressBar].
  ///
  /// If the value is null, no top bar is shown.
  final Widget topBar;

  /// Top bar. By default, [WebBrowserNavigationBar].
  ///
  /// If the value is null, no bottom bar is shown.
  final Widget bottomBar;

  /// Whether gesture navigation is enabled. Default is false.
  /// Only supported in Android and iOS.
  /// Ignored in other platforms.
  final bool gestureNavigationEnabled;

  final AutoMediaPlaybackPolicy initialMediaPlaybackPolicy;

  const WebBrowserInteractionSettings({
    this.topBar = const WebBrowserAddressBar(),
    this.bottomBar = const WebBrowserNavigationBar(),
    this.gestureNavigationEnabled = false,
    this.initialMediaPlaybackPolicy =
        AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
  });

  @override
  int get hashCode => topBar.hashCode ^ bottomBar.hashCode;

  @override
  bool operator ==(other) =>
      other is WebBrowserInteractionSettings &&
      topBar == other.topBar &&
      bottomBar == other.bottomBar &&
      gestureNavigationEnabled == other.gestureNavigationEnabled &&
      initialMediaPlaybackPolicy == other.initialMediaPlaybackPolicy;
}
