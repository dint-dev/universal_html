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
import 'package:web_browser/html.dart';
import 'package:web_browser/src/feature_policy.dart';
import 'package:web_browser/src/iframe_settings.dart';

void main() {
  group('IframeSettings:', () {
    IFrameElement element;

    setUp(() {
      element = IFrameElement();
    });

    test('==', () {
      final value = WebBrowserIFrameSettings(
        allow: WebBrowserFeaturePolicy.fromString('allow'),
        csp: 'csp',
        referrerPolicy: 'referrerPolicy',
      );
      final clone = WebBrowserIFrameSettings(
        allow: WebBrowserFeaturePolicy.fromString('allow'),
        csp: 'csp',
        referrerPolicy: 'referrerPolicy',
      );
      final other0 = WebBrowserIFrameSettings(
        allow: WebBrowserFeaturePolicy.fromString('OTHER'),
        csp: 'csp',
        referrerPolicy: 'referrerPolicy',
      );
      final other1 = WebBrowserIFrameSettings(
        allow: WebBrowserFeaturePolicy.fromString('allow'),
        csp: 'OTHER',
        referrerPolicy: 'referrerPolicy',
      );
      final other2 = WebBrowserIFrameSettings(
        allow: WebBrowserFeaturePolicy.fromString('allow'),
        csp: 'csp',
        referrerPolicy: 'OTHER',
      );

      expect(value.hashCode, clone.hashCode);
      expect(value.hashCode, isNot(other0.hashCode));
      expect(value.hashCode, isNot(other1.hashCode));
      expect(value.hashCode, isNot(other2.hashCode));

      expect(value, clone);
      expect(value, isNot(other0));
      expect(value, isNot(other1));
      expect(value, isNot(other2));
    });

    test('allow', () {
      const settings = WebBrowserIFrameSettings(
        allow: WebBrowserFeaturePolicy(
          geolocation: true,
        ),
      );
      settings.applyToIFrameElement(element);
      expect(element.allow, 'geolocation');
    });

    test('csp', () {
      const settings = WebBrowserIFrameSettings(
        csp: 'abc',
      );
      settings.applyToIFrameElement(element);
      expect(element.csp, 'abc');
    });

    test('height', () {
      const settings = WebBrowserIFrameSettings(
        height: '100',
      );
      settings.applyToIFrameElement(element);
      expect(element.height, '100');
    });

    test('importance', () {
      const settings = WebBrowserIFrameSettings(
        importance: 'abc',
      );
      settings.applyToIFrameElement(element);
      expect(element.getAttribute('importance'), 'abc');
    });

    test('referrerPolicy', () {
      const settings = WebBrowserIFrameSettings(
        referrerPolicy: 'abc',
      );
      settings.applyToIFrameElement(element);
      expect(element.referrerPolicy, 'abc');
    });

    test('scrolling', () {
      const settings = WebBrowserIFrameSettings(
        scrolling: 'no',
      );
      settings.applyToIFrameElement(element);
      expect(element.getAttribute('scrolling'), 'no');
    });

    test('width', () {
      const settings = WebBrowserIFrameSettings(
        width: '100',
      );
      settings.applyToIFrameElement(element);
      expect(element.width, '100');
    });
  });
}
