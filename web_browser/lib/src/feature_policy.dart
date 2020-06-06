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

import 'package:web_browser/src/iframe_settings.dart';

/// A web browser feature policy. Used by [WebBrowserIFrameSettings].
///
/// See [documentation at developer.mozilla.com](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Feature-Policy).
class WebBrowserFeaturePolicy {
  const factory WebBrowserFeaturePolicy({
    bool autoplay,
    bool camera,
    bool geolocation,
    bool fullscreen,
    bool payment,
    bool publicKeyCredentialsGet,
  }) = _WebBrowserFeaturePolicy;

  const factory WebBrowserFeaturePolicy.fromString(String value) =
      _WebBrowserFeaturePolicyFromString;
}

class _WebBrowserFeaturePolicyFromString implements WebBrowserFeaturePolicy {
  final String _value;

  const _WebBrowserFeaturePolicyFromString(this._value);

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(other) =>
      other is WebBrowserFeaturePolicy && toString() == other.toString();

  @override
  String toString() => _value;
}

class _WebBrowserFeaturePolicy implements WebBrowserFeaturePolicy {
  final bool autoplay;
  final bool camera;
  final bool geolocation;
  final bool fullscreen;
  final bool payment;
  final bool publicKeyCredentialsGet;

  const _WebBrowserFeaturePolicy({
    this.autoplay = false,
    this.camera = false,
    this.geolocation = false,
    this.fullscreen = false,
    this.payment = false,
    this.publicKeyCredentialsGet = false,
  })  : assert(autoplay != null),
        assert(camera != null),
        assert(geolocation != null),
        assert(fullscreen != null),
        assert(payment != null),
        assert(publicKeyCredentialsGet != null);

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(other) =>
      other is WebBrowserFeaturePolicy && toString() == other.toString();

  @override
  String toString() {
    final list = <String>[];
    if (autoplay) {
      list.add('autoplay');
    }
    if (camera) {
      list.add('camera');
    }
    if (geolocation) {
      list.add('geolocation');
    }
    if (fullscreen) {
      list.add('fullscreen');
    }
    if (payment) {
      list.add('payment');
    }
    if (publicKeyCredentialsGet) {
      list.add('publickey-credentials-get');
    }
    return list.join(' ');
  }
}
