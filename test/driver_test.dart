@TestOn("vm")
library driver_test;

import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart' show StreamQueue;
import 'package:test/test.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/src/html.dart' hide HttpRequest;
import 'package:universal_io/io.dart';

part 'src/driver/content_security_policy.dart';
part 'src/driver/content_type_sniffer.dart';
part 'src/driver/dom_parser_driver.dart';
part 'src/driver/html_driver.dart';
part 'src/driver/server_side_renderer.dart';

void main() {
  _testHtmlDriver();
  _testDomParserDriver();
  _testContentSecurityPolicy();
  _testContentTypeSniffer();
  _testServerSideRenderer();
}
