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

library main_test;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:test/test.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/src/internal/event_stream_decoder.dart';

import 'src/libraries.dart';

part 'src/html/api/blob.dart';
part 'src/html/api/event_target.dart';
part 'src/html/api/history.dart';
part 'src/html/api/networking.dart';
part 'src/html/api/networking_event_source.dart';
part 'src/html/api/networking_http_request.dart';
part 'src/html/dom/css.dart';
part 'src/html/dom/node.dart';
part 'src/html/dom/cloning.dart';
part 'src/html/dom/document.dart';
part 'src/html/dom/element.dart';
part 'src/html/dom/element_classes.dart';
part 'src/html/dom/parsing.dart';
part 'src/html/api/navigator.dart';
part 'src/html/api/window.dart';
part 'src/html/dom/helpers.dart';

void main() {
  group("In VM: ", () {
    _sharedTests();
  }, testOn: "vm");

  group("In Chrome: ", () {
    _sharedTests();
  }, testOn: "chrome");
}

void _sharedTests() {
  // Core DOM
  _testCloning();
  _testNode();
  _testDocument();
  _testElement();
  _testElementClasses();
  _testParsing();
  _testCss();
  _testEvents();

  _testWindow();

  _testNavigator();

  // History
  _testHistory();

  // Networking
  _testNetworking();

  _testBlob();

  testLibraries();
}
