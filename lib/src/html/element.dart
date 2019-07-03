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

abstract class Element extends Node
    with ChildNode, NonDocumentTypeChildNode, ParentNode, _ElementOrDocument {
  /// Static factory designed to expose `abort` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> abortEvent =
      EventStreamProvider<Event>('abort');

  /// Static factory designed to expose `beforecopy` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> beforeCopyEvent =
      EventStreamProvider<Event>('beforecopy');

  /// Static factory designed to expose `beforecut` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> beforeCutEvent =
      EventStreamProvider<Event>('beforecut');

  /// Static factory designed to expose `beforepaste` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> beforePasteEvent =
      EventStreamProvider<Event>('beforepaste');

  /// Static factory designed to expose `blur` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> blurEvent =
      EventStreamProvider<Event>('blur');

  static const EventStreamProvider<Event> canPlayEvent =
      EventStreamProvider<Event>('canplay');

  static const EventStreamProvider<Event> canPlayThroughEvent =
      EventStreamProvider<Event>('canplaythrough');

  /// Static factory designed to expose `change` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> changeEvent =
      EventStreamProvider<Event>('change');

  /// Static factory designed to expose `click` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> clickEvent =
      EventStreamProvider<MouseEvent>('click');

  /// Static factory designed to expose `contextmenu` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> contextMenuEvent =
      EventStreamProvider<MouseEvent>('contextmenu');

  /// Static factory designed to expose `copy` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ClipboardEvent> copyEvent =
      EventStreamProvider<ClipboardEvent>('copy');

  /// Static factory designed to expose `cut` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ClipboardEvent> cutEvent =
      EventStreamProvider<ClipboardEvent>('cut');

  /// Static factory designed to expose `doubleclick` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  @DomName('Element.dblclickEvent')
  static const EventStreamProvider<Event> doubleClickEvent =
      EventStreamProvider<Event>('dblclick');

  /// A stream of `drag` events fired when an element is currently being dragged.
  ///
  /// A `drag` event is added to this stream as soon as the drag begins.
  /// A `drag` event is also added to this stream at intervals while the drag
  /// operation is still ongoing.
  ///
  /// ## Other resources
  ///
  /// * [Drag and drop
  ///   sample](https://github.com/dart-lang/dart-samples/tree/master/html5/web/dnd/basics)
  ///   based on [the tutorial](http://www.html5rocks.com/en/tutorials/dnd/basics/)
  ///   from HTML5Rocks.
  /// * [Drag and drop
  ///   specification](https://html.spec.whatwg.org/multipage/interaction.html#dnd)
  ///   from WHATWG.
  static const EventStreamProvider<MouseEvent> dragEvent =
      EventStreamProvider<MouseEvent>('drag');

  /// A stream of `dragend` events fired when an element completes a drag
  /// operation.
  ///
  /// ## Other resources
  ///
  /// * [Drag and drop
  ///   sample](https://github.com/dart-lang/dart-samples/tree/master/html5/web/dnd/basics)
  ///   based on [the tutorial](http://www.html5rocks.com/en/tutorials/dnd/basics/)
  ///   from HTML5Rocks.
  /// * [Drag and drop
  ///   specification](https://html.spec.whatwg.org/multipage/interaction.html#dnd)
  ///   from WHATWG.
  static const EventStreamProvider<MouseEvent> dragEndEvent =
      EventStreamProvider<MouseEvent>('dragend');

  /// A stream of `dragenter` events fired when a dragged object is first dragged
  /// over an element.
  ///
  /// ## Other resources
  ///
  /// * [Drag and drop
  ///   sample](https://github.com/dart-lang/dart-samples/tree/master/html5/web/dnd/basics)
  ///   based on [the tutorial](http://www.html5rocks.com/en/tutorials/dnd/basics/)
  ///   from HTML5Rocks.
  /// * [Drag and drop
  ///   specification](https://html.spec.whatwg.org/multipage/interaction.html#dnd)
  ///   from WHATWG.
  static const EventStreamProvider<MouseEvent> dragEnterEvent =
      EventStreamProvider<MouseEvent>('dragenter');

  /// A stream of `dragleave` events fired when an object being dragged over an
  /// element leaves the element's target area.
  ///
  /// ## Other resources
  ///
  /// * [Drag and drop
  ///   sample](https://github.com/dart-lang/dart-samples/tree/master/html5/web/dnd/basics)
  ///   based on [the tutorial](http://www.html5rocks.com/en/tutorials/dnd/basics/)
  ///   from HTML5Rocks.
  /// * [Drag and drop
  ///   specification](https://html.spec.whatwg.org/multipage/interaction.html#dnd)
  ///   from WHATWG.
  static const EventStreamProvider<MouseEvent> dragLeaveEvent =
      EventStreamProvider<MouseEvent>('dragleave');

  /// A stream of `dragover` events fired when a dragged object is currently
  /// being dragged over an element.
  ///
  /// ## Other resources
  ///
  /// * [Drag and drop
  ///   sample](https://github.com/dart-lang/dart-samples/tree/master/html5/web/dnd/basics)
  ///   based on [the tutorial](http://www.html5rocks.com/en/tutorials/dnd/basics/)
  ///   from HTML5Rocks.
  /// * [Drag and drop
  ///   specification](https://html.spec.whatwg.org/multipage/interaction.html#dnd)
  ///   from WHATWG.
  static const EventStreamProvider<MouseEvent> dragOverEvent =
      EventStreamProvider<MouseEvent>('dragover');

  /// A stream of `dragstart` events for a dragged element whose drag has begun.
  ///
  /// ## Other resources
  ///
  /// * [Drag and drop
  ///   sample](https://github.com/dart-lang/dart-samples/tree/master/html5/web/dnd/basics)
  ///   based on [the tutorial](http://www.html5rocks.com/en/tutorials/dnd/basics/)
  ///   from HTML5Rocks.
  /// * [Drag and drop
  ///   specification](https://html.spec.whatwg.org/multipage/interaction.html#dnd)
  ///   from WHATWG.
  static const EventStreamProvider<MouseEvent> dragStartEvent =
      EventStreamProvider<MouseEvent>('dragstart');

  /// A stream of `drop` events fired when a dragged object is dropped on an
  /// element.
  ///
  /// ## Other resources
  ///
  /// * [Drag and drop
  ///   sample](https://github.com/dart-lang/dart-samples/tree/master/html5/web/dnd/basics)
  ///   based on [the tutorial](http://www.html5rocks.com/en/tutorials/dnd/basics/)
  ///   from HTML5Rocks.
  /// * [Drag and drop
  ///   specification](https://html.spec.whatwg.org/multipage/interaction.html#dnd)
  ///   from WHATWG.
  static const EventStreamProvider<MouseEvent> dropEvent =
      EventStreamProvider<MouseEvent>('drop');

  static const EventStreamProvider<Event> durationChangeEvent =
      EventStreamProvider<Event>('durationchange');

  static const EventStreamProvider<Event> emptiedEvent =
      EventStreamProvider<Event>('emptied');

  static const EventStreamProvider<Event> endedEvent =
      EventStreamProvider<Event>('ended');

  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  /// Static factory designed to expose `focus` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> focusEvent =
      EventStreamProvider<Event>('focus');

  /// Static factory designed to expose `input` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> inputEvent =
      EventStreamProvider<Event>('input');

  /// Static factory designed to expose `invalid` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> invalidEvent =
      EventStreamProvider<Event>('invalid');

  /// Static factory designed to expose `keydown` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<KeyboardEvent> keyDownEvent =
      EventStreamProvider<KeyboardEvent>('keydown');

  /// Static factory designed to expose `keypress` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<KeyboardEvent> keyPressEvent =
      EventStreamProvider<KeyboardEvent>('keypress');

  /// Static factory designed to expose `keyup` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<KeyboardEvent> keyUpEvent =
      EventStreamProvider<KeyboardEvent>('keyup');

  /// Static factory designed to expose `load` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> loadEvent =
      EventStreamProvider<Event>('load');

  static const EventStreamProvider<Event> loadedDataEvent =
      EventStreamProvider<Event>('loadeddata');

  static const EventStreamProvider<Event> loadedMetadataEvent =
      EventStreamProvider<Event>('loadedmetadata');

  /// Static factory designed to expose `mousedown` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> mouseDownEvent =
      EventStreamProvider<MouseEvent>('mousedown');

  /// Static factory designed to expose `mouseenter` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> mouseEnterEvent =
      EventStreamProvider<MouseEvent>('mouseenter');

  /// Static factory designed to expose `mouseleave` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> mouseLeaveEvent =
      EventStreamProvider<MouseEvent>('mouseleave');

  /// Static factory designed to expose `mousemove` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> mouseMoveEvent =
      EventStreamProvider<MouseEvent>('mousemove');

  /// Static factory designed to expose `mouseout` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> mouseOutEvent =
      EventStreamProvider<MouseEvent>('mouseout');

  /// Static factory designed to expose `mouseover` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> mouseOverEvent =
      EventStreamProvider<MouseEvent>('mouseover');

  /// Static factory designed to expose `mouseup` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MouseEvent> mouseUpEvent =
      EventStreamProvider<MouseEvent>('mouseup');

  /// Static factory designed to expose `paste` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ClipboardEvent> pasteEvent =
      EventStreamProvider<ClipboardEvent>('paste');

  static const EventStreamProvider<Event> pauseEvent =
      EventStreamProvider<Event>('pause');

  static const EventStreamProvider<Event> playEvent =
      EventStreamProvider<Event>('play');

  static const EventStreamProvider<Event> playingEvent =
      EventStreamProvider<Event>('playing');

  static const EventStreamProvider<Event> rateChangeEvent =
      EventStreamProvider<Event>('ratechange');

  /// Static factory designed to expose `reset` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> resetEvent =
      EventStreamProvider<Event>('reset');

  static const EventStreamProvider<Event> resizeEvent =
      EventStreamProvider<Event>('resize');

  /// Static factory designed to expose `scroll` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> scrollEvent =
      EventStreamProvider<Event>('scroll');

  /// Static factory designed to expose `search` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> searchEvent =
      EventStreamProvider<Event>('search');

  static const EventStreamProvider<Event> seekedEvent =
      EventStreamProvider<Event>('seeked');

  static const EventStreamProvider<Event> seekingEvent =
      EventStreamProvider<Event>('seeking');

  /// Static factory designed to expose `select` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> selectEvent =
      EventStreamProvider<Event>('select');

  /// Static factory designed to expose `selectstart` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> selectStartEvent =
      EventStreamProvider<Event>('selectstart');

  static const EventStreamProvider<Event> stalledEvent =
      EventStreamProvider<Event>('stalled');

  /// Static factory designed to expose `submit` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> submitEvent =
      EventStreamProvider<Event>('submit');

  static const EventStreamProvider<Event> suspendEvent =
      EventStreamProvider<Event>('suspend');

  static const EventStreamProvider<Event> timeUpdateEvent =
      EventStreamProvider<Event>('timeupdate');

  /// Static factory designed to expose `touchcancel` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<TouchEvent> touchCancelEvent =
      EventStreamProvider<TouchEvent>('touchcancel');

  /// Static factory designed to expose `touchend` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<TouchEvent> touchEndEvent =
      EventStreamProvider<TouchEvent>('touchend');

  /// Static factory designed to expose `touchenter` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<TouchEvent> touchEnterEvent =
      EventStreamProvider<TouchEvent>('touchenter');

  /// Static factory designed to expose `touchleave` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<TouchEvent> touchLeaveEvent =
      EventStreamProvider<TouchEvent>('touchleave');

  /// Static factory designed to expose `touchmove` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<TouchEvent> touchMoveEvent =
      EventStreamProvider<TouchEvent>('touchmove');

  /// Static factory designed to expose `touchstart` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<TouchEvent> touchStartEvent =
      EventStreamProvider<TouchEvent>('touchstart');

  static const EventStreamProvider<Event> volumeChangeEvent =
      EventStreamProvider<Event>('volumechange');

  static const EventStreamProvider<Event> waitingEvent =
      EventStreamProvider<Event>('waiting');

  /// Static factory designed to expose `fullscreenchange` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.SAFARI)
  static const EventStreamProvider<Event> fullscreenChangeEvent =
      EventStreamProvider<Event>('webkitfullscreenchange');

  /// Static factory designed to expose `fullscreenerror` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.SAFARI)
  static const EventStreamProvider<Event> fullscreenErrorEvent =
      EventStreamProvider<Event>('webkitfullscreenerror');

  static const EventStreamProvider<WheelEvent> wheelEvent =
      EventStreamProvider<WheelEvent>('wheel');

  static final _normalizedElementNameRegExp =
      RegExp(r"^[a-z_\:][a-z0-9_\-\:]*$");

  static final _normalizedAttributeNameRegExp =
      RegExp(r"^[a-z_\:][a-z0-9_\-\:]*$");

  static NodeValidatorBuilder _defaultValidator;

  static _ValidatingTreeSanitizer _defaultSanitizer;

  /// Static factory designed to expose `mousewheel` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<WheelEvent> mouseWheelEvent =
      EventStreamProvider<WheelEvent>("mousewheel");

  /// Static factory designed to expose `transitionend` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<TransitionEvent> transitionEndEvent =
      EventStreamProvider<TransitionEvent>("transition");

  /// For [nodeName] and [tagName].
  String _nodeName;

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

  RenderData _renderData;

  /// Creates a new `<a>` element.
  ///
  /// This is equivalent to calling `new Element.tag('a')`.
  factory Element.a() = AnchorElement;

  /// Creates a new `<article>` element.
  ///
  /// This is equivalent to calling `new Element.tag('article')`.
  factory Element.article() => Element.tag('article');

  /// Creates a new `<aside>` element.
  ///
  /// This is equivalent to calling `new Element.tag('aside')`.
  factory Element.aside() => Element.tag('aside');

  /// Creates a new `<audio>` element.
  ///
  /// This is equivalent to calling `new Element.tag('audio')`.
  factory Element.audio() = AudioElement;

  /// Creates a new `<br>` element.
  ///
  /// This is equivalent to calling `new Element.tag('br')`.
  factory Element.br() = BRElement;

  /// Creates a new `<canvas>` element.
  ///
  /// This is equivalent to calling `new Element.tag('canvas')`.
  factory Element.canvas() = CanvasElement;

  /// Creates a new `<div>` element.
  ///
  /// This is equivalent to calling `new Element.tag('div')`.
  factory Element.div() = DivElement;

  /// Creates a new `<footer>` element.
  ///
  /// This is equivalent to calling `new Element.tag('footer')`.
  factory Element.footer() => Element.tag('footer');

  /// Creates a new `<header>` element.
  ///
  /// This is equivalent to calling `new Element.tag('header')`.
  factory Element.header() => Element.tag('header');

  /// Creates a new `<hr>` element.
  ///
  /// This is equivalent to calling `new Element.tag('hr')`.
  factory Element.hr() = HRElement;

  /// Creates an HTML element from a valid fragment of HTML.
  ///
  ///     var element = new Element.html('<div class="foo">content</div>');
  ///
  /// The HTML fragment should contain only one single root element, any
  /// leading or trailing text nodes will be removed.
  ///
  /// The HTML fragment is parsed as if it occurred within the context of a
  /// `<body>` tag, this means that special elements such as `<caption>` which
  /// must be parsed within the scope of a `<table>` element will be dropped. Use
  /// [createFragment] to parse contextual HTML fragments.
  ///
  /// Unless a validator is provided this will perform the default validation
  /// and remove all scriptable elements and attributes.
  ///
  /// See also:
  ///
  /// * [NodeValidator]
  ///
  factory Element.html(String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    final fragment = const DomParserDriver().parseDocumentFragmentFromHtml(
      document,
      html.trim(),
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
    final element = fragment.childNodes.single as Element;
    element.remove();
    return element;
  }

  /// Creates a new `<iframe>` element.
  ///
  /// This is equivalent to calling `new Element.tag('iframe')`.
  factory Element.iframe() = IFrameElement;

  /// Creates a new `<img>` element.
  ///
  /// This is equivalent to calling `new Element.tag('img')`.
  factory Element.img() = ImageElement;

  /// IMPORTANT: Not part of 'dart:html' API.
  Element.internal(Document document, String tagName)
      : this._(document, tagName);

  /// IMPORTANT: Not part 'dart:html'.
  factory Element.internalTag(Document ownerDocument, String name,
      [String typeExtension]) {
    final result = Element._internalTag(
      ownerDocument,
      name,
      typeExtension,
    );
    result._nodeName = name;
    return result;
  }

  /// IMPORTANT: Not part 'dart:html'.
  factory Element.internalTagNS(
      Document ownerDocument, String namespaceUri, String name,
      [String typeExtension]) {
    final normalizedName = name.toLowerCase();
    if (!Element._normalizedElementNameRegExp.hasMatch(normalizedName)) {
      throw ArgumentError.value(name);
    }
    return UnknownElement.internal(ownerDocument, namespaceUri, normalizedName);
  }

  /// Creates a new `<li>` element.
  ///
  /// This is equivalent to calling `new Element.tag('li')`.
  factory Element.li() = LIElement;

  /// Creates a new `<nav>` element.
  ///
  /// This is equivalent to calling `new Element.tag('nav')`.
  factory Element.nav() => Element.tag('nav');

  /// Creates a new `<ol>` element.
  ///
  /// This is equivalent to calling `new Element.tag('ol')`.
  factory Element.ol() = OListElement;

  /// Creates a new `<option>` element.
  ///
  /// This is equivalent to calling `new Element.tag('option')`.
  factory Element.option() = OptionElement;

  /// Creates a new `<p>` element.
  ///
  /// This is equivalent to calling `new Element.tag('p')`.
  factory Element.p() = ParagraphElement;

  /// Creates a new `<pre>` element.
  ///
  /// This is equivalent to calling `new Element.tag('pre')`.
  factory Element.pre() = PreElement;

  /// Creates a new `<section>` element.
  ///
  /// This is equivalent to calling `new Element.tag('section')`.
  factory Element.section() => Element.tag('section');

  /// Creates a new `<select>` element.
  ///
  /// This is equivalent to calling `new Element.tag('select')`.
  factory Element.select() = SelectElement;

  /// Creates a new `<span>` element.
  ///
  /// This is equivalent to calling `new Element.tag('span')`.
  factory Element.span() = SpanElement;

  /// Creates a new `<svg>` element.
  ///
  /// This is equivalent to calling `new Element.tag('svg')`.
  factory Element.svg() => Element.tag('svg');

  /// Creates a new `<table>` element.
  ///
  /// This is equivalent to calling `new Element.tag('table')`.
  factory Element.table() = TableElement;

  /// Creates a new element with the tag name.
  /// If the name is invalid, throws an error or exception.
  factory Element.tag(String name, [String typeExtension]) {
    return Element.internalTag(null, name.toUpperCase(), typeExtension);
  }

  /// Creates a new `<td>` element.
  ///
  /// This is equivalent to calling `new Element.tag('td')`.
  factory Element.td() = TableCellElement;

  /// Creates a new `<textarea>` element.
  ///
  /// This is equivalent to calling `new Element.tag('textarea')`.
  factory Element.textarea() = TextAreaElement;

  /// Creates a new `<th>` element.
  ///
  /// This is equivalent to calling `new Element.tag('th')`.
  factory Element.th() => Element.tag('th');

  /// Creates a new `<tr>` element.
  ///
  /// This is equivalent to calling `new Element.tag('tr')`.
  factory Element.tr() = TableRowElement;

  /// Creates a new `<ul>` element.
  ///
  /// This is equivalent to calling `new Element.tag('ul')`.
  factory Element.ul() = UListElement;

  /// Creates a new `<video>` element.
  ///
  /// This is equivalent to calling `new Element.tag('video')`.
  factory Element.video() = VideoElement;

  /// Internal constructor that does not normalize or validate element name.
  /// Used by Element subclasses such as [AnchorElement].
  Element._(Document ownerDocument, String nodeName)
      : this._nodeName = nodeName,
        this._lowerCaseTagName = nodeName.toLowerCase(),
        super._(ownerDocument);

  factory Element._internalTag(Document ownerDocument, String name,
      [String typeExtension]) {
    final lowerCaseName = name.toLowerCase();
    switch (lowerCaseName) {
      case "a":
        return AnchorElement._(ownerDocument);
      case "area":
        return AreaElement._(ownerDocument);
      case "audio":
        return AudioElement._(ownerDocument);
      case "base":
        return BaseElement._(ownerDocument);
      case "body":
        return BodyElement._(ownerDocument);
      case "br":
        return BRElement._(ownerDocument);
      case "button":
        return ButtonElement._(ownerDocument);
      case "canvas":
        return CanvasElement._(ownerDocument);
      case "caption":
        return TableCaptionElement._(ownerDocument);
      case "content":
        return ContentElement._(ownerDocument);
      case "datalist":
        return DataListElement._(ownerDocument);
      case "dialog":
        return DialogElement._(ownerDocument);
      case "div":
        return DivElement._(ownerDocument);
      case "fieldset":
        return FieldSetElement._(ownerDocument);
      case "form":
        return FormElement._(ownerDocument);
      case "head":
        return HeadElement._(ownerDocument);
      case "h1":
        return HeadingElement._(ownerDocument, name);
      case "h2":
        return HeadingElement._(ownerDocument, name);
      case "h3":
        return HeadingElement._(ownerDocument, name);
      case "h4":
        return HeadingElement._(ownerDocument, name);
      case "h5":
        return HeadingElement._(ownerDocument, name);
      case "h6":
        return HeadingElement._(ownerDocument, name);
      case "hr":
        return HRElement._(ownerDocument);
      case "html":
        return HtmlHtmlElement._(ownerDocument);
      case "iframe":
        return IFrameElement._(ownerDocument);
      case "img":
        return ImageElement._(ownerDocument);
      case "input":
        return InputElementBase._(ownerDocument, null);
      case "label":
        return LabelElement._(ownerDocument);
      case "legend":
        return LegendElement._(ownerDocument);
      case "li":
        return LIElement._(ownerDocument);
      case "link":
        return LinkElement._(ownerDocument);
      case "meta":
        return MetaElement._(ownerDocument);
      case "ol":
        return OListElement._(ownerDocument);
      case "option":
        return OptionElement._(ownerDocument);
      case "optgroup":
        return OptGroupElement._(ownerDocument);
      case "p":
        return ParagraphElement._(ownerDocument);
      case "picture":
        return PictureElement._(ownerDocument);
      case "pre":
        return PreElement._(ownerDocument);
      case "select":
        return SelectElement._(ownerDocument);
      case "script":
        return ScriptElement._(ownerDocument);
      case "slot":
        return SlotElement._(ownerDocument);
      case "source":
        return SourceElement._(ownerDocument);
      case "span":
        return SpanElement._(ownerDocument);
      case "style":
        return StyleElement._(ownerDocument);
      case "table":
        return TableElement._(ownerDocument);
      case "tbody":
        return TableSectionElement._(ownerDocument, name);
      case "template":
        return TemplateElement._(ownerDocument);
      case "td":
        return TableCellElement._(ownerDocument);
      case "tfoot":
        return TableSectionElement._(ownerDocument, name);
      case "thead":
        return TableSectionElement._(ownerDocument, name);
      case "textarea":
        return TextAreaElement._(ownerDocument);
      case "title":
        return TitleElement._(ownerDocument);
      case "tr":
        return TableRowElement._(ownerDocument);
      case "track":
        return TrackElement._(ownerDocument);
      case "ul":
        return UListElement._(ownerDocument);
      case "video":
        return VideoElement._(ownerDocument);
      default:
        if (!Element._normalizedElementNameRegExp.hasMatch(lowerCaseName)) {
          throw DomException._failedToExecute(
            "ElementNameException",
            "Element",
            "tag",
            "'$name' is an invalid element name.",
          );
        }
        return UnknownElement.internal(ownerDocument, null, name);
    }
  }

  /// Returns a modifiable map of attributes.
  Map<String, String> get attributes {
    return _attributesFullViewOrNull ??
        (_attributesFullViewOrNull = _Attributes(this));
  }

  /// Access the dimensions and position of this element's content + padding +
  /// border box.
  ///
  /// This returns a rectangle with the dimensions actually available for content
  /// in this element, in pixels, regardless of this element's box-sizing
  /// property. Unlike [getBoundingClientRect], the dimensions of this rectangle
  /// will return the same numerical height if the element is hidden or not. This
  /// can be used to retrieve jQuery's
  /// [outerHeight](http://api.jquery.com/outerHeight/) value for an element.
  ///
  /// _Important_ _note_: use of this method _will_ perform CSS calculations that
  /// can trigger a browser reflow. Therefore, use of this property _during_ an
  /// animation frame is discouraged. See also:
  /// [Browser Reflow](https://developers.google.com/speed/articles/reflow)
  CssRect get borderEdge => _BorderCssRect(this);

  List<Element> get children => _ElementChildren(this);

  /// The set of CSS classes applied to this element.
  ///
  /// This set makes it easy to add, remove or toggle the classes applied to
  /// this element.
  ///
  ///     element.classes.add('selected');
  ///     element.classes.toggle('isOnline');
  ///     element.classes.remove('selected');
  CssClassSet get classes => _ElementCssClassSet(this);

  set classes(Iterable<String> value) {
    // TODO(sra): Do this without reading the classes in clear() and addAll(),
    // or writing the classes in clear().
    CssClassSet classSet = classes;
    classSet.clear();
    classSet.addAll(value);
  }

  String get className => getAttribute("class");

  set className(String newValue) {
    _setAttribute("class", newValue);
  }

  Rectangle<int> get client => _getRenderData().client;

  /// Returns 0 outside browser.tagWithoutValidation
  int get clientHeight => client.height;

  /// Returns 0 outside browser.
  int get clientLeft => client.left;

  /// Returns 0 outside browser.
  int get clientTop => client.top;

  /// Returns 0 outside browser.
  int get clientWidth => client.width;

  /// Access this element's content position.
  ///
  /// This returns a rectangle with the dimensions actually available for content
  /// in this element, in pixels, regardless of this element's box-sizing
  /// property. Unlike [getBoundingClientRect], the dimensions of this rectangle
  /// will return the same numerical height if the element is hidden or not.
  ///
  /// _Important_ _note_: use of this method _will_ perform CSS calculations that
  /// can trigger a browser reflow. Therefore, use of this property _during_ an
  /// animation frame is discouraged. See also:
  /// [Browser Reflow](https://developers.google.com/speed/articles/reflow)
  CssRect get contentEdge => _ContentCssRect(this);

  /// Allows access to all custom data attributes (data-*) set on this element.
  ///
  /// The keys for the map must follow these rules:
  ///
  /// * The name must not begin with 'xml'.
  /// * The name cannot contain a semi-colon (';').
  /// * The name cannot contain any capital letters.
  ///
  /// Any keys from markup will be converted to camel-cased keys in the map.
  ///
  /// For example, HTML specified as:
  ///
  ///     <div data-my-random-value='value'></div>
  ///
  /// Would be accessed in Dart as:
  ///
  ///     var value = element.dataset['myRandomValue'];
  ///
  /// See also:
  ///
  /// * [Custom data
  ///   attributes](http://dev.w3.org/html5/spec-preview/global-attributes.html#custom-data-attribute)
  Map<String, String> get dataset => _DataAttributeMap(attributes);

  set dataset(Map<String, String> value) {
    final data = this.dataset;
    data.clear();
    for (String key in value.keys) {
      data[key] = value[key];
    }
  }

  String get dir => getAttribute("dir");

  set dir(String value) {
    _setAttribute("dir", value);
  }

  /// Provides the coordinates of the element relative to the top of the
  /// document.
  ///
  /// This method is the Dart equivalent to jQuery's
  /// [offset](http://api.jquery.com/offset/) method.
  Point get documentOffset => offsetTo(document.documentElement);

  bool get draggable => _getAttributeBool("draggable");

  set draggable(bool value) {
    _setAttributeBool("draggable", value);
  }

  String get id => getAttribute("id");

  set id(String value) {
    _setAttribute("id", value);
  }

  String get innerHtml {
    final sb = StringBuffer();
    final flags = _getPrintingFlags(this);
    Node next = this.firstChild;
    while (next != null) {
      _printNode(sb, flags, next);
      next = next.nextNode;
    }
    return sb.toString();
  }

  /// Parses the HTML fragment and sets it as the contents of this element.
  ///
  /// This uses the default sanitization behavior to sanitize the HTML fragment,
  /// use [setInnerHtml] to override the default behavior.
  set innerHtml(String html) {
    this.setInnerHtml(html);
  }

  /// Access the dimensions and position of this element's content + padding +
  /// border + margin box.
  ///
  /// This returns a rectangle with the dimensions actually available for content
  /// in this element, in pixels, regardless of this element's box-sizing
  /// property. Unlike [getBoundingClientRect], the dimensions of this rectangle
  /// will return the same numerical height if the element is hidden or not. This
  /// can be used to retrieve jQuery's
  /// [outerHeight](http://api.jquery.com/outerHeight/) value for an element.
  ///
  /// _Important_ _note_: use of this method will perform CSS calculations that
  /// can trigger a browser reflow. Therefore, use of this property _during_ an
  /// animation frame is discouraged. See also:
  /// [Browser Reflow](https://developers.google.com/speed/articles/reflow)
  CssRect get marginEdge => _MarginCssRect(this);

  String get namespaceUri => null;

  Element get nextElementSibling {
    Node sibling = nextNode;
    while (sibling != null) {
      if (sibling is Element) {
        return sibling;
      }
      sibling = sibling.nextNode;
    }
    return null;
  }

  /// Returns node name in uppercase.
  String get nodeName => _nodeName;

  @override
  int get nodeType => Node.ELEMENT_NODE;

  Rectangle<int> get offset => _getRenderData().offset;

  /// Returns 0 outside browser.
  int get offsetHeight => offset.height;

  /// Returns 0 outside browser.
  int get offsetLeft => offset.left;

  Element get offsetParent => parent;

  /// Returns 0 outside browser.
  int get offsetTop => offset.top;

  /// Returns 0 outside browser.
  int get offsetWidth => offset.width;

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
    final sb = StringBuffer();
    final flags = _getPrintingFlags(this);
    _printNode(sb, flags, this);
    return sb.toString();
  }

  /// Access the dimensions and position of this element's content + padding box.
  ///
  /// This returns a rectangle with the dimensions actually available for content
  /// in this element, in pixels, regardless of this element's box-sizing
  /// property. Unlike [getBoundingClientRect], the dimensions of this rectangle
  /// will return the same numerical height if the element is hidden or not. This
  /// can be used to retrieve jQuery's
  /// [innerHeight](http://api.jquery.com/innerHeight/) value for an element.
  /// This is also a rectangle equalling the dimensions of clientHeight and
  /// clientWidth.
  ///
  /// _Important_ _note_: use of this method _will_ perform CSS calculations that
  /// can trigger a browser reflow. Therefore, use of this property _during_ an
  /// animation frame is discouraged. See also:
  /// [Browser Reflow](https://developers.google.com/speed/articles/reflow)
  CssRect get paddingEdge => _PaddingCssRect(this);

  Element get previousElementSibling {
    Node sibling = previousNode;
    while (sibling != null) {
      if (sibling is Element) {
        return sibling;
      }
      sibling = sibling.previousNode;
    }
    return null;
  }

  /// Returns 0 outside browser.
  int get scrollHeight => _getRenderData().scroll.height;

  int get scrollLeft => _getRenderData().scroll.left;

  /// Returns 0 outside browser.
  int get scrollTop => _getRenderData().scroll.top;

  /// Returns 0 outside browser.
  int get scrollWidth => _getRenderData().scroll.width;

  /// The shadow root of this shadow host.
  ///
  /// ## Other resources
  ///
  /// * [Shadow DOM 101](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
  ///   from HTML5Rocks.
  /// * [Shadow DOM specification](http://www.w3.org/TR/shadow-dom/)
  ///   from W3C.
  @SupportedBrowser(SupportedBrowser.CHROME, '25')
  ShadowRoot get shadowRoot => null;

  bool get spellcheck => _getAttributeBool("spellcheck");

  set spellcheck(bool value) {
    _setAttributeBool("spellcheck", value);
  }

  CssStyleDeclaration get style => _getOrCreateStyle();

  int get tabIndex => _getAttributeInt("tabindex");

  set tabIndex(int value) {
    _setAttributeInt("tabindex", value);
  }

  /// Returns node name in uppercase.
  String get tagName => this.nodeName;

  String get title => getAttribute("title");

  set title(String value) {
    setAttribute("title", value);
  }

  bool get translate => _getAttributeBool("translate");

  set translate(bool value) {
    _setAttributeBool("translate", value);
  }

  /// Returns read-only list of attribute names.
  List<String> get _attributeNames {
    final result = <String>[]..addAll(_attributesWithoutLatestValues.keys);
    final style = this._style;
    if (style != null && (style._sourceIsLatest || style._map.isNotEmpty)) {
      result.add("style");
    }
    return result;
  }

  LinkedHashMap<String, String> get _attributesWithoutLatestValues {
    return this._attributesPartialViewOrNull ??
        (this._attributesPartialViewOrNull = LinkedHashMap<String, String>());
  }

  HtmlDriver get _htmlDriver {
    final ownerDocument = this.ownerDocument;
    if (ownerDocument != null) {
      final result = ownerDocument._htmlDriver;
      if (result != null) {
        return result;
      }
    }
    return HtmlDriver.current;
  }

  /// Creates a new AnimationEffect object whose target element is the object
  /// on which the method is called, and calls the play() method of the
  /// AnimationTimeline object of the document timeline of the node document
  /// of the element, passing the newly created AnimationEffect as the argument
  /// to the method. Returns an Animation for the effect.
  ///
  /// Examples
  ///
  ///     var animation = elem.animate([{"opacity": 75}, {"opacity": 0}], 200);
  ///
  ///     var animation = elem.animate([
  ///       {"transform": "translate(100px, -100%)"},
  ///       {"transform" : "translate(400px, 500px)"}
  ///     ], 1500);
  ///
  /// The [frames] parameter is an Iterable<Map>, where the
  /// map entries specify CSS animation effects. The
  /// [timing] paramter can be a double, representing the number of milliseconds
  /// for the transition, or a Map with fields corresponding to those
  /// of the [Timing] object.
  @SupportedBrowser(SupportedBrowser.CHROME, '36')
  Animation animate(Iterable<Map<String, dynamic>> frames, [timing]) {
    if (frames is! Iterable || !(frames.every((x) => x is Map))) {
      throw ArgumentError("The frames parameter should be a List of Maps "
          "with frame information");
    }
    return Animation();
  }

  /// Parses the specified text as HTML and adds the resulting node after the
  /// last child of this element.
  void appendHtml(String text,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    final fragment = const DomParserDriver().parseDocumentFragmentFromHtml(
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
    this.insertBefore(Text(value), null);
  }

  void blur() {
    dispatchEvent(FocusEvent("blur"));
  }

  void click() {
    dispatchEvent(MouseEvent("click"));
  }

  /// Create a DocumentFragment from the HTML fragment and ensure that it follows
  /// the sanitization rules specified by the validator or treeSanitizer.
  ///
  /// If the default validation behavior is too restrictive then a new
  /// NodeValidator should be created, either extending or wrapping a default
  /// validator and overriding the validation APIs.
  ///
  /// The treeSanitizer is used to walk the generated node tree and sanitize it.
  /// A custom treeSanitizer can also be provided to perform special validation
  /// rules but since the API is more complex to implement this is discouraged.
  ///
  /// The returned tree is guaranteed to only contain nodes and attributes which
  /// are allowed by the provided validator.
  ///
  /// See also:
  ///
  /// * [NodeValidator]
  /// * [NodeTreeSanitizer]
  DocumentFragment createFragment(
    String html, {
    NodeValidator validator,
    NodeTreeSanitizer treeSanitizer,
  }) {
    if (treeSanitizer == null) {
      if (validator == null) {
        if (_defaultValidator == null) {
          _defaultValidator = NodeValidatorBuilder.common();
        }
        validator = _defaultValidator;
      }
      if (_defaultSanitizer == null) {
        _defaultSanitizer = _ValidatingTreeSanitizer(validator);
      } else {
        _defaultSanitizer.validator = validator;
      }
      treeSanitizer = _defaultSanitizer;
    } else if (validator != null) {
      throw ArgumentError(
          'validator can only be passed if treeSanitizer is null');
    }
    final fragment = DocumentFragment.html(
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
    document.adoptNode(fragment);
    return fragment;
  }

  /// Creates a new shadow root for this shadow host.
  ///
  /// ## Other resources
  ///
  /// * [Shadow DOM 101](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
  ///   from HTML5Rocks.
  /// * [Shadow DOM specification](http://www.w3.org/TR/shadow-dom/) from W3C.
  @SupportedBrowser(SupportedBrowser.CHROME, '25')
  ShadowRoot createShadowRoot() {
    throw UnimplementedError();
  }

  void focus() {
    dispatchEvent(FocusEvent("focus"));
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

  /// Returns the smallest bounding rectangle that encompasses this element's
  /// padding, scrollbar, and border.
  ///
  /// ## Other resources
  ///
  /// * [Element.getBoundingClientRect](https://developer.mozilla.org/en-US/docs/Web/API/Element.getBoundingClientRect)
  ///   from MDN.
  /// * [The getBoundingClientRect()
  ///   method](http://www.w3.org/TR/cssom-view/#the-getclientrects()-and-getboundingclientrect()-methods)
  ///   from W3C.
  Rectangle getBoundingClientRect() {
    throw UnimplementedError();
  }

  CssStyleDeclaration getComputedStyle([String pseudoElement]) {
    return _ComputedStyle._(this, pseudoElement);
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

  @override
  Element internalCloneWithOwnerDocument(Document ownerDocument, bool deep) {
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

  /// Provides the offset of this element's [borderEdge] relative to the
  /// specified [parent].
  ///
  /// This is the Dart equivalent of jQuery's
  /// [position](http://api.jquery.com/position/) method. Unlike jQuery's
  /// position, however, [parent] can be any parent element of `this`,
  /// rather than only `this`'s immediate [offsetParent]. If the specified
  /// element is _not_ an offset parent or transitive offset parent to this
  /// element, an [ArgumentError] is thrown.
  Point offsetTo(Element parent) {
    return Element._offsetToHelper(this, parent);
  }

  void removeAttribute(String name) {
    _attributesWithoutLatestValues.remove(name);
    switch (name) {
      case "style":
        this._style = null;
    }
  }

  void removeAttributeNS(String namespace, String name) {
    setAttributeNS(namespace, name, null);
  }

  void requestFullscreen() {}

  void requestPointerLock() {}

  void scroll([dynamic options_OR_x, num y]) {}

  void scrollBy([dynamic options_OR_x, num y]) {}

  /// Scrolls this element into view.
  ///
  /// Only one of of the alignment options may be specified at a time.
  ///
  /// If no options are specified then this will attempt to scroll the minimum
  /// amount needed to bring the element into view.
  ///
  /// Note that alignCenter is currently only supported on WebKit platforms. If
  /// alignCenter is specified but not supported then this will fall back to
  /// alignTop.
  ///
  /// See also:
  ///
  /// * [scrollIntoView](https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoView)
  ///   from MDN.
  /// * [scrollIntoViewIfNeeded](https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoViewIfNeeded)
  ///   from MDN.
  void scrollIntoView([ScrollAlignment alignment]) {
    // Ignore
  }

  void scrollTo([dynamic options_OR_x, num y]) {}

  void setAttribute(String name, String value) {
    // Normalize name
    final normalizedName = name.toLowerCase();

    // Validate name
    if (!_normalizedAttributeNameRegExp.hasMatch(normalizedName)) {
      throw DomException._failedToExecute(
        "InvalidCharacterError",
        "setAttribute",
        "node",
        "'$name' is not a valid attribute name.",
      );
    }

    // Use internal method
    _setAttribute(normalizedName, value);
  }

  void setAttributeNS(String namespace, String name, String value) {
    if (namespace == null ||
        !Element._normalizedAttributeNameRegExp.hasMatch(namespace)) {
      throw ArgumentError.value(namespace, "namespace");
    }
    if (name == null ||
        !Element._normalizedAttributeNameRegExp.hasMatch(name)) {
      throw ArgumentError.value(name, "name");
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

  /// Parses the HTML fragment and sets it as the contents of this element.
  /// This ensures that the generated content follows the sanitization rules
  /// specified by the validator or treeSanitizer.
  ///
  /// If the default validation behavior is too restrictive then a new
  /// NodeValidator should be created, either extending or wrapping a default
  /// validator and overriding the validation APIs.
  ///
  /// The treeSanitizer is used to walk the generated node tree and sanitize it.
  /// A custom treeSanitizer can also be provided to perform special validation
  /// rules but since the API is more complex to implement this is discouraged.
  ///
  /// The resulting tree is guaranteed to only contain nodes and attributes which
  /// are allowed by the provided validator.
  ///
  /// See also:
  ///
  /// * [NodeValidator]
  /// * [NodeTreeSanitizer]
  void setInnerHtml(String html,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    while (this.firstChild != null) {
      this.firstChild.remove();
    }
    append(createFragment(
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    ));
  }

  @override
  String toString() {
    final id = this.id;
    if (id == null) {
      return '<$tagName ...>...</$tagName>';
    }
    return '<$tagName id="$id" ...>...</$tagName>';
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

  _CssStyleDeclaration _getOrCreateStyle() {
    _CssStyleDeclaration result = this._style;
    if (result == null) {
      result = _CssStyleDeclaration._();
      final value = this._attributesWithoutLatestValues["style"];
      if (value != null) {
        result._parse(value);
      }
      this._style = result;
    }
    return result;
  }

  RenderData _getRenderData() {
    return _htmlDriver.layoutDataFor(this);
  }

  Element _newInstance(Document document);

  /// Internal method that does not validate attribute name
  void _setAttribute(String name, String value) {
    value ??= "null";

    // Map update
    _attributesWithoutLatestValues[name] = value;

    // Field update for possible special case
    switch (name) {
      case "style":
        this._getOrCreateStyle()._parse(value);
        break;
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

  static Point _offsetToHelper(Element current, Element parent) {
    // We're hopping from _offsetParent_ to offsetParent (not just parent), so
    // offsetParent, "tops out" at BODY. But people could conceivably pass in
    // the document.documentElement and I want it to return an absolute offset,
    // so we have the special case checking for HTML.
    bool sameAsParent = identical(current, parent);
    bool foundAsParent = sameAsParent || parent.tagName == 'HTML';
    if (current == null || sameAsParent) {
      if (foundAsParent) return Point(0, 0);
      throw ArgumentError("Specified element is not a transitive offset "
          "parent of this element.");
    }
    Element parentOffset = current.offsetParent;
    Point p = Element._offsetToHelper(parentOffset, parent);
    return Point(p.x + current.offsetLeft, p.y + current.offsetTop);
  }

  static String _safeTagName(Element element) {
    return element.tagName;
  }
}

class ScrollAlignment {
  static const ScrollAlignment BOTTOM = ScrollAlignment._("BOTTOM");
  static const ScrollAlignment CENTER = ScrollAlignment._("CENTER");
  static const ScrollAlignment TOP = ScrollAlignment._("TOP");
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
    return _element._attributeNames;
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
    for (var key in _element._attributeNames) {
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

/// Provides a Map abstraction on top of data-* attributes, similar to the
/// dataSet in the old DOM.
class _DataAttributeMap extends MapBase<String, String> {
  final Map<String, String> _attributes;

  _DataAttributeMap(this._attributes);

  // interface Map

  bool get isEmpty => length == 0;

  bool get isNotEmpty => !isEmpty;

  // TODO: Use lazy iterator when it is available on Map.
  Iterable<String> get keys {
    final keys = <String>[];
    _attributes.forEach((String key, String value) {
      if (_matches(key)) {
        keys.add(_strip(key));
      }
    });
    return keys;
  }

  int get length => keys.length;

  Iterable<String> get values {
    final values = <String>[];
    _attributes.forEach((String key, String value) {
      if (_matches(key)) {
        values.add(value);
      }
    });
    return values;
  }

  String operator [](Object key) => _attributes[_attr(key)];

  void operator []=(String key, String value) {
    _attributes[_attr(key)] = value;
  }

  void addAll(Map<String, String> other) {
    other.forEach((k, v) {
      this[k] = v;
    });
  }

  Map<K, V> cast<K, V>() => Map.castFrom<String, String, K, V>(this);

  void clear() {
    // Needs to operate on a snapshot since we are mutating the collection.
    for (String key in keys) {
      remove(key);
    }
  }

  bool containsKey(Object key) => _attributes.containsKey(_attr(key));

  bool containsValue(Object value) => values.any((v) => v == value);

  void forEach(void f(String key, String value)) {
    _attributes.forEach((String key, String value) {
      if (_matches(key)) {
        f(_strip(key), value);
      }
    });
  }

  // TODO: Use lazy iterator when it is available on Map.
  String putIfAbsent(String key, String ifAbsent()) =>
      _attributes.putIfAbsent(_attr(key), ifAbsent);

  String remove(Object key) => _attributes.remove(_attr(key));

  // Helpers.
  String _attr(String key) => 'data-${_toHyphenedName(key)}';

  bool _matches(String key) => key.startsWith('data-');

  String _strip(String key) => _toCamelCase(key.substring(5));

  /// Converts a string name with hyphens into an identifier, by removing hyphens
  /// and capitalizing the following letter. Optionally [startUppercase] to
  /// capitalize the first letter.
  String _toCamelCase(String hyphenedName, {bool startUppercase = false}) {
    var segments = hyphenedName.split('-');
    int start = startUppercase ? 0 : 1;
    for (int i = start; i < segments.length; i++) {
      var segment = segments[i];
      if (segment.isNotEmpty) {
        // Character between 'a'..'z' mapped to 'A'..'Z'
        segments[i] = '${segment[0].toUpperCase()}${segment.substring(1)}';
      }
    }
    return segments.join('');
  }

  /// Reverse of [toCamelCase].
  String _toHyphenedName(String word) {
    var sb = StringBuffer();
    for (int i = 0; i < word.length; i++) {
      var lower = word[i].toLowerCase();
      if (word[i] != lower && i > 0) sb.write('-');
      sb.write(lower);
    }
    return sb.toString();
  }
}

class _ElementChildren extends ListBase<Element> {
  final _ElementOrDocument _element;

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
    throw ArgumentError.value(index);
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
      throw StateError("DOM tree was modified during iteration");
    }
    final next = current.nextElementSibling;
    if (next == null) {
      return false;
    }
    this._current = next;
    return true;
  }
}
