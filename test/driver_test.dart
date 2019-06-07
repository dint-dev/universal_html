@TestOn("vm")
library driver_test;

import 'package:test/test.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/src/html.dart';

part 'src/driver/content_security_policy.dart';
part 'src/driver/content_type_sniffer.dart';
part 'src/driver/dom_parser_driver.dart';
part 'src/driver/html_driver.dart';

void main() {
  _testHtmlDriver();
  _testDomParserDriver();
  _testContentSecurityPolicy();
  _testContentTypeSniffer();
}
