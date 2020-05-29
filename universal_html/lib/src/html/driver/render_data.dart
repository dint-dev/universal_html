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

part of universal_html.internal;

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private
//    fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
/// Contains data for layout queries.
///
/// Elements request this object from [HtmlDriver],  which can use [setAttached]
/// and [getAttached] methods for caching.
class RenderData {
  Rectangle<int> client = Rectangle<int>(0, 0, 0, 0);
  Rectangle<int> offset = Rectangle<int>(0, 0, 0, 0);
  Rectangle<int> scroll = Rectangle<int>(0, 0, 0, 0);
  void markDirty() {}

  static RenderData getAttached(Element element) {
    return element._renderDataField;
  }

  static void setAttached(Element element, RenderData data) {
    element._renderDataField = data;
  }
}
