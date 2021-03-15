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

import 'package:meta/meta.dart';
import 'package:universal_html/controller.dart';
import 'package:universal_html/html.dart';

import 'window_behavior_impl_browser.dart'
    if (dart.library.html) 'window_behavior_impl_browser.dart' // Browser
    if (dart.library.io) 'window_behavior_impl_others.dart' // VM
    if (dart.library.js) 'window_behavior_impl_others.dart' as impl; // Node.JS

/// Defines behavior of the browser APIs (such as navigation events).
///
/// # Example
/// ```
/// import 'package:universal_html/parsing.dart';
///
/// Future<void> main() async {
///   final controller = WindowController();
///   await controller.openHttp(
///     method: 'GET',
///     uri: Uri.parse('https://www.ietf.org/'),
///   );
///   final document = controller.window.document;
///   // ...
/// }
/// ```
class WindowBehavior {
  /// Intercepts DOM element attribute mutations.
  @protected
  void beforeElementAttributeMutation({
    required Element element,
    required String attributeName,
    required String? oldValue,
    required String? newValue,
  }) {}

  /// Intercepts DOM text changes.
  @protected
  void beforeElementChildrenMutation({
    required Element element,
  }) {}

  /// Intercepts DOM node attachment operations.
  @protected
  void beforeNodeAttached({
    required Node node,
  }) {}

  /// Intercepts DOM node detachments operations.
  @protected
  void beforeNodeDetached({
    required Node node,
  }) {}

  /// Called by [EventTarget] when default behavior of an event should occur.
  ///
  /// In other words:
  ///   * Capturing and bubbling phases of event handling are already done when
  ///     this method is invoked.
  ///   * This method is not invoked if [Event.preventDefault] was called by
  ///     an event handler.
  ///
  /// The default implementation handles the following events:
  ///   * [InputElement] clicks
  @protected
  void handleEventDefault(EventTarget eventTarget, Event event) {
    switch (event.type) {
      case 'click':
        if (eventTarget is InputElement) {
          final type = eventTarget.type;
          if (type == null) {
            return;
          }
          switch (type.toLowerCase()) {
            case 'file':
              handleFileUploadInputElementClick(eventTarget, event);
              break;

            case 'reset':
              eventTarget.form?.reset();
              break;

            case 'radio':
              final name = eventTarget.name;
              final form = eventTarget.form!;
              final length = form.length!;
              for (var i = 0; i < length; i++) {
                final item = form.item(i);
                if (item is InputElement && item.name == name) {
                  item.checked = false;
                }
              }
              eventTarget.checked = true;
              break;

            case 'checkbox':
              eventTarget.checked = !eventTarget.checked!;
              break;

            default:
              eventTarget.focus();
              break;
          }
        }
        break;
    }
  }

  /// Called when [FileUploadInputElement] is clicked.
  @protected
  void handleFileUploadInputElementClick(
      FileUploadInputElement element, Event event) {
    throw UnimplementedError();
  }

  /// Method used for constructing new [Document] object.
  ///
  /// This method enables developers to override the default [Document]
  /// implementation.
  Document newDocument({
    required Window window,
    String contentType = 'text/html',
    bool filled = true,
  }) {
    return impl.newDocument(
      window: window,
      contentType: contentType,
      filled: filled,
    );
  }

  InternalElementData newInternalElementData({
    required Element element,
  }) {
    return InternalElementData();
  }

  /// Constructs new [Navigator] object.
  ///
  /// This method enables developers to override the default [Navigator]
  /// implementation.
  Navigator newNavigator({
    required Window window,
  }) {
    return impl.newNavigator(
      window: window,
    );
  }

  Window newWindow({
    required WindowController windowController,
  }) {
    return impl.newWindow(windowController: windowController);
  }
}
