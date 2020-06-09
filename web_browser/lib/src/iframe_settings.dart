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
    // IMPORTANT:
    // We noticed browsers throw errors if some attributes (such as 'csp' and
    // 'sandbox') are null.
    final csp = this.csp ?? '';
    if (csp != element.csp ?? '') {
      element.csp = csp;
    }
    final height = this.height ?? '';
    if (height != element.height ?? '') {
      element.height = height;
    }
    final width = this.width ?? '';
    if (width != element.width ?? '') {
      element.width = width;
    }
    final allow = this.allow ?? '';
    if (allow != element.allow ?? '') {
      element.allow = allow?.toString();
    }
    final referrerPolicy = this.referrerPolicy ?? '';
    if (referrerPolicy != element.referrerPolicy ?? '') {
      element.referrerPolicy = referrerPolicy;
    }
    final sandbox = this.sandbox;
    if (sandbox != element.getAttribute('sandbox')) {
      element.setAttribute('sandbox', sandbox);
    }
    final importance = this.importance;
    if (importance != element.getAttribute('importance')) {
      element.setAttribute('importance', importance);
    }
    final scrolling = this.scrolling;
    if (scrolling != element.getAttribute('scrolling')) {
      element.setAttribute('scrolling', scrolling);
    }
  }
}
