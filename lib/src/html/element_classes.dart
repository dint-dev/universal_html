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

class AnchorElement extends HtmlElement
    with _HtmlHyperlinkElementUtils, _UrlBase, _HrefAttributeElement
    implements HtmlHyperlinkElementUtils {
  factory AnchorElement() => AnchorElement._(null);

  AnchorElement._(Document ownerDocument) : super._(ownerDocument, "A");

  String get download => _getAttribute("download");

  set download(String value) {
    _setAttribute("download", value);
  }

  String get hreflang => _getAttribute("hreflang");

  set hreflang(String value) {
    _setAttribute("hreflang", value);
  }

  String get rel => _getAttribute("rel");

  set rel(String value) {
    _setAttribute("rel", value);
  }

  String get target => _getAttribute("target");

  set target(String value) {
    _setAttribute("target", value);
  }

  String get type => _getAttribute("type");

  set type(String value) {
    _setAttribute("type", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      AnchorElement._(ownerDocument);
}

class AreaElement extends HtmlElement
    with _HtmlHyperlinkElementUtils, _UrlBase, _HrefAttributeElement
    implements HtmlHyperlinkElementUtils {
  factory AreaElement() => AreaElement._(null);

  AreaElement._(Document ownerDocument, {String nodeName = "AREA"})
      : super._(ownerDocument, nodeName);

  String get download => _getAttribute("download");

  set download(String value) {
    _setAttribute("download", value);
  }

  String get rel => _getAttribute("rel");

  set rel(String value) {
    _setAttribute("rel", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => AreaElement._(ownerDocument);
}

class AudioElement extends MediaElement {
  factory AudioElement() => AudioElement._(null);

  AudioElement._(Document ownerDocument) : super._(ownerDocument, "AUDIO");

  @override
  Element _newInstance(Document ownerDocument) => AudioElement._(ownerDocument);
}

class BaseElement extends HtmlElement {
  BaseElement() : this._(null);
  BaseElement._(Document ownerDocument) : super._(ownerDocument, "BASE");

  String get href => _getAttribute("href");
  set href(String value) {
    _setAttribute("href", value);
  }

  String get target => _getAttribute("target");
  set target(String value) {
    _setAttribute("target", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => BaseElement._(ownerDocument);
}

class BodyElement extends HtmlElement implements WindowEventHandlers {
  /// Static factory designed to expose `blur` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> blurEvent =
      EventStreamProvider<Event>('blur');

  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  /// Static factory designed to expose `focus` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> focusEvent =
      EventStreamProvider<Event>('focus');

  /// Static factory designed to expose `hashchange` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> hashChangeEvent =
      EventStreamProvider<Event>('hashchange');

  /// Static factory designed to expose `load` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> loadEvent =
      EventStreamProvider<Event>('load');

  /// Static factory designed to expose `message` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  /// Static factory designed to expose `offline` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> offlineEvent =
      EventStreamProvider<Event>('offline');

  /// Static factory designed to expose `online` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> onlineEvent =
      EventStreamProvider<Event>('online');

  /// Static factory designed to expose `popstate` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<PopStateEvent> popStateEvent =
      EventStreamProvider<PopStateEvent>('popstate');

  /// Static factory designed to expose `resize` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> resizeEvent =
      EventStreamProvider<Event>('resize');

  static const EventStreamProvider<Event> scrollEvent =
      EventStreamProvider<Event>('scroll');

  /// Static factory designed to expose `storage` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<StorageEvent> storageEvent =
      EventStreamProvider<StorageEvent>('storage');

  /// Static factory designed to expose `unload` events to event
  /// handlers that are not necessarily instances of [BodyElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> unloadEvent =
      EventStreamProvider<Event>('unload');

  factory BodyElement() => BodyElement._(null);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  BodyElement.created() : super.created();

  BodyElement._(Document ownerDocument) : super._(ownerDocument, "BODY");

  /// Stream of `blur` events handled by this [BodyElement].
  ElementStream<Event> get onBlur => blurEvent.forElement(this);

  /// Stream of `error` events handled by this [BodyElement].
  ElementStream<Event> get onError => errorEvent.forElement(this);

  /// Stream of `focus` events handled by this [BodyElement].
  ElementStream<Event> get onFocus => focusEvent.forElement(this);

  /// Stream of `hashchange` events handled by this [BodyElement].
  ElementStream<Event> get onHashChange => hashChangeEvent.forElement(this);

  /// Stream of `load` events handled by this [BodyElement].
  ElementStream<Event> get onLoad => loadEvent.forElement(this);

  /// Stream of `message` events handled by this [BodyElement].
  ElementStream<MessageEvent> get onMessage => messageEvent.forElement(this);

  /// Stream of `offline` events handled by this [BodyElement].
  ElementStream<Event> get onOffline => offlineEvent.forElement(this);

  /// Stream of `online` events handled by this [BodyElement].
  ElementStream<Event> get onOnline => onlineEvent.forElement(this);

  /// Stream of `popstate` events handled by this [BodyElement].
  ElementStream<PopStateEvent> get onPopState => popStateEvent.forElement(this);

  /// Stream of `resize` events handled by this [BodyElement].
  ElementStream<Event> get onResize => resizeEvent.forElement(this);

  ElementStream<Event> get onScroll => scrollEvent.forElement(this);

  /// Stream of `storage` events handled by this [BodyElement].
  ElementStream<StorageEvent> get onStorage => storageEvent.forElement(this);

  /// Stream of `unload` events handled by this [BodyElement].
  ElementStream<Event> get onUnload => unloadEvent.forElement(this);

  @override
  Element _newInstance(Document ownerDocument) => BodyElement._(ownerDocument);
}

class BRElement extends HtmlElement {
  factory BRElement() => BRElement._(null);

  BRElement._(Document ownerDocument) : super._(ownerDocument, "BR");

  @override
  Element _newInstance(Document ownerDocument) => BRElement._(ownerDocument);
}

class ButtonElement extends HtmlElement
    with _DisabledElement, _FormFieldElement {

  String get formAction => _getAttributeResolvedUri("formaction") ?? "";

  set formAction(String value) {
    _setAttribute("formaction", value);
  }

  String get formEnctype => _getAttribute("formenctype");

  set formEnctype(String value) {
    _setAttribute("formenctype", value);
  }

  String get formMethod => _getAttribute("formmethod");

  set formMethod(String value) {
    _setAttribute("formmethod", value);
  }

  bool formNoValidate;

  String formTarget;

  factory ButtonElement() => ButtonElement._(null);

  ButtonElement._(Document ownerDocument) : super._(ownerDocument, "BUTTON");

  bool get autofocus => _getAttributeBool("autofocus");

  set autofocus(bool value) {
    _setAttributeBool(name, value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute(name, value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ButtonElement._(ownerDocument);
}

class CanvasElement extends HtmlElement implements CanvasImageSource {
  /// Static factory designed to expose `webglcontextlost` events to event
  /// handlers that are not necessarily instances of [CanvasElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<gl.ContextEvent> webGlContextLostEvent =
      EventStreamProvider<gl.ContextEvent>('webglcontextlost');

  /// Static factory designed to expose `webglcontextrestored` events to event
  /// handlers that are not necessarily instances of [CanvasElement].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<gl.ContextEvent> webGlContextRestoredEvent =
      EventStreamProvider<gl.ContextEvent>('webglcontextrestored');

  CanvasRenderingContext2D _context2D;

  CanvasElement({int width, int height}) : super._(null, "CANVAS") {
    if (width != null) {
      _setAttributeInt("width", width);
    }
    if (height != null) {
      _setAttributeInt("height", height);
    }
  }

  CanvasElement._(Document ownerDocument) : super._(ownerDocument, "CANVAS");

  /// An API for drawing on this canvas.
  CanvasRenderingContext2D get context2D {
    return _context2D ??=
        _htmlDriver.browserImplementation.newCanvasRenderingContext2D(this);
  }

  /// The height of this canvas element in CSS pixels.
  int get height => _getAttributeInt("height");

  set height(int value) {
    _setAttributeInt("height", value);
  }

  /// Stream of `webglcontextlost` events handled by this [CanvasElement].
  ElementStream<gl.ContextEvent> get onWebGlContextLost =>
      webGlContextLostEvent.forElement(this);

  /// Stream of `webglcontextrestored` events handled by this [CanvasElement].
  ElementStream<gl.ContextEvent> get onWebGlContextRestored =>
      webGlContextRestoredEvent.forElement(this);

  /// The width of this canvas element in CSS pixels.
  int get width => _getAttributeInt("width");

  set width(int value) {
    _setAttributeInt("width", value);
  }

  MediaStream captureStream([num frameRate]) {
    throw UnimplementedError();
  }

  Object getContext(String contextId, [Map attributes]) {
    throw UnimplementedError();
  }

  /// Returns a new Web GL context for this canvas.
  ///
  /// ## Other resources
  ///
  /// * [WebGL fundamentals](http://www.html5rocks.com/en/tutorials/webgl/webgl_fundamentals/)
  ///   from HTML5Rocks.
  /// * [WebGL homepage](http://get.webgl.org/).
  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.FIREFOX)
  gl.RenderingContext getContext3d(
      {alpha = true,
      depth = true,
      stencil = false,
      antialias = true,
      premultipliedAlpha = true,
      preserveDrawingBuffer = false}) {
    var options = {
      'alpha': alpha,
      'depth': depth,
      'stencil': stencil,
      'antialias': antialias,
      'premultipliedAlpha': premultipliedAlpha,
      'preserveDrawingBuffer': preserveDrawingBuffer,
    };
    var context = getContext('webgl', options);
    if (context == null) {
      context = getContext('experimental-webgl', options);
    }
    return context;
  }

  Future<Blob> toBlob(String type, [Object arguments]) {
    throw UnimplementedError();
  }

  /// Returns a data URI containing a representation of the image in the
  /// format specified by type (defaults to 'image/png').
  ///
  /// Data Uri format is as follow
  /// `data:[<MIME-type>][;charset=<encoding>][;base64],<data>`
  ///
  /// Optional parameter [quality] in the range of 0.0 and 1.0 can be used when
  /// requesting [type] 'image/jpeg' or 'image/webp'. If [quality] is not passed
  /// the default value is used. Note: the default value varies by browser.
  ///
  /// If the height or width of this canvas element is 0, then 'data:' is
  /// returned, representing no data.
  ///
  /// If the type requested is not 'image/png', and the returned value is
  /// 'data:image/png', then the requested type is not supported.
  ///
  /// Example usage:
  ///
  ///     CanvasElement canvas = new CanvasElement();
  ///     var ctx = canvas.context2D
  ///     ..fillStyle = "rgb(200,0,0)"
  ///     ..fillRect(10, 10, 55, 50);
  ///     var dataUrl = canvas.toDataUrl("image/jpeg", 0.95);
  ///     // The Data Uri would look similar to
  ///     // 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUA
  ///     // AAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO
  ///     // 9TXL0Y4OHwAAAABJRU5ErkJggg=='
  ///     //Create a new image element from the data URI.
  ///     var img = new ImageElement();
  ///     img.src = dataUrl;
  ///     document.body.children.add(img);
  ///
  /// See also:
  ///
  /// * [Data URI Scheme](http://en.wikipedia.org/wiki/Data_URI_scheme) from Wikipedia.
  ///
  /// * [HTMLCanvasElement](https://developer.mozilla.org/en-US/docs/DOM/HTMLCanvasElement) from MDN.
  ///
  /// * [toDataUrl](http://dev.w3.org/html5/spec/the-canvas-element.html#dom-canvas-todataurl) from W3C.
  String toDataUrl([String type = 'image/png', num quality]) {
    throw UnimplementedError();
  }

  OffscreenCanvas transferControlToOffscreen() {
    throw UnimplementedError();
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      CanvasElement._(ownerDocument);
}

class ContentElement extends HtmlElement {
  static bool get supported => false;

  String select;

  factory ContentElement() => ContentElement._(null);

  ContentElement._(Document ownerDocument) : super._(ownerDocument, "CONTENTN");

  List<Node> getDistributedNodes() {
    throw UnimplementedError();
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ContentElement._(ownerDocument);
}

class DataElement extends HtmlElement {
  DataElement._(Document ownerDocument) : super._(ownerDocument, "DATA");

  @override
  Element _newInstance(Document ownerDocument) => DataElement._(ownerDocument);
}

class DataListElement extends HtmlElement {
  static bool get supported => true;

  factory DataListElement() => DataListElement._(null);

  DataListElement._(Document ownerDocument)
      : super._(ownerDocument, "DATALIST");

  @override
  Element _newInstance(Document ownerDocument) =>
      DataListElement._(ownerDocument);
}

class DetailsElement extends HtmlElement {
  static bool get supported => true;

  factory DetailsElement() => DetailsElement._(null);

  DetailsElement._(Document ownerDocument) : super._(ownerDocument, "DETAILS");

  @override
  Element _newInstance(Document ownerDocument) =>
      DetailsElement._(ownerDocument);
}

class DialogElement extends HtmlElement {
  bool open;

  String returnValue;

  DialogElement._(Document ownerDocument) : super._(ownerDocument, "DIALOG");

  void close([String returnValue]) {
    // Ignore
  }

  void show() {
    // Ignore
  }

  void showModal() {
    // Ignore
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      DialogElement._(ownerDocument);
}

class DivElement extends HtmlElement {
  factory DivElement() => DivElement._(null);

  DivElement._(Document ownerDocument) : super._(ownerDocument, "DIV");

  @override
  Element _newInstance(Document ownerDocument) => DivElement._(ownerDocument);
}

class DListElement extends HtmlElement {
  factory DListElement() => DListElement._(null);

  DListElement._(Document ownerDocument) : super._(ownerDocument, "DL");

  @override
  Element _newInstance(Document ownerDocument) => DListElement._(ownerDocument);
}

class DomTokenList {
  DomTokenList._();

  void add(String tokens) {
    throw UnimplementedError();
  }

  bool contains(String token) {
    throw UnimplementedError();
  }

  String item(int index) {
    throw UnimplementedError();
  }

  void remove(String tokens) {
    throw UnimplementedError();
  }

  void replace(String token, String newToken) {
    throw UnimplementedError();
  }

  bool supports(String token) {
    throw UnimplementedError();
  }

  bool toggle(String token, [bool force]) {
    throw UnimplementedError();
  }
}

class EmbedElement extends HtmlElement {
  static bool get supported => true;

  factory EmbedElement() => EmbedElement._(null);

  EmbedElement._(Document ownerDocument) : super._(ownerDocument, "EMBED");

  @override
  Element _newInstance(Document ownerDocument) => EmbedElement._(ownerDocument);
}

class FieldSetElement extends HtmlElement with _FormFieldElement {
  factory FieldSetElement() => FieldSetElement._(null);

  FieldSetElement._(Document ownerDocument)
      : super._(ownerDocument, "FIELDSET");

  @override
  Element _newInstance(Document ownerDocument) =>
      FieldSetElement._(ownerDocument);
}

class FormElement extends HtmlElement {
  factory FormElement() => FormElement._(null);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  FormElement.created() : super.created();

  FormElement._(Document ownerDocument) : super._(ownerDocument, "FORM");

  String get acceptCharset => _getAttribute("acceptcharset");

  set acceptCharset(String value) {
    _setAttribute("acceptcharset", value);
  }

  String get action => _getAttributeResolvedUri("action") ?? "";

  set action(String value) {
    _setAttribute("action", value);
  }

  String get autocomplete => _getAttribute("autocomplete");

  set autocomplete(String value) {
    _setAttribute("autocomplete", value);
  }

  String get encoding => _getAttribute("encoding");

  set encoding(String value) {
    _setAttribute("encoding", value);
  }

  String get enctype => _getAttribute("enctype");

  set enctype(String value) {
    _setAttribute("enctype", value);
  }

  int get length => _items.length;

  String get method => _getAttribute("method");

  set method(String value) {
    _setAttribute("method", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  bool get noValidate => _getAttributeBool("novalidate");

  set noValidate(bool value) {
    _setAttributeBool("novalidate", value);
  }

  String get target => _getAttribute("target");

  set target(String value) {
    _setAttribute("target", value);
  }

  Iterable<Element> get _items sync* {
    for (var element in BrowserImplementationUtils.descendingElements(this)) {
      if (element is InputElement && identical(element.form, this)) {
        yield (element);
      }
    }
  }

  bool checkValidity() {
    return true;
  }

  Element item(int index) {
    return _items.skip(index).first;
  }

  bool reportValidity() {
    return true;
  }

  void requestAutocomplete(Map details) {}

  /// Resets the form.
  ///
  /// No event is dispatched.
  void reset() {
    this._htmlDriver.browserImplementation.handleFormReset(this);
  }

  /// Resets the form.
  ///
  /// No event is dispatched.
  void submit() {
    this._htmlDriver.browserImplementation.handleFormSubmit(this);
  }

  /// Gets the URL where the form should be sent.
  String _getFormAction(Element button) {
    String action;
    if (button is ButtonElement) {
      action = button.formAction;
    } else if (button is InputElement) {
      action = button.formAction;
    }
    if (action == null || action.isEmpty) {
      action = this.action;
    }

    return action;
  }

  @override
  Element _newInstance(Document ownerDocument) => FormElement._(ownerDocument);

  void _reset() {
    for (var element in _items) {
      if (element is InputElement) {
        element._reset();
      }
    }
  }

  /// Sends values in 'multipart/form-data' format.
  Future<void> _sendMultiPart(
    Uri uri,
  ) async {
    final httpClient = _htmlDriver.browserImplementation.newHttpClient();
    final httpRequest = await httpClient.openUrl(method, uri);

    final writer = MultipartFormWriter(httpRequest);

    httpRequest.headers.contentType = io.ContentType(
      "multipart",
      "form-data",
      parameters: {
        "boundary": writer.boundary,
      },
    );

    for (var item in this._items) {
      _sendMultiPartElement(writer, item);
    }

    // Load response page
    await _htmlDriver.setDocumentFromHttpClientRequest(httpRequest);
  }

  /// Sends an element in 'multipart/form-data' format.
  /// Called by [_sendMultiPart].
  void _sendMultiPartElement(
      MultipartFormWriter writer, Element element) async {
    if (element is InputElement) {
      final name = element.name;
      if (name.isEmpty) {
        return;
      }
      final value = element.value;
      switch (element.type.toLowerCase()) {
        case "button":
          break;

        case "reset":
          break;

        case "submit":
          break;

        case "file":
          for (var file in element.files ?? []) {
            writer.writeFile(name, file, fileName: file.name);
          }
          break;

        case "checkbox":
          if (element.checked) {
            writer.writeFieldValue(name, value);
          }
          break;

        case "radio":
          if (element.checked) {
            writer.writeFieldValue(name, value);
          }
          break;

        default:
          writer.writeFieldValue(name, value);
          break;
      }
    }
  }

  /// Sends values in 'application/x-www-form-urlencoded' format.
  Future<void> _sendUrlEncoded(
    String method,
    Uri uri,
  ) async {
    switch (method) {
      case "get":
        uri = uri.replace(
          queryParameters: _valuesToQueryParameters(uri.queryParameters),
        );
        final httpClient = _htmlDriver.browserImplementation.newHttpClient();
        final httpRequest = await httpClient.openUrl(method, uri);
        await _htmlDriver.setDocumentFromHttpClientRequest(httpRequest);
        break;

      case "post":
        final httpClient = _htmlDriver.browserImplementation.newHttpClient();
        final httpRequest = await httpClient.openUrl(method, uri);
        httpRequest.headers.contentType = io.ContentType(
          "application",
          "x-www-form-urlencoded",
        );
        final tmpUri = Uri(queryParameters: _valuesToQueryParameters());
        final s = tmpUri.toString().substring(1);
        httpRequest.write(s);
        await _htmlDriver.setDocumentFromHttpClientRequest(httpRequest);
        break;

      default:
        throw StateError("Unsupported HTTP method: '$method'");
    }
  }

  /// Submits the form.
  Future<void> _submit(Element buttonElement) async {
    // Get method
    var method = this.method.toLowerCase();
    if (method == "") {
      method = "get";
    }

    // Get URI
    var uriString = _getFormAction(buttonElement);
    if (uriString.isEmpty) {
      uriString = this.baseUri;
    }
    final uri = Uri.parse(uriString);
    switch (uri.scheme) {
      case "http":
        break;
      case "https":
        break;
      default:
        return;
    }

    // Open HTTP request
    final encType = enctype?.toLowerCase();
    switch (encType ?? "") {
      case "":
        await _sendUrlEncoded(method, uri);
        break;

      case "multipart/form-data":
        await _sendMultiPart(uri);
        break;

      case "application/x-www-form-urlencoded":
        await _sendUrlEncoded(method, uri);
        break;

      default:
        throw StateError("Unsupported encoding type: '$encType'");
    }
  }

  /// Builds a map that contains all field values.
  Map<String, dynamic> _valuesToQueryParameters([Map<String, dynamic> args]) {
    final result = <String, dynamic>{};
    if (args != null) {
      result.addAll(args);
    }
    elementLoop:
    for (var element in this._items) {
      if (element is InputElement) {
        // Ignore empty keys
        final name = element.name;
        if (name.isEmpty) {
          continue;
        }
        final value = element.value;

        switch (element.type.toLowerCase()) {
          case "button":
            continue elementLoop;

          case "submit":
            continue elementLoop;

          case "reset":
            continue elementLoop;

          case "file":
            continue elementLoop;

          case "radio":
            if (!element.checked) {
              continue elementLoop;
            }
            break;

          case "checkbox":
            if (!element.checked) {
              continue elementLoop;
            }
            break;

          default:
            break;
        }
        var existing = result[name];
        if (existing == null) {
          result[name] = value;
        } else if (existing is String) {
          result[name] = <String>[existing, value];
        } else {
          (existing as List<String>).add(value);
        }
      }
    }
    return result;
  }
}

class HeadElement extends HtmlElement {
  factory HeadElement() => HeadElement._(null);

  HeadElement._(Document ownerDocument) : super._(ownerDocument, "HEAD");

  @override
  Element _newInstance(Document ownerDocument) => HeadElement._(ownerDocument);
}

class HeadingElement extends HtmlElement {
  factory HeadingElement.h1() => HeadingElement._(null, "H1");

  factory HeadingElement.h2() => HeadingElement._(null, "H2");

  factory HeadingElement.h3() => HeadingElement._(null, "H3");

  factory HeadingElement.h4() => HeadingElement._(null, "H4");

  factory HeadingElement.h5() => HeadingElement._(null, "H5");

  factory HeadingElement.h6() => HeadingElement._(null, "H6");

  HeadingElement._(Document ownerDocument, String name)
      : super._(ownerDocument, name);

  @override
  Element _newInstance(Document ownerDocument) =>
      HeadingElement._(ownerDocument, _lowerCaseTagName);
}

class HRElement extends HtmlElement {
  factory HRElement() => HRElement._(null);

  HRElement._(Document ownerDocument) : super._(ownerDocument, "HR");

  @override
  Element _newInstance(Document ownerDocument) => HRElement._(ownerDocument);
}

abstract class HtmlElement extends Element implements NoncedElement {
  factory HtmlElement() {
    throw UnimplementedError();
  }

  HtmlElement.created() : super.created();

  HtmlElement._(Document ownerDocument, String tagName)
      : super._(ownerDocument, tagName);

  String get nonce => _getAttribute("nonce");

  set nonce(String value) {
    _setAttribute("nonce", value);
  }
}

class HtmlHtmlElement extends HtmlElement {
  factory HtmlHtmlElement() => HtmlHtmlElement._(null);

  HtmlHtmlElement._(Document ownerDocument) : super._(ownerDocument, "HTML");

  @override
  Element _newInstance(Document ownerDocument) =>
      HtmlHtmlElement._(ownerDocument);
}

abstract class HtmlHyperlinkElementUtils implements _UrlBase {
  String href;
  HtmlHyperlinkElementUtils._();
  String get password;
  String get username;
}

class IFrameElement extends HtmlElement {
  factory IFrameElement() => IFrameElement._(null);

  IFrameElement._(Document ownerDocument) : super._(ownerDocument, "IFRAME");

  String get allow => _getAttribute("allow");

  set allow(String value) {
    _setAttribute("allow", value);
  }

  bool get allowFullscreen => _getAttributeBool("allowfullscreen");

  set allowFullscreen(bool value) {
    _setAttributeBool("allowfullscreen", value);
  }

  bool get allowPaymentRequest => _getAttributeBool("allowpaymentrequest");

  set allowPaymentRequest(bool value) {
    _setAttributeBool("allowpaymentrequest", value);
  }

  WindowBase get contentWindow => null;

  String get csp => _getAttribute("csp");

  set csp(String value) {
    _setAttribute("csp", value);
  }

  String get height => _getAttribute("height");

  set height(String value) {
    _setAttribute("height", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  set referrerPolicy(String value) {
    _setAttribute("referrerpolicy", value);
  }

  DomTokenList get sandbox {
    throw UnimplementedError();
  }

  String get src => _getAttributeResolvedUri("src") ?? "";

  set src(String value) {
    _setAttribute("src", value);
  }

  String get srcdoc => _getAttribute("srcdoc");

  set srcdoc(String value) {
    _setAttribute("srcdoc", value);
  }

  String get width => _getAttribute("width");

  set width(String value) {
    _setAttribute("width", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      IFrameElement._(ownerDocument);
}

class ImageElement extends HtmlElement implements CanvasImageSource {
  factory ImageElement() => ImageElement._(null);

  ImageElement._(Document ownerDocument) : super._(ownerDocument, "IMG");

  String get alt => _getAttribute("alt");

  set alt(String value) {
    _setAttribute("alt", value);
  }

  bool get async => _getAttributeBool("async");

  set async(bool value) {
    _setAttributeBool("async", value);
  }

  bool get complete => false;

  String get crossOrigin => _getAttribute("crossorigin");

  set crossOrigin(String value) {
    _setAttribute("crossorigin", value);
  }

  String get currentSrc => null;

  int get height => _getAttributeInt("height") ?? 0;

  set height(int value) {
    _setAttributeInt("height", value);
  }

  bool get isMap => _getAttributeBool("ismap");

  set isMap(bool value) {
    _setAttributeBool("ismap", value);
  }

  int get naturalHeight => null;

  int get naturalWidth => null;

  String get referrerPolicy => _getAttribute("referrerpolicy");

  set referrerPolicy(String value) {
    _setAttribute("referrerpolicy", value);
  }

  String get sizes => _getAttribute("sizes");

  set sizes(String value) {
    _setAttribute("sizes", value);
  }

  String get src {
    return _getAttributeResolvedUri("src") ?? "";
  }

  set src(String value) {
    _setAttribute("src", value);
  }

  String get srcset => _getAttribute("srcset");

  set srcset(String value) {
    _setAttribute("srcset", value);
  }

  String get useMap => _getAttribute("usemap");

  set useMap(String value) {
    _setAttribute("usemap", value);
  }

  int get width => _getAttributeInt("width") ?? 0;

  set width(int value) {
    _setAttributeInt("width", value);
  }

  Future decode() => throw UnimplementedError();

  @override
  Element _newInstance(Document ownerDocument) => ImageElement._(ownerDocument);
}

class InputElement extends HtmlElement
    with _DisabledElement, _FormFieldElement, _LabelsElement
    implements
        HiddenInputElement,
        SearchInputElement,
        TextInputElement,
        UrlInputElement,
        TelephoneInputElement,
        EmailInputElement,
        PasswordInputElement,
        DateInputElement,
        MonthInputElement,
        WeekInputElement,
        TimeInputElement,
        LocalDateTimeInputElement,
        NumberInputElement,
        RangeInputElement,
        CheckboxInputElement,
        RadioButtonInputElement,
        FileUploadInputElement,
        SubmitButtonInputElement,
        ImageButtonInputElement,
        ResetButtonInputElement,
        ButtonInputElement {
  static final _typesNotValidated = {"hidden", "reset", "button"};

  /// Current value. This is different from attribute "value", which can be
  /// accessed with [defaultValue].
  String _value;

  /// Current checked value. This is different from attribute "checked", which
  /// can be accessed with [defaultChecked].
  bool _checked;

  /// Prevously compiled pattern.
  RegExp _lastRegExp;

  bool directory;

  @override
  String selectionDirection;

  @override
  int selectionStart;

  @override
  int selectionEnd;

  List<File> _files;

  factory InputElement({String type}) {
    InputElement e = InputElement._(null);
    if (type != null) {
      e.type = type;
    }
    return e;
  }

  InputElement._(Document ownerDocument) : super._(ownerDocument, "INPUT");

  @override
  String get accept => _getAttribute("accept");

  @override
  set accept(String value) {
    _setAttribute("accept", value);
  }

  @override
  String get alt => _getAttribute("alt");

  @override
  set alt(String value) {
    _setAttribute("alt", value);
  }

  String get autocapitalize => _getAttribute("autocapitalize");

  set autocapitalize(String value) {
    _setAttribute("autocapitalize", value);
  }

  @override
  String get autocomplete => _getAttribute("autocomplete");

  @override
  set autocomplete(String value) {
    _setAttribute("autocomplete", value);
  }

  @override
  bool get autofocus => _getAttributeBool("autofocus");

  @override
  set autofocus(bool value) {
    _setAttributeBool("autofocus", value);
  }

  String get capture => _getAttribute("capture");

  set capture(String value) {
    _setAttribute("capture", value);
  }

  @override
  bool get checked => _checked ?? defaultChecked;

  @override
  set checked(bool value) {
    if (value != _checked) {
      _markDirty();
      this._checked = value;
    }
  }

  bool get defaultChecked => _getAttributeBool("checked");

  set defaultChecked(bool value) {
    _setAttributeBool("checked", value);
  }

  String get defaultValue => _getAttribute("value");

  set defaultValue(String value) {
    _setAttribute("value", value);
  }

  String get dirName => _getAttribute("dirname");

  set dirName(String value) {
    _setAttribute("dirname", value);
  }

  @override
  set disabled(bool value) {
    _setAttributeBool("disabled", value);
  }

  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.SAFARI)
  List<Entry> get entries => const <Entry>[];

  @override
  List<File> get files => _files;

  @override
  set files(List<File> value) {
    _markDirty();
    this._files = value;
  }

  String get formAction => _getAttributeResolvedUri("formaction") ?? "";

  set formAction(String value) {
    _setAttribute("formaction", value);
  }

  String get formEnctype => _getAttribute("formenctype");

  set formEnctype(String value) {
    _setAttribute("formenctype", value);
  }

  String get formMethod => _getAttribute("formmethod");

  set formMethod(String value) {
    _setAttribute("formmethod", value);
  }

  bool get formNoValidate => _getAttributeBool("formnovalidate");

  set formNoValidate(bool value) {
    _setAttributeBool("formnovalidate", value);
  }

  String get formTarget => _getAttribute("formtarget");

  set formTarget(String value) {
    _setAttribute("formtarget", value);
  }

  @override
  int get height => _getAttributeInt("height");

  @override
  set height(int value) {
    _setAttributeInt("height", value);
  }

  @override
  bool get incremental => _getAttributeBool("incremental");

  @override
  set incremental(bool value) {
    _setAttributeBool("incremental", value);
  }

  @override
  bool get indeterminate => _getAttributeBool("indeterminate");

  @override
  set indeterminate(bool value) {
    _setAttributeBool("indeterminate", value);
  }

  @override
  Element get list => null;

  @override
  String get max => _getAttribute("max");

  @override
  set max(String value) {
    _setAttribute("max", value);
  }

  @override
  int get maxLength => _getAttributeInt("maxlength");

  @override
  set maxLength(int value) {
    _setAttributeInt("maxlength", value);
  }

  @override
  String get min => _getAttribute("min");

  @override
  set min(String value) {
    _setAttribute("min", value);
  }

  int get minLength => _getAttributeInt("minlength");

  set minLength(int value) {
    _setAttributeInt("minlength", value);
  }

  @override
  bool get multiple => _getAttributeBool("multiple");

  @override
  set multiple(bool value) {
    _setAttributeBool("multiple", value);
  }

  @override
  String get name => _getAttribute("name");

  @override
  set name(String value) {
    _setAttribute("name", value);
  }

  @override
  String get pattern => _getAttribute("pattern");

  @override
  set pattern(String value) {
    _setAttribute("pattern", value);
  }

  @override
  String get placeholder => _getAttribute("placeholder");

  @override
  set placeholder(String value) {
    _setAttribute("placeholder", value);
  }

  @override
  bool get readOnly => _getAttributeBool("readonly");

  @override
  set readOnly(bool value) {
    _setAttributeBool("readonly", value);
  }

  @override
  bool get required => _getAttributeBool("required");

  @override
  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  int get size => _getAttributeInt("size");

  @override
  set size(int value) {
    _setAttributeInt("size", value);
  }

  @override
  String get src => _getAttribute("src");

  @override
  set src(String value) {
    _setAttribute("src", value);
  }

  @override
  String get step => _getAttribute("step");

  @override
  set step(String value) {
    _setAttribute("step", value);
  }

  String get type => _getAttribute("type", defaultValue: "text");

  set type(String value) {
    _setAttribute("type", value);
  }

  @override
  String get validationMessage {
    return null;
  }

  ValidityState get validity {
    return ValidityState._();
  }

  @override
  String get value => _value ?? "";

  @override
  set value(String value) {
    if (value != _value) {
      _markDirty();
      this._value = value;
    }
  }

  @override
  DateTime get valueAsDate {
    return DateTime.parse(value);
  }

  @override
  set valueAsDate(DateTime value) {
    this.value = value.toIso8601String();
  }

  @override
  num get valueAsNumber {
    final value = this.value;
    return value == null ? null : num.parse(value);
  }

  @override
  set valueAsNumber(num value) {
    this.value = value?.toString();
  }

  @override
  int get width => _getAttributeInt("width");

  @override
  set width(int value) {
    _setAttributeInt("width", value);
  }

  @override
  bool get willValidate {
    return !(_ancestors.any((e) => e is DataListElement) ||
        _typesNotValidated.contains(type.toString()) ||
        disabled);
  }

  /// Gets regular expression.
  RegExp get _regExp {
    final pattern = this.pattern;
    if (pattern == null) {
      return null;
    }
    final lastRegExp = this._lastRegExp;
    if (lastRegExp != null && pattern == lastRegExp.pattern) {
      return lastRegExp;
    }
    final regExp = RegExp(pattern);
    _lastRegExp = regExp;
    return regExp;
  }

  @override
  bool checkValidity() {
    switch (type) {
      case "text":
        return _checkTextValidity(value);
      default:
        return true;
    }
  }

  bool reportValidity() {
    return checkValidity();
  }

  void select() {}

  void setCustomValidity(String error) {}

  void setRangeText(String replacement,
      {int start, int end, String selectionMode}) {}

  void setSelectionRange(int start, int end, [String direction]) {}

  void stepDown([int n]) {
    valueAsNumber -= n;
  }

  void stepUp([int n]) {
    valueAsNumber += n;
  }

  bool _checkTextValidity(String value) {
    // Required?
    if (value == null) return !required;

    // Minimum length
    {
      final minLength = this.minLength;
      if (minLength is int && value.length < minLength) {
        return false;
      }
    }

    // Maximum length
    {
      final maxLength = this.maxLength;
      if (maxLength is int && value.length > maxLength) {
        return false;
      }
    }

    // Regular expression
    {
      final regExp = this._regExp;
      if (regExp != null && !regExp.hasMatch(value)) {
        return false;
      }
    }
    return true;
  }

  @override
  Element _newInstance(Document ownerDocument) => InputElement._(ownerDocument);

  /// Resets values.
  void _reset() {
    _value = null;
    _checked = null;
    files = null;
  }
}

class LabelElement extends HtmlElement with _FormFieldElement {
  factory LabelElement() => LabelElement._(null);

  LabelElement._(Document ownerDocument) : super._(ownerDocument, "LABEL");

  String get htmlFor => _getAttribute("for");

  set htmlFor(String value) {
    _setAttribute("for", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => LabelElement._(ownerDocument);
}

class LegendElement extends HtmlElement with _FormFieldElement {
  factory LegendElement() => LegendElement._(null);

  LegendElement._(Document ownerDocument) : super._(ownerDocument, "LEGEND");

  @override
  Element _newInstance(Document ownerDocument) =>
      LegendElement._(ownerDocument);
}

class LIElement extends HtmlElement {
  factory LIElement() => LIElement._(null);

  LIElement._(Document ownerDocument) : super._(ownerDocument, "LI");

  @override
  Element _newInstance(Document ownerDocument) => LIElement._(ownerDocument);
}

class LinkElement extends HtmlElement
    with _HrefAttributeElement, _DisabledElement {
  factory LinkElement() => LinkElement._(null);

  LinkElement._(Document ownerDocument) : super._(ownerDocument, "LINK");

  String get as => _getAttribute("as");

  set as(String value) {
    _setAttribute("as", value);
  }

  String get crossOrigin => _getAttribute("crossorigin");

  set crossOrigin(String value) {
    _setAttribute("crossorigin", value);
  }

  String get integrity => _getAttribute("integrity");

  set integrity(String value) {
    _setAttribute("integrity", value);
  }

  String get media => _getAttribute("media");

  set media(String value) {
    _setAttribute("media", value);
  }

  String get rel => _getAttribute("rel");

  set rel(String value) {
    _setAttribute("rel", value);
  }

  String get type => _getAttribute("type");

  set type(String value) {
    _setAttribute("type", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => LinkElement._(ownerDocument);
}

class MapElement extends HtmlElement {
  factory MapElement() => MapElement._(null);

  MapElement._(Document ownerDocument) : super._(ownerDocument, "MAP");

  @override
  Element _newInstance(Document ownerDocument) => MapElement._(ownerDocument);
}

abstract class MediaElement extends HtmlElement {
  bool _muted;

  MediaElement._(Document ownerDocument, String tag)
      : super._(ownerDocument, tag);

  bool get autoplay => _getAttributeBool("autoplay");

  set autoplay(bool value) {
    _setAttributeBool("autoplay", value);
  }

  String get crossOrigin => _getAttribute("crossorigin");

  set crossOrigin(String value) {
    _setAttribute("crossorigin", value);
  }

  bool get defaultMuted => _getAttributeBool("muted");

  set defaultMuted(bool value) {
    _setAttributeBool("muted", value);
  }

  bool get loop => _getAttributeBool("loop");

  set loop(bool value) {
    _setAttributeBool("loop", value);
  }

  bool get muted => _muted ?? false;

  set muted(bool value) {
    this._muted = value;
  }

  String get preload => _getAttribute("preload");

  set preload(String value) {
    _setAttribute("preload", value);
  }

  String get src => _getAttributeResolvedUri("src") ?? "";

  set src(String value) {
    _setAttribute("src", value);
  }

  String get srcObject {
    throw UnimplementedError();
  }

  set srcObject(Object value) {
    throw UnimplementedError();
  }

  String get volume => _getAttribute("volume");

  set volume(String value) {
    _setAttribute("volume", value);
  }

  TextTrack addTextTrack(String kind, [String label, String language]) {
    throw UnimplementedError();
  }

  String canPlayType(String type, [String keySystem]) {
    throw UnimplementedError();
  }

  MediaStream captureStream() {
    throw UnimplementedError();
  }

  void load() {}

  void pause() {}

  Future play() {
    throw UnimplementedError();
  }

  Future setMediaKeys(MediaKeys mediaKeys) {
    throw UnimplementedError();
  }

  Future setSinkId(String sinkId) {
    throw UnimplementedError();
  }
}

class MenuElement extends HtmlElement {
  factory MenuElement() => MenuElement._(null);

  MenuElement._(Document ownerDocument) : super._(ownerDocument, "MENU");

  @override
  Element _newInstance(Document ownerDocument) => MenuElement._(ownerDocument);
}

class MetaElement extends HtmlElement {
  factory MetaElement() => MetaElement._(null);

  MetaElement._(Document ownerDocument) : super._(ownerDocument, "META");

  String get content => _getAttribute("content");

  set content(String value) {
    _setAttribute("content", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => MetaElement._(ownerDocument);
}

class MeterElement extends HtmlElement {
  /// Checks if this type is supported on the current platform.
  static bool get supported => Element.isTagSupported('meter');

  factory MeterElement() => document.createElement("meter");

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  MeterElement.created() : super.created();

  MeterElement._(Document ownerDocument) : super._(ownerDocument, "METER");

  num get high => _getAttributeNum("high");

  set high(num value) {
    _setAttributeNum("high", value);
  }

  List<Node> get labels => <Node>[];

  num get low => _getAttributeNum("low");

  set low(num value) {
    _setAttributeNum("low", value);
  }

  num get max => _getAttributeNum("max");

  set max(num value) {
    _setAttributeNum("max", value);
  }

  num get min => _getAttributeNum("min");

  set min(num value) {
    _setAttributeNum("min", value);
  }

  num get optimum => _getAttributeNum("optimum");

  set optimum(num value) {
    _setAttributeNum("optimum", value);
  }

  num get value => _getAttributeNum("value");

  set value(num value) {
    _setAttributeNum("value", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => MeterElement._(ownerDocument);
}

class ModElement extends HtmlElement {
  ModElement._(Document ownerDocument) : super._(ownerDocument, "MOD");

  @override
  Element _newInstance(Document ownerDocument) => ModElement._(ownerDocument);
}

class NoncedElement {
  String nonce;

  factory NoncedElement._() {
    throw UnimplementedError();
  }
}

class ObjectElement extends HtmlElement with _FormFieldElement {
  static bool get supported => true;

  factory ObjectElement() => ObjectElement._(null);

  ObjectElement._(Document ownerDocument) : super._(ownerDocument, "OBJECT");

  @override
  Element _newInstance(Document ownerDocument) =>
      ObjectElement._(ownerDocument);
}

class OListElement extends HtmlElement {
  factory OListElement() => OListElement._(null);

  OListElement._(Document ownerDocument) : super._(ownerDocument, "OL");

  @override
  Element _newInstance(Document ownerDocument) => OListElement._(ownerDocument);
}

class OptGroupElement extends HtmlElement {
  factory OptGroupElement() => OptGroupElement._(null);

  OptGroupElement._(Document ownerDocument)
      : super._(ownerDocument, "OPTGROUP");

  @override
  Element _newInstance(Document ownerDocument) =>
      OptGroupElement._(ownerDocument);
}

class OptionElement extends HtmlElement
    with _DisabledElement, _FormFieldElement {
  String label;

  bool _selected;

  OptionElement({String data = '', String value = '', bool selected = false})
      : super._(null, "option") {
    if (data.isNotEmpty) {
      appendText(data);
    }
    if (value.isNotEmpty) {
      this.value = value;
    }
    if (selected) {
      this.selected = selected;
    }
  }

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  OptionElement.created() : super.created();

  OptionElement._(Document ownerDocument, {String nodeName = "OPTION"})
      : super._(ownerDocument, nodeName);

  bool get defaultSelected => _getAttributeBool("selected");

  set defaultSelected(bool value) {
    _setAttributeBool("selected", value);
  }

  int get index {
    final selectElement = this._selectElement;
    if (selectElement == null) {
      return null;
    }
    final siblings = selectElement.options;
    var i = 0;
    for (var sibling in siblings) {
      if (sibling is OptionElement) {
        if (identical(sibling, this)) {
          return i;
        }
        i++;
      }
    }
    return null;
  }

  bool get selected => _selected ?? defaultSelected;

  set selected(bool value) {
    final selectElement = this._selectElement;
    if (selectElement == null) {
      return null;
    }
    this._selected = value;
    if (selectElement.multiple == false) {
      for (var option in selectElement.options) {
        option._selected = identical(option, this);
      }
    }
  }

  String get value => _getAttribute("value");

  set value(String value) {
    _setAttribute("value", value);
  }

  SelectElement get _selectElement {
    var parent = this.parent;
    if (parent is SelectElement) {
      return parent;
    }
    if (parent is OptGroupElement) {
      final grandParent = parent.parent;
      if (grandParent is SelectElement) {
        return grandParent;
      }
    }
    return null;
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      OptionElement._(ownerDocument);
}

class OutputElement extends HtmlElement with _FormFieldElement {
  static bool get supported => true;

  factory OutputElement() => OutputElement._(null);

  OutputElement._(Document ownerDocument) : super._(ownerDocument, "OUTPUT");

  String get defaultValue => _getAttribute("value");

  set defaultValue(String value) {
    _setAttribute("value", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  String get type => _getAttribute("type");

  String get value => _getAttribute("value");

  set value(String value) {
    _setAttribute("value", value);
  }

  bool get willValidate => true;

  @override
  Element _newInstance(Document ownerDocument) =>
      OutputElement._(ownerDocument);
}

class ParagraphElement extends HtmlElement {
  factory ParagraphElement() => ParagraphElement._(null);

  ParagraphElement._(Document ownerDocument, {String nodeName = "P"})
      : super._(ownerDocument, nodeName);

  @override
  Element _newInstance(Document ownerDocument) =>
      ParagraphElement._(ownerDocument);
}

class ParamElement extends HtmlElement {
  factory ParamElement() => ParamElement._(null);

  ParamElement._(Document ownerDocument) : super._(ownerDocument, "PARAM");

  @override
  Element _newInstance(Document ownerDocument) => ParamElement._(ownerDocument);
}

class PictureElement extends HtmlElement {
  factory PictureElement.created() => PictureElement._(null);

  PictureElement._(Document ownerDocument, {String nodeName = "PICTURE"})
      : super._(ownerDocument, nodeName);

  @override
  Element _newInstance(Document ownerDocument) =>
      PictureElement._(ownerDocument);
}

class PreElement extends HtmlElement {
  factory PreElement() => PreElement._(null);

  PreElement._(Document ownerDocument, {String nodeName = "PRE"})
      : super._(ownerDocument, nodeName);

  @override
  Element _newInstance(Document ownerDocument) => PreElement._(ownerDocument);
}

class ProgressElement extends HtmlElement {
  static bool get supported => true;

  factory ProgressElement() => ProgressElement._(null);

  ProgressElement._(Document ownerDocument, {String nodeName = "PROGRESS"})
      : super._(ownerDocument, nodeName);

  num get max => _getAttributeNum("max");

  set max(num value) {
    _setAttributeNum("max", value);
  }

  num get position => _getAttributeNum("position");

  num get value => _getAttributeNum("value");

  set value(num value) {
    _setAttributeNum("value", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ProgressElement._(ownerDocument);
}

class QuoteElement extends HtmlElement {
  QuoteElement._(Document ownerDocument) : super._(ownerDocument, "Q");

  @override
  Element _newInstance(Document ownerDocument) => QuoteElement._(ownerDocument);
}

class ScriptElement extends HtmlElement {
  factory ScriptElement() => ScriptElement._(null);

  ScriptElement._(Document ownerDocument, {String nodeName = "SCRIPT"})
      : super._(ownerDocument, nodeName);

  bool get async => _getAttributeBool("async");

  set async(bool value) {
    _setAttributeBool("async", value);
  }

  String get crossOrigin => _getAttribute("crossorigin");

  set crossOrigin(String value) {
    _setAttribute("crossorigin", value);
  }

  bool get defer => _getAttributeBool("defer");

  set defer(bool value) {
    _setAttributeBool("defer", value);
  }

  String get integrity => _getAttribute("integrity");

  set integrity(String value) {
    _setAttribute("integrity", value);
  }

  bool get noModule => _getAttributeBool("nomodule") ?? "";

  set noModule(bool value) {
    _setAttributeBool("nomodule", value);
  }

  String get src => _getAttributeResolvedUri("src") ?? "";

  set src(String value) {
    _setAttribute("src", value);
  }

  String get type => _getAttribute("type");

  set type(String value) {
    _setAttribute("type", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ScriptElement._(ownerDocument);
}

class SelectElement extends HtmlElement
    with _DisabledElement, _FormFieldElement, _LabelsElement {
  factory SelectElement() => SelectElement._(null);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  SelectElement.created() : super.created();

  SelectElement._(Document ownerDocument) : super._(ownerDocument, "SELECT");

  bool get autofocus => _getAttributeBool("autofocus");

  set autofocus(bool value) {
    _setAttributeBool("autofocus", value);
  }

  int get length => options.length;

  set length(int newLength) {
    while (options.length < newLength) {
      append(OptionElement());
    }
    while (options.length > newLength) {
      options.last.remove();
    }
  }

  bool get multiple => _getAttributeBool("multiple");

  set multiple(bool value) {
    _setAttributeBool("multiple", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  List<OptionElement> get options {
    final result = <OptionElement>[];
    for (var child in children) {
      if (child is OptionElement) {
        result.add(child);
      } else if (child is OptGroupElement) {
        for (var grandChild in child.children) {
          if (grandChild is OptionElement) {
            result.add(grandChild);
          }
        }
      }
    }
    return result;
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  int get selectedIndex {
    final options = this.options;
    for (var i = 0; i < options.length; i++) {
      if (options[i].selected) {
        return i;
      }
    }
    return multiple ? -1 : 0;
  }

  set selectedIndex(int value) {
    final options = this.options;
    for (var i = 0; i < options.length; i++) {
      options[i]._selected = i == value;
    }
  }

  List<OptionElement> get selectedOptions {
    if (this.multiple) {
      var options = this.options.where((o) => o.selected).toList();
      return UnmodifiableListView<OptionElement>(options);
    } else {
      return <OptionElement>[this.options[this.selectedIndex]];
    }
  }

  int get size => _getAttributeInt("size");

  set size(int value) {
    _setAttributeInt("size", value);
  }

  String get type {
    if (multiple) {
      return "select-multiple";
    }
    return "select-one";
  }

  String get validationMessage => "";

  ValidityState get validity => ValidityState._();

  String get value {
    final options = this.options;
    for (var option in options) {
      if (option.selected) {
        return option.value;
      }
    }
    if (multiple) {
      return "";
    }
    return options.first.value;
  }

  set value(String value) {
    for (var option in options) {
      option.selected = option.value == value;
    }
  }

  bool get willValidate {
    return !(_ancestors.any((e) => e is DataListElement) || disabled);
  }

  void add(Object element, Object before) {}

  bool checkValidity() {
    return true;
  }

  Element item(int index) {
    return options[index];
  }

  OptionElement namedItem(String name) {
    for (var option in options) {
      if (option.value == name) {
        return option;
      }
    }
    return null;
  }

  bool reportValidity() {
    return true;
  }

  void setCustomValidity(String error) {}

  @override
  Element _newInstance(Document ownerDocument) =>
      SelectElement._(ownerDocument);
}

class ShadowElement extends HtmlElement {
  static bool get supported => true;

  ShadowElement._(Document ownerDocument) : super._(ownerDocument, "SHADOW");

  @override
  Element _newInstance(Document ownerDocument) =>
      ShadowElement._(ownerDocument);
}

class SlotElement extends HtmlElement {
  SlotElement._(Document ownerDocument) : super._(ownerDocument, "SLOT");

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => SlotElement._(ownerDocument);
}

class SourceElement extends HtmlElement {
  factory SourceElement() => SourceElement._(null);

  SourceElement._(Document ownerDocument) : super._(ownerDocument, "SOURCE");

  String get media => _getAttribute("media");

  set media(String value) {
    _setAttribute("media", value);
  }

  String get sizes => _getAttribute("sizes");

  set sizes(String value) {
    _setAttribute("sizes", value);
  }

  String get src => _getAttribute("src");

  set src(String value) {
    _setAttribute("src", value);
  }

  String get srcset => _getAttribute("srcset");

  set srcset(String value) {
    _setAttribute("srcset", value);
  }

  String get type => _getAttribute("type");

  set type(String value) {
    _setAttribute("type", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      SourceElement._(ownerDocument);
}

class SpanElement extends HtmlElement {
  factory SpanElement() => SpanElement._(null);

  SpanElement._(Document ownerDocument) : super._(ownerDocument, "SPAN");

  @override
  Element _newInstance(Document ownerDocument) => SpanElement._(ownerDocument);
}

class StyleElement extends HtmlElement {
  StyleSheet _sheet;

  factory StyleElement() => StyleElement._(null);

  StyleElement._(Document ownerDocument) : super._(ownerDocument, "STYLE");

  StyleSheet get sheet {
    if (_sheet != null) {
      return _sheet;
    }
    final type = this.type;
    if (type != null && type != "" && type != "text/css") {
      return null;
    }
    final text = this.text;
    final parsed = css.parse(text);
    final styleSheet = CssStyleSheet._();
    for (var node in parsed.topLevels) {
      final styleRule = CssStyleRule._(styleSheet, node);
      if (styleRule != null) {
        styleSheet.cssRules.add(styleRule);
      }
    }
    this._sheet = styleSheet;
    return styleSheet;
  }

  String get type => _getAttribute("type");

  set type(String value) {
    _setAttribute("type", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => StyleElement._(ownerDocument);
}

class TableCaptionElement extends HtmlElement {
  factory TableCaptionElement() => TableCaptionElement._(null);

  TableCaptionElement._(Document ownerDocument)
      : super._(ownerDocument, "CAPTION");

  @override
  Element _newInstance(Document ownerDocument) =>
      TableCaptionElement._(ownerDocument);
}

class TableCellElement extends HtmlElement {
  factory TableCellElement() => TableCellElement._(null);

  TableCellElement._(Document ownerDocument) : super._(ownerDocument, "TD");

  int get cellIndex {
    return this
        .parent
        .children
        .whereType<TableCellElement>()
        .toList()
        .indexOf(this);
  }

  int get colSpan => _getAttributeInt("colspan");

  set colSpan(int value) {
    _setAttributeInt("colspan", value);
  }

  int get rowSpan => _getAttributeInt("rowspan");

  set rowSpan(int value) {
    _setAttributeInt("rowspan", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TableCellElement._(ownerDocument);
}

class TableColElement extends HtmlElement {
  factory TableColElement() => TableColElement._(null);

  TableColElement._(Document ownerDocument) : super._(ownerDocument, "COL");

  @override
  Element _newInstance(Document ownerDocument) =>
      TableColElement._(ownerDocument);
}

class TableElement extends HtmlElement {
  factory TableElement() => TableElement._(null);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  TableElement.created() : super.created();

  TableElement._(Document ownerDocument) : super._(ownerDocument, "TABLE");

  TableCaptionElement get caption => children
      .whereType<TableCaptionElement>()
      .firstWhere((e) => true, orElse: () => null);

  List<TableRowElement> get rows {
    final tableRows = <TableRowElement>[];
    for (var child in children) {
      if (child is TableRowElement) {
        tableRows.add(child);
      }
      if (child._lowerCaseTagName == "tbody") {
        for (var grandChild in child.children) {
          tableRows.add(grandChild);
        }
      }
    }
    return tableRows;
  }

  List<TableSectionElement> get tBodies {
    return children
        .whereType<TableSectionElement>()
        .where((e) => e.tagName.toLowerCase() == "body")
        .toList();
  }

  TableSectionElement get tFoot => children
      .whereType<TableSectionElement>()
      .firstWhere((e) => e.tagName.toLowerCase() == "tfoot");

  TableSectionElement get tHead => children
      .whereType<TableSectionElement>()
      .firstWhere((e) => e.tagName.toLowerCase() == "thead");

  TableRowElement addRow() => createTBody().addRow();

  TableCaptionElement createCaption() {
    return _createUniqueChild("_table", () => TableCaptionElement());
  }

  TableSectionElement createTBody() {
    return _createUniqueChild(
        "_tbody", () => TableSectionElement._(ownerDocument, "tbody"));
  }

  TableSectionElement createTFoot() {
    return _createUniqueChild(
        "_tfoot", () => TableSectionElement._(ownerDocument, "tfoot"));
  }

  TableSectionElement createTHead() {
    return _createUniqueChild(
        "_thead", () => TableSectionElement._(ownerDocument, "thead"));
  }

  void deleteCaption() =>
      this.children.removeWhere((e) => e._lowerCaseTagName == "caption");

  void deleteRow(int index) {
    this.createTBody().deleteRow(index);
  }

  void deleteTFoot() {
    this.children.removeWhere((e) => e._lowerCaseTagName == "tfoot");
  }

  void deleteTHead() {
    this.children.removeWhere((e) => e._lowerCaseTagName == "tbody");
  }

  TableRowElement insertRow(int index) {
    return this.createTBody().insertRow(index);
  }

  Element _createUniqueChild<T extends Element>(String name, T f()) {
    final existing = this
        .children
        .firstWhere((e) => e._lowerCaseTagName == name, orElse: () => null);
    if (existing != null) {
      return existing;
    }
    final section = f();
    append(section);
    return section;
  }

  @override
  Element _newInstance(Document ownerDocument) => TableElement._(ownerDocument);
}

class TableRowElement extends HtmlElement {
  factory TableRowElement() => TableRowElement._(null);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  TableRowElement.created() : super.created();

  TableRowElement._(Document ownerDocument) : super._(ownerDocument, "TR");

  List<TableCellElement> get cells {
    return children.whereType<TableCellElement>().toList();
  }

  int get rowIndex {
    final siblings = this.parent.children.toList();
    for (var i = 0; i < siblings.length; i++) {
      if (identical(siblings[i], this)) {
        return i;
      }
    }
    return -1;
  }

  int get sectionRowIndex {
    final siblings =
        this.parent.children.whereType<TableCellElement>().toList();
    for (var i = 0; i < siblings.length; i++) {
      if (identical(siblings[i], this)) {
        return i;
      }
    }
    return -1;
  }

  TableCellElement addCell() {
    return insertCell(-1);
  }

  void deleteCell(int index) {
    this.cells[index]?.remove();
  }

  TableCellElement insertCell(int index) {
    final cell = TableCellElement();
    if (index == cells.length) {
      this.insertBefore(cell, null);
      return cell;
    }
    this.insertBefore(cell, cells[index]);
    return cell;
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TableRowElement._(ownerDocument);
}

class TableSectionElement extends HtmlElement {
  TableSectionElement._(Document ownerDocument, String tag)
      : super._(ownerDocument, tag);

  List<TableRowElement> get rows =>
      this.childNodes.whereType<TableRowElement>().toList();

  TableRowElement addRow() {
    final row = TableRowElement();
    this.append(row);
    return row;
  }

  void deleteRow(int index) {
    for (var existing in this.childNodes) {
      if (existing is TableRowElement) {
        if (index == 0) {
          existing.remove();
          return;
        }
        index--;
      }
    }
  }

  TableRowElement insertRow(int index) {
    TableRowElement before;
    for (var existing in this.childNodes) {
      if (existing is TableRowElement) {
        index--;
        if (index < 0) {
          before = existing;
          break;
        }
      }
    }
    final row = TableRowElement();
    this.insertBefore(row, before);
    return row;
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TableSectionElement._(ownerDocument, _lowerCaseTagName);
}

class TemplateElement extends HtmlElement {
  /// Checks if this type is supported on the current platform.
  static bool get supported => Element.isTagSupported('template');

  factory TemplateElement() => TemplateElement._(null);

  TemplateElement._(Document ownerDocument)
      : super._(ownerDocument, "TEMPLATE");

  DocumentFragment get content {
    throw UnimplementedError();
  }

  /// An override to place the contents into content rather than as child nodes.
  ///
  /// See also:
  ///
  /// * <https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/templates/index.html#innerhtml-on-templates>
  @override
  void setInnerHtml(
    String html, {
    NodeValidator validator,
    NodeTreeSanitizer treeSanitizer,
  }) {
    text = null;
    var fragment = createFragment(
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
    content.append(fragment);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TemplateElement._(ownerDocument);
}

class TextAreaElement extends HtmlElement
    with _DisabledElement, _FormFieldElement, _LabelsElement {
  String dirName;

  String selectionDirection;

  int selectionEnd;

  int selectionStart;

  factory TextAreaElement() => TextAreaElement._(null);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  TextAreaElement.created() : super.created();

  TextAreaElement._(Document ownerDocument)
      : super._(ownerDocument, "TEXTAREA");

  String get autocapitalize => _getAttribute("autocapitalize");

  set autocapitalize(String value) {
    _setAttribute("autocapitalize", value);
  }

  bool get autofocus => _getAttributeBool("autofocus");

  set autofocus(bool value) {
    _setAttributeBool("autofocus", value);
  }

  int get cols => _getAttributeInt("cols") ?? 20;

  set cols(int value) {
    _setAttributeInt("cols", value);
  }

  String get defaultValue => _getAttribute("value");

  set defaultValue(String value) {
    _setAttribute("value", value);
  }

  List<Node> get labels => <Node>[];

  int get maxLength => _getAttributeInt("maxlength") ?? -1;

  set maxLength(int value) {
    _setAttributeInt("maxlength", value);
  }

  int get minLength => _getAttributeInt("minlength") ?? -1;

  set minLength(int value) {
    _setAttributeInt("minlength", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  String get placeholder => _getAttribute("placeholder");

  set placeholder(String value) {
    _setAttribute("placeholder", value);
  }

  bool get readOnly => _getAttributeBool("readonly");

  set readOnly(bool value) {
    _setAttributeBool("readonly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  int get rows => _getAttributeInt("rows") ?? 2;

  set rows(int value) {
    _setAttributeInt("rows", value);
  }

  int get textLength => this.value.length;

  String get type => null;

  String get validationMessage => null;

  ValidityState get validity => ValidityState._();

  String get value => this.innerText;

  set value(String value) {
    this.innerText = value;
  }

  bool get willValidate {
    return !(_ancestors.any((e) => e is DataListElement) || disabled);
  }

  String get wrap => _getAttribute("wrap");

  set wrap(String value) {
    _setAttribute("wrap", value);
  }

  @override
  bool get _defaultSpellcheck => true;

  bool checkValidity() {
    return true;
  }

  bool reportValidity() {
    return true;
  }

  void select() {
    setSelectionRange(0, textLength);
  }

  void setCustomValidity(String error) {}

  void setRangeText(String replacement,
      {int start, int end, String selectionMode}) {}

  void setSelectionRange(int start, int end, [String direction]) {
    this.selectionStart = start;
    this.selectionEnd = end;
    this.selectionDirection = direction;
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TextAreaElement._(ownerDocument);
}

class TimeElement extends HtmlElement {
  TimeElement._(Document ownerDocument) : super._(ownerDocument, "TIME");

  String get dateTime => _getAttribute("datetime");

  set dateTime(String value) {
    _setAttribute("datetime", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => TimeElement._(ownerDocument);
}

class TitleElement extends HtmlElement {
  factory TitleElement() => TitleElement._(null);

  TitleElement._(Document ownerDocument) : super._(ownerDocument, "TITLE");

  @override
  Element _newInstance(Document ownerDocument) => TitleElement._(ownerDocument);
}

class TrackElement extends HtmlElement {
  static bool get supported => true;

  factory TrackElement() => TrackElement._(null);

  TrackElement._(Document ownerDocument) : super._(ownerDocument, "TRACK");

  String get kind => _getAttribute("kind");

  set kind(String value) {
    _setAttribute("kind", value);
  }

  String get label => _getAttribute("label");

  set label(String value) {
    _setAttribute("label", value);
  }

  String get src => _getAttributeResolvedUri("src") ?? "";

  set src(String value) {
    _setAttribute("src", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => TrackElement._(ownerDocument);
}

class UListElement extends HtmlElement {
  factory UListElement() => UListElement._(null);

  UListElement._(Document ownerDocument) : super._(ownerDocument, "UL");

  @override
  Element _newInstance(Document ownerDocument) => UListElement._(ownerDocument);
}

class UnknownElement extends HtmlElement {
  @override
  final String namespaceUri;

  UnknownElement._(Document ownerDocument, this.namespaceUri, String tag)
      : super._(ownerDocument, tag);

  @override
  Element _newInstance(Document ownerDocument) =>
      UnknownElement._(ownerDocument, namespaceUri, _lowerCaseTagName);
}

class ValidityState {
  final bool badInput;
  final bool customError;
  final bool patternMismatch;
  final bool rangeOverflow;
  final bool rangeUnderflow;
  final bool stepMismatch;
  final bool tooLong;
  final bool tooShort;
  final bool typeMismatch;
  final bool valid;
  final bool valueMissing;

  ValidityState._({
    this.badInput,
    this.customError,
    this.patternMismatch,
    this.rangeOverflow,
    this.rangeUnderflow,
    this.stepMismatch,
    this.tooLong,
    this.tooShort,
    this.typeMismatch,
    this.valid,
    this.valueMissing,
  });
}

class VideoElement extends MediaElement implements CanvasImageSource {
  factory VideoElement() => VideoElement._(null);

  VideoElement._(Document ownerDocument) : super._(ownerDocument, "VIDEO");

  int get height => _getAttributeInt("height");

  set height(int value) {
    _setAttributeInt("height", value);
  }

  int get width => _getAttributeInt("width");

  set width(int value) {
    _setAttributeInt("width", value);
  }

  void enterFullscreen() {}

  void exitFullscreen() {}

  VideoPlaybackQuality getVideoPlaybackQuality() {
    throw UnimplementedError();
  }

  @override
  Element _newInstance(Document ownerDocument) => VideoElement._(ownerDocument);
}

abstract class _DisabledElement implements HtmlElement {
  bool get disabled => _getAttributeBool("disabled");

  set disabled(bool value) {
    _setAttributeBool("disabled", value);
  }
}

abstract class _FormFieldElement implements HtmlElement {
  FormElement get form {
    var ancestor = this.parent;
    while (ancestor != null) {
      if (ancestor is FormElement) {
        return ancestor;
      }
      ancestor = ancestor.parent;
    }
    return null;
  }
}

abstract class _HrefAttributeElement implements HtmlElement {
  String get href {
    return _getAttributeResolvedUri("href") ?? "";
  }

  set href(String value) {
    _setAttribute("href", value);
  }

  String get referrerPolicy => _getAttribute("referrerpolicy");

  set referrerPolicy(String value) {
    _setAttribute("referrerpolicy", value);
  }
}

abstract class _HtmlHyperlinkElementUtils implements _UrlBase {
  String get href;

  set href(String value);

  String get password {
    final userInfo = _uri?.userInfo;
    if (userInfo == null) {
      return null;
    }
    final i = userInfo.indexOf(":");
    if (i < 0) {
      return null;
    }
    return userInfo.substring(i + 1);
  }

  String get username {
    final userInfo = _uri?.userInfo;
    if (userInfo == null) {
      return null;
    }
    final i = userInfo.indexOf(":");
    if (i < 0) {
      return userInfo;
    }
    return userInfo.substring(0, i);
  }

  @override
  Uri get _uri => Uri.parse(href);

  set _uri(Uri value) {
    this.href = value?.toString();
  }
}

abstract class _LabelsElement implements HtmlElement {
  List<Node> get labels {
    return const <Node>[];
  }
}
