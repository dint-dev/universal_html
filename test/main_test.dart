library main_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/src/internal/event_stream_decoder.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:universal_io/io.dart' as io;

part 'src/html/css.dart';
part 'src/html/dom.dart';
part 'src/html/dom_cloning.dart';
part 'src/html/dom_document.dart';
part 'src/html/dom_element.dart';
part 'src/html/dom_parsing.dart';
part 'src/html/event.dart';
part 'src/html/helpers.dart';
part 'src/html/history.dart';
part 'src/html/http_request.dart';
part 'src/html/event_source.dart';

void main() {
  // Core DOM
  _testCloning();
  _testNode();
  _testDocument();
  _testElement();
  _testParsing();
  _testCss();
  _testEvents();

  // History
  _testHistory();

  // HttpRequest
  _testHttpRequest();

  // EventSource
  _testEventSource();
}
