// Copyright 2019 terrier989@gmail.com
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

import 'package:test/test.dart';
import 'package:universal_html/html.dart' as default_html;
import 'package:universal_html/indexed_db.dart' as default_indexed_db;
import 'package:universal_html/js.dart' as default_js;
import 'package:universal_html/js_util.dart' as default_js_util;
import 'package:universal_html/svg.dart' as default_svg;

void testLibraries() {
  test("'{libraryName}.dart", () {
    // dart:html
    expect(default_html.EventSource, isNotNull);
    expect(default_html.Element.tag('h1').outerHtml, '<h1></h1>');

    // dart:indexed_db
    expect(default_indexed_db.IdbFactory, isNotNull);

    // dart:js
    expect(default_js.allowInterop, isNotNull);
    expect(default_js.allowInteropCaptureThis, isNotNull);
    expect(default_js.JsFunction, isNotNull);
    expect(default_js.JsArray, isNotNull);
    expect(default_js.JsObject, isNotNull);

    // dart:js_util
    expect(default_js_util.promiseToFuture, isNotNull);

    // dart:svg
    expect(default_svg.SvgElement, isNotNull);
  });
}
