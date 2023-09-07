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
  'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
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
  factory AnchorElement({String? href}) {
    final element = AnchorElement._(window.document);
    if (href != null) {
      element.href = href;
    }
    return element;
  }

  AnchorElement._(Document ownerDocument) : super._(ownerDocument, 'A');

  String? get download => _getAttribute('download');

  set download(String? value) {
    _setAttribute('download', value);
  }

  String? get hreflang => _getAttribute('hreflang');

  set hreflang(String? value) {
    _setAttribute('hreflang', value);
  }

  String get rel => _getAttribute('rel') ?? '';

  set rel(String value) {
    _setAttribute('rel', value);
  }

  String? get target => _getAttribute('target');

  set target(String? value) {
    _setAttribute('target', value);
  }

  String? get type => _getAttribute('type');

  set type(String? value) {
    _setAttribute('type', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      AnchorElement._(ownerDocument);
}

class AreaElement extends HtmlElement
    with _HtmlHyperlinkElementUtils, _UrlBase, _HrefAttributeElement
    implements HtmlHyperlinkElementUtils {
  factory AreaElement() => AreaElement._(window.document);

  AreaElement._(Document ownerDocument, {String nodeName = 'AREA'})
      : super._(ownerDocument, nodeName);

  String? get download => _getAttribute('download');

  set download(String? value) {
    _setAttribute('download', value);
  }

  String get rel => _getAttribute('rel') ?? '';

  set rel(String value) {
    _setAttribute('rel', value);
  }

  String? get target => _getAttribute('target');

  set target(String? value) {
    _setAttribute('target', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => AreaElement._(ownerDocument);
}

class AudioElement extends MediaElement {
  factory AudioElement() => AudioElement._(window.document);

  AudioElement._(Document ownerDocument) : super._(ownerDocument, 'AUDIO');

  @override
  Element _newInstance(Document ownerDocument) => AudioElement._(ownerDocument);
}

class BaseElement extends HtmlElement {
  BaseElement() : this._(window.document);

  BaseElement._(Document ownerDocument) : super._(ownerDocument, 'BASE');

  String get href => _getAttribute('href') ?? '';

  set href(String value) {
    _setAttribute('href', value);
  }

  String get target => _getAttribute('target') ?? '';

  set target(String value) {
    _setAttribute('target', value);
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

  factory BodyElement() => BodyElement._(window.document);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  BodyElement.created() : super.created();

  BodyElement._(Document ownerDocument) : super._(ownerDocument, 'BODY');

  /// Stream of `blur` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onBlur => blurEvent.forElement(this);

  /// Stream of `error` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onError => errorEvent.forElement(this);

  /// Stream of `focus` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onFocus => focusEvent.forElement(this);

  /// Stream of `hashchange` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onHashChange => hashChangeEvent.forElement(this);

  /// Stream of `load` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onLoad => loadEvent.forElement(this);

  /// Stream of `message` events handled by this [BodyElement].
  @override
  ElementStream<MessageEvent> get onMessage => messageEvent.forElement(this);

  /// Stream of `offline` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onOffline => offlineEvent.forElement(this);

  /// Stream of `online` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onOnline => onlineEvent.forElement(this);

  /// Stream of `popstate` events handled by this [BodyElement].
  @override
  ElementStream<PopStateEvent> get onPopState => popStateEvent.forElement(this);

  /// Stream of `resize` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onResize => resizeEvent.forElement(this);

  @override
  ElementStream<Event> get onScroll => scrollEvent.forElement(this);

  /// Stream of `storage` events handled by this [BodyElement].
  @override
  ElementStream<StorageEvent> get onStorage => storageEvent.forElement(this);

  /// Stream of `unload` events handled by this [BodyElement].
  @override
  ElementStream<Event> get onUnload => unloadEvent.forElement(this);

  @override
  Element _newInstance(Document ownerDocument) => BodyElement._(ownerDocument);
}

class BRElement extends HtmlElement {
  factory BRElement() => BRElement._(window.document);

  BRElement._(Document ownerDocument) : super._(ownerDocument, 'BR');

  @override
  Element _newInstance(Document ownerDocument) => BRElement._(ownerDocument);
}

class ButtonElement extends HtmlElement
    with _DisabledElement, _FormFieldElement {
  bool? formNoValidate;

  String? formTarget;

  factory ButtonElement() => ButtonElement._(window.document);

  ButtonElement._(Document ownerDocument) : super._(ownerDocument, 'BUTTON');

  bool get autofocus => _getAttributeBool('autofocus');

  set autofocus(bool value) {
    _setAttributeBool('autofocus', value);
  }

  String? get formAction => _getAttributeResolvedUri('formaction') ?? '';

  set formAction(String? value) {
    _setAttribute('formaction', value);
  }

  String get formEnctype => _getAttribute('formenctype') ?? '';

  set formEnctype(String value) {
    _setAttribute('formenctype', value);
  }

  String get formMethod => _getAttribute('formmethod') ?? '';

  set formMethod(String value) {
    _setAttribute('formmethod', value);
  }

  String? get name => _getAttribute('name');

  set name(String? value) {
    _setAttribute('name', value);
  }

  String? get type => _getAttribute('type', defaultValue: 'submit');

  set type(String? value) {
    _setAttribute('type', value);
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

  /// An API for drawing on this canvas.
  late final CanvasRenderingContext2D context2D = throw UnimplementedError();

  CanvasElement({int? width, int? height})
      : super._(window.document, 'CANVAS') {
    if (width != null) {
      _setAttributeInt('width', width);
    }
    if (height != null) {
      _setAttributeInt('height', height);
    }
  }

  CanvasElement._(Document ownerDocument) : super._(ownerDocument, 'CANVAS');

  /// The height of this canvas element in CSS pixels.
  int? get height => _getAttributeInt('height');

  set height(int? value) {
    _setAttributeInt('height', value);
  }

  /// Stream of `webglcontextlost` events handled by this [CanvasElement].
  ElementStream<gl.ContextEvent> get onWebGlContextLost =>
      webGlContextLostEvent.forElement(this);

  /// Stream of `webglcontextrestored` events handled by this [CanvasElement].
  ElementStream<gl.ContextEvent> get onWebGlContextRestored =>
      webGlContextRestoredEvent.forElement(this);

  /// The width of this canvas element in CSS pixels.
  int? get width => _getAttributeInt('width');

  set width(int? value) {
    _setAttributeInt('width', value);
  }

  MediaStream captureStream([num? frameRate]) {
    throw UnimplementedError();
  }

  Object? getContext(String contextId, [Map? attributes]) {
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
  gl.RenderingContext getContext3d({
    alpha = true,
    depth = true,
    stencil = false,
    antialias = true,
    premultipliedAlpha = true,
    preserveDrawingBuffer = false,
  }) {
    var options = {
      'alpha': alpha,
      'depth': depth,
      'stencil': stencil,
      'antialias': antialias,
      'premultipliedAlpha': premultipliedAlpha,
      'preserveDrawingBuffer': preserveDrawingBuffer,
    };
    var context = getContext('webgl', options);
    context ??= getContext('experimental-webgl', options);
    return context as gl.RenderingContext;
  }

  Future<Blob> toBlob(String type, [Object? arguments]) {
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
  ///     ..fillStyle = 'rgb(200,0,0)'
  ///     ..fillRect(10, 10, 55, 50);
  ///     var dataUrl = canvas.toDataUrl('image/jpeg', 0.95);
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
  String toDataUrl([String type = 'image/png', num? quality]) {
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

  String? select;

  factory ContentElement() => ContentElement._(window.document);

  ContentElement._(Document ownerDocument) : super._(ownerDocument, 'CONTENT');

  List<Node> getDistributedNodes() {
    throw UnimplementedError();
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ContentElement._(ownerDocument);
}

class DataElement extends HtmlElement {
  DataElement._(Document ownerDocument) : super._(ownerDocument, 'DATA');

  @override
  Element _newInstance(Document ownerDocument) => DataElement._(ownerDocument);
}

class DataListElement extends HtmlElement {
  static bool get supported => true;

  factory DataListElement() => DataListElement._(window.document);

  DataListElement._(Document ownerDocument)
      : super._(ownerDocument, 'DATALIST');

  @override
  Element _newInstance(Document ownerDocument) =>
      DataListElement._(ownerDocument);
}

class DetailsElement extends HtmlElement {
  static bool get supported => true;

  factory DetailsElement() => DetailsElement._(window.document);

  DetailsElement._(Document ownerDocument) : super._(ownerDocument, 'DETAILS');

  bool get open => _getAttributeBool('open');

  set open(bool value) {
    _setAttributeBool('open', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      DetailsElement._(ownerDocument);
}

class DialogElement extends HtmlElement {
  bool? open;

  String? returnValue;

  DialogElement._(Document ownerDocument) : super._(ownerDocument, 'DIALOG');

  void close([String? returnValue]) {
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
  factory DivElement() => DivElement._(window.document);

  DivElement._(Document ownerDocument) : super._(ownerDocument, 'DIV');

  @override
  Element _newInstance(Document ownerDocument) => DivElement._(ownerDocument);
}

class DListElement extends HtmlElement {
  factory DListElement() => DListElement._(window.document);

  DListElement._(Document ownerDocument) : super._(ownerDocument, 'DL');

  @override
  Element _newInstance(Document ownerDocument) => DListElement._(ownerDocument);
}

class DomTokenList {
  final Element _element;
  final String _name;

  DomTokenList._(this._element, this._name);

  int get length => _getList().length;

  void add(String tokens) {
    final list = _getList();
    final splitTokens =
        tokens.split(' ').map((e) => e.trim()).where((e) => e.isNotEmpty);
    list.addAll(splitTokens);
    _setList(list);
  }

  bool contains(String token) {
    return _getList().contains(token);
  }

  String item(int index) {
    return _getList()[index];
  }

  void remove(String tokens) {
    final list = _getList();
    final splitTokens =
        tokens.split(' ').map((e) => e.trim()).where((e) => e.isNotEmpty);
    for (var token in splitTokens) {
      list.remove(token);
    }
    _setList(list);
  }

  void replace(String token, String newToken) {
    final list = _getList();
    for (var i = 0; i < list.length; i++) {
      if (list[i] == token) {
        list[i] = newToken;
      }
    }
    _setList(list);
  }

  bool supports(String token) {
    return true;
  }

  bool toggle(String token, [bool? force]) {
    if (contains(token)) {
      remove(token);
      return true;
    } else {
      add(token);
      return false;
    }
  }

  List<String> _getList() {
    final value = _element._getAttribute(_name);
    if (value == null || value.isEmpty) {
      return <String>[];
    }
    return value
        .split(' ')
        .map((e) => e.trim())
        .where((e) => e.trim().isNotEmpty)
        .toList();
  }

  void _setList(List<String> list) {
    _element._setAttribute(_name, list.join(' '));
  }
}

class EmbedElement extends HtmlElement {
  static bool get supported => true;

  factory EmbedElement() => EmbedElement._(window.document);

  EmbedElement._(Document ownerDocument) : super._(ownerDocument, 'EMBED');

  @override
  Element _newInstance(Document ownerDocument) => EmbedElement._(ownerDocument);
}

class FieldSetElement extends HtmlElement with _FormFieldElement {
  factory FieldSetElement() => FieldSetElement._(window.document);

  FieldSetElement._(Document ownerDocument)
      : super._(ownerDocument, 'FIELDSET');

  bool get disabled => _getAttributeBool('disabled');

  set disabled(bool value) {
    _setAttributeBool('disabled', value);
  }

  String? get type => null;

  @override
  Element _newInstance(Document ownerDocument) =>
      FieldSetElement._(ownerDocument);
}

class FormElement extends HtmlElement {
  factory FormElement() => FormElement._(window.document);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  FormElement.created() : super.created();

  FormElement._(Document ownerDocument) : super._(ownerDocument, 'FORM');

  String? get acceptCharset => _getAttribute('acceptcharset');

  set acceptCharset(String? value) {
    _setAttribute('acceptcharset', value);
  }

  String? get action => _getAttributeResolvedUri('action') ?? '';

  set action(String? value) {
    _setAttribute('action', value);
  }

  String? get autocomplete => _getAttribute('autocomplete');

  set autocomplete(String? value) {
    _setAttribute('autocomplete', value);
  }

  String? get encoding => _getAttribute('encoding');

  set encoding(String? value) {
    _setAttribute('encoding', value);
  }

  String? get enctype => _getAttribute('enctype');

  set enctype(String? value) {
    _setAttribute('enctype', value);
  }

  int? get length => _items.length;

  String? get method => _getAttribute('method');

  set method(String? value) {
    _setAttribute('method', value);
  }

  String? get name => _getAttribute('name');

  set name(String? value) {
    _setAttribute('name', value);
  }

  bool? get noValidate => _getAttributeBool('novalidate');

  set noValidate(bool? value) {
    _setAttributeBool('novalidate', value);
  }

  String? get target => _getAttribute('target');

  set target(String? value) {
    _setAttribute('target', value);
  }

  /// Returns all items of this form.
  Iterable<Element> get _items {
    return _treeAsIterable(this)
        .whereType<InputElement>()
        .where((element) => identical(element.form, this));
  }

  bool checkValidity() {
    return true;
  }

  void internalReset() {
    for (var element in _items) {
      if (element is InputElement) {
        element._reset();
      }
    }
  }

  /// Submits the form.
  Future<void> internalSubmit(Element? buttonElement) async {
    // Get method
    var method = (this.method ?? 'get').toLowerCase();
    if (method == '') {
      method = 'get';
    }

    // Get URI
    var uriString = _getFormAction(buttonElement!) ?? '';
    if (uriString.isEmpty) {
      uriString = baseUri!;
    }
    final uri = Uri.parse(uriString);
    switch (uri.scheme) {
      case 'http':
        break;
      case 'https':
        break;
      default:
        return;
    }

    // Open HTTP request
    final encType = enctype?.toLowerCase();
    switch (encType ?? '') {
      case '':
        await _sendUrlEncoded(method, uri);
        break;

      case 'multipart/form-data':
        await _sendMultiPart(uri);
        break;

      case 'application/x-www-form-urlencoded':
        await _sendUrlEncoded(method, uri);
        break;

      default:
        throw StateError('Unsupported encoding type: "$encType"');
    }
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
    throw UnimplementedError();
  }

  /// Resets the form.
  ///
  /// No event is dispatched.
  void submit() {
    throw UnimplementedError();
  }

  /// Gets the URL where the form should be sent.
  String? _getFormAction(Element button) {
    String? action;
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

  /// Sends values in 'multipart/form-data' format.
  Future<void> _sendMultiPart(
    Uri uri,
  ) async {
    final httpClient = window.internalWindowController.onChooseHttpClient(uri);
    final httpRequest = await httpClient.openUrl(method ?? 'POST', uri);

    final writer = MultipartFormWriter(httpRequest);

    httpRequest.headers.contentType = io.ContentType(
      'multipart',
      'form-data',
      parameters: {
        'boundary': writer.boundary,
      },
    );

    for (var item in _items) {
      _sendMultiPartElement(writer, item);
    }

    // Load response page
    throw UnimplementedError();
  }

  /// Sends an element in 'multipart/form-data' format.
  /// Called by [_sendMultiPart].
  void _sendMultiPartElement(
      MultipartFormWriter writer, Element element) async {
    if (element is InputElement) {
      final name = element.name;
      if (name == null || name.isEmpty) {
        return;
      }
      final value = element.value;
      if (value == null) {
        return;
      }
      final elementType = element.type!;
      switch (elementType.toLowerCase()) {
        case 'button':
          break;

        case 'reset':
          break;

        case 'submit':
          break;

        case 'file':
          for (var file in element.files ?? []) {
            writer.writeFile(name, file, fileName: file._qualifiedName);
          }
          break;

        case 'checkbox':
          if (element.checked ?? false) {
            writer.writeFieldValue(name, value);
          }
          break;

        case 'radio':
          if (element.checked ?? false) {
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
    final windowController = ownerDocument!.window.internalWindowController;
    switch (method.toLowerCase()) {
      case 'get':
        uri = uri.replace(
          queryParameters: _valuesToQueryParameters(uri.queryParameters),
        );
        return windowController.openHttp(
          method: 'GET',
          uri: uri,
        );

      case 'post':
        final httpClient =
            window.internalWindowController.onChooseHttpClient(uri);
        final httpRequest = await httpClient.openUrl(method, uri);
        httpRequest.headers.contentType = io.ContentType(
          'application',
          'x-www-form-urlencoded',
        );
        final tmpUri = Uri(queryParameters: _valuesToQueryParameters());
        return windowController.openHttp(
          method: 'POST',
          uri: tmpUri,
          contentType: io.ContentType('application', 'x-www-form-urlencoded'),
        );

      default:
        throw StateError('Unsupported HTTP method: "$method"');
    }
  }

  /// Builds a map that contains all field values.
  Map<String, dynamic> _valuesToQueryParameters([Map<String, dynamic>? args]) {
    final result = <String, dynamic>{};
    if (args != null) {
      result.addAll(args);
    }
    elementLoop:
    for (var element in _items) {
      if (element is InputElement) {
        // Ignore empty keys
        final name = element.name ?? '';
        if (name.isEmpty) {
          continue;
        }
        final value = element.value ?? '';
        final type = element.type ?? '';
        switch (type.toLowerCase()) {
          case 'button':
            continue elementLoop;

          case 'submit':
            continue elementLoop;

          case 'reset':
            continue elementLoop;

          case 'file':
            continue elementLoop;

          case 'radio':
            if (!(element.checked ?? false)) {
              continue elementLoop;
            }
            break;

          case 'checkbox':
            if (!(element.checked ?? false)) {
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

  /// Iterates all nodes in DOM subtree.
  static Iterable<Element> _treeAsIterable(Element root) sync* {
    for (var child in root.children) {
      yield (child);
      yield* (_treeAsIterable(child));
    }
  }
}

class HeadElement extends HtmlElement {
  factory HeadElement() => HeadElement._(window.document);

  HeadElement._(Document ownerDocument) : super._(ownerDocument, 'HEAD');

  @override
  Element _newInstance(Document ownerDocument) => HeadElement._(ownerDocument);
}

class HeadingElement extends HtmlElement {
  factory HeadingElement.h1() => HeadingElement._(window.document, 'H1');

  factory HeadingElement.h2() => HeadingElement._(window.document, 'H2');

  factory HeadingElement.h3() => HeadingElement._(window.document, 'H3');

  factory HeadingElement.h4() => HeadingElement._(window.document, 'H4');

  factory HeadingElement.h5() => HeadingElement._(window.document, 'H5');

  factory HeadingElement.h6() => HeadingElement._(window.document, 'H6');

  HeadingElement._(Document ownerDocument, String name)
      : super._(ownerDocument, name);

  @override
  Element _newInstance(Document ownerDocument) =>
      HeadingElement._(ownerDocument, _lowerCaseTagName);
}

class HRElement extends HtmlElement {
  factory HRElement() => HRElement._(window.document);

  HRElement._(Document ownerDocument) : super._(ownerDocument, 'HR');

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

  @override
  String? get nonce => _getAttribute('nonce');

  @override
  set nonce(String? value) {
    _setAttribute('nonce', value);
  }
}

class HtmlHtmlElement extends HtmlElement {
  factory HtmlHtmlElement() => HtmlHtmlElement._(window.document);

  HtmlHtmlElement._(Document ownerDocument) : super._(ownerDocument, 'HTML');

  @override
  Element _newInstance(Document ownerDocument) =>
      HtmlHtmlElement._(ownerDocument);
}

abstract class HtmlHyperlinkElementUtils implements _UrlBase {
  String? href;

  HtmlHyperlinkElementUtils._();

  set host(String? value);

  set hostname(String? value);

  String? get password;

  set password(String? value);

  set protocol(String? value);

  String? get username;

  set username(String? value);
}

class IFrameElement extends HtmlElement {
  late final _sandbox = DomTokenList._(this, 'sandbox');

  factory IFrameElement() => IFrameElement._(window.document);

  IFrameElement._(Document ownerDocument) : super._(ownerDocument, 'IFRAME');

  String? get allow => _getAttribute('allow');

  set allow(String? value) {
    _setAttribute('allow', value);
  }

  bool? get allowFullscreen => _getAttributeBool('allowfullscreen');

  set allowFullscreen(bool? value) {
    _setAttributeBool('allowfullscreen', value);
  }

  bool? get allowPaymentRequest => _getAttributeBool('allowpaymentrequest');

  set allowPaymentRequest(bool? value) {
    _setAttributeBool('allowpaymentrequest', value);
  }

  WindowBase? get contentWindow => null;

  String? get csp => _getAttribute('csp');

  set csp(String? value) {
    _setAttribute('csp', value);
  }

  String? get height => _getAttribute('height');

  set height(String? value) {
    _setAttribute('height', value);
  }

  String? get name => _getAttribute('name');

  set name(String? value) {
    _setAttribute('name', value);
  }

  String? get referrerPolicy => _getAttribute('referrerpolicy');

  set referrerPolicy(String? value) {
    _setAttribute('referrerpolicy', value);
  }

  DomTokenList? get sandbox => _sandbox;

  String? get src => _getAttributeResolvedUri('src') ?? '';

  set src(String? value) {
    _setAttribute('src', value);
  }

  String? get srcdoc => _getAttribute('srcdoc');

  set srcdoc(String? value) {
    _setAttribute('srcdoc', value);
  }

  String? get width => _getAttribute('width');

  set width(String? value) {
    _setAttribute('width', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      IFrameElement._(ownerDocument);
}

class ImageElement extends HtmlElement implements CanvasImageSource {
  factory ImageElement() => ImageElement._(window.document);

  ImageElement._(Document ownerDocument) : super._(ownerDocument, 'IMG');

  String? get alt => _getAttribute('alt');

  set alt(String? value) {
    _setAttribute('alt', value);
  }

  bool? get async => _getAttributeBool('async');

  set async(bool? value) {
    _setAttributeBool('async', value);
  }

  bool get complete => false;

  String? get crossOrigin => _getAttribute('crossorigin');

  set crossOrigin(String? value) {
    _setAttribute('crossorigin', value);
  }

  String? get currentSrc => null;

  int? get height => _getAttributeInt('height') ?? 0;

  set height(int? value) {
    _setAttributeInt('height', value);
  }

  bool get isMap => _getAttributeBool('ismap');

  set isMap(bool value) {
    _setAttributeBool('ismap', value);
  }

  int? get naturalHeight => null;

  int? get naturalWidth => null;

  String? get referrerPolicy => _getAttribute('referrerpolicy');

  set referrerPolicy(String? value) {
    _setAttribute('referrerpolicy', value);
  }

  String? get sizes => _getAttribute('sizes');

  set sizes(String? value) {
    _setAttribute('sizes', value);
  }

  String? get src {
    return _getAttributeResolvedUri('src') ?? '';
  }

  set src(String? value) {
    _setAttribute('src', value);
  }

  String? get srcset => _getAttribute('srcset');

  set srcset(String? value) {
    _setAttribute('srcset', value);
  }

  String? get useMap => _getAttribute('usemap');

  set useMap(String? value) {
    _setAttribute('usemap', value);
  }

  int? get width => _getAttributeInt('width') ?? 0;

  set width(int? value) {
    _setAttributeInt('width', value);
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
  static final _typesNotValidated = {'hidden', 'reset', 'button'};

  /// Current value. This is different from attribute 'value', which can be
  /// accessed with [defaultValue].
  String? internalValue;

  /// Current checked value. This is different from attribute 'checked', which
  /// can be accessed with [defaultChecked].
  bool? internalChecked;

  /// Prevously compiled pattern.
  RegExp? _lastRegExp;

  bool? directory;

  @override
  String? selectionDirection;

  @override
  int? selectionStart;

  @override
  int? selectionEnd;

  List<File>? _files;

  factory InputElement({String? type}) {
    final e = InputElement._(window.document);
    if (type != null) {
      e.type = type;
    }
    return e;
  }

  InputElement._(Document ownerDocument) : super._(ownerDocument, 'INPUT');

  @override
  String? get accept => _getAttribute('accept');

  @override
  set accept(String? value) {
    _setAttribute('accept', value);
  }

  @override
  String? get alt => _getAttribute('alt');

  @override
  set alt(String? value) {
    _setAttribute('alt', value);
  }

  String? get autocapitalize => _getAttribute('autocapitalize');

  set autocapitalize(String? value) {
    _setAttribute('autocapitalize', value);
  }

  @override
  String get autocomplete => _getAttribute('autocomplete') ?? '';

  @override
  set autocomplete(String value) {
    _setAttribute('autocomplete', value);
  }

  @override
  bool get autofocus => _getAttributeBool('autofocus');

  @override
  set autofocus(bool value) {
    _setAttributeBool('autofocus', value);
  }

  String? get capture => _getAttribute('capture');

  set capture(String? value) {
    _setAttribute('capture', value);
  }

  @override
  bool? get checked => internalChecked ?? defaultChecked;

  @override
  set checked(bool? value) {
    if (value != internalChecked) {
      _markDirty();
      internalChecked = value;
    }
  }

  bool? get defaultChecked => _getAttributeBool('checked');

  set defaultChecked(bool? value) {
    _setAttributeBool('checked', value);
  }

  String? get defaultValue => _getAttribute('value');

  set defaultValue(String? value) {
    _setAttribute('value', value);
  }

  @override
  String? get dirName => _getAttribute('dirname');

  @override
  set dirName(String? value) {
    _setAttribute('dirname', value);
  }

  @override
  set disabled(bool? value) {
    _setAttributeBool('disabled', value);
  }

  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.SAFARI)
  List<Entry> get entries => const <Entry>[];

  @override
  List<File>? get files => _files;

  @override
  set files(List<File>? value) {
    _markDirty();
    _files = value;
  }

  @override
  String? get formAction => _getAttributeResolvedUri('formaction') ?? '';

  @override
  set formAction(String? value) {
    _setAttribute('formaction', value);
  }

  @override
  String get formEnctype => _getAttribute('formenctype') ?? '';

  @override
  set formEnctype(String value) {
    _setAttribute('formenctype', value);
  }

  @override
  String get formMethod => _getAttribute('formmethod') ?? '';

  @override
  set formMethod(String value) {
    _setAttribute('formmethod', value);
  }

  @override
  bool get formNoValidate => _getAttributeBool('formnovalidate');

  @override
  set formNoValidate(bool value) {
    _setAttributeBool('formnovalidate', value);
  }

  @override
  String? get formTarget => _getAttribute('formtarget') ?? '';

  @override
  set formTarget(String? value) {
    _setAttribute('formtarget', value);
  }

  @override
  int? get height => _getAttributeInt('height');

  @override
  set height(int? value) {
    _setAttributeInt('height', value);
  }

  @override
  bool? get incremental => _getAttributeBool('incremental');

  @override
  set incremental(bool? value) {
    _setAttributeBool('incremental', value);
  }

  @override
  bool? get indeterminate => _getAttributeBool('indeterminate');

  @override
  set indeterminate(bool? value) {
    _setAttributeBool('indeterminate', value);
  }

  @override
  Element? get list => null;

  @override
  String? get max => _getAttribute('max');

  @override
  set max(String? value) {
    _setAttribute('max', value);
  }

  @override
  int? get maxLength => _getAttributeInt('maxlength');

  @override
  set maxLength(int? value) {
    _setAttributeInt('maxlength', value);
  }

  @override
  String? get min => _getAttribute('min');

  @override
  set min(String? value) {
    _setAttribute('min', value);
  }

  int? get minLength => _getAttributeInt('minlength');

  set minLength(int? value) {
    _setAttributeInt('minlength', value);
  }

  @override
  bool? get multiple => _getAttributeBool('multiple');

  @override
  set multiple(bool? value) {
    _setAttributeBool('multiple', value);
  }

  @override
  String? get name => _getAttribute('name');

  @override
  set name(String? value) {
    _setAttribute('name', value);
  }

  @override
  String get pattern => _getAttribute('pattern') ?? '';

  @override
  set pattern(String value) {
    _setAttribute('pattern', value);
  }

  @override
  String get placeholder => _getAttribute('placeholder') ?? '';

  @override
  set placeholder(String value) {
    _setAttribute('placeholder', value);
  }

  @override
  bool? get readOnly => _getAttributeBool('readonly');

  @override
  set readOnly(bool? value) {
    _setAttributeBool('readonly', value);
  }

  @override
  bool get required => _getAttributeBool('required');

  @override
  set required(bool value) {
    _setAttributeBool('required', value);
  }

  @override
  int? get size => _getAttributeInt('size');

  @override
  set size(int? value) {
    _setAttributeInt('size', value);
  }

  @override
  String? get src => _getAttribute('src');

  @override
  set src(String? value) {
    _setAttribute('src', value);
  }

  @override
  String? get step => _getAttribute('step');

  @override
  set step(String? value) {
    _setAttribute('step', value);
  }

  String? get type => _getAttribute('type', defaultValue: 'text');

  set type(String? value) {
    _setAttribute('type', value);
  }

  @override
  String? get validationMessage {
    return null;
  }

  @override
  ValidityState get validity {
    return ValidityState.constructor();
  }

  @override
  String? get value => internalValue ?? '';

  @override
  set value(String? value) {
    if (value != internalValue) {
      _markDirty();
      internalValue = value;
    }
  }

  @override
  DateTime get valueAsDate {
    return DateTime.parse(value ?? '');
  }

  @override
  set valueAsDate(DateTime value) {
    this.value = value.toIso8601String();
  }

  @override
  num? get valueAsNumber {
    final value = this.value;
    return value == null ? null : num.parse(value);
  }

  @override
  set valueAsNumber(num? value) {
    this.value = value?.toString();
  }

  @override
  int? get width => _getAttributeInt('width');

  @override
  set width(int? value) {
    _setAttributeInt('width', value);
  }

  @override
  bool get willValidate {
    return !(_ancestors.any((e) => e is DataListElement) ||
        _typesNotValidated.contains(type.toString()) ||
        disabled);
  }

  /// Gets regular expression.
  RegExp? get _regExp {
    final pattern = this.pattern;
    if (pattern == '') {
      return null;
    }
    final lastRegExp = _lastRegExp;
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
      case 'text':
        return _checkTextValidity(value);
      default:
        return true;
    }
  }

  /// Default action when [click] is called.
  @protected
  void internalDefaultClick() {
    final type = (this.type ?? '').toLowerCase();
    final form = this.form;
    switch (type) {
      case 'file':
        throw UnimplementedError();

      case 'reset':
        form?.reset();
        break;

      case 'submit':
        form?.internalSubmit(this);
        break;

      case 'radio':
        if (form != null) {
          final name = this.name;
          for (var item in form._items) {
            if (item is InputElement && item.name == name) {
              item.checked = false;
            }
          }
          checked = true;
        }
        break;

      case 'checkbox':
        checked = !(checked ?? false);
        break;

      default:
        focus();
        break;
    }
  }

  bool reportValidity() {
    return checkValidity();
  }

  @override
  void select() {}

  @override
  void setCustomValidity(String error) {}

  void setRangeText(
    String replacement, {
    int? start,
    int? end,
    String? selectionMode,
  }) {}

  @override
  void setSelectionRange(int start, int end, [String? direction]) {}

  @override
  void stepDown([int? n]) {
    n ??= 1;
    valueAsNumber = (valueAsNumber ?? 0) - n;
  }

  @override
  void stepUp([int? n]) {
    n ??= 1;
    valueAsNumber = (valueAsNumber ?? 0) + n;
  }

  bool _checkTextValidity(String? value) {
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
      final regExp = _regExp;
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
    internalValue = null;
    internalChecked = null;
    files = null;
  }
}

class LabelElement extends HtmlElement with _FormFieldElement {
  factory LabelElement() => LabelElement._(window.document);

  LabelElement._(Document ownerDocument) : super._(ownerDocument, 'LABEL');

  String? get htmlFor => _getAttribute('for');

  set htmlFor(String? value) {
    _setAttribute('for', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => LabelElement._(ownerDocument);
}

class LegendElement extends HtmlElement with _FormFieldElement {
  factory LegendElement() => LegendElement._(window.document);

  LegendElement._(Document ownerDocument) : super._(ownerDocument, 'LEGEND');

  @override
  Element _newInstance(Document ownerDocument) =>
      LegendElement._(ownerDocument);
}

class LIElement extends HtmlElement {
  factory LIElement() => LIElement._(window.document);

  LIElement._(Document ownerDocument) : super._(ownerDocument, 'LI');

  int? get value => _getAttributeInt('value');

  set value(int? value) {
    _setAttributeInt('value', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => LIElement._(ownerDocument);
}

class LinkElement extends HtmlElement
    with _HrefAttributeElement, _DisabledElement {
  factory LinkElement() => LinkElement._(window.document);

  LinkElement._(Document ownerDocument) : super._(ownerDocument, 'LINK');

  String? get as => _getAttribute('as');

  set as(String? value) {
    _setAttribute('as', value);
  }

  String? get crossOrigin => _getAttribute('crossorigin');

  set crossOrigin(String? value) {
    _setAttribute('crossorigin', value);
  }

  String? get hreflang => _getAttribute('hreflang');

  set hreflang(String? value) {
    _setAttribute('hreflang', value);
  }

  String? get integrity => _getAttribute('integrity');

  set integrity(String? value) {
    _setAttribute('integrity', value);
  }

  String? get media => _getAttribute('media');

  set media(String? value) {
    _setAttribute('media', value);
  }

  String get rel => _getAttribute('rel') ?? '';

  set rel(String value) {
    _setAttribute('rel', value);
  }

  String? get scope => _getAttribute('scope');

  set scope(String? value) {
    _setAttribute('scope', value);
  }

  String? get type => _getAttribute('type');

  set type(String? value) {
    _setAttribute('type', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => LinkElement._(ownerDocument);
}

class MapElement extends HtmlElement {
  factory MapElement() => MapElement._(window.document);

  MapElement._(Document ownerDocument) : super._(ownerDocument, 'MAP');

  String? get name => _getAttribute('name');

  set name(String? value) {
    _setAttribute('name', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => MapElement._(ownerDocument);
}

abstract class MediaElement extends HtmlElement {
  static const int HAVE_CURRENT_DATA = 2;

  static const int HAVE_ENOUGH_DATA = 4;

  static const int HAVE_FUTURE_DATA = 3;

  static const int HAVE_METADATA = 1;

  static const int HAVE_NOTHING = 0;

  static const int NETWORK_EMPTY = 0;

  static const int NETWORK_IDLE = 1;

  static const int NETWORK_LOADING = 2;

  static const int NETWORK_NO_SOURCE = 3;

  bool muted = false;

  num defaultPlaybackRate = 1.0;

  bool disableRemotePlayback = false;

  MediaElement._(Document ownerDocument, String tag)
      : super._(ownerDocument, tag);

  bool get autoplay => _getAttributeBool('autoplay');

  set autoplay(bool value) {
    _setAttributeBool('autoplay', value);
  }

  bool get controls => _getAttributeBool('controls');

  set controls(bool value) {
    _setAttributeBool('controls', value);
  }

  String? get crossOrigin => _getAttribute('crossorigin');

  set crossOrigin(String? value) {
    _setAttribute('crossorigin', value);
  }

  bool get defaultMuted => _getAttributeBool('muted');

  set defaultMuted(bool value) {
    _setAttributeBool('muted', value);
  }

  MediaError? get error => null;

  bool get loop => _getAttributeBool('loop');

  set loop(bool value) {
    _setAttributeBool('loop', value);
  }

  MediaKeys? get mediaKeys => null;

  int? get networkState => NETWORK_EMPTY;

  String get preload => _getAttribute('preload') ?? '';

  set preload(String value) {
    _setAttribute('preload', value);
  }

  int get readyState => 0;

  RemotePlayback? get remote => null;

  TimeRanges? get seekable => null;

  String get src => _getAttributeResolvedUri('src') ?? '';

  set src(String value) {
    _setAttribute('src', value);
  }

  MediaStream? get srcObject {
    throw UnimplementedError();
  }

  set srcObject(MediaStream? value) {
    throw UnimplementedError();
  }

  num get volume => _getAttributeNum('volume', defaultValue: 1.0) ?? 1.0;

  set volume(num value) {
    _setAttributeNum('volume', value);
  }

  TextTrack addTextTrack(String kind, [String? label, String? language]) {
    throw UnimplementedError();
  }

  String canPlayType(String type, [String? keySystem]) {
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
  factory MenuElement() => MenuElement._(window.document);

  MenuElement._(Document ownerDocument) : super._(ownerDocument, 'MENU');

  @override
  Element _newInstance(Document ownerDocument) => MenuElement._(ownerDocument);
}

class MetaElement extends HtmlElement {
  factory MetaElement() => MetaElement._(window.document);

  MetaElement._(Document ownerDocument) : super._(ownerDocument, 'META');

  String get content => _getAttribute('content') ?? '';

  set content(String value) {
    _setAttribute('content', value);
  }

  String get name => _getAttribute('name') ?? '';

  set name(String value) {
    _setAttribute('name', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => MetaElement._(ownerDocument);
}

class MeterElement extends HtmlElement {
  /// Checks if this type is supported on the current platform.
  static bool get supported => Element.isTagSupported('meter');

  factory MeterElement() => MeterElement._(window.document);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  MeterElement.created() : super.created();

  MeterElement._(Document ownerDocument) : super._(ownerDocument, 'METER');

  num? get high => _getAttributeNum('high', defaultValue: 0.0) ?? 1;

  set high(num? value) {
    _setAttributeNum('high', value);
  }

  List<Node> get labels => <Node>[];

  num? get low => _getAttributeNum('low', defaultValue: 0.0) ?? 0;

  set low(num? value) {
    _setAttributeNum('low', value);
  }

  num? get max => _getAttributeNum('max', defaultValue: 0.0) ?? 1;

  set max(num? value) {
    _setAttributeNum('max', value);
  }

  num? get min => _getAttributeNum('min', defaultValue: 0.0) ?? 0;

  set min(num? value) {
    _setAttributeNum('min', value);
  }

  num? get optimum => _getAttributeNum('optimum', defaultValue: 0.0);

  set optimum(num? value) {
    _setAttributeNum('optimum', value);
  }

  num? get value => _getAttributeNum('value', defaultValue: 0.0);

  set value(num? value) {
    _setAttributeNum('value', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => MeterElement._(ownerDocument);
}

class ModElement extends HtmlElement {
  ModElement._(Document ownerDocument) : super._(ownerDocument, 'MOD');

  @override
  Element _newInstance(Document ownerDocument) => ModElement._(ownerDocument);
}

class NoncedElement {
  String? nonce;

  factory NoncedElement._() {
    throw UnimplementedError();
  }
}

class ObjectElement extends HtmlElement with _FormFieldElement {
  static bool get supported => true;

  factory ObjectElement() => ObjectElement._(window.document);

  ObjectElement._(Document ownerDocument) : super._(ownerDocument, 'OBJECT');

  WindowBase? get contentWindow => null;

  String get height => _getAttribute('height') ?? '';

  set height(String value) {
    _setAttribute('height', value);
  }

  String get name => _getAttribute('name') ?? '';

  set name(String value) {
    _setAttribute('name', value);
  }

  String? get type => _getAttribute('type') ?? '';

  set type(String? value) {
    _setAttribute('type', value);
  }

  String get width => _getAttribute('width') ?? '';

  set width(String value) {
    _setAttribute('width', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ObjectElement._(ownerDocument);
}

class OListElement extends HtmlElement {
  factory OListElement() => OListElement._(window.document);

  OListElement._(Document ownerDocument) : super._(ownerDocument, 'OL');

  @override
  Element _newInstance(Document ownerDocument) => OListElement._(ownerDocument);
}

class OptGroupElement extends HtmlElement {
  factory OptGroupElement() => OptGroupElement._(window.document);

  OptGroupElement._(Document ownerDocument)
      : super._(ownerDocument, 'OPTGROUP');

  bool get disabled => _getAttributeBool('disabled');

  set disabled(bool value) {
    _setAttributeBool('disabled', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      OptGroupElement._(ownerDocument);
}

class OptionElement extends HtmlElement
    with _DisabledElement, _FormFieldElement {
  String? label;
  bool? _selected;

  OptionElement({
    String data = '',
    String value = '',
    bool selected = false,
  }) : super._(window.document, 'option') {
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

  OptionElement._(Document ownerDocument, {String nodeName = 'OPTION'})
      : super._(ownerDocument, nodeName);

  bool get defaultSelected => _getAttributeBool('selected');

  set defaultSelected(bool value) {
    _setAttributeBool('selected', value);
  }

  int? get index {
    final selectElement = _selectElement;
    if (selectElement == null) {
      return null;
    }
    final siblings = selectElement.options;
    var i = 0;
    for (var sibling in siblings) {
      if (identical(sibling, this)) {
        return i;
      }
      i++;
    }
    return null;
  }

  bool? get selected => _selected ?? defaultSelected;

  set selected(bool? value) {
    final selectElement = _selectElement;
    if (selectElement == null) {
      return;
    }
    _selected = value;
    if (selectElement.multiple == false) {
      for (var option in selectElement.options) {
        option._selected = identical(option, this);
      }
    }
  }

  String get value => _getAttribute('value') ?? '';

  set value(String value) {
    _setAttribute('value', value);
  }

  SelectElement? get _selectElement {
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

  factory OutputElement() => OutputElement._(window.document);

  OutputElement._(Document ownerDocument) : super._(ownerDocument, 'OUTPUT');

  String? get defaultValue => _getAttribute('value');

  set defaultValue(String? value) {
    _setAttribute('value', value);
  }

  String? get name => _getAttribute('name');

  set name(String? value) {
    _setAttribute('name', value);
  }

  String? get type => _getAttribute('type');

  String? get value => _getAttribute('value');

  set value(String? value) {
    _setAttribute('value', value);
  }

  bool get willValidate => true;

  @override
  Element _newInstance(Document ownerDocument) =>
      OutputElement._(ownerDocument);
}

class ParagraphElement extends HtmlElement {
  factory ParagraphElement() => ParagraphElement._(window.document);

  ParagraphElement._(Document ownerDocument, {String nodeName = 'P'})
      : super._(ownerDocument, nodeName);

  @override
  Element _newInstance(Document ownerDocument) =>
      ParagraphElement._(ownerDocument);
}

class ParamElement extends HtmlElement {
  factory ParamElement() => ParamElement._(window.document);

  ParamElement._(Document ownerDocument) : super._(ownerDocument, 'PARAM');

  String? get name => _getAttribute('name');

  set name(String? value) {
    _setAttribute('name', value);
  }

  String? get value => _getAttribute('value');

  set value(String? value) {
    _setAttribute('value', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => ParamElement._(ownerDocument);
}

class PictureElement extends HtmlElement {
  factory PictureElement.created() => PictureElement._(window.document);

  PictureElement._(Document ownerDocument, {String nodeName = 'PICTURE'})
      : super._(ownerDocument, nodeName);

  @override
  Element _newInstance(Document ownerDocument) =>
      PictureElement._(ownerDocument);
}

class PreElement extends HtmlElement {
  factory PreElement() => PreElement._(window.document);

  PreElement._(Document ownerDocument, {String nodeName = 'PRE'})
      : super._(ownerDocument, nodeName);

  @override
  Element _newInstance(Document ownerDocument) => PreElement._(ownerDocument);
}

class ProgressElement extends HtmlElement {
  static bool get supported => true;

  factory ProgressElement() => ProgressElement._(window.document);

  ProgressElement._(Document ownerDocument, {String nodeName = 'PROGRESS'})
      : super._(ownerDocument, nodeName);

  num? get max => _getAttributeNum('max', defaultValue: null);

  set max(num? value) {
    _setAttributeNum('max', value);
  }

  num? get position => _getAttributeNum('position', defaultValue: null);

  num? get value => _getAttributeNum('value', defaultValue: null);

  set value(num? value) {
    _setAttributeNum('value', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ProgressElement._(ownerDocument);
}

class QuoteElement extends HtmlElement {
  QuoteElement._(Document ownerDocument) : super._(ownerDocument, 'Q');

  @override
  Element _newInstance(Document ownerDocument) => QuoteElement._(ownerDocument);
}

class ScriptElement extends HtmlElement {
  factory ScriptElement() => ScriptElement._(window.document);

  ScriptElement._(Document ownerDocument, {String nodeName = 'SCRIPT'})
      : super._(ownerDocument, nodeName);

  bool get async => _getAttributeBool('async');

  set async(bool value) {
    _setAttributeBool('async', value);
  }

  String? get crossOrigin => _getAttribute('crossorigin');

  set crossOrigin(String? value) {
    _setAttribute('crossorigin', value);
  }

  bool? get defer => _getAttributeBool('defer');

  set defer(bool? value) {
    _setAttributeBool('defer', value);
  }

  String? get integrity => _getAttribute('integrity');

  set integrity(String? value) {
    _setAttribute('integrity', value);
  }

  bool? get noModule => _getAttributeBool('nomodule');

  set noModule(bool? value) {
    _setAttributeBool('nomodule', value);
  }

  String get src => _getAttributeResolvedUri('src') ?? '';

  set src(String value) {
    _setAttribute('src', value);
  }

  String? get type => _getAttribute('type');

  set type(String? value) {
    _setAttribute('type', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      ScriptElement._(ownerDocument);
}

class SelectElement extends HtmlElement
    with _DisabledElement, _FormFieldElement, _LabelsElement {
  factory SelectElement() => SelectElement._(window.document);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  SelectElement.created() : super.created();

  SelectElement._(Document ownerDocument) : super._(ownerDocument, 'SELECT');

  bool get autofocus => _getAttributeBool('autofocus');

  set autofocus(bool value) {
    _setAttributeBool('autofocus', value);
  }

  int? get length => options.length;

  set length(int? newLength) {
    newLength ??= 0;
    while (options.length < newLength) {
      append(OptionElement());
    }
    while (options.length > newLength) {
      options.last.remove();
    }
  }

  bool? get multiple => _getAttributeBool('multiple');

  set multiple(bool? value) {
    _setAttributeBool('multiple', value);
  }

  String? get name => _getAttribute('name');

  set name(String? value) {
    _setAttribute('name', value);
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

  bool get required => _getAttributeBool('required');

  set required(bool value) {
    _setAttributeBool('required', value);
  }

  int get selectedIndex {
    final options = this.options;
    for (var i = 0; i < options.length; i++) {
      if (options[i].selected ?? false) {
        return i;
      }
    }
    return (multiple ?? false) ? -1 : 0;
  }

  set selectedIndex(int value) {
    final options = this.options;
    for (var i = 0; i < options.length; i++) {
      options[i]._selected = i == value;
    }
  }

  List<OptionElement> get selectedOptions {
    if (multiple ?? false) {
      var options = this.options.where((o) => o.selected ?? false).toList();
      return UnmodifiableListView<OptionElement>(options);
    } else {
      return <OptionElement>[options[selectedIndex]];
    }
  }

  int? get size => _getAttributeInt('size');

  set size(int? value) {
    _setAttributeInt('size', value);
  }

  String get type {
    if (multiple ?? false) {
      return 'select-multiple';
    }
    return 'select-one';
  }

  String get validationMessage => '';

  ValidityState get validity => ValidityState.constructor();

  String? get value {
    final options = this.options;
    for (var option in options) {
      if (option.selected ?? false) {
        return option.value;
      }
    }
    if (multiple ?? false) {
      return '';
    }
    return options.first.value;
  }

  set value(String? value) {
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

  OptionElement? namedItem(String name) {
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

  ShadowElement._(Document ownerDocument) : super._(ownerDocument, 'SHADOW');

  @override
  Element _newInstance(Document ownerDocument) =>
      ShadowElement._(ownerDocument);
}

class SlotElement extends HtmlElement {
  SlotElement._(Document ownerDocument) : super._(ownerDocument, 'SLOT');

  String? get name => _getAttribute('name');

  set name(String? value) {
    _setAttribute('name', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => SlotElement._(ownerDocument);
}

class SourceElement extends HtmlElement {
  factory SourceElement() => SourceElement._(window.document);

  SourceElement._(Document ownerDocument) : super._(ownerDocument, 'SOURCE');

  String get media => _getAttribute('media') ?? '';

  set media(String value) {
    _setAttribute('media', value);
  }

  String? get sizes => _getAttribute('sizes');

  set sizes(String? value) {
    _setAttribute('sizes', value);
  }

  String? get src => _getAttribute('src') ?? '';

  set src(String? value) {
    _setAttribute('src', value);
  }

  String? get srcset => _getAttribute('srcset') ?? '';

  set srcset(String? value) {
    _setAttribute('srcset', value);
  }

  String get type => _getAttribute('type') ?? '';

  set type(String value) {
    _setAttribute('type', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      SourceElement._(ownerDocument);
}

class SpanElement extends HtmlElement {
  factory SpanElement() => SpanElement._(window.document);

  SpanElement._(Document ownerDocument) : super._(ownerDocument, 'SPAN');

  @override
  Element _newInstance(Document ownerDocument) => SpanElement._(ownerDocument);
}

class StyleElement extends HtmlElement {
  StyleSheet? _sheet;

  factory StyleElement() => StyleElement._(window.document);

  StyleElement._(Document ownerDocument) : super._(ownerDocument, 'STYLE');

  bool get disabled => _getAttributeBool('disabled');

  set disabled(bool value) {
    _setAttributeBool('disabled', value);
  }

  StyleSheet? get sheet {
    final existing = _sheet;
    if (existing != null) {
      return existing;
    }
    final type = this.type;
    if (type != null && type != '' && type != 'text/css') {
      return null;
    }
    final text = this.text;
    final parsed = css.parse(text as String);
    final styleSheet = CssStyleSheet.constructor();
    for (var node in parsed.topLevels) {
      if (node is css.RuleSet) {
        final styleRule = CssStyleRule.internal(styleSheet, node);
        styleSheet.cssRules.add(styleRule);
      }
    }
    _sheet = styleSheet;
    return styleSheet;
  }

  String? get type => _getAttribute('type');

  set type(String? value) {
    _setAttribute('type', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => StyleElement._(ownerDocument);
}

class TableCaptionElement extends HtmlElement {
  factory TableCaptionElement() => TableCaptionElement._(window.document);

  TableCaptionElement._(Document ownerDocument)
      : super._(ownerDocument, 'CAPTION');

  @override
  Element _newInstance(Document ownerDocument) =>
      TableCaptionElement._(ownerDocument);
}

class TableCellElement extends HtmlElement {
  factory TableCellElement() => TableCellElement._(window.document);

  TableCellElement._(Document ownerDocument) : super._(ownerDocument, 'TD');

  int get cellIndex {
    final parent = this.parent!;
    return parent.children.whereType<TableCellElement>().toList().indexOf(this);
  }

  int get colSpan => _getAttributeInt('colspan') ?? 1;

  set colSpan(int value) {
    _setAttributeInt('colspan', value);
  }

  int get rowSpan => _getAttributeInt('rowspan') ?? 1;

  set rowSpan(int value) {
    _setAttributeInt('rowspan', value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TableCellElement._(ownerDocument);
}

class TableColElement extends HtmlElement {
  factory TableColElement() => TableColElement._(window.document);

  TableColElement._(Document ownerDocument) : super._(ownerDocument, 'COL');

  @override
  Element _newInstance(Document ownerDocument) =>
      TableColElement._(ownerDocument);
}

class TableElement extends HtmlElement {
  factory TableElement() => TableElement._(window.document);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  TableElement.created() : super.created();

  TableElement._(Document ownerDocument) : super._(ownerDocument, 'TABLE');

  TableCaptionElement? get caption => children
      .whereType<TableCaptionElement?>()
      .firstWhere((e) => true, orElse: () => null);

  List<TableRowElement> get rows {
    final tableRows = <TableRowElement>[];
    for (var child in children) {
      if (child is TableRowElement) {
        tableRows.add(child);
      }
      if (child._lowerCaseTagName == 'tbody') {
        for (var grandChild in child.children) {
          if (grandChild is TableRowElement) {
            tableRows.add(grandChild);
          }
        }
      }
    }
    return tableRows;
  }

  List<TableSectionElement> get tBodies {
    return children
        .whereType<TableSectionElement>()
        .where((e) => e.tagName.toLowerCase() == 'body')
        .toList();
  }

  TableSectionElement get tFoot => children
      .whereType<TableSectionElement>()
      .firstWhere((e) => e.tagName.toLowerCase() == 'tfoot');

  TableSectionElement get tHead => children
      .whereType<TableSectionElement>()
      .firstWhere((e) => e.tagName.toLowerCase() == 'thead');

  TableRowElement addRow() => createTBody().addRow();

  TableCaptionElement createCaption() {
    return _createUniqueChild(
      lowerCaseTagName: '_table',
      constructor: () => TableCaptionElement(),
    );
  }

  TableSectionElement createTBody() {
    return _createUniqueChild(
      lowerCaseTagName: '_tbody',
      constructor: () => TableSectionElement._(ownerDocument!, 'tbody'),
    );
  }

  TableSectionElement createTFoot() {
    return _createUniqueChild(
      lowerCaseTagName: '_tfoot',
      constructor: () => TableSectionElement._(ownerDocument!, 'tfoot'),
    );
  }

  TableSectionElement createTHead() {
    return _createUniqueChild(
      lowerCaseTagName: '_thead',
      constructor: () => TableSectionElement._(ownerDocument!, 'thead'),
    );
  }

  void deleteCaption() =>
      children.removeWhere((e) => e._lowerCaseTagName == 'caption');

  void deleteRow(int index) {
    createTBody().deleteRow(index);
  }

  void deleteTFoot() {
    children.removeWhere((e) => e._lowerCaseTagName == 'tfoot');
  }

  void deleteTHead() {
    children.removeWhere((e) => e._lowerCaseTagName == 'tbody');
  }

  TableRowElement insertRow(int index) {
    return createTBody().insertRow(index);
  }

  T _createUniqueChild<T extends Element>({
    required String lowerCaseTagName,
    required T Function() constructor,
  }) {
    final existing = children.whereType<T?>().firstWhere(
        (e) => e != null && e._lowerCaseTagName == lowerCaseTagName,
        orElse: () => null);
    if (existing != null) {
      return existing;
    }
    final section = constructor();
    append(section);
    return section;
  }

  @override
  Element _newInstance(Document ownerDocument) => TableElement._(ownerDocument);
}

class TableRowElement extends HtmlElement {
  factory TableRowElement() => TableRowElement._(window.document);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  TableRowElement.created() : super.created();

  TableRowElement._(Document ownerDocument) : super._(ownerDocument, 'TR');

  List<TableCellElement> get cells {
    return children.whereType<TableCellElement>().toList();
  }

  int get rowIndex {
    final parent = this.parent!;
    final siblings = parent.children.toList();
    for (var i = 0; i < siblings.length; i++) {
      if (identical(siblings[i], this)) {
        return i;
      }
    }
    return -1;
  }

  int get sectionRowIndex {
    final parent = this.parent!;
    final siblings = parent.children.whereType<TableCellElement>().toList();
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
    cells[index].remove();
  }

  TableCellElement insertCell(int index) {
    final cell = TableCellElement();
    if (index == cells.length) {
      insertBefore(cell, null);
      return cell;
    }
    insertBefore(cell, cells[index]);
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
      childNodes.whereType<TableRowElement>().toList();

  TableRowElement addRow() {
    final row = TableRowElement();
    append(row);
    return row;
  }

  void deleteRow(int index) {
    for (var existing in childNodes) {
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
    TableRowElement? before;
    for (var existing in childNodes) {
      if (existing is TableRowElement) {
        index--;
        if (index < 0) {
          before = existing;
          break;
        }
      }
    }
    final row = TableRowElement();
    insertBefore(row, before);
    return row;
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TableSectionElement._(ownerDocument, _lowerCaseTagName);
}

class TemplateElement extends HtmlElement {
  /// Checks if this type is supported on the current platform.
  static bool get supported => Element.isTagSupported('template');

  factory TemplateElement() => TemplateElement._(window.document);

  TemplateElement._(Document ownerDocument)
      : super._(ownerDocument, 'TEMPLATE');

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
    String? html, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    text = null;
    var fragment = createFragment(
      html ?? '',
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
  String dirName = '';
  String selectionDirection = '';
  int selectionEnd = -1;
  int selectionStart = -1;

  factory TextAreaElement() => TextAreaElement._(window.document);

  /// Constructor instantiated by the DOM when a custom element has been created.
  ///
  /// This can only be called by subclasses from their created constructor.
  TextAreaElement.created() : super.created();

  TextAreaElement._(Document ownerDocument)
      : super._(ownerDocument, 'TEXTAREA');

  String? get autocapitalize => _getAttribute('autocapitalize');

  set autocapitalize(String? value) {
    _setAttribute('autocapitalize', value);
  }

  bool get autofocus => _getAttributeBool('autofocus');

  set autofocus(bool value) {
    _setAttributeBool('autofocus', value);
  }

  int get cols => _getAttributeInt('cols') ?? 20;

  set cols(int value) {
    _setAttributeInt('cols', value);
  }

  String get defaultValue => _getAttribute('value') ?? '';

  set defaultValue(String value) {
    _setAttribute('value', value);
  }

  @override
  List<Node> get labels => <Node>[];

  int get maxLength => _getAttributeInt('maxlength') ?? -1;

  set maxLength(int value) {
    _setAttributeInt('maxlength', value);
  }

  int get minLength => _getAttributeInt('minlength') ?? -1;

  set minLength(int value) {
    _setAttributeInt('minlength', value);
  }

  String get name => _getAttribute('name') ?? '';

  set name(String value) {
    _setAttribute('name', value);
  }

  String get placeholder => _getAttribute('placeholder') ?? '';

  set placeholder(String value) {
    _setAttribute('placeholder', value);
  }

  bool? get readOnly => _getAttributeBool('readonly');

  set readOnly(bool? value) {
    _setAttributeBool('readonly', value);
  }

  bool get required => _getAttributeBool('required');

  set required(bool value) {
    _setAttributeBool('required', value);
  }

  int get rows => _getAttributeInt('rows') ?? 2;

  set rows(int value) {
    _setAttributeInt('rows', value);
  }

  int? get textLength => value?.length;

  String? get type => null;

  String? get validationMessage => null;

  ValidityState get validity => ValidityState.constructor();

  String? get value => text;

  set value(String? value) {
    text = value?.replaceAll('\n', '');
  }

  bool get willValidate {
    return !(_ancestors.any((e) => e is DataListElement) || disabled);
  }

  String get wrap => _getAttribute('wrap') ?? '';

  set wrap(String value) {
    _setAttribute('wrap', value);
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
    setSelectionRange(0, textLength ?? 0);
  }

  void setCustomValidity(String error) {}

  void setRangeText(
    String replacement, {
    int? start,
    int? end,
    String? selectionMode,
  }) {}

  void setSelectionRange(int start, int end, [String? direction]) {
    selectionStart = start;
    selectionEnd = end;
    selectionDirection = direction ?? '';
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TextAreaElement._(ownerDocument);
}

class TimeElement extends HtmlElement {
  TimeElement._(Document ownerDocument) : super._(ownerDocument, 'TIME');

  String get dateTime => _getAttribute('datetime') ?? '';

  set dateTime(String value) {
    _setAttribute('datetime', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => TimeElement._(ownerDocument);
}

class TitleElement extends HtmlElement {
  factory TitleElement() => TitleElement._(window.document);

  TitleElement._(Document ownerDocument) : super._(ownerDocument, 'TITLE');

  @override
  Element _newInstance(Document ownerDocument) => TitleElement._(ownerDocument);
}

class TrackElement extends HtmlElement {
  static bool get supported => true;

  factory TrackElement() => TrackElement._(window.document);

  TrackElement._(Document ownerDocument) : super._(ownerDocument, 'TRACK');

  String? get kind => _getAttribute('kind');

  set kind(String? value) {
    _setAttribute('kind', value);
  }

  String? get label => _getAttribute('label');

  set label(String? value) {
    _setAttribute('label', value);
  }

  String? get src => _getAttributeResolvedUri('src') ?? '';

  set src(String? value) {
    _setAttribute('src', value);
  }

  @override
  Element _newInstance(Document ownerDocument) => TrackElement._(ownerDocument);
}

class UListElement extends HtmlElement {
  factory UListElement() => UListElement._(window.document);

  UListElement._(Document ownerDocument) : super._(ownerDocument, 'UL');

  @override
  Element _newInstance(Document ownerDocument) => UListElement._(ownerDocument);
}

class UnknownElement extends HtmlElement {
  final String? _namespaceUri;

  /// Internal constructor. __Not part of dart:html__.
  UnknownElement.internal(
      Document ownerDocument, this._namespaceUri, String tag)
      : super._(ownerDocument, tag);

  @override
  String? get namespaceUri {
    if (_namespaceUri != null) {
      return _namespaceUri;
    }
    return super.namespaceUri;
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      UnknownElement.internal(ownerDocument, namespaceUri, _lowerCaseTagName);
}

class ValidityState {
  final bool? badInput;
  final bool? customError;
  final bool? patternMismatch;
  final bool? rangeOverflow;
  final bool? rangeUnderflow;
  final bool? stepMismatch;
  final bool? tooLong;
  final bool? tooShort;
  final bool? typeMismatch;
  final bool? valid;
  final bool? valueMissing;

  ValidityState.constructor({
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
  factory VideoElement() => VideoElement._(window.document);

  VideoElement._(Document ownerDocument) : super._(ownerDocument, 'VIDEO');

  num get duration => 0;

  bool get ended => false;

  int get height => _getAttributeInt('height') ?? 0;

  set height(int value) {
    _setAttributeInt('height', value);
  }

  bool get paused => false;

  String get poster => _getAttribute('poster') ?? '';

  set poster(String value) {
    _setAttribute('poster', value);
  }

  int get width => _getAttributeInt('width') ?? 0;

  set width(int value) {
    _setAttributeInt('width', value);
  }

  void enterFullscreen() {}

  void exitFullscreen() {}

  VideoPlaybackQuality getVideoPlaybackQuality() {
    throw UnimplementedError();
  }

  @override
  Element _newInstance(Document ownerDocument) => VideoElement._(ownerDocument);
}

mixin _DisabledElement implements HtmlElement {
  bool get disabled => _getAttributeBool('disabled');

  set disabled(bool value) {
    _setAttributeBool('disabled', value);
  }
}

mixin _FormFieldElement implements HtmlElement {
  FormElement? get form {
    var ancestor = parent;
    while (ancestor != null) {
      if (ancestor is FormElement) {
        return ancestor;
      }
      ancestor = ancestor.parent;
    }
    return null;
  }
}

mixin _HrefAttributeElement implements HtmlElement {
  String? get href {
    return _getAttributeResolvedUri('href') ?? '';
  }

  set href(String? value) {
    _setAttribute('href', value);
  }

  String? get referrerPolicy => _getAttribute('referrerpolicy') ?? '';

  set referrerPolicy(String? value) {
    _setAttribute('referrerpolicy', value);
  }
}

mixin _HtmlHyperlinkElementUtils
    implements HtmlHyperlinkElementUtils, _UrlBase {
  @override
  set host(String? value) {
    throw UnimplementedError();
  }

  @override
  set hostname(String? value) {
    throw UnimplementedError();
  }

  @override
  String? get href;

  @override
  set href(String? value);

  @override
  String? get password {
    final userInfo = _uri?.userInfo;
    if (userInfo == null) {
      return null;
    }
    final i = userInfo.indexOf(':');
    if (i < 0) {
      return null;
    }
    return userInfo.substring(i + 1);
  }

  @override
  set password(String? value) {
    throw UnimplementedError();
  }

  @override
  set protocol(String? value) {
    throw UnimplementedError();
  }

  @override
  String? get username {
    final userInfo = _uri?.userInfo;
    if (userInfo == null) {
      return null;
    }
    final i = userInfo.indexOf(':');
    if (i < 0) {
      return userInfo;
    }
    return userInfo.substring(0, i);
  }

  @override
  set username(String? value) {
    throw UnimplementedError();
  }

  @override
  Uri? get _uri => Uri.parse(href!);
}

mixin _LabelsElement implements HtmlElement {
  List<Node> get labels {
    return const <Node>[];
  }
}
