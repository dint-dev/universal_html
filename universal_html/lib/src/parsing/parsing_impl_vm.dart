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

import 'package:universal_html/driver.dart';
import 'package:universal_html/src/html.dart';

HtmlDocument parseHtmlDocument(String content) {
  return HtmlDriver.current.domParserDriver.parseHtml(content);
}

XmlDocument parseXmlDocument(String content, {String mime = 'text/xml'}) {
  return HtmlDriver.current.domParserDriver.parseXml(content, mime: mime);
}
