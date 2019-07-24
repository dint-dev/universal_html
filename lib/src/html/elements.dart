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

part of universal_html;

class AnchorElement extends HtmlElement with _UrlBase {
  factory AnchorElement() => AnchorElement._(null);

  AnchorElement._(Document ownerDocument) : super._(ownerDocument, "A");

  String get download => _getAttribute("download");

  set download(String value) {
    _setAttribute("download", value);
  }

  String get href => _getAttribute("href");

  set href(String value) {
    _setAttribute("href", value);
  }

  String get hreflang => _getAttribute("hreflang");

  set hreflang(String value) {
    _setAttribute("hreflang", value);
  }

  String get rel => _getAttribute("ref");

  set rel(String value) {
    _setAttribute("ref", value);
  }

  String get target => _getAttribute("target");

  set target(String value) {
    _setAttribute("target", value);
  }

  @override
  Uri get _uri => Uri.parse(href);

  @override
  Element _newInstance(Document ownerDocument) =>
      AnchorElement._(ownerDocument);
}

class AreaElement extends MediaElement {
  factory AreaElement() => AreaElement._(null);

  AreaElement._(Document ownerDocument, {String nodeName = "AREA"})
      : super._(ownerDocument, nodeName);

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

class BodyElement extends HtmlElement {
  factory BodyElement() => BodyElement._(null);

  BodyElement._(Document ownerDocument) : super._(ownerDocument, "BODY");

  @override
  Element _newInstance(Document ownerDocument) => BodyElement._(ownerDocument);
}

class BRElement extends HtmlElement {
  factory BRElement() => BRElement._(null);

  BRElement._(Document ownerDocument) : super._(ownerDocument, "BR");

  @override
  Element _newInstance(Document ownerDocument) => BRElement._(ownerDocument);
}

class ButtonElement extends HtmlElement {
  factory ButtonElement() => ButtonElement._(null);

  ButtonElement._(Document ownerDocument) : super._(ownerDocument, "BUTTON");

  @override
  Element _newInstance(Document ownerDocument) =>
      ButtonElement._(ownerDocument);
}

class CanvasElement extends HtmlElement implements CanvasImageSource {
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

  CanvasRenderingContext2D get context2D {
    if (_context2D == null) {
      final htmlDriver = ownerDocument?._htmlDriver ?? HtmlDriver.current;
      _context2D = htmlDriver.newCanvasRenderingContext2D(this);
    }
    return _context2D;
  }

  int get height => _getAttributeInt("height");

  int get width => _getAttributeInt("width");

  MediaStream captureStream([num frameRate]) {
    throw UnimplementedError();
  }

  void toBlob(BlobCallback callback, String type, [Object arguments]) {
    throw UnimplementedError();
  }

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

class DataListElement extends HtmlElement {
  factory DataListElement() => DataListElement._(null);

  DataListElement._(Document ownerDocument)
      : super._(ownerDocument, "DATALIST");

  @override
  Element _newInstance(Document ownerDocument) =>
      DataListElement._(ownerDocument);
}

class DetailsElement extends HtmlElement {
  factory DetailsElement() => DetailsElement._(null);

  DetailsElement._(Document ownerDocument) : super._(ownerDocument, "DETAILS");

  @override
  Element _newInstance(Document ownerDocument) =>
      DetailsElement._(ownerDocument);
}

class DialogElement extends HtmlElement {
  bool open;

  String returnValue;

  factory DialogElement() => DialogElement._(null);

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

class FieldSetElement extends HtmlElement {
  factory FieldSetElement() => FieldSetElement._(null);

  FieldSetElement._(Document ownerDocument)
      : super._(ownerDocument, "FIELDSET");

  @override
  Element _newInstance(Document ownerDocument) =>
      FieldSetElement._(ownerDocument);
}

class FormElement extends HtmlElement {
  factory FormElement() => FormElement._(null);

  FormElement._(Document ownerDocument) : super._(ownerDocument, "FORM");

  String get action => _getAttribute("action");

  set action(String value) {
    _setAttribute("action", value);
  }

  String get method => _getAttribute("method");

  set method(String value) {
    _setAttribute("method", value);
  }

  bool get noValidate => _getAttributeBool("novalidate");

  set noValidate(bool value) {
    _setAttributeBool("novalidate", value);
  }

  String get target => _getAttribute("target");

