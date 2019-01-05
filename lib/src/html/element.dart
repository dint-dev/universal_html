part of universal_html;

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

class CssClassSet extends SetBase<String> {
  final Element _element;

  CssClassSet._(this._element);

  bool get frozen => false;

  @override
  Iterator<String> get iterator => _all.iterator;

  @override
  int get length {
    return _all.length;
  }

  List<String> get _all {
    final existing = _element.getAttribute("class");
    if (existing == null || existing.isEmpty) {
      return const <String>[];
    }
    return existing.split(" ");
  }

  @override
  bool add(String value) {
    final existing = _element.getAttribute("class");
    if (existing == null || existing.isEmpty) {
      _element.setAttribute("class", value);
    } else if (existing.split(" ").contains(value)) {
      return false;
    }
    _element.setAttribute("class", "${existing} ${value}");
    return true;
  }

  @override
  bool contains(Object element) {
    return _all.contains(element);
  }

  @override
  String lookup(Object element) {
    return _all.firstWhere((e) => e == element, orElse: () => null);
  }

  @override
  bool remove(Object value) {
    final existing = _element.getAttribute("class");
    if (existing == null || existing.isEmpty) {
      return false;
    }
    final list = existing.split(" ");
    if (!list.remove(value)) {
      return false;
    }
    _element.setAttribute("class", list.join(" "));
    return true;
  }

  @override
  Set<String> toSet() => new Set<String>.from(_all);
}

