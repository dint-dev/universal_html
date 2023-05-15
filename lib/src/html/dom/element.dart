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

abstract class Element extends Node
    with GlobalEventHandlers, _ChildNode, _ElementOrDocument
    implements ChildNode, NonDocumentTypeChildNode, ParentNode {
  /// Static factory designed to expose `abort` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> abortEvent =
      EventStreamProvider<Event>('abort');

  static final _whitespaceRegExp = RegExp(r'\s');

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
      RegExp(r'^[a-zA-Z_:][a-zA-Z0-9_:\.\-]*$');

  static final _normalizedAttributeNameRegExp =
      RegExp(r'^[a-zA-Z_:][a-zA-Z0-9_:\.\-]*$');

  /// Static factory designed to expose `mousewheel` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<WheelEvent> mouseWheelEvent =
      EventStreamProvider<WheelEvent>('mousewheel');

  /// Static factory designed to expose `transitionend` events to event
  /// handlers that are not necessarily instances of [Element].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<TransitionEvent> transitionEndEvent =
      EventStreamProvider<TransitionEvent>('transition');

  /// For [nodeName] and [tagName].
  final String _nodeName;

  /// For [localName] and case-insensitive DOM queries.
  final String _lowerCaseTagName;

  AccessibleNode? _accessibleNode;

  /// Attributes is a linked list of [_Attribute] nodes.
  /// This is the first attribute.
  _Attribute? _firstAttribute;

  _Attributes? _attributes;

  /// Contains style. The instance is allocated lazily.
  _CssStyleDeclaration? _style;

  @override
  late final InternalElementData internalElementData = ownerDocument!
      .window.internalWindowController.windowBehavior
      .newInternalElementData(
    element: this as universal_html_in_browser_or_vm.Element,
  );

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

  Element.created()
      : _nodeName = '',
        _lowerCaseTagName = '',
        super._(window.document) {
    throw UnimplementedError();
  }

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
  ///     var element = new Element.html('<div class='foo'>content</div>');
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
  factory Element.html(
    String html, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    final fragment = DomParserDriver().parseDocumentFragmentFromHtml(
      ownerDocument: window.document,
      content: html.trim(),
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

  /// Internal constructor. __Not part of dart:html__.
  Element.internal(Document document, String tagName)
      : this._(document, tagName);

  /// Internal constructor. __Not part of dart:html__.
  factory Element.internalTag(Document ownerDocument, String name,
      [String? typeExtension]) {
    return Element._internalTag(
      ownerDocument,
      name,
      typeExtension,
    );
  }

  /// Internal constructor. __Not part of dart:html__.
  factory Element.internalTagNS(
      Document ownerDocument, String namespaceUri, String name,
      [String? typeExtension]) {
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
  factory Element.tag(String name, [String? typeExtension]) {
    return Element.internalTag(
        window.document, name.toUpperCase(), typeExtension);
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
      : _nodeName = nodeName,
        _lowerCaseTagName =
            ownerDocument is XmlDocument ? nodeName : nodeName.toLowerCase(),
        super._(ownerDocument);

  factory Element._internalTag(Document ownerDocument, String name,
      [String? typeExtension]) {
    final lowerCaseName = name.toLowerCase();
    switch (lowerCaseName) {
      case 'a':
        return AnchorElement._(ownerDocument);
      case 'area':
        return AreaElement._(ownerDocument);
      case 'audio':
        return AudioElement._(ownerDocument);
      case 'base':
        return BaseElement._(ownerDocument);
      case 'body':
        return BodyElement._(ownerDocument);
      case 'br':
        return BRElement._(ownerDocument);
      case 'button':
        return ButtonElement._(ownerDocument);
      case 'canvas':
        return CanvasElement._(ownerDocument);
      case 'caption':
        return TableCaptionElement._(ownerDocument);
      case 'col':
        return TableColElement._(ownerDocument);
      case 'content':
        return ContentElement._(ownerDocument);
      case 'data':
        return DataElement._(ownerDocument);
      case 'datalist':
        return DataListElement._(ownerDocument);
      case 'dialog':
        return DialogElement._(ownerDocument);
      case 'div':
        return DivElement._(ownerDocument);
      case 'embed':
        return EmbedElement._(ownerDocument);
      case 'fieldset':
        return FieldSetElement._(ownerDocument);
      case 'form':
        return FormElement._(ownerDocument);
      case 'head':
        return HeadElement._(ownerDocument);
      case 'h1':
        return HeadingElement._(ownerDocument, name);
      case 'h2':
        return HeadingElement._(ownerDocument, name);
      case 'h3':
        return HeadingElement._(ownerDocument, name);
      case 'h4':
        return HeadingElement._(ownerDocument, name);
      case 'h5':
        return HeadingElement._(ownerDocument, name);
      case 'h6':
        return HeadingElement._(ownerDocument, name);
      case 'hr':
        return HRElement._(ownerDocument);
      case 'html':
        return HtmlHtmlElement._(ownerDocument);
      case 'iframe':
        return IFrameElement._(ownerDocument);
      case 'img':
        return ImageElement._(ownerDocument);
      case 'input':
        return InputElement._(ownerDocument);
      case 'label':
        return LabelElement._(ownerDocument);
      case 'legend':
        return LegendElement._(ownerDocument);
      case 'li':
        return LIElement._(ownerDocument);
      case 'link':
        return LinkElement._(ownerDocument);
      case 'map':
        return MapElement._(ownerDocument);
      case 'menu':
        return MenuElement._(ownerDocument);
      case 'meta':
        return MetaElement._(ownerDocument);
      case 'meter':
        return MeterElement._(ownerDocument);
      case 'object':
        return ObjectElement._(ownerDocument);
      case 'ol':
        return OListElement._(ownerDocument);
      case 'option':
        return OptionElement._(ownerDocument);
      case 'optgroup':
        return OptGroupElement._(ownerDocument);
      case 'p':
        return ParagraphElement._(ownerDocument);
      case 'param':
        return ParamElement._(ownerDocument);
      case 'picture':
        return PictureElement._(ownerDocument);
      case 'pre':
        return PreElement._(ownerDocument);
      case 'q':
        return QuoteElement._(ownerDocument);
      case 'select':
        return SelectElement._(ownerDocument);
      case 'script':
        return ScriptElement._(ownerDocument);
      case 'shadow':
        return ShadowElement._(ownerDocument);
      case 'slot':
        return SlotElement._(ownerDocument);
      case 'source':
        return SourceElement._(ownerDocument);
      case 'span':
        return SpanElement._(ownerDocument);
      case 'style':
        return StyleElement._(ownerDocument);
      case 'table':
        return TableElement._(ownerDocument);
      case 'tbody':
        return TableSectionElement._(ownerDocument, name);
      case 'template':
        return TemplateElement._(ownerDocument);
      case 'td':
        return TableCellElement._(ownerDocument);
      case 'tfoot':
        return TableSectionElement._(ownerDocument, name);
      case 'thead':
        return TableSectionElement._(ownerDocument, name);
      case 'textarea':
        return TextAreaElement._(ownerDocument);
      case 'time':
        return TimeElement._(ownerDocument);
      case 'title':
        return TitleElement._(ownerDocument);
      case 'tr':
        return TableRowElement._(ownerDocument);
      case 'track':
        return TrackElement._(ownerDocument);
      case 'ul':
        return UListElement._(ownerDocument);
      case 'video':
        return VideoElement._(ownerDocument);
      default:
        if (!Element._normalizedElementNameRegExp.hasMatch(lowerCaseName)) {
          throw DomException._failedToExecute(
            'ElementNameException',
            'Element',
            'tag',
            '"$name" is an invalid element name.',
          );
        }
        return UnknownElement.internal(ownerDocument, null, name);
    }
  }

  AccessibleNode get accessibleNode {
    return _accessibleNode ??= AccessibleNode();
  }

  Element? get assignedSlot => null;

  /// Returns a modifiable map of attributes.
  Map<String, String> get attributes {
    return _attributes ??= _Attributes(this, '');
  }

  set attributes(Map<String, String> value) {
    attributes.clear();
    for (var entry in value.entries) {
      setAttribute(entry.key, entry.value);
    }
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

  set children(List<Element> value) {
    _clearChildren();
    for (var child in value) {
      append(child);
    }
  }

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
    var classSet = classes;
    classSet.clear();
    classSet.addAll(value);
  }

  String? get className => _getAttribute('class');

  set className(String? newValue) {
    _setAttribute('class', newValue);
  }

  Rectangle<int> get client => internalElementData.client;

  /// Returns 0 outside browser.tagWithoutValidation
  int get clientHeight => client.height;

  /// Returns 0 outside browser.
  int get clientLeft => client.left;

  /// Returns 0 outside browser.
  int get clientTop => client.top;

  /// Returns 0 outside browser.
  int get clientWidth => client.width;

  String? get computedName => null;

  String? get computedRole => null;

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

  String get contentEditable {
    return _getAttribute('contenteditable') ?? '';
  }

  set contentEditable(String value) {
    _setAttribute('contentEditable', value);
  }

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
    final data = dataset;
    data.clear();
    for (var key in value.keys) {
      data[key] = value[key]!;
    }
  }

  String? get dir => _getAttribute('dir');

  set dir(String? value) {
    _setAttribute('dir', value);
  }

  /// Provides the coordinates of the element relative to the top of the
  /// document.
  ///
  /// This method is the Dart equivalent to jQuery's
  /// [offset](http://api.jquery.com/offset/) method.
  Point get documentOffset => offsetTo(window.document.documentElement!);

  bool get draggable => _getAttributeBoolString('draggable') ?? false;

  set draggable(bool value) {
    _setAttributeBoolString('draggable', value);
  }

  bool get hidden {
    return _getAttributeBool('hidden');
  }

  set hidden(bool value) {
    _setAttributeBool('hidden', value);
  }

  String get id => _getAttribute('id') ?? '';

  set id(String value) {
    _setAttribute('id', value);
  }

  bool? get inert => _getAttributeBool('inert');

  set inert(bool? value) {
    _setAttributeBool('inert', value);
  }

  String? get innerHtml {
    final sb = StringBuffer();
    final flags = _getPrintingFlags(this);
    var next = firstChild;
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
  set innerHtml(String? html) {
    setInnerHtml(html);
  }

  String get innerText => text ?? '';

  set innerText(String value) {
    text = value.replaceAll('\n', '');
  }

  String? get inputMode => _getAttribute('inputmode');

  set inputMode(String? value) {
    _setAttribute('inputmode', value);
  }

  bool? get isContentEditable => false;

  String? get lang => getAttribute('lang');

  set lang(String? value) {
    setAttribute('lang', value ?? '');
  }

  String get localName {
    final name = _lowerCaseTagName;
    final i = name.indexOf(':');
    if (i < 0) {
      return name;
    }
    return name.substring(i + 1);
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

  String? get namespaceUri {
    final nodeName = this.nodeName;
    final i = nodeName.indexOf(':');
    if (i >= 0) {
      final prefix = nodeName.substring(0, i);
      final result = _namespaceUriFromPrefix(prefix);
      if (result != null) {
        return result;
      }
    }
    final document = ownerDocument;
    if (document is HtmlDocument) {
      return 'http://www.w3.org/1999/xhtml';
    }
    return null;
  }

  @override
  Element? get nextElementSibling {
    var sibling = nextNode;
    while (sibling != null) {
      if (sibling is Element) {
        return sibling;
      }
      sibling = sibling.nextNode;
    }
    return null;
  }

  /// Returns node name in uppercase.
  @override
  String get nodeName {
    return _nodeName;
  }

  @override
  int get nodeType => Node.ELEMENT_NODE;

  Rectangle<int> get offset => internalElementData.offset;

  /// Returns 0 outside browser.
  int get offsetHeight => offset.height;

  /// Returns 0 outside browser.
  int get offsetLeft => offset.left;

  Element? get offsetParent => parent;

  /// Returns 0 outside browser.
  int get offsetTop => offset.top;

  /// Returns 0 outside browser.
  int get offsetWidth => offset.width;

  @override
  Events get on => ElementEvents(this);

  /// Stream of `abort` events handled by this [Element].
  @override
  ElementStream<Event> get onAbort => abortEvent.forElement(this);

  /// Stream of `beforecopy` events handled by this [Element].
  ElementStream<Event> get onBeforeCopy => beforeCopyEvent.forElement(this);

  /// Stream of `beforecut` events handled by this [Element].
  ElementStream<Event> get onBeforeCut => beforeCutEvent.forElement(this);

  /// Stream of `beforepaste` events handled by this [Element].
  ElementStream<Event> get onBeforePaste => beforePasteEvent.forElement(this);

  /// Stream of `blur` events handled by this [Element].
  @override
  ElementStream<Event> get onBlur => blurEvent.forElement(this);

  @override
  ElementStream<Event> get onCanPlay => canPlayEvent.forElement(this);

  @override
  ElementStream<Event> get onCanPlayThrough =>
      canPlayThroughEvent.forElement(this);

  /// Stream of `change` events handled by this [Element].
  @override
  ElementStream<Event> get onChange => changeEvent.forElement(this);

  /// Stream of `click` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onClick => clickEvent.forElement(this);

  /// Stream of `contextmenu` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onContextMenu =>
      contextMenuEvent.forElement(this);

  /// Stream of `copy` events handled by this [Element].
  ElementStream<ClipboardEvent> get onCopy => copyEvent.forElement(this);

  /// Stream of `cut` events handled by this [Element].
  ElementStream<ClipboardEvent> get onCut => cutEvent.forElement(this);

  /// Stream of `doubleclick` events handled by this [Element].
  @DomName('Element.ondblclick')
  @override
  ElementStream<Event> get onDoubleClick => doubleClickEvent.forElement(this);

  /// A stream of `drag` events fired when this element currently being dragged.
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
  @override
  ElementStream<MouseEvent> get onDrag => dragEvent.forElement(this);

  /// A stream of `dragend` events fired when this element completes a drag
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
  @override
  ElementStream<MouseEvent> get onDragEnd => dragEndEvent.forElement(this);

  /// A stream of `dragenter` events fired when a dragged object is first dragged
  /// over this element.
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
  @override
  ElementStream<MouseEvent> get onDragEnter => dragEnterEvent.forElement(this);

  /// A stream of `dragleave` events fired when an object being dragged over this
  /// element leaves this element's target area.
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
  @override
  ElementStream<MouseEvent> get onDragLeave => dragLeaveEvent.forElement(this);

  /// A stream of `dragover` events fired when a dragged object is currently
  /// being dragged over this element.
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
  @override
  ElementStream<MouseEvent> get onDragOver => dragOverEvent.forElement(this);

  /// A stream of `dragstart` events fired when this element starts being
  /// dragged.
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
  @override
  ElementStream<MouseEvent> get onDragStart => dragStartEvent.forElement(this);

  /// A stream of `drop` events fired when a dragged object is dropped on this
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
  @override
  ElementStream<MouseEvent> get onDrop => dropEvent.forElement(this);

  @override
  ElementStream<Event> get onDurationChange =>
      durationChangeEvent.forElement(this);

  @override
  ElementStream<Event> get onEmptied => emptiedEvent.forElement(this);

  @override
  ElementStream<Event> get onEnded => endedEvent.forElement(this);

  /// Stream of `error` events handled by this [Element].
  @override
  ElementStream<Event> get onError => errorEvent.forElement(this);

  /// Stream of `focus` events handled by this [Element].
  @override
  ElementStream<Event> get onFocus => focusEvent.forElement(this);

  /// Stream of `fullscreenchange` events handled by this [Element].
  ElementStream<Event> get onFullscreenChange =>
      fullscreenChangeEvent.forElement(this);

  /// Stream of `fullscreenerror` events handled by this [Element].
  ElementStream<Event> get onFullscreenError =>
      fullscreenErrorEvent.forElement(this);

  /// Stream of `input` events handled by this [Element].
  @override
  ElementStream<Event> get onInput => inputEvent.forElement(this);

  /// Stream of `invalid` events handled by this [Element].
  @override
  ElementStream<Event> get onInvalid => invalidEvent.forElement(this);

  /// Stream of `keydown` events handled by this [Element].
  @override
  ElementStream<KeyboardEvent> get onKeyDown => keyDownEvent.forElement(this);

  /// Stream of `keypress` events handled by this [Element].
  @override
  ElementStream<KeyboardEvent> get onKeyPress => keyPressEvent.forElement(this);

  /// Stream of `keyup` events handled by this [Element].
  @override
  ElementStream<KeyboardEvent> get onKeyUp => keyUpEvent.forElement(this);

  /// Stream of `load` events handled by this [Element].
  @override
  ElementStream<Event> get onLoad => loadEvent.forElement(this);

  @override
  ElementStream<Event> get onLoadedData => loadedDataEvent.forElement(this);

  @override
  ElementStream<Event> get onLoadedMetadata =>
      loadedMetadataEvent.forElement(this);

  /// Stream of `mousedown` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseDown => mouseDownEvent.forElement(this);

  /// Stream of `mouseenter` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseEnter =>
      mouseEnterEvent.forElement(this);

  /// Stream of `mouseleave` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseLeave =>
      mouseLeaveEvent.forElement(this);

  /// Stream of `mousemove` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseMove => mouseMoveEvent.forElement(this);

  /// Stream of `mouseout` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseOut => mouseOutEvent.forElement(this);

  /// Stream of `mouseover` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseOver => mouseOverEvent.forElement(this);

  /// Stream of `mouseup` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseUp => mouseUpEvent.forElement(this);

  /// Stream of `mousewheel` events handled by this [Element].
  @override
  ElementStream<WheelEvent> get onMouseWheel =>
      mouseWheelEvent.forElement(this);

  /// Stream of `paste` events handled by this [Element].
  ElementStream<ClipboardEvent> get onPaste => pasteEvent.forElement(this);

  @override
  ElementStream<Event> get onPause => pauseEvent.forElement(this);

  @override
  ElementStream<Event> get onPlay => playEvent.forElement(this);

  @override
  ElementStream<Event> get onPlaying => playingEvent.forElement(this);

  @override
  ElementStream<Event> get onRateChange => rateChangeEvent.forElement(this);

  /// Stream of `reset` events handled by this [Element].
  @override
  ElementStream<Event> get onReset => resetEvent.forElement(this);

  @override
  ElementStream<Event> get onResize => resizeEvent.forElement(this);

  /// Stream of `scroll` events handled by this [Element].
  @override
  ElementStream<Event> get onScroll => scrollEvent.forElement(this);

  /// Stream of `search` events handled by this [Element].
  ElementStream<Event> get onSearch => searchEvent.forElement(this);

  @override
  ElementStream<Event> get onSeeked => seekedEvent.forElement(this);

  @override
  ElementStream<Event> get onSeeking => seekingEvent.forElement(this);

  /// Stream of `select` events handled by this [Element].
  @override
  ElementStream<Event> get onSelect => selectEvent.forElement(this);

  /// Stream of `selectstart` events handled by this [Element].
  ElementStream<Event> get onSelectStart => selectStartEvent.forElement(this);

  @override
  ElementStream<Event> get onStalled => stalledEvent.forElement(this);

  /// Stream of `submit` events handled by this [Element].
  @override
  ElementStream<Event> get onSubmit => submitEvent.forElement(this);

  @override
  ElementStream<Event> get onSuspend => suspendEvent.forElement(this);

  @override
  ElementStream<Event> get onTimeUpdate => timeUpdateEvent.forElement(this);

  /// Stream of `touchcancel` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchCancel =>
      touchCancelEvent.forElement(this);

  /// Stream of `touchend` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchEnd => touchEndEvent.forElement(this);

  /// Stream of `touchenter` events handled by this [Element].
  ElementStream<TouchEvent> get onTouchEnter =>
      touchEnterEvent.forElement(this);

  /// Stream of `touchleave` events handled by this [Element].
  ElementStream<TouchEvent> get onTouchLeave =>
      touchLeaveEvent.forElement(this);

  /// Stream of `touchmove` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchMove => touchMoveEvent.forElement(this);

  /// Stream of `touchstart` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchStart =>
      touchStartEvent.forElement(this);

  /// Stream of `transitionend` events handled by this [Element].
  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.FIREFOX)
  @SupportedBrowser(SupportedBrowser.IE, '10')
  @SupportedBrowser(SupportedBrowser.SAFARI)
  ElementStream<TransitionEvent> get onTransitionEnd =>
      transitionEndEvent.forElement(this);

  @override
  ElementStream<Event> get onVolumeChange => volumeChangeEvent.forElement(this);

  @override
  ElementStream<Event> get onWaiting => waitingEvent.forElement(this);

  @override
  ElementStream<WheelEvent> get onWheel => wheelEvent.forElement(this);

  String? get outerHtml {
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

  @override
  Element? get previousElementSibling {
    var sibling = previousNode;
    while (sibling != null) {
      if (sibling is Element) {
        return sibling;
      }
      sibling = sibling.previousNode;
    }
    return null;
  }

  /// Returns 0 outside browser.
  int get scrollHeight => internalElementData.scroll.height;

  int get scrollLeft => internalElementData.scroll.left;

  set scrollLeft(int value) {}

  /// Returns 0 outside browser.
  int get scrollTop => internalElementData.scroll.top;

  set scrollTop(int value) {}

  /// Returns 0 outside browser.
  int get scrollWidth => internalElementData.scroll.width;

  /// The shadow root of this shadow host.
  ///
  /// ## Other resources
  ///
  /// * [Shadow DOM 101](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
  ///   from HTML5Rocks.
  /// * [Shadow DOM specification](http://www.w3.org/TR/shadow-dom/)
  ///   from W3C.
  @SupportedBrowser(SupportedBrowser.CHROME, '25')
  ShadowRoot? get shadowRoot => null;

  String? get slot => _getAttribute('slot');

  set slot(String? value) {
    _setAttribute('slot', value);
  }

  bool? get spellcheck {
    final value = _getAttributeBoolString('spellcheck') ?? _defaultSpellcheck;
    if (value != null) {
      return value;
    }
    final parent = this.parent;
    if (parent != null) {
      return parent.spellcheck;
    }
    return true;
  }

  set spellcheck(bool? value) {
    _setAttributeBoolString('spellcheck', value);
  }

  CssStyleDeclaration get style => _getOrCreateStyle();

  StylePropertyMap? get styleMap => StylePropertyMap._();

  int? get tabIndex => _getAttributeInt('tabindex') ?? -1;

  set tabIndex(int? value) {
    _setAttributeInt('tabindex', value ?? -1);
  }

  /// Returns node name in uppercase.
  String get tagName => nodeName;

  String? get title => getAttribute('title');

  set title(String? value) {
    setAttribute('title', value ?? '');
  }

  bool? get translate {
    final result = _getAttributeBoolString(
      'translate',
      falseString: 'no',
      trueString: 'yes',
    );
    return result ?? true;
  }

  set translate(bool? value) {
    if (value == null) {
      removeAttribute('translate');
      return;
    }
    _setAttribute('translate', value ? 'yes' : 'no');
  }

  /// Default value of [spellcheck]. Null means that it's inherited.
  bool? get _defaultSpellcheck => null;

  /// Tells whether the element is in a HTML document.
  bool get _isHtmlDocument => ownerDocument is HtmlDocument;

  bool get _isXml {
    return ownerDocument?._isXml ?? false;
  }

  /// Creates a new AnimationEffect object whose target element is the object
  /// on which the method is called, and calls the play() method of the
  /// AnimationTimeline object of the document timeline of the node document
  /// of the element, passing the newly created AnimationEffect as the argument
  /// to the method. Returns an Animation for the effect.
  ///
  /// Examples
  ///
  ///     var animation = elem.animate([{'opacity': 75}, {'opacity': 0}], 200);
  ///
  ///     var animation = elem.animate([
  ///       {'transform': 'translate(100px, -100%)'},
  ///       {'transform' : 'translate(400px, 500px)'}
  ///     ], 1500);
  ///
  /// The [frames] parameter is an Iterable<Map>, where the
  /// map entries specify CSS animation effects. The
  /// [timing] paramter can be a double, representing the number of milliseconds
  /// for the transition, or a Map with fields corresponding to those
  /// of the [Timing] object.
  @SupportedBrowser(SupportedBrowser.CHROME, '36')
  Animation animate(Iterable<Map<String, dynamic>> frames, [timing]) {
    return Animation();
  }

  /// Parses the specified text as HTML and adds the resulting node after the
  /// last child of this element.
  void appendHtml(
    String text, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    final fragment = const DomParserDriver().parseDocumentFragmentFromHtml(
        ownerDocument: ownerDocument!,
        content: text,
        validator: validator,
        treeSanitizer: treeSanitizer);
    while (true) {
      final child = fragment.firstChild;
      if (child == null) {
        return;
      }
      child.remove();
      append(child);
    }
  }

  void appendText(String value) {
    insertBefore(Text(value), null);
  }

  /// Called by the DOM when this element has been inserted into the live
  /// document.
  ///
  /// More information can be found in the
  /// [Custom Elements](http://w3c.github.io/webcomponents/spec/custom/#dfn-attached-callback)
  /// draft specification.
  void attached() {}

  ShadowRoot attachShadow(Map shadowRootInitDict) {
    throw UnimplementedError();
  }

  /// Called by the DOM whenever an attribute on this has been changed.
  void attributeChanged(String name, String oldValue, String newValue) {}

  void blur() {
    dispatchEvent(FocusEvent('blur'));
  }

  void click() {
    dispatchEvent(MouseEvent('click'));
  }

  Element closest(String selectors) {
    throw UnimplementedError();
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
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    final fragment = DocumentFragment.html(
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
    window.document.adoptNode(fragment);
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

  /// Called by the DOM when this element has been removed from the live
  /// document.
  ///
  /// More information can be found in the
  /// [Custom Elements](http://w3c.github.io/webcomponents/spec/custom/#dfn-detached-callback)
  /// draft specification.
  void detached() {}

  void focus() {
    dispatchEvent(FocusEvent('focus'));
  }

  List<Animation> getAnimations() {
    return const <Animation>[];
  }

  String? getAttribute(String name) {
    //
    // Loosely based on:
    // https://dom.spec.whatwg.org/#dom-element-getattribute
    //

    if (!_isXml) {
      name = name.toLowerCase();

      if (name == 'style') {
        return _style?.toString();
      }
    }

    var attribute = _firstAttribute;
    while (attribute != null) {
      if (attribute._qualifiedName == name) {
        return attribute.value;
      }
      attribute = attribute._next;
    }

    // Didn't find attribute
    return null;
  }

  List<String> getAttributeNames() {
    final list = <String>[];
    var attribute = _firstAttribute;
    while (attribute != null) {
      list.add(attribute._qualifiedName);
      attribute = attribute._next;
    }
    return list;
  }

  String? getAttributeNS(String? namespaceUri, String name) {
    //
    // Loosely based on:
    // https://dom.spec.whatwg.org/#dom-element-getattributens
    //

    namespaceUri ??= '';

    // Should we ignore the case?
    // XML is case sensitive, but HTML is not.
    if (!_isXml) {
      name = name.toLowerCase();

      // Is the attribute 'style'?
      if (name == 'style' && _isHtmlNamespaceUri(namespaceUri)) {
        return _style?.toString();
      }
    }

    var attribute = _firstAttribute;
    while (attribute != null) {
      if (attribute._localName == name &&
          attribute._namespaceUri == namespaceUri) {
        return attribute.value;
      }
      attribute = attribute._next;
    }

    // Didn't find attribute
    return null;
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

  List<Rectangle> getClientRects() {
    throw UnimplementedError();
  }

  CssStyleDeclaration getComputedStyle([String? pseudoElement]) {
    return _ComputedStyle._(this, pseudoElement);
  }

  /// Returns a list of shadow DOM insertion points to which this element is
  /// distributed.
  ///
  /// ## Other resources
  ///
  /// * [Shadow DOM
  ///   specification](https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html)
  ///   from W3C.
  List<Node> getDestinationInsertionPoints() {
    throw UnimplementedError();
  }

  List<Node> getElementsByClassName(String classNames) {
    if (classNames.isEmpty) {
      throw ArgumentError.value(classNames);
    }
    return querySelectorAll(
        classNames.split(_whitespaceRegExp).map((name) => '.$name').join());
  }

  Map<String, String> getNamespacedAttributes(String namespaceUri) {
    if (namespaceUri == '') {
      return attributes;
    }
    return _Attributes(this, namespaceUri);
  }

  bool hasAttribute(String name) {
    return getAttribute(name) != null;
  }

  bool hasAttributeNS(String? namespaceUri, String name) {
    return getAttributeNS(namespaceUri, name) != null;
  }

  bool hasPointerCapture(int pointerId) {
    return false;
  }

  /// Inserts [element] into the DOM at the specified location.
  ///
  /// To see the possible values for [where], read the doc for
  /// [insertAdjacentHtml].
  ///
  /// See also:
  ///
  /// * [insertAdjacentHtml]
  Element insertAdjacentElement(String where, Element element) {
    throw UnimplementedError();
  }

  /// Parses text as an HTML fragment and inserts it into the DOM at the
  /// specified location.
  ///
  /// The [where] parameter indicates where to insert the HTML fragment:
  ///
  /// * 'beforeBegin': Immediately before this element.
  /// * 'afterBegin': As the first child of this element.
  /// * 'beforeEnd': As the last child of this element.
  /// * 'afterEnd': Immediately after this element.
  ///
  ///     var html = '<div class='something'>content</div>';
  ///     // Inserts as the first child
  ///     document.body.insertAdjacentHtml('afterBegin', html);
  ///     var createdElement = document.body.children[0];
  ///     print(createdElement.classes[0]); // Prints 'something'
  ///
  /// See also:
  ///
  /// * [insertAdjacentText]
  /// * [insertAdjacentElement]
  void insertAdjacentHtml(String where, String html,
      {NodeValidator? validator, NodeTreeSanitizer? treeSanitizer}) {
    throw UnimplementedError();
  }

  /// Inserts text into the DOM at the specified location.
  ///
  /// To see the possible values for [where], read the doc for
  /// [insertAdjacentHtml].
  ///
  /// See also:
  ///
  /// * [insertAdjacentHtml]
  void insertAdjacentText(String where, String text) {
    throw UnimplementedError();
  }

  @visibleForTesting
  @override
  Element internalCloneWithOwnerDocument(Document ownerDocument, bool deep) {
    // Create a new instance of the same class
    final clone = _newInstance(ownerDocument);

    // Clone attributes
    clone._firstAttribute = _firstAttribute?.cloneChain();

    // Clone style
    clone._style = _style?._clone();

    // Clone children
    if (deep != false) {
      Node._cloneChildrenFrom(
        ownerDocument,
        newParent: clone,
        oldParent: this,
      );
    }

    return clone;
  }

  /// Returns all descending elements. __Not part of "dart:html".__
  Iterable<Element> internalDescendingElements() sync* {
    for (var child in children) {
      yield (child);
      yield* (child.internalDescendingElements());
    }
  }

  /// Internal method. __Not part of "dart:html".__
  void internalSetAttributeNSFromParser({
    String? namespaceUri,
    required String qualifiedName,
    required String localName,
    String? value,
  }) {
    namespaceUri ??= '';
    value ??= 'null';
    if (!_isXml) {
      qualifiedName = qualifiedName.toLowerCase();
      localName = localName.toLowerCase();

      if (qualifiedName == 'style' && namespaceUri == '') {
        _setAttribute('style', value);
        return;
      }
    }

    _Attribute? previous;
    var attribute = _firstAttribute;
    while (attribute != null) {
      if (attribute._qualifiedName == qualifiedName) {
        attribute.value = value;
        return;
      }
      previous = attribute;
      attribute = attribute._next;
    }
    final newAttribute = _Attribute(
      namespaceUri != '',
      namespaceUri,
      qualifiedName,
      localName,
      value,
    );
    if (previous == null) {
      _firstAttribute = newAttribute;
    } else {
      previous._next = newAttribute;
    }
  }

  bool matches(String selectors) {
    return _matches(this, selectors, null);
  }

  bool matchesWithAncestors(String selectors) {
    Element? element = this;
    while (element != null) {
      if (_matches(element, selectors, null)) {
        return true;
      }
      element = element.parent;
    }
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

  void releasePointerCapture(int pointerId) {}

  void removeAttribute(String name) {
    //
    // Loosely based on:
    // https://dom.spec.whatwg.org/#dom-element-removeattribute
    //

    if (!_isXml) {
      name = name.toLowerCase();

      if (name == 'style') {
        _style = null;
        return;
      }
    }

    _Attribute? previous;
    var current = _firstAttribute;
    while (current != null) {
      final next = current._next;
      if (current._localName == name) {
        if (previous == null) {
          _firstAttribute = next;
        } else {
          previous._next = next;
        }
        return;
      }
      previous = current;
      current = next;
    }
  }

  void removeAttributeNS(String? namespaceUri, String name) {
    //
    // Loosely based on:
    // https://dom.spec.whatwg.org/#dom-element-removeattributens
    //

    namespaceUri ??= '';

    if (!_isXml) {
      name = name.toLowerCase();

      if (name == 'style' && _isHtmlNamespaceUri(namespaceUri)) {
        _style = null;
        return;
      }
    }

    _Attribute? previous;
    var current = _firstAttribute;
    while (current != null) {
      final next = current._next;
      if (current._localName == name && current._namespaceUri == namespaceUri) {
        if (previous == null) {
          _firstAttribute = next;
        } else {
          previous._next = next;
        }
        return;
      }
      previous = current;
      current = next;
    }
  }

  void requestFullscreen() {}

  void requestPointerLock() {}

  void scroll([dynamic options_OR_x, num? y]) {}

  void scrollBy([dynamic options_OR_x, num? y]) {}

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
  void scrollIntoView([ScrollAlignment? alignment]) {
    // Ignore
  }

  void scrollTo([dynamic options_OR_x, num? y]) {}

  Future<ScrollState> setApplyScroll(String nativeScrollBehavior) {
    throw UnimplementedError();
  }

  void setAttribute(String name, String value) {
    //
    // Loosely based on:
    // https://dom.spec.whatwg.org/#dom-element-setattribute
    //

    _validateAttributeName('setAttribute', null, name);

    if (!_isXml) {
      name = name.toLowerCase();

      if (name == 'style') {
        _setAttribute('style', value);
        return;
      }
    }

    _Attribute? previous;
    var attribute = _firstAttribute;
    while (attribute != null) {
      if (attribute._localName == name) {
        attribute.value = value;
        return;
      }
      previous = attribute;
      attribute = attribute._next;
    }
    final newAttribute = _Attribute(
      false,
      '',
      name,
      name,
      value,
    );
    if (previous == null) {
      _firstAttribute = newAttribute;
    } else {
      previous._next = newAttribute;
    }
  }

  void setAttributeNS(String? namespaceUri, String name, String value) {
    //
    // Loosely based on:
    // https://dom.spec.whatwg.org/#dom-element-setattributens
    //

    _validateAttributeName('setAttributeNS', namespaceUri, name);

    namespaceUri ??= '';

    if (!_isXml) {
      name = name.toLowerCase();

      if (name == 'style' && namespaceUri == '') {
        _setAttribute('style', value);
        return;
      }
    }

    final qualifiedName = name;
    var localName = qualifiedName;
    final i = localName.indexOf(':');
    if (i >= 0) {
      localName = localName.substring(i + 1);
    }

    _Attribute? previous;
    var attribute = _firstAttribute;
    while (attribute != null) {
      if (attribute._localName == localName &&
          attribute._namespaceUri == namespaceUri) {
        attribute.value = value;
        return;
      }
      previous = attribute;
      attribute = attribute._next;
    }
    final newAttribute = _Attribute(
      true,
      namespaceUri,
      qualifiedName,
      localName,
      value,
    );
    if (previous == null) {
      _firstAttribute = newAttribute;
    } else {
      previous._next = newAttribute;
    }
  }

  Future<ScrollState> setDistributeScroll(String nativeScrollBehavior) {
    throw UnimplementedError();
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
  void setInnerHtml(
    String? html, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    if (this is IFrameElement) {
      childNodes.clear();
      if (html != null) {
        innerText = html;
      }
      return;
    }
    while (true) {
      final firstChild = this.firstChild;
      if (firstChild == null) {
        break;
      }
      firstChild.remove();
    }
    html ??= 'null';
    final fragment = createFragment(
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
    while (true) {
      final firstChild = fragment.firstChild;
      if (firstChild == null) {
        break;
      }
      append(firstChild);
    }
  }

  void setPointerCapture(int pointerId) {}

  @override
  String toString() {
    // dart:html returns localName.
    var result = localName;

    // In development mode, we print a debugging-friendly string.
    assert(() {
      final outerHtml = this.outerHtml ?? '';
      if (outerHtml.length < 256) {
        result = outerHtml;
      } else {
        final id = this.id;
        final tagName = this.tagName.toLowerCase();
        if (id == '') {
          result = '<$tagName ...>...</$tagName>';
        } else {
          result = '<$tagName id="$id" ...>...</$tagName>';
        }
      }
      return true;
    }());

    return result;
  }

  /// Returns value of the attribute. The name MUST be lowercase.
  String? _getAttribute(String name, {String? defaultValue = ''}) {
    switch (name) {
      case 'style':
        return _style?.toString() ?? defaultValue;
      default:
        var attribute = _firstAttribute;
        while (attribute != null) {
          if (attribute._qualifiedName == name &&
              attribute._namespaceUri == '') {
            return attribute.value;
          }
          attribute = attribute._next;
        }
        return defaultValue;
    }
  }

  /// Returns boolean value of the attribute. The name MUST be lowercase.
  /// This is for attributes that either exist or don't exist.
  ///
  /// See also [_getAttributeBoolString].
  bool _getAttributeBool(String name) {
    return _hasAttribute(name);
  }

  /// Returns boolean value of the attribute. The name MUST be lowercase.
  /// This is for attributes where the value is either 'true' or 'false'.
  /// If the value is something else, returns null.
  ///
  /// See also [_getAttributeBool].
  bool? _getAttributeBoolString(
    String name, {
    String falseString = 'false',
    String trueString = 'true',
  }) {
    final value = _getAttribute(
      name,
      defaultValue: null,
    );
    if (value == falseString) {
      return false;
    }
    if (value == trueString) {
      return true;
    }
    return null;
  }

  /// Returns integer value of the attribute. The name MUST be lowercase.
  int? _getAttributeInt(String name) {
    final s = _getAttribute(name, defaultValue: null);
    if (s == null) {
      return null;
    }
    return int.tryParse(s);
  }

  /// Returns number value of the attribute. The name MUST be lowercase.
  num? _getAttributeNum(String name, {required num? defaultValue}) {
    final s = _getAttribute(name, defaultValue: null);
    if (s == null) {
      return null;
    }
    return num.tryParse(s) ?? defaultValue;
  }

  /// Returns resolved URI value of the attribute. The name MUST be lowercase.
  String? _getAttributeResolvedUri(String name) {
    final uriString = _getAttribute(name, defaultValue: null);
    if (uriString == null) {
      return null;
    }
    final uri = Uri.tryParse(uriString);
    if (uri == null) {
      return uriString;
    }
    if (uri.scheme != '') {
      return uriString;
    }
    final baseUriString = this.baseUri;
    if (baseUriString == null) {
      return uriString;
    }
    final baseUri = Uri.tryParse(baseUriString);
    if (baseUri == null) {
      return uriString;
    }
    return baseUri.resolveUri(uri).toString();
  }

  _CssStyleDeclaration _getOrCreateStyle() {
    var style = _style;
    if (style == null) {
      var attribute = _firstAttribute;
      while (attribute != null) {
        if (attribute._qualifiedName == 'style' &&
            attribute._namespaceUri == '') {
          break;
        }
        attribute = attribute._next;
      }
      style = _CssStyleDeclaration._();
      if (attribute != null) {
        style._parse(attribute.value);
      }

      _style = style;
    }
    return style;
  }

  bool _hasAttribute(String name) {
    switch (name) {
      case 'style':
        return _style != null;
      default:
        var attribute = _firstAttribute;
        while (attribute != null) {
          if (attribute._qualifiedName == name &&
              attribute._namespaceUri == '') {
            return true;
          }
          attribute = attribute._next;
        }
        return false;
    }
  }

  /// Tells whether the namespace URI refers to standard HTML elements.
  bool _isHtmlNamespaceUri(String namespaceUri) {
    return _isHtmlDocument && namespaceUri == '';
  }

  String? _namespaceUriFromPrefix(String? prefix) {
    if (prefix == null) {
      return null;
    }
    final attributeName = 'xmlns:$prefix';
    Node? node = this;
    for (; node != null; node = node.parent) {
      if (node is Element) {
        var attribute = node._firstAttribute;
        while (attribute != null) {
          if (attribute._qualifiedName == attributeName) {
            return attribute.value;
          }
          attribute = attribute._next;
        }
      }
    }
    return null;
  }

  Element _newInstance(Document ownerDocument);

  /// Sets value of an attribute.
  ///
  /// Unlike [setAttribute], this method assumes that:
  ///   * The name is valid.
  ///   * The name is lowercase.
  void _setAttribute(String name, String? value) {
    assert(name == name.toLowerCase());
    value ??= 'null';

    // Field update for possible special case
    switch (name) {
      case 'style':
        if (getAttribute('style') != value) {
          _getOrCreateStyle()._parse(value);
          _markDirty();
        }
        return;
    }

    _Attribute? previous;
    var attribute = _firstAttribute;
    while (attribute != null) {
      if (attribute._qualifiedName == name && attribute._namespaceUri == '') {
        if (attribute.value != value) {
          attribute.value = value;
          _markDirty();
        }
        return;
      }
      previous = attribute;
      attribute = attribute._next;
    }
    final newAttribute = _Attribute(
      false,
      '',
      name,
      name,
      value,
    );
    if (previous == null) {
      _firstAttribute = newAttribute;
    } else {
      previous._next = newAttribute;
    }
    _markDirty();
  }

  /// Sets boolean value of the attribute. The name MUST be lowercase.
  void _setAttributeBool(String name, bool? value) {
    if (value != null && value) {
      _setAttribute(name, '');
    } else {
      _setAttribute(name, null);
    }
  }

  /// Sets boolean value of the attribute. The name MUST be lowercase.
  void _setAttributeBoolString(String name, bool? value) {
    if (value == null) {
      _setAttribute(name, null);
      return;
    }
    _setAttribute(name, value ? 'true' : 'false');
  }

  /// Sets integer value of the attribute. The name MUST be lowercase.
  void _setAttributeInt(String name, int? value) {
    _setAttribute(name, value?.toString());
  }

  /// Sets number value of the attribute. The name MUST be lowercase.
  void _setAttributeNum(String name, num? value) {
    _setAttribute(name, value?.toString());
  }

  static bool isTagSupported(String tag) {
    return _Html5NodeValidator._allowedElements.contains(tag);
  }

  static bool _hasCorruptedAttributes(Element element) => false;

  static bool _hasCorruptedAttributesAdditionalCheck(Element element) => false;

  static Point _offsetToHelper(Element? current, Element parent) {
    // We're hopping from _offsetParent_ to offsetParent (not just parent), so
    // offsetParent, 'tops out' at BODY. But people could conceivably pass in
    // the document.documentElement and I want it to return an absolute offset,
    // so we have the special case checking for HTML.
    var sameAsParent = identical(current, parent);
    var foundAsParent = sameAsParent || parent.tagName == 'HTML';
    if (current == null || sameAsParent) {
      if (foundAsParent) return Point(0, 0);
      throw ArgumentError(
        'Specified element is not a transitive offset '
        'parent of this element.',
      );
    }
    final parentOffset = current.offsetParent;
    final p = Element._offsetToHelper(parentOffset, parent);
    return Point(p.x + current.offsetLeft, p.y + current.offsetTop);
  }

  static String _safeTagName(Element element) {
    return element.tagName;
  }

  static void _validateAttributeName(
    String methodName,
    String? namespace,
    String name,
  ) {
    //
    // Validate name
    //
    if (!_normalizedAttributeNameRegExp.hasMatch(name)) {
      throw DomException._failedToExecute(
        'InvalidCharacterError',
        methodName,
        'Element',
        '"$name" is not a valid attribute name.',
      );
    }
    if (namespace != null) {
      final i = name.indexOf(':');
      if (i == 0) {
        throw DomException._failedToExecute(
          'InvalidCharacterError',
          methodName,
          'Element',
          'The qualified name provided (\'$name\') has an empty namespace prefix.',
        );
      } else if (i > 0) {
        final afterPrefix = name.substring(i + 1);
        if (afterPrefix.contains(':')) {
          throw DomException._failedToExecute(
            'InvalidCharacterError',
            methodName,
            'Element',
            'The qualified name provided (\'$name\') contains multiple colons.',
          );
        }
        if (!_normalizedAttributeNameRegExp.hasMatch(afterPrefix)) {
          throw DomException._failedToExecute(
            'InvalidCharacterError',
            methodName,
            'Element',
            'The qualified name provided (\'$name\') contains the invalid characters.',
          );
        }
      }
    }
  }
}
