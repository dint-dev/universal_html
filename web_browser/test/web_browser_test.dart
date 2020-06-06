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
import 'package:flutter_test/flutter_test.dart';
import 'package:web_browser/web_browser.dart';

void main() {
  setUpAll(() {
    spawnHybridUri('test/web_server.dart');
  });

  group('WebBrowser:', () {
    testWidgets('basic usage in CupertinoApp', (WidgetTester tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: WebBrowser(
            initialUrl: 'http://localhost:9898/',
            javascriptEnabled: true,
          ),
        ),
      );
    });

    testWidgets('basic usage in MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WebBrowser(
            initialUrl: 'http://localhost:9898/',
            javascriptEnabled: true,
          ),
        ),
      );
    });

    testWidgets('with onCreated', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WebBrowser(
            initialUrl: 'http://localhost:9898/',
            javascriptEnabled: true,
            onCreated: (controller) {
              // TODO: Test that this is called
            },
          ),
        ),
      );
    });

    testWidgets('with onError', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WebBrowser(
            initialUrl: 'http://localhost:9898/',
            javascriptEnabled: true,
            onError: (error) {
              // TODO: Test that this is called
            },
          ),
        ),
      );
    });
  });
}