abstract class Element extends Node
    with ChildNode, NonDocumentTypeChildNode, ParentNode, _ElementOrDocument {
  static const EventStreamProvider<Event> abortEvent =
      const EventStreamProvider<Event>("abort");

  static const EventStreamProvider<Event> beforeCopyEvent =
      const EventStreamProvider<Event>("beforecopy");

  static const EventStreamProvider<Event> beforePasteEvent =
      const EventStreamProvider<Event>("beforepaste");

  static const EventStreamProvider<Event> blurEvent =
      const EventStreamProvider<Event>("blur");

  static const EventStreamProvider<Event> canPlayEvent =
      const EventStreamProvider<Event>("canplay");

  static const EventStreamProvider<Event> changeEvent =
      const EventStreamProvider<Event>("change");

  static const EventStreamProvider<MouseEvent> clickEvent =
      const EventStreamProvider<MouseEvent>("click");

  static const EventStreamProvider<Event> contextMenuEvent =
      const EventStreamProvider<Event>("contextmenu");

  static const EventStreamProvider<ClipboardEvent> copyEvent =
      const EventStreamProvider<ClipboardEvent>("copy");

  static const EventStreamProvider<ClipboardEvent> cutEvent =
      const EventStreamProvider<ClipboardEvent>("cut");

  static const EventStreamProvider<MouseEvent> doubleClickEvent =
      const EventStreamProvider<MouseEvent>("doubleclick");

  static const EventStreamProvider<MouseEvent> dragEvent =
      const EventStreamProvider<MouseEvent>("drag");

  static const EventStreamProvider<MouseEvent> dragEndEvent =
      const EventStreamProvider<MouseEvent>("dragend");

  static const EventStreamProvider<MouseEvent> dragEnterEvent =
      const EventStreamProvider<MouseEvent>("dragenter");

  static const EventStreamProvider<MouseEvent> dragLeaveEvent =
      const EventStreamProvider<MouseEvent>("dragleave");

  static const EventStreamProvider<MouseEvent> dragOverEvent =
      const EventStreamProvider<MouseEvent>("dragover");

  static const EventStreamProvider<MouseEvent> dragStartEvent =
      const EventStreamProvider<MouseEvent>("dragstart");

  static const EventStreamProvider<MouseEvent> dropEvent =
      const EventStreamProvider<MouseEvent>("dropevent");

  static const EventStreamProvider<Event> fullscreenChangeEvent =
      const EventStreamProvider<MouseEvent>("fullscreenchange");

  static const EventStreamProvider<Event> fullscreenErrorEvent =
      const EventStreamProvider<MouseEvent>("fullscreenerror");

  static const EventStreamProvider<Event> errorEvent =
      const EventStreamProvider<Event>("error");

  static const EventStreamProvider<Event> focusEvent =
      const EventStreamProvider<Event>("focus");

  static const EventStreamProvider<Event> inputEvent =
      const EventStreamProvider<Event>("input");

  static const EventStreamProvider<KeyboardEvent> keyDownEvent =
      const EventStreamProvider<KeyboardEvent>("keydown");

  static const EventStreamProvider<KeyboardEvent> keyUpEvent =
      const EventStreamProvider<KeyboardEvent>("keyup");

  static const EventStreamProvider<KeyboardEvent> keyPressEvent =
      const EventStreamProvider<KeyboardEvent>("keypress");

  static const EventStreamProvider<Event> loadEvent =
      const EventStreamProvider<Event>("load");

  static const EventStreamProvider<MouseEvent> mouseDownEvent =
      const EventStreamProvider<MouseEvent>("mousedown");

  static const EventStreamProvider<MouseEvent> mouseEnterEvent =
      const EventStreamProvider<MouseEvent>("mouseenter");

  static const EventStreamProvider<MouseEvent> mouseLeaveEvent =
      const EventStreamProvider<MouseEvent>("mouseleave");

  static const EventStreamProvider<MouseEvent> mouseMoveEvent =
      const EventStreamProvider<MouseEvent>("mousemove");

  static const EventStreamProvider<MouseEvent> mouseOverEvent =
      const EventStreamProvider<MouseEvent>("mouseover");

  static const EventStreamProvider<MouseEvent> mouseUpEvent =
      const EventStreamProvider<MouseEvent>("mouseup");

  static const EventStreamProvider<Event> playEvent =
      const EventStreamProvider<Event>("play");

  static const EventStreamProvider<MouseEvent> playingEvent =
      const EventStreamProvider<MouseEvent>("playing");

  static const EventStreamProvider<MouseEvent> resetEvent =
      const EventStreamProvider<MouseEvent>("reset");

  static const EventStreamProvider<Event> scrollEvent =
      const EventStreamProvider<Event>("scroll");

  static const EventStreamProvider<Event> selectEvent =
      const EventStreamProvider<Event>("select");

  static const EventStreamProvider<MouseEvent> resizeEvent =
      const EventStreamProvider<MouseEvent>("resize");

  static const EventStreamProvider<TouchEvent> touchCancelEvent =
      const EventStreamProvider<TouchEvent>("touchcancel");

  static const EventStreamProvider<TouchEvent> touchEndEvent =
      const EventStreamProvider<TouchEvent>("touchend");

  static const EventStreamProvider<TouchEvent> touchEnterEvent =
      const EventStreamProvider<TouchEvent>("touchenter");

  static const EventStreamProvider<TouchEvent> touchLeaveEvent =
      const EventStreamProvider<TouchEvent>("touchleave");

  static const EventStreamProvider<TouchEvent> touchMoveEvent =
      const EventStreamProvider<TouchEvent>("touchmove");

  static const EventStreamProvider<TouchEvent> touchStartEvent =
      const EventStreamProvider<TouchEvent>("touchstart");

  static const EventStreamProvider<Event> submitEvent =
      const EventStreamProvider<Event>("submit");

  static const EventStreamProvider<MouseEvent> volumeChangeEvent =
      const EventStreamProvider<MouseEvent>("volumechange");

  static const EventStreamProvider<MouseEvent> waitingEvent =
      const EventStreamProvider<MouseEvent>("waiting");

  static const EventStreamProvider<MouseEvent> wheelEvent =
      const EventStreamProvider<MouseEvent>("wheelevent");

  static final _normalizedElementNameRegExp =
      new RegExp(r"^[a-z_\:][a-z0-9_\-\:]*$");

  static final _normalizedAttributeNameRegExp =
      new RegExp(r"^[a-z_\:][a-z0-9_\-\:]*$");

  final String _lowerCaseTagName;

  /// Contains all non-namespaced attributes except special cases.
  /// Initialized lazily.
  LinkedHashMap<String, String> _attributesPartialViewOrNull;

  /// Contains all attributes. The map will take care of special cases.
  /// Initialized lazily.
  ///
  /// Note that because it just invokes [getAttribute] and [setAttribute],
  /// we don't necessarily have to cache it and decision to cache it wasn't a
  /// result of careful analysis.
  _Attributes _attributesFullViewOrNull;

  /// Contains style.
  /// Initialized lazily.
  _CssStyleDeclaration _style;

  /// Contains namespaced attributes.
  Map<String, Map<String, String>> _namedspacedAttributes;

  @visibleForTesting
  Element.constructor(Document document, String tagName)
      : this._(document, tagName);

  /**
   * Creates an HTML element from a valid fragment of HTML.
   *
   *     var element = new Element.html('<div class="foo">content</div>');
   *
   * The HTML fragment should contain only one single root element, any
   * leading or trailing text nodes will be removed.
   *
   * The HTML fragment is parsed as if it occurred within the context of a
   * `<body>` tag, this means that special elements such as `<caption>` which
   * must be parsed within the scope of a `<table>` element will be dropped. Use
   * [createFragment] to parse contextual HTML fragments.
   *
   * Unless a validator is provided this will perform the default validation
   * and remove all scriptable elements and attributes.
   *
   * See also:
   *
   * * [NodeValidator]
   *
   */
  factory Element.html(String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    final fragment = const _NodeParserDriver().parseFragmentWithHtml(
      document,
      html.trim(),
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
    final element = fragment.childNodes.single as Element;
    element.remove();
    return element;
  }

  /// Creates a new element with the tag name.
  /// If the name is invalid, throws an error or exception.
  factory Element.tag(String name, [String typeExtension]) {
    return Element._tag(null, name, typeExtension);
  }

  /// Internal constructor that does not normalize or validate element name.
  /// Used by Element subclasses such as [AnchorElement].
  Element._(Document ownerDocument, String nodeName)
      : this._lowerCaseTagName = nodeName,
        super._(ownerDocument);

  factory Element._tag(Document ownerDocument, String name,
      [String typeExtension]) {
    final normalizedName = name.toLowerCase();
    switch (normalizedName) {
      case "a":
        return new AnchorElement._(ownerDocument);
      case "audio":
        return new AudioElement._(ownerDocument);
      case "body":
        return new BodyElement._(ownerDocument);
      case "br":
        return new BRElement._(ownerDocument);
      case "button":
        return new ButtonElement._(ownerDocument);
      case "canvas":
        return new CanvasElement._(ownerDocument);
      case "caption":
        return new TableCaptionElement._(ownerDocument);
      case "datalist":
        return new DataListElement._(ownerDocument);
      case "div":
        return new DivElement._(ownerDocument);
      case "fieldset":
        return new FieldSetElement._(ownerDocument);
      case "form":
        return new FormElement._(ownerDocument);
      case "head":
        return new HeadElement._(ownerDocument);
      case "h1":
        return new HeadingElement._(ownerDocument, "h1");
      case "h2":
        return new HeadingElement._(ownerDocument, "h2");
      case "h3":
        return new HeadingElement._(ownerDocument, "h3");
      case "h4":
        return new HeadingElement._(ownerDocument, "h4");
      case "h5":
        return new HeadingElement._(ownerDocument, "h5");
      case "h6":
        return new HeadingElement._(ownerDocument, "h6");
      case "hr":
        return new HRElement._(ownerDocument);
      case "iframe":
        return new IFrameElement._(ownerDocument);
      case "img":
        return new ImageElement._(ownerDocument);
      case "input":
        return new InputElementBase._(ownerDocument, null);
      case "label":
        return new LabelElement._(ownerDocument);
      case "legend":
        return new LegendElement._(ownerDocument);
      case "li":
        return new LIElement._(ownerDocument);
      case "link":
        return new LinkElement._(ownerDocument);
      case "meta":
        return new MetaElement._(ownerDocument);
      case "ol":
        return new OListElement._(ownerDocument);
      case "option":
        return new OptionElement._(ownerDocument);
      case "optgroup":
        return new OptGroupElement._(ownerDocument);
      case "p":
        return new ParagraphElement._(ownerDocument);
      case "picture":
        return new PictureElement._(ownerDocument);
      case "pre":
        return new PreElement._(ownerDocument);
      case "select":
        return new SelectElement._(ownerDocument);
      case "script":
        return new ScriptElement._(ownerDocument);
      case "slot":
        return new SlotElement._(ownerDocument);
      case "source":
        return new SourceElement._(ownerDocument);
      case "span":
        return new SpanElement._(ownerDocument);
      case "style":
        return new StyleElement._(ownerDocument);
      case "table":
        return new TableElement._(ownerDocument);
      case "tbody":
        return new TableSectionElement._(ownerDocument, "tbody");
      case "td":
        return new TableCellElement._(ownerDocument);
      case "tfoot":
        return new TableSectionElement._(ownerDocument, "tfoot");
      case "thead":
        return new TableSectionElement._(ownerDocument, "thead");
      case "template":
        return new TemplateElement._(ownerDocument);
      case "textarea":
        return new TextAreaElement._(ownerDocument);
      case "title":
        return new TitleElement._(ownerDocument);
      case "tr":
        return new TableRowElement._(ownerDocument);
      case "track":
        return new TrackElement._(ownerDocument);
      case "ul":
        return new UListElement._(ownerDocument);
      case "video":
        return new VideoElement._(ownerDocument);
      default:
        if (!Element._normalizedElementNameRegExp.hasMatch(normalizedName)) {
          throw new ArgumentError.value(name);
        }
        return UnknownElement._(ownerDocument, null, normalizedName);
    }
  }

  factory Element._tagNS(
      Document ownerDocument, String namespaceUri, String name,
      [String typeExtension]) {
    final normalizedName = name.toLowerCase();
    if (!Element._normalizedElementNameRegExp.hasMatch(normalizedName)) {
      throw new ArgumentError.value(name);
    }
    return UnknownElement._(ownerDocument, namespaceUri, normalizedName);
  }

  /// Returns read-only list of attribute names.
  List<String> get attributeNames {
    final result = <String>[]..addAll(_attributesWithoutLatestValues.keys);
    final style = this._style;
    if (style != null && (style._sourceIsLatest || style._map.isNotEmpty)) {
      result.add("style");
    }
    return result;
  }

  /// Returns a modifiable map of attributes.
  Map<String, String> get attributes {
    return _attributesFullViewOrNull ??
        (_attributesFullViewOrNull = new _Attributes(this));
  }

  List<Element> get children => _ElementChildren(this);

  CssClassSet get classes => new CssClassSet._(this);

  String get className => getAttribute("class");

  set className(String newValue) {
    _setAttribute("class", newValue);
  }

  Rectangle<int> get client =>
      new Rectangle(clientLeft, clientTop, clientWidth, clientHeight);

  /// Returns 0 outside browser.tagWithoutValidation
  int get clientHeight => 0;

  /// Returns 0 outside browser.
  int get clientLeft => 0;

  /// Returns 0 outside browser.
  int get clientTop => 0;

  /// Returns 0 outside browser.
  int get clientWidth => 0;

  String get dir => getAttribute("dir");

  set dir(String value) {
    _setAttribute("dir", value);
  }

  bool get draggable => _getAttributeBool("draggable");

  set draggable(bool value) {
    _setAttributeBool("draggable", value);
  }

  String get id => getAttribute("id");

  set id(String value) {
    _setAttribute("id", value);
  }

  String get innerHtml {
    final sb = new StringBuffer();
    final flags = _getPrintingFlags(this);
    Node next = this.firstChild;
    while (next != null) {
      _printNode(sb, flags, next);
      next = next.nextNode;
    }
    return sb.toString();
  }

  String get namespaceUri => null;

  /// Returns node name in uppercase.
  @override
  String get nodeName => _lowerCaseTagName.toUpperCase();

  @override
  int get nodeType => Node.ELEMENT_NODE;

  Rectangle<int> get offset =>
      new Rectangle(offsetLeft, offsetTop, offsetWidth, offsetHeight);

  /// Returns 0 outside browser.
  int get offsetHeight => 0;

  /// Returns 0 outside browser.
  int get offsetLeft => 0;

  Element get offsetParent => parent;

  /// Returns 0 outside browser.
  int get offsetTop => 0;

  /// Returns 0 outside browser.
  int get offsetWidth => 0;

  ElementStream<Event> get onBlur => blurEvent.forElement(this);

  ElementStream<Event> get onChange => changeEvent.forElement(this);

  ElementStream<MouseEvent> get onClick => clickEvent.forElement(this);

  ElementStream<MouseEvent> get onDrag => dragEvent.forElement(this);

  ElementStream<MouseEvent> get onDragEnd => dragEndEvent.forElement(this);

  ElementStream<MouseEvent> get onDragEnter => dragEnterEvent.forElement(this);

  ElementStream<MouseEvent> get onDragLeave => dragLeaveEvent.forElement(this);

  ElementStream<MouseEvent> get onDragOver => dragOverEvent.forElement(this);

  ElementStream<MouseEvent> get onDragStart => dragStartEvent.forElement(this);

  ElementStream<MouseEvent> get onDrop => dropEvent.forElement(this);

  ElementStream<Event> get onError => errorEvent.forElement(this);

  ElementStream<Event> get onFocus => focusEvent.forElement(this);

  ElementStream<Event> get onInput => inputEvent.forElement(this);

  ElementStream<KeyboardEvent> get onKeyDown => keyDownEvent.forElement(this);

  ElementStream<KeyboardEvent> get onKeyPress => keyPressEvent.forElement(this);

  ElementStream<KeyboardEvent> get onKeyUp => keyUpEvent.forElement(this);

  ElementStream<Event> get onLoad => loadEvent.forElement(this);

  ElementStream<MouseEvent> get onMouseDown => mouseDownEvent.forElement(this);

  ElementStream<MouseEvent> get onMouseEnter =>
      mouseEnterEvent.forElement(this);

  ElementStream<MouseEvent> get onMouseLeave =>
      mouseLeaveEvent.forElement(this);

  ElementStream<MouseEvent> get onMouseMove => mouseMoveEvent.forElement(this);

  ElementStream<MouseEvent> get onMouseOver => mouseOverEvent.forElement(this);

  ElementStream<MouseEvent> get onMouseUp => mouseUpEvent.forElement(this);

  ElementStream<Event> get onPlay => playEvent.forElement(this);

  ElementStream<Event> get onScroll => scrollEvent.forElement(this);

  ElementStream<Event> get onSelect => selectEvent.forElement(this);

  ElementStream<Event> get onSubmit => submitEvent.forElement(this);

  ElementStream<TouchEvent> get onTouchCancel =>
      touchCancelEvent.forElement(this);

  ElementStream<TouchEvent> get onTouchEndCancel =>
      touchEndEvent.forElement(this);

  ElementStream<TouchEvent> get onTouchEnter =>
      touchEnterEvent.forElement(this);

  ElementStream<TouchEvent> get onTouchLeave =>
      touchLeaveEvent.forElement(this);

  ElementStream<TouchEvent> get onTouchMove => touchMoveEvent.forElement(this);

  ElementStream<TouchEvent> get onTouchStart =>
      touchStartEvent.forElement(this);

  String get outerHtml {
    final sb = new StringBuffer();
    final flags = _getPrintingFlags(this);
    _printNode(sb, flags, this);
    return sb.toString();
  }

  /// Returns 0 outside browser.
  int get scrollHeight => 0;

  int get scrollLeft => 0;

  /// Returns 0 outside browser.
  int get scrollTop => 0;

  /// Returns 0 outside browser.
  int get scrollWidth => 0;

  bool get spellcheck => _getAttributeBool("spellcheck");

  set spellcheck(bool value) {
    _setAttributeBool("spellcheck", value);
  }

  CssStyleDeclaration getComputedStyle([String pseudoElement]) {
    return new _ComputedStyle._(this, pseudoElement);
  }

  CssStyleDeclaration get style => _getOrCreateStyle();
  _CssStyleDeclaration _getOrCreateStyle() {
    _CssStyleDeclaration result = this._style;
    if (result == null) {
      result = new _CssStyleDeclaration._();
      final value = this._attributesWithoutLatestValues["style"];
      if (value != null) {
        result._parse(value);
      }
      this._style = result;
    }
    return result;
  }

  int get tabIndex => _getAttributeInt("tabindex");

  set tabIndex(int value) {
    _setAttributeInt("tabindex", value);
  }

  /// Returns node name in uppercase.
  String get tagName => this.nodeName;

  bool get translate => _getAttributeBool("translate");

  set translate(bool value) {
    _setAttributeBool("translate", value);
  }

  LinkedHashMap<String, String> get _attributesWithoutLatestValues {
    return this._attributesPartialViewOrNull ??
        (this._attributesPartialViewOrNull = LinkedHashMap<String, String>());
  }

  Animation animate(Iterable<Map<String, dynamic>> frames, [dynamic timing]) {
    return Animation();
  }

  /**
   * Parses the specified text as HTML and adds the resulting node after the
   * last child of this element.
   */
  void appendHtml(String text,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    final fragment = const _NodeParserDriver().parseFragmentWithHtml(
        ownerDocument, text,
        validator: validator, treeSanitizer: treeSanitizer);
    while (true) {
      final child = fragment.firstChild;
      if (child == null) {
        return;
      }
      child.remove();
      this.append(child);
    }
  }

  void appendText(String value) {
    this.insertBefore(new Text(value), null);
  }

  void blur() {
    dispatchEvent(new FocusEvent("blur"));
  }

  void click() {
    dispatchEvent(new MouseEvent("click"));
  }

  @override
  Element cloneWithOwnerDocument(Document ownerDocument, bool deep) {
    // Create a new instance of the same class
    final clone = _newInstance(ownerDocument);

    // Clone attributes
    final attributes = this._attributesPartialViewOrNull;
    if (attributes != null) {
      final cloneAttributes = clone._attributesWithoutLatestValues;
      attributes.forEach((k, v) {
        cloneAttributes[k] = v;
      });
    }

    // Clone style
    clone._style = this._style?._clone();

    // Clone children
    if (deep != false) {
      Node._cloneChildrenFrom(ownerDocument, clone, this);
    }

    return clone;
  }

  void focus() {
    dispatchEvent(new FocusEvent("focus"));
  }

  String getAttribute(String name) {
    return _getAttribute(name.toLowerCase());
  }

  List<String> getAttributeNames() {
    return this.attributes.keys.toList();
  }

  String getAttributeNS(String namespace, String name) {
    final namespaces = this._namedspacedAttributes;
    if (namespaces == null) {
      return null;
    }
    final attributes = _namedspacedAttributes[namespace];
    if (attributes == null) {
      return null;
    }
    return attributes[name];
  }

  Map<String, String> getNamespacedAttributes(String namespace) {
    var namespaces = this._namedspacedAttributes;
    if (namespaces == null) {
      this._namedspacedAttributes =
          namespaces = <String, Map<String, String>>{};
    }
    var result = namespaces[namespace];
    if (result == null) {
      namespaces[namespace] = result = <String, String>{};
    }
    return result;
  }


  bool matches(String selectors) {
    return _matches(this, selectors, null);
  }

  bool matchesWithAncestors(String selectors) {
    Element element = this;
    do {
      if (_matches(element, selectors, null)) {
        return true;
      }
      element = element.parent;
    } while (element != null);
    return false;
  }

  void requestFullscreen() {}

  void requestPointerLock() {}

  void scroll([dynamic options_OR_x, num y]) {}

  void scrollBy([dynamic options_OR_x, num y]) {}

  void scrollIntoView([ScrollAlignment alignment]) {}

  void scrollTo([dynamic options_OR_x, num y]) {}

  void setAttribute(String name, String value) {
    // Normalize name
    final normalizedName = name.toLowerCase();

    // Validate name
    if (!_normalizedAttributeNameRegExp.hasMatch(normalizedName)) {
      throw new ArgumentError.value(
          name, "name", "Attribute name has invalid characters");
    }

    // Use internal method
    _setAttribute(normalizedName, value);
  }

  void setAttributeNS(String namespace, String name, String value) {
    if (namespace == null ||
        !Element._normalizedAttributeNameRegExp.hasMatch(namespace)) {
      throw new ArgumentError.value(namespace, "namespace");
    }
    if (name == null ||
        !Element._normalizedAttributeNameRegExp.hasMatch(name)) {
      throw new ArgumentError.value(name, "name");
    }
    var namespaces = this._namedspacedAttributes;
    if (value == null) {
      if (namespaces != null) {
        namespaces[namespace]?.remove(name);
      }
    } else {
      getNamespacedAttributes(namespace)[name] = value;
    }
  }

  String _getAttribute(String name) {
    switch (name) {
      case "style":
        return _style?.toString();
      default:
        return _attributesWithoutLatestValues[name];
    }
  }

  bool _getAttributeBool(String name) {
    return getAttribute(name) != "";
  }

  int _getAttributeInt(String name) {
    final s = getAttribute(name);
    if (s == null) {
      return null;
    }
    return int.parse(s);
  }

  num _getAttributeNum(String name) {
    final s = getAttribute(name);
    if (s == null) {
      return null;
    }
    return num.parse(s);
  }

  Element _newInstance(Document document);

  /// Internal method that does not validate attribute name
  void _setAttribute(String name, String value) {
    if (value == null) {
      // Map update
      _attributesWithoutLatestValues.remove(name);

      // Field update for possible special case
      switch (name) {
        case "style":
          final style = this._style;
          if (style != null) {
            style._parse(null);
          }
          break;
      }
    } else {
      // Map update
      _attributesWithoutLatestValues[name] = value;

      // Field update for possible special case
      switch (name) {
        case "style":
          this._getOrCreateStyle()._parse(value);
          break;
      }
    }
  }

  void _setAttributeBool(String name, bool value) {
    if (value) {
      _setAttribute(name, "");
    } else {
      _setAttribute(name, null);
    }
  }

  void _setAttributeInt(String name, int value) {
    _setAttribute(name, value?.toString());
  }

  void _setAttributeNum(String name, num value) {
    _setAttribute(name, value?.toString());
  }

  static bool isTagSupported(String tag) {
    return _Html5NodeValidator._allowedElements.contains(tag);
  }

  static bool _hasCorruptedAttributes(Element element) => false;

  static bool _hasCorruptedAttributesAdditionalCheck(Element element) => false;

  static String _safeTagName(Element element) {
    return element.tagName;
  }
}

class ScrollAlignment {
  static const ScrollAlignment BOTTOM = const ScrollAlignment._("BOTTOM");
  static const ScrollAlignment CENTER = const ScrollAlignment._("CENTER");
  static const ScrollAlignment TOP = const ScrollAlignment._("TOP");
  final String _name;

  const ScrollAlignment._(this._name);

  String toString() => _name;
}

/// Exposes attributes (including up-to-date 'style') as a map.
class _Attributes extends MapBase<String, String> {
  final Element _element;

  _Attributes(this._element);

  @override
  Iterable<String> get keys {
    return _element.attributeNames;
  }

  @override
  String operator [](Object key) {
    return _element.getAttribute(key);
  }

  @override
  void operator []=(String key, String value) {
    _element.setAttribute(key, value);
  }

  @override
  void clear() {
    for (var key in _element.attributeNames) {
      _element.setAttribute(key, null);
    }
  }

  @override
  String remove(Object key) {
    final value = _element.getAttribute(key);
    _element.setAttribute(key, null);
    return value;
  }
}

class _ElementChildren extends ListBase<Element> {
  final Element _element;

  _ElementChildren(this._element);

  @override
  Iterator<Element> get iterator {
    return _ElementIterator(_element);
  }

  @override
  int get length {
    Node node = _element.firstChild;
    int length = 0;
    while (node != null) {
      if (node is Element) {
        length++;
      }
      node = node.nextNode;
    }
    return length;
  }

  @override
  set length(int newLength) {
    final element = this._element;
    if (newLength == 0) {
      while (true) {
        final first = element._firstElementChild;
        if (first == null) {
          break;
        }
        first.remove();
      }
    } else {
      final lastChild = this[newLength - 1];
      while (true) {
        final last = lastChild.nextElementSibling;
        if (last == null) {
          break;
        }
        last.remove();
      }
    }
  }

  @override
  Element operator [](int index) {
    Node node = _element.firstChild;
    while (node != null) {
      if (node is Element) {
        if (index == 0) {
          return node;
        }
        index--;
      }
      node = node.nextNode;
    }
    throw new ArgumentError.value(index);
  }

  @override
  operator []=(int index, Element child) {
    this[index].replaceWith(child);
  }
}

class _ElementIterator extends Iterator<Element> {
  final Element _parent;
  Element _current;

  _ElementIterator(this._parent);

  @override
  Element get current => _current;

  @override
  bool moveNext() {
    final current = this._current;
    if (current == null) {
      final first = _parent._firstElementChild;
      this._current = first;
      return first != null;
    }
    if (!identical(_parent, current)) {
      // TODO: Implementation that handles modifications like 'dart:html' does.
      throw new StateError("DOM tree was modified during iteration");
    }
    final next = current.nextElementSibling;
    if (next == null) {
      return false;
    }
    this._current = next;
    return true;
  }
}
