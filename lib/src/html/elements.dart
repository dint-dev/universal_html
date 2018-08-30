part of universal_html;

class AnchorElement extends HtmlElement with _UrlBase {
  factory AnchorElement() => AnchorElement._(null);

  AnchorElement._(Document ownerDocument) : super._(ownerDocument, "a");

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
      new AnchorElement._(ownerDocument);
}

class AudioElement extends MediaElement {
  factory AudioElement() => AudioElement._(null);

  AudioElement._(Document ownerDocument) : super._(ownerDocument, "audio");

  @override
  Element _newInstance(Document ownerDocument) =>
      new AudioElement._(ownerDocument);
}

class BodyElement extends HtmlElement {
  factory BodyElement() => BodyElement._(null);

  BodyElement._(Document ownerDocument) : super._(ownerDocument, "body");

  @override
  Element _newInstance(Document ownerDocument) =>
      new BodyElement._(ownerDocument);
}

class BRElement extends HtmlElement {
  factory BRElement() => BRElement._(null);

  BRElement._(Document ownerDocument) : super._(ownerDocument, "br");

  @override
  Element _newInstance(Document ownerDocument) =>
      new BRElement._(ownerDocument);
}

class ButtonElement extends HtmlElement {
  factory ButtonElement() => ButtonElement._(null);

  ButtonElement._(Document ownerDocument) : super._(ownerDocument, "button");

  @override
  Element _newInstance(Document ownerDocument) =>
      new ButtonElement._(ownerDocument);
}

class ButtonInputElement extends InputElementBase {
  factory ButtonInputElement() => ButtonInputElement._(null);

  ButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "button");

  @override
  Element _newInstance(Document ownerDocument) =>
      new ButtonInputElement._(ownerDocument);
}

class CanvasElement extends HtmlElement {
  CanvasRenderingContext2D _context2D;

  CanvasElement({int width, int height}) : super._(null, "canvas") {
    if (width != null) {
      _setAttributeInt("width", width);
    }
    if (height != null) {
      _setAttributeInt("height", height);
    }
  }

  CanvasElement._(Document ownerDocument) : super._(ownerDocument, "canvas");

  CanvasRenderingContext2D get context2D {
    return _context2D ??= new CanvasRenderingContext2D._(this);
  }

  int get height => _getAttributeInt("height");

  int get width => _getAttributeInt("width");

  MediaStream captureStream([num frameRate]) {
    throw new CanvasRenderingContext2D._(this);
  }

  void toBlob(BlobCallback callback, String type, [Object arguments]) {
    throw new UnimplementedError();
  }

  String toDataUrl([String type = 'image/png', num quality]) {
    throw new UnimplementedError();
  }

  OffscreenCanvas transferControlToOffscreen() {
    throw new UnimplementedError();
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new CanvasElement._(ownerDocument);
}

class CheckboxInputElement extends InputElementBase {
  factory CheckboxInputElement() => CheckboxInputElement._(null);

  CheckboxInputElement._(Document ownerDocument)
      : super._(ownerDocument, "checkbox");

  bool get checked => _getAttributeBool("checked");

