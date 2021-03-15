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

import 'package:universal_html/html.dart';

import 'internal_element_data_impl_others.dart'
    if (dart.library.html) 'internal_element_data_impl_browser.dart' as impl;

/// Internal data of [Element].
///
/// # Example
/// ```
/// import 'package:universal_html/html.dart';
///
/// void main() {
///   final element = DivElement();
///   final data = InternalElementData.of(element);
/// }
/// ```
class InternalElementData {
  Rectangle<int> client = Rectangle<int>(0, 0, 0, 0);
  Rectangle<int> offset = Rectangle<int>(0, 0, 0, 0);
  Rectangle<int> scroll = Rectangle<int>(0, 0, 0, 0);

  /// Called when non-element child is mutated.
  void beforeNonElementChildMutation() {}

  /// Returns [InternalElementData] of the element.
  ///
  /// Throws [StateError] in browsers.
  static InternalElementData of(Element element) {
    return impl.ofElement(element as impl.Element);
  }
}
