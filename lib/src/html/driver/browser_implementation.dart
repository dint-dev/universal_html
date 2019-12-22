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
//  * Part of library '/src/html.dart' so we have access to private fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
/// Implementation of browser functions. The instance is usually obtained via
/// [HtmlDriver.browserImplementation].
///
/// [BrowserImplementation] contains functionality such as:
///   * Class factories (e.g. [newWindow])
///   * Special event handling code (e.g. [handleFileUploadInputElementClick])
///
/// Sometimes it may not clear whether functionality should be written in
/// [HtmlDriver] or [BrowserImplementation]. The general rule is that if
/// developers may override a method, it should be in [BrowserImplementation.
class BrowserImplementation {
  final HtmlDriver htmlDriver;

  BrowserImplementation(this.htmlDriver);

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
  void handleEventDefault(EventTarget eventTarget, Event event) {
    switch (event.type) {
      case 'click':
        if (eventTarget is InputElement) {
          final type = eventTarget.type.toLowerCase();
          switch (type) {
            case 'file':
              handleFileUploadInputElementClick(eventTarget, event);
              break;

            case 'reset':
              eventTarget.form?.reset();
              break;

            case 'submit':
              final form = eventTarget.form;
              if (form != null) {
                handleFormSubmit(form, button: eventTarget);
              }
              break;

            case 'radio':
              final name = eventTarget.name;
              for (var item in eventTarget.form._items) {
                if (item is InputElement && item.name == name) {
                  item.checked = false;
                }
              }
              eventTarget.checked = true;
              break;

            case 'checkbox':
              eventTarget.checked = !eventTarget.checked;
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
  void handleFileUploadInputElementClick(
      FileUploadInputElement element, Event event) {
    throw UnimplementedError();
  }

  /// Called by [FormElement.reset].
  void handleFormReset(FormElement element) {
    element._reset();
  }

  /// Called by [FormElement.submit].
  void handleFormSubmit(FormElement element, {Element button}) {
    element._submit(button);
  }

  ApplicationCache newApplicationCache() => throw UnimplementedError();

  CanvasRenderingContext2D newCanvasRenderingContext2D(CanvasElement element) =>
      throw UnimplementedError();

  /// Constructs 'dart:html' _window.console_.
  Console newConsole() => Console._();

  /// Constructs 'dart:html' _navigator.geolocation_.
  Geolocation newGeolocation() => Geolocation._();

  /// Constructs 'dart:html' _window.history_.
  History newHistory() => History._();

  /// Constructs HTTP client used by 'dart:html' APIs that require network
  /// access.
  ///
  /// Examples of such APIs:
  ///   * [HttpClient]
  ///   * [EventSource]
  io.HttpClient newHttpClient() {
    final httpClient = io.HttpClient();
    httpClient.userAgent = htmlDriver.userAgent.string;
    return httpClient;
  }

  /// Constructs 'dart:html' _window.location_.
  Location newLocation() => Location._(htmlDriver);

  /// Constructs 'dart:html' _navigator_.
  Navigator newNavigator() => Navigator._(htmlDriver);

  /// Constructs 'dart:html' _window.console_.
  RenderData newRenderData(Element element) => RenderData();

  /// Constructs 'dart:html' _window.storage_ / _window.sessionStorage_.
  Storage newStorage({bool sessionStorage = false}) =>
      Storage._(htmlDriver.window);

  /// Constructs 'dart:html' _WebSocket_.
  WebSocket newWebSocket(String url, [Object protocols]) {
    throw UnimplementedError();
  }

  /// Constructs 'dart:html' _window_.
  Window newWindow() => Window._(htmlDriver);

  /// Called by [window.windowRequestFileSystem]. Default implementation throws
  /// [UnimplementedError].
  Future<FileSystem> windowRequestFileSystem(int size,
      {bool persistent = false}) {
    throw UnimplementedError();
  }
}
