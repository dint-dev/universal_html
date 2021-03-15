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

import 'dart:html';

import 'window_controller.dart';

HtmlDocument newHtmlDocument({
  required Window window,
  required String? contentType,
}) {
  return DomParser().parseFromString('<html></html>', 'text/html') as HtmlDocument;
}

Window newWindow({
  required WindowController windowController,
}) {
  throw UnsupportedError('Constructing new window is unsupported in browser');
}

Document newDocument({
  required Window window,
  required String contentType,
  required bool filled,
}) {
  return DomParser().parseFromString('<html></html>', 'text/html');
}

Navigator newNavigator({
  required Window window,
}) {
  throw UnsupportedError('Constructing new navigator is unsupported in browser');
}
