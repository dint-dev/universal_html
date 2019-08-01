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
import 'package:universal_html/prefer_sdk/html.dart' as prefer_sdk_html;
import 'package:universal_html/prefer_sdk/svg.dart' as prefer_sdk_svg;
import 'package:universal_html/prefer_universal/html.dart'
    as prefer_universal_html;
import 'package:universal_html/prefer_universal/svg.dart'
    as prefer_universal_svg;

void testLibraries() {
  test("'package:_/prefer_sdk/X.dart", () {
    expect(prefer_sdk_html.EventSource, isNotNull);
    expect(prefer_sdk_svg.SvgElement, isNotNull);
  });
  test("'package:_/prefer_universal/X.dart", () {
    expect(prefer_universal_html.EventSource, isNotNull);
    expect(prefer_universal_svg.SvgElement, isNotNull);
  });
}
