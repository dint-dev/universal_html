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

/// Implements _dart:html_ in VM and Flutter. In browser, this library exports
/// _"dart:html"_.
///
/// # Introduction
///
/// HTML elements and other resources for web-based applications that need to
/// interact with the browser and the DOM (Document Object Model).
///
/// This library includes DOM element types, CSS styling, local storage,
/// media, speech, events, and more.
/// To get started,
/// check out the [Element] class, the base class for many of the HTML
/// DOM types.
///
/// For information on writing web apps with Dart, see https://webdev.dartlang.org.
library universal_html;

export 'src/html.dart' if (dart.library.html) 'src/_sdk/html.dart';
