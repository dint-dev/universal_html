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

import 'package:web_browser/html.dart' show IFrameElement;
import 'package:web_browser/web_browser.dart';

/// Settings for iframes.
class WebBrowserIFrameSettings {
  /// `<iframe>` "allow" attribute. By default, undefined.
  /// Only supported in browsers.
  /// Ignored in other platforms.
  ///
  /// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe).
  final WebBrowserFeaturePolicy allow;

  /// `<iframe>` content security policy.
  /// Only supported in browsers.
  /// Ignored in other platforms.
  ///
  /// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe).
  final String csp;

  /// `<iframe>` "height" attribute. By default, "100%".
  /// Only supported in browsers.
  /// Ignored in other platforms.
  ///
  /// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe).
  final String height;

  /// `<iframe>` "importance" attribute. By default, undefined.
  /// Only supported in browsers.
  /// Ignored in other platforms.
  ///
  /// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe).
  final String importance;

  /// `<iframe>` "referrerpolicy" attribute. By default, undefined.
  /// Only supported in browsers.
  /// Ignored in other platforms.
  ///
  /// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe).
  final String referrerPolicy;

  /// `<iframe>` "sandbox" attribute. By default, undefined.
  /// Only supported in browsers.
  /// Ignored in other platforms.
  ///
  /// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe).
  final String sandbox;

  /// `<iframe>` "scrolling" attribute. By default, undefined.
  /// Only supported in browsers.
  /// Ignored in other platforms.
  ///
  /// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe).
  final String scrolling;

  /// `<iframe>` "width" attribute. By default, "100%".
  /// Only supported in browsers.
  /// Ignored in other platforms.
  ///
  /// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe).
  final String width;

  const WebBrowserIFrameSettings({
    this.allow,
    this.csp,
    this.height,
    this.importance,
    this.referrerPolicy,
    this.sandbox,
    this.scrolling,
    this.width,
  });

  @override
  int get hashCode =>
      allow.hashCode ^
      csp.hashCode ^
      height.hashCode ^
      importance.hashCode ^
      referrerPolicy.hashCode ^
      sandbox.hashCode ^
      scrolling.hashCode ^
      width.hashCode;

  @override
  bool operator ==(other) =>
      other is WebBrowserIFrameSettings &&
      allow == other.allow &&
      csp == other.csp &&
      height == other.height &&
      importance == other.importance &&
      referrerPolicy == other.referrerPolicy &&
      sandbox == other.sandbox &&
      scrolling == other.scrolling &&
      width == other.width;

  void applyToIFrameElement(IFrameElement element) {
    element.height = height;
    element.width = width;
    element.allow = allow?.toString();
    element.csp = csp;
    element.setAttribute('importance', importance);
    element.referrerPolicy = referrerPolicy;
    element.setAttribute('sandbox', sandbox);
    element.setAttribute('scrolling', scrolling);
  }
}
