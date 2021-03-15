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

import '../html.dart';
import 'window_controller.dart';

Document newDocument({
  required Window window,
  required String contentType,
  required bool filled,
}) {
  final document = HtmlDocument.internal(
    window: window,
    contentType: contentType,
    filled: filled,
  );
  assert(identical(document.window, window));
  return document;
}

HtmlDocument newHtmlDocument({
  required Window window,
  required String? contentType,
}) {
  return HtmlDocument.internal(
    window: window,
    contentType: contentType ?? 'text/html',
    filled: true,
  );
}

Navigator newNavigator({
  required Window window,
}) {
  final navigator = Navigator.internal(
    internalWindow: window,
  );
  assert(identical(navigator.internalWindow, window));
  return navigator;
}

Window newWindow({
  required WindowController windowController,
  String href = 'http://localhost/',
}) {
  return Window.internal(
    internalWindowController: windowController,
    href: href,
  );
}
