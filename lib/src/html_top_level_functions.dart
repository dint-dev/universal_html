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

import 'html.dart';

// MOTIVATION:
//
// We want to prevent us from accidentally using `document`.
// This caused bugs in the past.
//
/// Root node for all content in a web page.
HtmlDocument get document => window.document as HtmlDocument;

/// Finds the first descendant element of this document that matches the
/// specified group of selectors.
///
/// Unless your webpage contains multiple documents, the top-level
/// [querySelector]
/// method behaves the same as this method, so you should use it instead to
/// save typing a few characters.
///
/// [selectors] should be a string using CSS selector syntax.
///
///     var element1 = document.querySelector('.className');
///     var element2 = document.querySelector('#id');
///
/// For details about CSS selector syntax, see the
/// [CSS selector specification](http://www.w3.org/TR/css3-selectors/).
Element? querySelector(String s) => window.document.querySelector(s);

/// Finds all descendant elements of this document that match the specified
/// group of selectors.
///
/// Unless your webpage contains multiple documents, the top-level
/// [querySelectorAll]
/// method behaves the same as this method, so you should use it instead to
/// save typing a few characters.
///
/// [selectors] should be a string using CSS selector syntax.
///
///     var items = document.querySelectorAll('.itemClassName');
///
/// For details about CSS selector syntax, see the
/// [CSS selector specification](http://www.w3.org/TR/css3-selectors/).
ElementList<Element> querySelectorAll(String s) =>
    window.document.querySelectorAll(s);