  set checked(bool value) {
    _setAttributeBool("checked", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new CheckboxInputElement._(ownerDocument);
}

class DataListElement extends HtmlElement {
  factory DataListElement() => DataListElement._(null);

  DataListElement._(Document ownerDocument)
      : super._(ownerDocument, "datalist");

  @override
  Element _newInstance(Document ownerDocument) =>
      new DataListElement._(ownerDocument);
}

class DateInputElement extends InputElementBase {
  factory DateInputElement() => DateInputElement._(null);

  DateInputElement._(Document ownerDocument) : super._(ownerDocument, "date");

  bool get readonly => _getAttributeBool("readonly");

  set readonly(bool value) {
    _setAttributeBool("readonly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  DateTime get valueAsDate => DateTime.parse(value);

  @override
  Element _newInstance(Document ownerDocument) =>
      new DateInputElement._(ownerDocument);
}

class DateTimeLocalInputElement extends InputElementBase {
  factory DateTimeLocalInputElement() => DateTimeLocalInputElement._(null);

  DateTimeLocalInputElement._(Document ownerDocument)
      : super._(ownerDocument, "datetime-local");

  bool get readonly => _getAttributeBool("readonly");

  set readonly(bool value) {
    _setAttributeBool("readonly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  DateTime get valueAsDate => DateTime.parse(value);

  @override
  Element _newInstance(Document ownerDocument) =>
      new DateTimeLocalInputElement._(ownerDocument);
}

class DetailsElement extends HtmlElement {
  factory DetailsElement() => DetailsElement._(null);

  DetailsElement._(Document ownerDocument) : super._(ownerDocument, "details");

  @override
  Element _newInstance(Document ownerDocument) =>
      new DetailsElement._(ownerDocument);
}

class DivElement extends HtmlElement {
  factory DivElement() => DivElement._(null);

  DivElement._(Document ownerDocument) : super._(ownerDocument, "div");

  @override
  Element _newInstance(Document ownerDocument) =>
      new DivElement._(ownerDocument);
}

class DListElement extends HtmlElement {
  factory DListElement() => DListElement._(null);

  DListElement._(Document ownerDocument) : super._(ownerDocument, "dl");

  @override
  Element _newInstance(Document ownerDocument) =>
      new DListElement._(ownerDocument);
}

class EmailInputElement extends TextInputElementBase {
  factory EmailInputElement() => EmailInputElement._(null);

  EmailInputElement._(Document ownerDocument) : super._(ownerDocument, "email");

  @override
  Element _newInstance(Document ownerDocument) =>
      new EmailInputElement._(ownerDocument);
}

class FieldSetElement extends HtmlElement {
  factory FieldSetElement() => FieldSetElement._(null);

  FieldSetElement._(Document ownerDocument)
      : super._(ownerDocument, "fieldset");

  @override
  Element _newInstance(Document ownerDocument) =>
      new FieldSetElement._(ownerDocument);
}

class FileUploadInputElement extends InputElementBase {
  factory FileUploadInputElement() => FileUploadInputElement._(null);

  FileUploadInputElement._(Document ownerDocument)
      : super._(ownerDocument, "file");

  String get accept => _getAttribute("accept");

  set accept(String value) {
    _setAttribute("accept", value);
  }

  List<File> get files => throw UnimplementedError();

  bool get multiple => _getAttributeBool("multiple");

  set multiple(bool value) {
    _setAttributeBool("multiple", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new FileUploadInputElement._(ownerDocument);
}

class FormElement extends HtmlElement {
  factory FormElement() => FormElement._(null);

  FormElement._(Document ownerDocument) : super._(ownerDocument, "form");

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
  Element _newInstance(Document ownerDocument) =>
      new FormElement._(ownerDocument);
}

class HeadElement extends HtmlElement {
  factory HeadElement() => HeadElement._(null);

  HeadElement._(Document ownerDocument) : super._(ownerDocument, "head");

  @override
  Element _newInstance(Document ownerDocument) =>
      new HeadElement._(ownerDocument);
}

class HeadingElement extends HtmlElement {
  factory HeadingElement.h1() => HeadingElement._(null, "h1");

  factory HeadingElement.h2() => HeadingElement._(null, "h2");

  factory HeadingElement.h3() => HeadingElement._(null, "h3");

  factory HeadingElement.h4() => HeadingElement._(null, "h4");

  factory HeadingElement.h5() => HeadingElement._(null, "h5");

  factory HeadingElement.h6() => HeadingElement._(null, "h6");

  HeadingElement._(Document ownerDocument, String name)
      : super._(ownerDocument, name);

  @override
  Element _newInstance(Document ownerDocument) =>
      new HeadingElement._(ownerDocument, _lowerCaseTagName);
}

class HiddenInputElement extends InputElementBase {
  factory HiddenInputElement() => HiddenInputElement._(null);

  HiddenInputElement._(Document ownerDocument)
      : super._(ownerDocument, "hidden");

  @override
  Element _newInstance(Document ownerDocument) =>
      new HiddenInputElement._(ownerDocument);
}

class HRElement extends HtmlElement {
  factory HRElement() => HRElement._(null);

  HRElement._(Document ownerDocument) : super._(ownerDocument, "hr");

  @override
  Element _newInstance(Document ownerDocument) =>
      new HRElement._(ownerDocument);
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
  factory HtmlHtmlElement() => new HtmlHtmlElement._(null);

  HtmlHtmlElement._(Document ownerDocument) : super._(ownerDocument, "html");

  @override
  Element _newInstance(Document ownerDocument) =>
      new HtmlHtmlElement._(ownerDocument);
}

class IFrameElement extends HtmlElement {
  factory IFrameElement() => new IFrameElement._(null);

  IFrameElement._(Document ownerDocument) : super._(ownerDocument, "iframe");

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
      new IFrameElement._(ownerDocument);
}

class ImageButtonInputElement extends InputElementBase {
  factory ImageButtonInputElement() => ImageButtonInputElement._(null);

  ImageButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "image");

  String get alt => _getAttribute("alt");

  set alt(String value) {
    _setAttribute("alt", value);
  }

  int get height => _getAttributeInt("height");

  set height(int value) {
    _setAttributeInt("height", value);
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
      new ImageButtonInputElement._(ownerDocument);
}

class ImageElement extends HtmlElement {
  factory ImageElement() => ImageElement._(null);

  ImageElement._(Document ownerDocument) : super._(ownerDocument, "img");

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

  String get src => _getAttribute("src");

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

  Future decode() => throw new UnimplementedError();

  @override
  Element _newInstance(Document ownerDocument) =>
      new ImageElement._(ownerDocument);
}

class InputElementBase extends HtmlElement {
  InputElementBase() : super._(null, "input");

  InputElementBase._(Document ownerDocument, String type)
      : super._(ownerDocument, "input") {
    _setAttribute("type", type);
  }

  factory InputElementBase._fromType(Document ownerDocument, String type) {
    switch (type) {
      case "button":
        return new ButtonInputElement._(ownerDocument);
      case "checkbox":
        return new CheckboxInputElement._(ownerDocument);
      case "date":
        return new DateInputElement._(ownerDocument);
      case "datetime-local":
        return new DateTimeLocalInputElement._(ownerDocument);
      case "email":
        return new EmailInputElement._(ownerDocument);
      case "hidden":
        return new HiddenInputElement._(ownerDocument);
      case "image":
        return new ImageButtonInputElement._(ownerDocument);
      case "number":
        return new NumberInputElement._(ownerDocument);
      case "password":
        return new PasswordInputElement._(ownerDocument);
      case "submit":
        return new SubmitButtonInputElement._(ownerDocument);
      case "telephone":
        return new TelephoneInputElement._(ownerDocument);
      case "text":
        return new TextInputElement._(ownerDocument);
      case "time":
        return new TimeInputElement._(ownerDocument);
      case "radio":
        return new RadioButtonInputElement._(ownerDocument);
      case "reset":
        return new ResetButtonInputElement._(ownerDocument);
      case "url":
        return new UrlInputElement._(ownerDocument);
      default:
        return new InputElementBase._(ownerDocument, null);
    }
  }

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

  String get validationMessage => _getAttribute("validationmessage");

  set validationMessage(String value) {
    _setAttribute("validationmessage", value);
  }

  ValidityState get validity => throw UnimplementedError();

  String get value => _getAttribute("value");

  set value(String value) {
    _setAttribute("value", value);
  }

  num get valueAsNumber {
    final value = this.value;
    return value == null ? null : num.parse(value);
  }

  set valueAsNumber(num value) {
    this.value = value?.toString();
  }

  bool checkValidity() => true;

  @override
  Element _newInstance(Document ownerDocument) =>
      new InputElementBase._(ownerDocument, null);
}

class LabelElement extends HtmlElement {
  factory LabelElement() => LabelElement._(null);

  LabelElement._(Document ownerDocument) : super._(ownerDocument, "label");

  String get htmlFor => _getAttribute("for");

  set htmlFor(String value) {
    _setAttribute("for", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new LabelElement._(ownerDocument);
}

class LegendElement extends HtmlElement {
  factory LegendElement() => LegendElement._(null);

  LegendElement._(Document ownerDocument) : super._(ownerDocument, "legend");

  @override
  Element _newInstance(Document ownerDocument) =>
      new LegendElement._(ownerDocument);
}

class LIElement extends HtmlElement {
  factory LIElement() => LIElement._(null);

  LIElement._(Document ownerDocument) : super._(ownerDocument, "li");

  @override
  Element _newInstance(Document ownerDocument) =>
      new LIElement._(ownerDocument);
}

class LinkElement extends HtmlElement {
  factory LinkElement() => LinkElement._(null);

  LinkElement._(Document ownerDocument) : super._(ownerDocument, "link");

  @override
  Element _newInstance(Document ownerDocument) =>
      new LinkElement._(ownerDocument);
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
    throw new UnimplementedError();
  }

  String canPlayType(String type, [String keySystem]) {
    throw new UnimplementedError();
  }

  MediaStream captureStream() {
    throw new UnimplementedError();
  }

  void load() {}

  void pause() {}

  Future play() {
    throw new UnimplementedError();
  }

  Future setMediaKeys(MediaKeys mediaKeys) {
    throw new UnimplementedError();
  }

  Future setSinkId(String sinkId) {
    throw new UnimplementedError();
  }
}

class MetaElement extends HtmlElement {
  factory MetaElement() => MetaElement._(null);

  MetaElement._(Document ownerDocument) : super._(ownerDocument, "meta");

  String get content => _getAttribute("content");

  set content(String value) {
    _setAttribute("content", value);
  }

  String get name => _getAttribute("name");

  set name(String value) {
    _setAttribute("name", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new MetaElement._(ownerDocument);
}

abstract class NoncedElement {
  String get nonce;

  set nonce(String value);
}

class NumberInputElement extends InputElementBase {
  factory NumberInputElement() => NumberInputElement._(null);

  NumberInputElement._(Document ownerDocument)
      : super._(ownerDocument, "number");

  String get placeholder => _getAttribute("placeholder");

  set placeholder(String value) {
    _setAttribute("placeholder", value);
  }

  bool get readonly => _getAttributeBool("readonly");

  set readonly(bool value) {
    _setAttributeBool("readonly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new NumberInputElement._(ownerDocument);
}

class OListElement extends HtmlElement {
  factory OListElement() => OListElement._(null);

  OListElement._(Document ownerDocument) : super._(ownerDocument, "ol");

  @override
  Element _newInstance(Document ownerDocument) =>
      new OListElement._(ownerDocument);
}

class OptGroupElement extends HtmlElement {
  factory OptGroupElement() => OptGroupElement._(null);

  OptGroupElement._(Document ownerDocument)
      : super._(ownerDocument, "optgroup");

  @override
  Element _newInstance(Document ownerDocument) =>
      new OptGroupElement._(ownerDocument);
}

class OptionElement extends HtmlElement {
  OptionElement({String data: '', String value: '', bool selected: false})
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

  OptionElement._(Document ownerDocument) : super._(ownerDocument, "option");

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
      new OptionElement._(ownerDocument);
}

class ParagraphElement extends HtmlElement {
  factory ParagraphElement() => ParagraphElement._(null);

  ParagraphElement._(Document ownerDocument) : super._(ownerDocument, "p");

  @override
  Element _newInstance(Document ownerDocument) =>
      new ParagraphElement._(ownerDocument);
}

class PasswordInputElement extends TextInputElementBase {
  factory PasswordInputElement() => PasswordInputElement._(null);

  PasswordInputElement._(Document ownerDocument)
      : super._(ownerDocument, "password");

  @override
  Element _newInstance(Document ownerDocument) =>
      new PasswordInputElement._(ownerDocument);
}

class PictureElement extends HtmlElement {
  factory PictureElement() => PictureElement._(null);

  PictureElement._(Document ownerDocument) : super._(ownerDocument, "picture");

  @override
  Element _newInstance(Document ownerDocument) =>
      new PictureElement._(ownerDocument);
}

class PreElement extends HtmlElement {
  factory PreElement() => PreElement._(null);

  PreElement._(Document ownerDocument) : super._(ownerDocument, "pre");

  @override
  Element _newInstance(Document ownerDocument) =>
      new PreElement._(ownerDocument);
}

class ProgressElement extends HtmlElement {
  factory ProgressElement() => ProgressElement._(null);

  ProgressElement._(Document ownerDocument)
      : super._(ownerDocument, "progress");

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
      new ProgressElement._(ownerDocument);
}

class RadioButtonInputElement extends InputElementBase {
  factory RadioButtonInputElement() => RadioButtonInputElement._(null);

  RadioButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "radio");

  bool get checked => _getAttributeBool("checked");

  set checked(bool value) {
    _setAttributeBool("checked", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new RadioButtonInputElement._(ownerDocument);
}

class ResetButtonInputElement extends InputElementBase {
  factory ResetButtonInputElement() => ResetButtonInputElement._(null);

  ResetButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "reset");

  @override
  Element _newInstance(Document ownerDocument) =>
      new ResetButtonInputElement._(ownerDocument);
}

class ScriptElement extends HtmlElement {
  factory ScriptElement() => ScriptElement._(null);

  ScriptElement._(Document ownerDocument) : super._(ownerDocument, "script");

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
      new ScriptElement._(ownerDocument);
}

class SearchInputElement extends TextInputElementBase {
  factory SearchInputElement() => SearchInputElement._(null);

  SearchInputElement._(Document ownerDocument)
      : super._(ownerDocument, "search");

  @override
  Element _newInstance(Document ownerDocument) =>
      new SearchInputElement._(ownerDocument);
}

class SelectElement extends HtmlElement {
  factory SelectElement() => SelectElement._(null);

  SelectElement._(Document ownerDocument) : super._(ownerDocument, "select");

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
      this.childNodes.where((node) => node is OptionElement).toList();

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new SelectElement._(ownerDocument);
}

class SlotElement extends HtmlElement {
  factory SlotElement() => SlotElement._(null);

  SlotElement._(Document ownerDocument) : super._(ownerDocument, "slot");

  @override
  Element _newInstance(Document ownerDocument) =>
      new SlotElement._(ownerDocument);
}

class SourceElement extends HtmlElement {
  factory SourceElement() => SourceElement._(null);

  SourceElement._(Document ownerDocument) : super._(ownerDocument, "source");

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
      new SourceElement._(ownerDocument);
}

class SpanElement extends HtmlElement {
  factory SpanElement() => SpanElement._(null);

  SpanElement._(Document ownerDocument) : super._(ownerDocument, "span");

  @override
  Element _newInstance(Document ownerDocument) =>
      new SpanElement._(ownerDocument);
}

class StyleElement extends HtmlElement {
  factory StyleElement() => StyleElement._(null);
  StyleElement._(Document ownerDocument) : super._(ownerDocument, "style");

  StyleSheet get sheet {
    final type = this.type;
    if (type == null || type == "" || type == "text/css") {
      final text = this.text;
      final parsed = css.parse(text);
      final styleSheet = new CssStyleSheet._();
      for (var node in parsed.topLevels) {
        final styleRule = new CssStyleRule._(styleSheet, node);
        if (styleRule != null) {
          styleSheet.cssRules.add(styleRule);
        }
      }
      return styleSheet;
    }
    return null;
  }

  String get type => _getAttribute("type");

  set type(String value) {
    _setAttribute("type", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new StyleElement._(ownerDocument);
}

class SubmitButtonInputElement extends InputElementBase {
  factory SubmitButtonInputElement() => SubmitButtonInputElement._(null);

  SubmitButtonInputElement._(Document ownerDocument)
      : super._(ownerDocument, "submit");

  @override
  Element _newInstance(Document ownerDocument) =>
      new SubmitButtonInputElement._(ownerDocument);
}

class TableCaptionElement extends HtmlElement {
  factory TableCaptionElement() => TableCaptionElement._(null);

  TableCaptionElement._(Document ownerDocument)
      : super._(ownerDocument, "caption");

  @override
  Element _newInstance(Document ownerDocument) =>
      new TableCaptionElement._(ownerDocument);
}

class TableCellElement extends HtmlElement {
  factory TableCellElement() => TableCellElement._(null);

  TableCellElement._(Document ownerDocument) : super._(ownerDocument, "td");

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
      new TableCellElement._(ownerDocument);
}

class TableElement extends HtmlElement {
  factory TableElement() => TableElement._(null);

  TableElement._(Document ownerDocument) : super._(ownerDocument, "table");

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
      this.children.removeWhere((e) => e.tagName == "caption");

  void deleteRow(int index) {
    this.createTBody().deleteRow(index);
  }

  void deleteTFoot() {
    this.children.removeWhere((e) => e.tagName == "tfoot");
  }

  void deleteTHead() {
    this.children.removeWhere((e) => e.tagName == "tbody");
  }

  TableRowElement insertRow(int index) {
    return this.createTBody().insertRow(index);
  }

  Element _createUniqueChild<T extends Element>(String name, T f()) {
    final existing =
        this.children.firstWhere((e) => e.tagName == name, orElse: () => null);
    if (existing != null) {
      return existing;
    }
    final section = f();
    append(section);
    return section;
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new TableElement._(ownerDocument);
}

class TableRowElement extends HtmlElement {
  factory TableRowElement() => TableRowElement._(null);

  TableRowElement._(Document ownerDocument) : super._(ownerDocument, "tr");

  @override
  Element _newInstance(Document ownerDocument) =>
      new TableRowElement._(ownerDocument);
}

class TableSectionElement extends HtmlElement {
  TableSectionElement._(Document ownerDocument, String tag)
      : super._(ownerDocument, tag);

  List<TableRowElement> get rows =>
      this.childNodes.where((item) => item is TableRowElement).toList();

  TableRowElement addRow() {
    final row = new TableRowElement();
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
    final row = new TableRowElement();
    this.insertBefore(row, before);
    return row;
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new TableSectionElement._(ownerDocument, _lowerCaseTagName);
}

class TelephoneInputElement extends TextInputElementBase {
  factory TelephoneInputElement() => TelephoneInputElement._(null);

  TelephoneInputElement._(Document ownerDocument)
      : super._(ownerDocument, "telephone");
}

class TemplateElement extends HtmlElement {
  factory TemplateElement() => TemplateElement._(null);

  TemplateElement._(Document ownerDocument)
      : super._(ownerDocument, "template");

  Element get content => this.childNodes.firstWhere(
      (child) => child is Element && child.tagName == "content",
      orElse: () => null);

  @override
  Element _newInstance(Document ownerDocument) =>
      new TemplateElement._(ownerDocument);
}

class TextAreaElement extends HtmlElement {
  factory TextAreaElement() => TextAreaElement._(null);

  TextAreaElement._(Document ownerDocument)
      : super._(ownerDocument, "textarea");

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

  String get wrap => _getAttribute("wrap");

  set wrap(String value) {
    _setAttribute("wrap", value);
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new TextAreaElement._(ownerDocument);
}

class TextInputElement extends TextInputElementBase {
  factory TextInputElement() => TextInputElement._(null);

  TextInputElement._(Document ownerDocument) : super._(ownerDocument, "text");

  @override
  Element _newInstance(Document ownerDocument) =>
      new TextInputElement._(ownerDocument);
}

abstract class TextInputElementBase extends InputElementBase {
  RegExp _patternRegExp;

  TextInputElementBase() : super();

  TextInputElementBase._(Document ownerDocument, String type)
      : super._(ownerDocument, type);

  int get maxLength => _getAttributeInt("maxlength");

  set maxLength(int value) {
    _setAttributeInt("maxlength", value);
  }

  int get minLength => _getAttributeInt("minlength");

  set minLength(int value) {
    _setAttributeInt("minlength", value);
  }

  String get pattern => _getAttribute("pattern");

  set pattern(String value) {
    _setAttribute("pattern", value);
  }

  String get placeholder => _getAttribute("placeholder");

  set placeholder(String value) {
    _setAttribute("placeholder", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  @override
  bool checkValidity() => _checkValidity(value);

  bool _checkValidity(String value) {
    if (value == null) return !required;
    final minLength = this.minLength;
    if (minLength is int && minLength > value.length) {
      return false;
    }
    final maxLength = this.minLength;
    if (maxLength is int && maxLength < value.length) {
      return false;
    }
    final regExp = this._getRegExp();
    if (regExp != null && !regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  RegExp _getRegExp() {
    final pattern = this.pattern;
    if (pattern == null) {
      return null;
    }
    var regExp = this._patternRegExp;
    if (regExp != null && pattern == regExp.pattern) {
      return regExp;
    }
    regExp = new RegExp(pattern);
    _patternRegExp = regExp;
    return regExp;
  }
}

class TimeInputElement extends InputElementBase {
  factory TimeInputElement() => TimeInputElement._(null);

  TimeInputElement._(Document ownerDocument) : super._(ownerDocument, "time");

  bool get readonly => _getAttributeBool("readonly");

  set readonly(bool value) {
    _setAttributeBool("readonly", value);
  }

  bool get required => _getAttributeBool("required");

  set required(bool value) {
    _setAttributeBool("required", value);
  }

  DateTime get valueAsDate => DateTime.parse(value);

  @override
  Element _newInstance(Document ownerDocument) =>
      new TimeInputElement._(ownerDocument);
}

class TitleElement extends HtmlElement {
  factory TitleElement() => TitleElement._(null);

  TitleElement._(Document ownerDocument) : super._(ownerDocument, "title");

  @override
  Element _newInstance(Document ownerDocument) =>
      new TitleElement._(ownerDocument);
}

class TrackElement extends HtmlElement {
  factory TrackElement() => TrackElement._(null);

  TrackElement._(Document ownerDocument) : super._(ownerDocument, "track");

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
  Element _newInstance(Document ownerDocument) =>
      new TrackElement._(ownerDocument);
}

class UListElement extends HtmlElement {
  factory UListElement() => UListElement._(null);

  UListElement._(Document ownerDocument) : super._(ownerDocument, "ul");

  @override
  Element _newInstance(Document ownerDocument) =>
      new UListElement._(ownerDocument);
}

class UnknownElement extends HtmlElement {
  @override
  final String namespaceUri;

  UnknownElement._(Document ownerDocument, this.namespaceUri, String tag)
      : super._(ownerDocument, tag);

  @override
  Element _newInstance(Document ownerDocument) =>
      new UnknownElement._(ownerDocument, namespaceUri, _lowerCaseTagName);
}

class UrlInputElement extends TextInputElementBase {
  factory UrlInputElement() => UrlInputElement._(null);

  UrlInputElement._(Document ownerDocument) : super._(ownerDocument, "url");

  @override
  Element _newInstance(Document ownerDocument) =>
      new UrlInputElement._(ownerDocument);
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

class VideoElement extends MediaElement {
  factory VideoElement() => VideoElement._(null);

  VideoElement._(Document ownerDocument) : super._(ownerDocument, "video");

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
    throw new UnimplementedError();
  }

  @override
  Element _newInstance(Document ownerDocument) =>
      new VideoElement._(ownerDocument);
}
