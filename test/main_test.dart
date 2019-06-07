library main_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/html.dart';

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

void main() {
  _testCloning();
  _testNode();
  _testDocument();
  _testElement();
  _testParsing();
  _testCss();
  _testEvents();
  _testHistory();
  _testHttpRequest();
}
