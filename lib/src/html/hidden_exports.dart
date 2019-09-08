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
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

part of universal_html.internal;

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
abstract class BlobBase implements Blob {
  @override
  Blob slice([int start, int end, String contentType]) {
    start ??= 0;
    end ??= size;
    if (start < 0 || start > size) {
      throw ArgumentError.value(end, "start");
    }
    if (end < start || end > size) {
      throw ArgumentError.value(end, "end");
    }
    return _SlicedBlob(this, start, end);
  }

  Future<Uint8List> toBytesFuture();

  @override
  String toString() => "Blob(...)";
}

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
      case "click":
        if (eventTarget is InputElement) {
          switch (eventTarget.type.toLowerCase()) {
            case "file":
              handleFileUploadInputElementClick(eventTarget, event);
              break;

            case "reset":
              eventTarget.form?.reset();
              break;

            case "submit":
              eventTarget.form?.submit();
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
    throw UnimplementedError();
  }

  /// Called by [FormElement.submit].
  void handleFormSubmit(FormElement element) {
    throw UnimplementedError();
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

/// Provides access to private fields of DOM classes.
class BrowserImplementationUtils {
  BrowserImplementationUtils._();

  static Future<Uint8List> getBlobData(Blob blob) {
    if (blob is BlobBase) {
      return blob.toBytesFuture();
    }
    throw ArgumentError.value(blob);
  }

  static RenderData getElementRenderData(Element element) {
    return element._renderDataField;
  }

  static Comment newComment(Document ownerDocument, String value) {
    return Comment._(ownerDocument, value);
  }

  static Coordinates newCoordinates({
    num accuracy = 0.0,
    num altitude = 0.0,
    num altitudeAccuracy = 0.0,
    num heading = 0.0,
    num latitude = 0.0,
    num longitude = 0.0,
    num speed = 0.0,
  }) {
    return Coordinates._(
      accuracy: accuracy,
      altitude: altitude,
      altitudeAccuracy: altitudeAccuracy,
      heading: heading,
      latitude: latitude,
      longitude: longitude,
      speed: speed,
    );
  }

  static DocumentFragment newDocumentFragment(Document ownerDocument) {
    return DocumentFragment._(ownerDocument);
  }

  static _DocumentType newDocumentType(Document ownerDocument, String value) {
    return _DocumentType._(ownerDocument, value);
  }

  static Element newElementWithInternalTag(Document ownerDocument, String name,
      [String typeExtension]) {
    return Element.internalTag(ownerDocument, name, typeExtension);
  }

  static Element newElementWithInternalTagNS(
      Document ownerDocument, String namespaceUri, String name,
      [String typeExtension]) {
    return Element.internalTagNS(
        ownerDocument, namespaceUri, name, typeExtension);
  }

  static ErrorEvent newErrorEvent(
      {int colno, Object error, String filename, int lineno, String message}) {
    return ErrorEvent._(
      colno: colno,
      error: error,
      filename: filename,
      lineno: lineno,
      message: message,
    );
  }

  static Geoposition newGeoposition({Coordinates coords, int timestamp}) {
    return Geoposition._(coords: coords, timestamp: timestamp);
  }

  static HtmlDocument newHtmlDocument({
    @required HtmlDriver htmlDriver,
    @required String contentType,
    @required bool filled,
    String origin,
  }) {
    return HtmlDocument._(
      htmlDriver: htmlDriver,
      contentType: contentType,
      filled: filled,
      origin: origin,
    );
  }

  static ProcessingInstruction newProcessingInstruction(Document ownerDocument,
      {StyleSheet sheet, String target}) {
    return ProcessingInstruction._(
      ownerDocument,
      sheet: sheet,
      target: target,
    );
  }

  static Text newText(Document ownerDocument, String value) {
    return Text._(ownerDocument, value);
  }

  static UnknownElement newUnknownElement(
      Document ownerDocument, String namespaceUri, String tag) {
    return UnknownElement._(ownerDocument, namespaceUri, tag);
  }

  static XmlDocument newXmlDocument({
    @required HtmlDriver htmlDriver,
    String contentType = "text/xml",
    String origin,
  }) {
    return XmlDocument._(
      htmlDriver: htmlDriver,
      contentType: contentType,
      origin: origin,
    );
  }

  /// Produces string representation of DOM tree.
  static String nodeToString(Node node) {
    if (node == null) {
      return "";
    }
    final sb = StringBuffer();
    _printNode(sb, _getPrintingFlags(node), node);
    return sb.toString();
  }

  static void setElementRenderData(Element element, RenderData renderData) {
    element._renderDataField = renderData;
  }
}

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private
//    fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
abstract class FileBase extends BlobBase implements File {
  @override
  String toString() => "File(...)";

  FileBase();
}

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private
//    fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
/// Base class for [FileWriter] implementations.
abstract class FileWriterBase extends FileWriter {
  FileWriterBase() : super._();
}

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

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private
//    fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
class _SlicedBlob extends BlobBase {
  final BlobBase blob;
  final int start;
  final int end;

  _SlicedBlob(this.blob, this.start, this.end);

  @override
  int get size => end - start;

  @override
  String get type => blob.type;

  @override
  Future<Uint8List> toBytesFuture() async {
    final data = await blob.toBytesFuture();
    return Uint8List.view(data.buffer, this.start, this.end - this.start);
  }
}
