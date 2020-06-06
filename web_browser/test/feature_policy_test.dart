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

import 'package:flutter_test/flutter_test.dart';
import 'package:web_browser/src/feature_policy.dart';

void main() {
  group('FeaturePolicy(...):', () {
    test('==', () {});

    test('with none', () {
      final policy = WebBrowserFeaturePolicy();
      expect(policy.toString(), '');
    });

    test('with all', () {
      final policy = WebBrowserFeaturePolicy(
        autoplay: true,
        camera: true,
        fullscreen: true,
        geolocation: true,
        payment: true,
        publicKeyCredentialsGet: true,
      );
      expect(
        policy.toString(),
        'autoplay camera geolocation fullscreen payment publickey-credentials-get',
      );
    });
  });

  group('FeaturePolicy.fromString(...):', () {
    test('==', () {
      final value = WebBrowserFeaturePolicy.fromString('camera');
      final clone = WebBrowserFeaturePolicy.fromString('camera');
      final other = WebBrowserFeaturePolicy.fromString('geolocation');

      expect(value.hashCode, clone.hashCode);
      expect(value.hashCode, isNot(other.hashCode));

      expect(value, clone);
      expect(value, isNot(other));
    });

    test('toString', () {
      final policy = WebBrowserFeaturePolicy.fromString('camera');
      expect(policy.toString(), 'camera');
    });
  });
}
