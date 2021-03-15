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

import 'package:universal_html/src/html.dart';
import 'package:universal_html/src/html/_dom_parser_driver.dart';

HtmlDocument parseHtmlDocument({
  required Window window,
  required String content,
}) {
  return DomParserDriver().parseHtml(
    window: window,
    content: content,
  );
}

XmlDocument parseXmlDocument({
  required Window window,
  required String content,
  String mime = 'text/xml',
}) {
  return DomParserDriver().parseXml(
    window: window,
    content: content,
    mime: mime,
  );
}
