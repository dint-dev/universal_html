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

/// Provides access to private fields of DOM classes.
class BrowserImplementationUtils {
  BrowserImplementationUtils._();

  /// Returns all descending elements.
  static Iterable<Element> descendingElements(Element root) sync* {
    for (var child in root.children) {
      yield (child);
      yield* (descendingElements(child));
    }
  }

  /// Returns data of a [Blob] (or [File]).
  static Future<Uint8List> getBlobData(Blob blob) {
    if (blob is BlobBase) {
      return blob.toBytesFuture();
    }
    throw ArgumentError.value(blob);
  }

  /// Returns [RenderData] of an element (a private field).
  static RenderData getElementRenderData(Element element) {
    return element._renderDataField;
  }

  /// Constructs [Comment], which only has a private constructor.
  static Comment newComment(Document ownerDocument, String value) {
    return Comment._(ownerDocument, value);
  }

  /// Constructs [Coordinates], which only has a private constructor.
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

  static void setInputElementValue(InputElement element, String value) {
    element._value = value;
  }

  static void setInputElementChecked(InputElement element, bool value) {
    element._checked = value;
  }

  /// Constructs [DocumentFragment], which only has a private constructor.
  static DocumentFragment newDocumentFragment(Document ownerDocument) {
    return DocumentFragment._(ownerDocument);
  }

  /// Constructs [_DocumentType], which only has a private constructor.
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

  /// Constructs [ErrorEvent], which only has a private constructor.
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

  /// Constructs [ProcessingInstruction], which only has a private constructor.
  static ProcessingInstruction newProcessingInstruction(Document ownerDocument,
      {StyleSheet sheet, String target}) {
    return ProcessingInstruction._(
      ownerDocument,
      sheet: sheet,
      target: target,
    );
  }

  /// Constructs [Text], which only has a private constructor.
  static Text newText(Document ownerDocument, String value) {
    return Text._(ownerDocument, value);
  }

  /// Constructs [UnknownComment], which only has a private constructor.
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

  /// Sets [RenderData] of an element (a private field).
  static void setElementRenderData(Element element, RenderData renderData) {
    element._renderDataField = renderData;
  }
}
