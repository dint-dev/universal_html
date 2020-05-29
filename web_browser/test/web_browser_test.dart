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
import 'package:web_browser/html.dart' as html;
import 'package:web_browser/src/web_browser.dart';

void main() {
  group('WebNode:', () {
    testWidgets('basic usage', (WidgetTester tester) async {
      await tester.pumpWidget(WebNode(
        html.HeadingElement.h1()..appendText('Hello world'),
      ));
    });
  });
  group('WebText:', () {
    testWidgets('basic usage', (WidgetTester tester) async {
      await tester.pumpWidget(WebText('<h1>Hello world</h1>'));
    });
  });
  group('WebBrowser:', () {
    testWidgets('basic usage', (WidgetTester tester) async {
      await tester.pumpWidget(WebBrowser(
        initialUrl: 'https://dart.dev/',
        javascript: true,
        allowFullscreen: true,
      ));
    });
  });
}
