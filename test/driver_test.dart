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

@TestOn('vm')
library driver_test;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart' show StreamQueue;
import 'package:test/test.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/src/html.dart' hide HttpRequest;
import 'package:universal_io/io.dart';

part 'src/driver/browser_implementation_utils.dart';
part 'src/driver/content_security_policy.dart';
part 'src/driver/content_type_sniffer.dart';
part 'src/driver/dom_parser_driver.dart';
part 'src/driver/html_driver.dart';
part 'src/driver/navigation.dart';
part 'src/driver/server_side_renderer.dart';

void main() {
  group('driver:', () {
    _testHtmlDriver();
    _testDomParserDriver();
    _testContentSecurityPolicy();
    _testContentTypeSniffer();
    _testServerSideRenderer();
    _testBrowserImplementationUtils();
    _testNavigationNetworking();
  });
}