  set target(String value) {
    _setAttribute("target", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => FormElement._(ownerDocument);
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

class IFrameElement extends HtmlElement {
  factory IFrameElement() => IFrameElement._(null);

  IFrameElement._(Document ownerDocument) : super._(ownerDocument, "IFRAME");

  bool get allowfullscreen => _getAttributeBool("allowfullscreen");

  set allowfullscreen(bool value) {
    _setAttributeBool("allowfullscreen", value);
  }

  bool get allowpaymentrequest => _getAttributeBool("allowpaymentrequest");

  set allowpaymentrequest(bool value) {
    _setAttributeBool("allowpaymentrequest", value);
  }

  WindowBase get contentWidget => null;

  String get csp => _getAttribute("csp");

  set csp(String value) {
    _setAttribute("csp", value);
  }

  int get height => _getAttributeInt("height");

  set height(int value) {
    _setAttributeInt("height", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  String get sandbox => _getAttribute("sandbox");

  set sandbox(String value) {
    _setAttribute("sandbox", value);
  }

  String get src => _getAttribute("src");

  set src(String value) {
    _setAttribute("src", value);
  }

  int get width => _getAttributeInt("width");

  set width(int value) {
    _setAttributeInt("width", value);
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

  String get crossorigin => _getAttribute("crossorigin");

  set crossorigin(String value) {
    _setAttribute("crossorigin", value);
  }

  String get currentSrc => null;

  int get height => _getAttributeInt("height");

  set height(int value) {
    _setAttributeInt("height", value);
  }

  int get naturalHeight => null;

  int get naturalWidth => null;

  String get sizes => _getAttribute("sizes");

  set sizes(String value) {
    _setAttribute("sizes", value);
  }

  String get src {
    final uriString = _getAttribute("src");
    if (uriString == null) {
      return null;
    }
    final uri = Uri.parse(uriString);
    if (uri.isAbsolute) {
      return uriString;
    }
    final baseUriString = this.baseUri;
    if (baseUriString == null) {
      return uriString;
    }
    final baseUri = Uri.parse(baseUriString);
    if (!baseUri.isAbsolute) {
      return uriString;
    }
    return baseUri.resolveUri(uri).toString();
  }

  set src(String value) {
    _setAttribute("src", value);
  }

  String get srcset => _getAttribute("srcset");

  set srcset(String value) {
    _setAttribute("srcset", value);
  }

  int get width => _getAttributeInt("width");

  set width(int value) {
    _setAttributeInt("width", value);
  }

  Future decode() => throw UnimplementedError();

  @override
  Element _newInstance(Document ownerDocument) => ImageElement._(ownerDocument);
}

class InputElement extends HtmlElement
    with _TextInputElementMixin
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
  String accept;

  String alt;

  String autocapitalize;

  String autocomplete;

  bool autofocus;

  String capture;

  bool checked;

  bool defaultChecked;

  String defaultValue;

  String dirName;

  bool disabled;

  List<File> files;

  FormElement form;

  String formAction;

  String formEnctype;

  String formMethod;

  bool formNoValidate;

  String formTarget;

  int height;

  bool incremental;

  bool indeterminate;

  List<Node> labels;

  HtmlElement list;

  String max;

  int maxLength;

  String min;

  int minLength;

  bool multiple;

  String name;

  String pattern;

  String placeholder;

  bool readOnly;

  bool required;

  String selectionDirection;

  int selectionEnd;

  int selectionStart;

  int size;

  String src;

  String step;

  String type;

  String validationMessage;

  ValidityState validity;

  String value;

  num valueAsNumber;

  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.SAFARI)
  List<Entry> entries;

  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.SAFARI)
  bool directory;

  int width;

  bool willValidate;

  factory InputElement({String type}) {
    InputElement e = InputElement._(null);
    e.type = type;
    return e;
  }

  InputElement._(Document ownerDocument) : super._(ownerDocument, "INPUT");

  DateTime get valueAsDate {
    throw UnimplementedError();
  }

  set valueAsDate(DateTime value) {
    throw UnimplementedError();
  }

  bool checkValidity() {
    throw UnimplementedError();
  }

  bool reportValidity() {
    throw UnimplementedError();
  }

  void select() {}

  void setCustomValidity(String error) {}

  void setRangeText(String replacement,
      {int start, int end, String selectionMode}) {}

  void setSelectionRange(int start, int end, [String direction]) {}

  void stepDown([int n]) {}

  void stepUp([int n]) {}

  @override
  Element _newInstance(Document ownerDocument) => InputElement._(ownerDocument);
}

class LabelElement extends HtmlElement {
  factory LabelElement() => LabelElement._(null);

  LabelElement._(Document ownerDocument) : super._(ownerDocument, "LABEL");

  String get htmlFor => _getAttribute("for");

  set htmlFor(String value) {
    _setAttribute("for", value);
  }

  @override
  Element _newInstance(Document ownerDocument) => LabelElement._(ownerDocument);
}

class LegendElement extends HtmlElement {
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

class LinkElement extends HtmlElement {
  factory LinkElement() => LinkElement._(null);

  LinkElement._(Document ownerDocument) : super._(ownerDocument, "LINK");

  @override
  Element _newInstance(Document ownerDocument) => LinkElement._(ownerDocument);
}

abstract class MediaElement extends HtmlElement {
  MediaElement._(Document ownerDocument, String tag)
      : super._(ownerDocument, tag);

  bool get autoplay => _getAttributeBool("autoplay");

  set autoplay(bool value) {
    _setAttributeBool("autoplay", value);
  }

  bool get loop => _getAttributeBool("loop");

  set loop(bool value) {
    _setAttributeBool("loop", value);
  }

  bool get muted => _getAttributeBool("muted");

  set muted(bool value) {
    _setAttributeBool("muted", value);
  }

  String get preload => _getAttribute("preload");

  set preload(String value) {
    _setAttribute("preload", value);
  }

  String get src => _getAttribute("src");

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

abstract class NoncedElement {
  String get nonce;

  set nonce(String value);
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

class OptionElement extends HtmlElement {
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

  OptionElement._(Document ownerDocument, {String nodeName = "OPTION"})
      : super._(ownerDocument, nodeName);

  bool get disabled => _getAttributeBool("disabled");

  set disabled(bool value) {
    _setAttributeBool("disabled", value);
  }

  bool get selected => _getAttributeBool("selected");

  set selected(bool value) {
    _setAttributeBool("selected", value);
  }

  String get value => _getAttribute("value");

  set value(String value) {
    _setAttribute("value", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      OptionElement._(ownerDocument);
}

class ParagraphElement extends HtmlElement {
  factory ParagraphElement() => ParagraphElement._(null);

  ParagraphElement._(Document ownerDocument, {String nodeName = "P"})
      : super._(ownerDocument, nodeName);

  @override
  Element _newInstance(Document ownerDocument) =>
      ParagraphElement._(ownerDocument);
}

class PictureElement extends HtmlElement {
  factory PictureElement() => PictureElement._(null);

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

  bool get noModule => _getAttributeBool("nomodule");

  set noModule(bool value) {
    _setAttributeBool("nomodule", value);
  }

  String get src => _getAttribute("src");

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

class SelectElement extends HtmlElement {
  factory SelectElement() => SelectElement._(null);

  SelectElement._(Document ownerDocument) : super._(ownerDocument, "SELECT");

  bool get autofocus => _getAttributeBool("autofocus");

  set autofocus(bool value) {
    _setAttributeBool("autofocus", value);
  }

  bool get disabled => _getAttributeBool("disabled");

  set disabled(bool value) {
    _setAttributeBool("disabled", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  List<OptionElement> get options =>
      this.childNodes.whereType<OptionElement>().toList();

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  String get value => _getAttribute("value");

  set value(String value) {
    _setAttribute("value", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      SelectElement._(ownerDocument);
}

class SlotElement extends HtmlElement {
  factory SlotElement() => SlotElement._(null);

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

  int get cellIndex => _getAttributeInt("cellindex");

  set cellIndex(int value) {
    _setAttributeInt("colspan", value);
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

class TableElement extends HtmlElement {
  factory TableElement() => TableElement._(null);

  TableElement._(Document ownerDocument) : super._(ownerDocument, "TABLE");

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

  TableRowElement._(Document ownerDocument) : super._(ownerDocument, "TR");

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

class TextAreaElement extends HtmlElement {
  factory TextAreaElement() => TextAreaElement._(null);

  TextAreaElement._(Document ownerDocument)
      : super._(ownerDocument, "TEXTAREA");

  int get cols => _getAttributeInt("cols");

  set cols(int value) {
    _setAttributeInt("cols", value);
  }

  int get maxLength => _getAttributeInt("maxlength");

  set maxLength(int value) {
    _setAttributeInt("maxlength", value);
  }

  int get minLength => _getAttributeInt("minlength");

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

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  int get rows => _getAttributeInt("rows");

  set rows(int value) {
    _setAttributeInt("rows", value);
  }

  String get value => _getAttribute("value");

  set value(String value) {
    _setAttribute("value", value);
  }

  String get wrap => _getAttribute("wrap");

  set wrap(String value) {
    _setAttribute("wrap", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      TextAreaElement._(ownerDocument);
}

class TitleElement extends HtmlElement {
  factory TitleElement() => TitleElement._(null);

  TitleElement._(Document ownerDocument) : super._(ownerDocument, "TITLE");

  @override
  Element _newInstance(Document ownerDocument) => TitleElement._(ownerDocument);
}

class TrackElement extends HtmlElement {
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

  String get src => _getAttribute("src");

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

  /// IMPORTANT: Not part 'dart:html'.
  UnknownElement.internal(Document ownerDocument, this.namespaceUri, String tag)
      : super._(ownerDocument, tag);

  @override
  Element _newInstance(Document ownerDocument) =>
      UnknownElement.internal(ownerDocument, namespaceUri, _lowerCaseTagName);
}

abstract class ValidityState {
  bool get badInput;

  bool get customError;

  bool get patternMismatch;

  bool get rangeOverflow;

  bool get rangeUnderflow;

  bool get stepMismatch;

  bool get tooLong;

  bool get tooShort;

  bool get typeMismatch;

  bool get valid;

  bool get valueMissing;
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
