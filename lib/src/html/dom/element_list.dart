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

/// An immutable list containing HTML elements. This list contains some
/// additional methods when compared to regular lists for ease of CSS
/// manipulation on a group of elements.
abstract class ElementList<T extends Element> extends ListBase<T> {
  /// Access dimensions and position of the first Element's content + padding +
  /// border box in this list.
  ///
  /// This returns a rectangle with the dimensions actually available for content
  /// in this element, in pixels, regardless of this element's box-sizing
  /// property. Unlike [getBoundingClientRect], the dimensions of this rectangle
  /// will return the same numerical height if the element is hidden or not. This
  /// can be used to retrieve jQuery's `outerHeight` value for an element.
  CssRect get borderEdge;

  /// The union of all CSS classes applied to the elements in this list.
  ///
  /// This set makes it easy to add, remove or toggle (add if not present, remove
  /// if present) the classes applied to a collection of elements.
  ///
  ///     htmlList.classes.add('selected');
  ///     htmlList.classes.toggle('isOnline');
  ///     htmlList.classes.remove('selected');
  CssClassSet get classes;

  /// Replace the classes with `value` for every element in this list.
  set classes(Iterable<String> value);

  /// Access dimensions and position of the Elements in this list.
  ///
  /// Setting the height or width properties will set the height or width
  /// property for all elements in the list. This returns a rectangle with the
  /// dimensions actually available for content
  /// in this element, in pixels, regardless of this element's box-sizing
  /// property. Getting the height or width returns the height or width of the
  /// first Element in this list.
  ///
  /// Unlike [getBoundingClientRect], the dimensions of this rectangle
  /// will return the same numerical height if the element is hidden or not.
  CssRect get contentEdge;

  /// Access dimensions and position of the first Element's content + padding +
  /// border + margin box in this list.
  ///
  /// This returns a rectangle with the dimensions actually available for content
  /// in this element, in pixels, regardless of this element's box-sizing
  /// property. Unlike [getBoundingClientRect], the dimensions of this rectangle
  /// will return the same numerical height if the element is hidden or not. This
  /// can be used to retrieve jQuery's `outerHeight` value for an element.
  CssRect get marginEdge;

  /// Stream of `abort` events handled by this [Element].
  ElementStream<Event> get onAbort;

  /// Stream of `beforecopy` events handled by this [Element].
  ElementStream<Event> get onBeforeCopy;

  /// Stream of `beforecut` events handled by this [Element].
  ElementStream<Event> get onBeforeCut;

  /// Stream of `beforepaste` events handled by this [Element].
  ElementStream<Event> get onBeforePaste;

  /// Stream of `blur` events handled by this [Element].
  ElementStream<Event> get onBlur;

  ElementStream<Event> get onCanPlay;

  ElementStream<Event> get onCanPlayThrough;

  /// Stream of `change` events handled by this [Element].
  ElementStream<Event> get onChange;

  /// Stream of `click` events handled by this [Element].
  ElementStream<MouseEvent> get onClick;

  /// Stream of `contextmenu` events handled by this [Element].
  ElementStream<MouseEvent> get onContextMenu;

  /// Stream of `copy` events handled by this [Element].
  ElementStream<ClipboardEvent> get onCopy;

  /// Stream of `cut` events handled by this [Element].
  ElementStream<ClipboardEvent> get onCut;

  /// Stream of `doubleclick` events handled by this [Element].
  @DomName('Element.ondblclick')
  ElementStream<Event> get onDoubleClick;

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
  ElementStream<MouseEvent> get onDrag;

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
  ElementStream<MouseEvent> get onDragEnd;

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
  ElementStream<MouseEvent> get onDragEnter;

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
  ElementStream<MouseEvent> get onDragLeave;

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
  ElementStream<MouseEvent> get onDragOver;

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
  ElementStream<MouseEvent> get onDragStart;

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
  ElementStream<MouseEvent> get onDrop;

  ElementStream<Event> get onDurationChange;

  ElementStream<Event> get onEmptied;

  ElementStream<Event> get onEnded;

  /// Stream of `error` events handled by this [Element].
  ElementStream<Event> get onError;

  /// Stream of `focus` events handled by this [Element].
  ElementStream<Event> get onFocus;

  /// Stream of `fullscreenchange` events handled by this [Element].
  ElementStream<Event> get onFullscreenChange;

  /// Stream of `fullscreenerror` events handled by this [Element].
  ElementStream<Event> get onFullscreenError;

  /// Stream of `input` events handled by this [Element].
  ElementStream<Event> get onInput;

  /// Stream of `invalid` events handled by this [Element].
  ElementStream<Event> get onInvalid;

  /// Stream of `keydown` events handled by this [Element].
  ElementStream<KeyboardEvent> get onKeyDown;

  /// Stream of `keypress` events handled by this [Element].
  ElementStream<KeyboardEvent> get onKeyPress;

  /// Stream of `keyup` events handled by this [Element].
  ElementStream<KeyboardEvent> get onKeyUp;

  /// Stream of `load` events handled by this [Element].
  ElementStream<Event> get onLoad;

  ElementStream<Event> get onLoadedData;

  ElementStream<Event> get onLoadedMetadata;

  /// Stream of `mousedown` events handled by this [Element].
  ElementStream<MouseEvent> get onMouseDown;

  /// Stream of `mouseenter` events handled by this [Element].
  ElementStream<MouseEvent> get onMouseEnter;

  /// Stream of `mouseleave` events handled by this [Element].
  ElementStream<MouseEvent> get onMouseLeave;

  /// Stream of `mousemove` events handled by this [Element].
  ElementStream<MouseEvent> get onMouseMove;

  /// Stream of `mouseout` events handled by this [Element].
  ElementStream<MouseEvent> get onMouseOut;

  /// Stream of `mouseover` events handled by this [Element].
  ElementStream<MouseEvent> get onMouseOver;

  /// Stream of `mouseup` events handled by this [Element].
  ElementStream<MouseEvent> get onMouseUp;

  /// Stream of `mousewheel` events handled by this [Element].
  ElementStream<WheelEvent> get onMouseWheel;

  /// Stream of `paste` events handled by this [Element].
  ElementStream<ClipboardEvent> get onPaste;

  ElementStream<Event> get onPause;

  ElementStream<Event> get onPlay;

  ElementStream<Event> get onPlaying;

  ElementStream<Event> get onRateChange;

  /// Stream of `reset` events handled by this [Element].
  ElementStream<Event> get onReset;

  ElementStream<Event> get onResize;

  /// Stream of `scroll` events handled by this [Element].
  ElementStream<Event> get onScroll;

  /// Stream of `search` events handled by this [Element].
  ElementStream<Event> get onSearch;

  ElementStream<Event> get onSeeked;

  ElementStream<Event> get onSeeking;

  /// Stream of `select` events handled by this [Element].
  ElementStream<Event> get onSelect;

  /// Stream of `selectstart` events handled by this [Element].
  ElementStream<Event> get onSelectStart;

  ElementStream<Event> get onStalled;

  /// Stream of `submit` events handled by this [Element].
  ElementStream<Event> get onSubmit;

  ElementStream<Event> get onSuspend;

  ElementStream<Event> get onTimeUpdate;

  /// Stream of `touchcancel` events handled by this [Element].
  ElementStream<TouchEvent> get onTouchCancel;

  /// Stream of `touchend` events handled by this [Element].
  ElementStream<TouchEvent> get onTouchEnd;

  /// Stream of `touchenter` events handled by this [Element].
  ElementStream<TouchEvent> get onTouchEnter;

  /// Stream of `touchleave` events handled by this [Element].
  ElementStream<TouchEvent> get onTouchLeave;

  /// Stream of `touchmove` events handled by this [Element].
  ElementStream<TouchEvent> get onTouchMove;

  /// Stream of `touchstart` events handled by this [Element].
  ElementStream<TouchEvent> get onTouchStart;

  /// Stream of `transitionend` events handled by this [Element].
  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.FIREFOX)
  @SupportedBrowser(SupportedBrowser.IE, '10')
  @SupportedBrowser(SupportedBrowser.SAFARI)
  ElementStream<TransitionEvent> get onTransitionEnd;

  ElementStream<Event> get onVolumeChange;

  ElementStream<Event> get onWaiting;

  ElementStream<WheelEvent> get onWheel;

  /// Access dimensions and position of the first Element's content + padding box
  /// in this list.
  ///
  /// This returns a rectangle with the dimensions actually available for content
  /// in this element, in pixels, regardless of this element's box-sizing
  /// property. Unlike [getBoundingClientRect], the dimensions of this rectangle
  /// will return the same numerical height if the element is hidden or not. This
  /// can be used to retrieve jQuery's `innerHeight` value for an element. This
  /// is also a rectangle equalling the dimensions of clientHeight and
  /// clientWidth.
  CssRect get paddingEdge;

  /// Access the union of all [CssStyleDeclaration]s that are associated with an
  /// [ElementList].
  ///
  /// Grouping the style objects all together provides easy editing of specific
  /// properties of a collection of elements. Setting a specific property value
  /// will set that property in all [Element]s in the [ElementList]. Getting a
  /// specific property value will return the value of the property of the first
  /// element in the [ElementList].
  CssStyleDeclarationBase get style;
}

// Wrapper over an immutable NodeList to make it implement ElementList.
//
// Clients are {`Document`, `DocumentFragment`}.`querySelectorAll` which are
// declared to return `ElementList`.  This provides all the static analysis
// benefit so there is no need for this class have a constrained type parameter.
//
class _FrozenElementList<E extends Element> extends ListBase<E>
    implements ElementList<E>, _NodeListWrapper {
  final List<Node> _nodeList;

  _FrozenElementList._wrap(this._nodeList) {
    assert(
      _nodeList.every((element) => element is E),
      'Query expects only HTML elements of type $E but found ${_nodeList.firstWhere((e) => e is! E)}',
    );
  }

  @override
  CssRect get borderEdge => first.borderEdge;

  @override
  CssClassSet get classes => _MultiElementCssClassSet(this);

  @override
  set classes(Iterable<String> value) {
    // TODO(sra): This might be faster for Sets:
    //
    //     new _MultiElementCssClassSet(this).writeClasses(value)
    //
    // as the code below converts the Iterable[value] to a string multiple
    // times.  Maybe compute the string and set className here.
    forEach((e) => e.classes = value);
  }

  @override
  CssRect get contentEdge => _ContentCssListRect(this);

  @override
  E get first => _nodeList.first as E;

  @override
  E get last => _nodeList.last as E;

  @override
  int get length => _nodeList.length;

  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot modify list');
  }

  @override
  CssRect get marginEdge => first.marginEdge;

  /// Stream of `abort` events handled by this [Element].
  @override
  ElementStream<Event> get onAbort => Element.abortEvent._forElementList(this);

  /// Stream of `beforecopy` events handled by this [Element].
  @override
  ElementStream<Event> get onBeforeCopy =>
      Element.beforeCopyEvent._forElementList(this);

  /// Stream of `beforecut` events handled by this [Element].
  @override
  ElementStream<Event> get onBeforeCut =>
      Element.beforeCutEvent._forElementList(this);

  /// Stream of `beforepaste` events handled by this [Element].
  @override
  ElementStream<Event> get onBeforePaste =>
      Element.beforePasteEvent._forElementList(this);

  /// Stream of `blur` events handled by this [Element].
  @override
  ElementStream<Event> get onBlur => Element.blurEvent._forElementList(this);

  @override
  ElementStream<Event> get onCanPlay =>
      Element.canPlayEvent._forElementList(this);

  @override
  ElementStream<Event> get onCanPlayThrough =>
      Element.canPlayThroughEvent._forElementList(this);

  /// Stream of `change` events handled by this [Element].
  @override
  ElementStream<Event> get onChange =>
      Element.changeEvent._forElementList(this);

  /// Stream of `click` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onClick =>
      Element.clickEvent._forElementList(this);

  /// Stream of `contextmenu` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onContextMenu =>
      Element.contextMenuEvent._forElementList(this);

  /// Stream of `copy` events handled by this [Element].
  @override
  ElementStream<ClipboardEvent> get onCopy =>
      Element.copyEvent._forElementList(this);

  /// Stream of `cut` events handled by this [Element].
  @override
  ElementStream<ClipboardEvent> get onCut =>
      Element.cutEvent._forElementList(this);

  /// Stream of `doubleclick` events handled by this [Element].
  @DomName('Element.ondblclick')
  @override
  ElementStream<Event> get onDoubleClick =>
      Element.doubleClickEvent._forElementList(this);

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
  ElementStream<MouseEvent> get onDrag =>
      Element.dragEvent._forElementList(this);

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
  ElementStream<MouseEvent> get onDragEnd =>
      Element.dragEndEvent._forElementList(this);

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
  ElementStream<MouseEvent> get onDragEnter =>
      Element.dragEnterEvent._forElementList(this);

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
  ElementStream<MouseEvent> get onDragLeave =>
      Element.dragLeaveEvent._forElementList(this);

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
  ElementStream<MouseEvent> get onDragOver =>
      Element.dragOverEvent._forElementList(this);

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
  ElementStream<MouseEvent> get onDragStart =>
      Element.dragStartEvent._forElementList(this);

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
  ElementStream<MouseEvent> get onDrop =>
      Element.dropEvent._forElementList(this);

  @override
  ElementStream<Event> get onDurationChange =>
      Element.durationChangeEvent._forElementList(this);

  @override
  ElementStream<Event> get onEmptied =>
      Element.emptiedEvent._forElementList(this);

  @override
  ElementStream<Event> get onEnded => Element.endedEvent._forElementList(this);

  /// Stream of `error` events handled by this [Element].
  @override
  ElementStream<Event> get onError => Element.errorEvent._forElementList(this);

  /// Stream of `focus` events handled by this [Element].
  @override
  ElementStream<Event> get onFocus => Element.focusEvent._forElementList(this);

  /// Stream of `fullscreenchange` events handled by this [Element].
  @override
  ElementStream<Event> get onFullscreenChange =>
      Element.fullscreenChangeEvent._forElementList(this);

  /// Stream of `fullscreenerror` events handled by this [Element].
  @override
  ElementStream<Event> get onFullscreenError =>
      Element.fullscreenErrorEvent._forElementList(this);

  /// Stream of `input` events handled by this [Element].
  @override
  ElementStream<Event> get onInput => Element.inputEvent._forElementList(this);

  /// Stream of `invalid` events handled by this [Element].
  @override
  ElementStream<Event> get onInvalid =>
      Element.invalidEvent._forElementList(this);

  /// Stream of `keydown` events handled by this [Element].
  @override
  ElementStream<KeyboardEvent> get onKeyDown =>
      Element.keyDownEvent._forElementList(this);

  /// Stream of `keypress` events handled by this [Element].
  @override
  ElementStream<KeyboardEvent> get onKeyPress =>
      Element.keyPressEvent._forElementList(this);

  /// Stream of `keyup` events handled by this [Element].
  @override
  ElementStream<KeyboardEvent> get onKeyUp =>
      Element.keyUpEvent._forElementList(this);

  /// Stream of `load` events handled by this [Element].
  @override
  ElementStream<Event> get onLoad => Element.loadEvent._forElementList(this);

  @override
  ElementStream<Event> get onLoadedData =>
      Element.loadedDataEvent._forElementList(this);

  @override
  ElementStream<Event> get onLoadedMetadata =>
      Element.loadedMetadataEvent._forElementList(this);

  /// Stream of `mousedown` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseDown =>
      Element.mouseDownEvent._forElementList(this);

  /// Stream of `mouseenter` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseEnter =>
      Element.mouseEnterEvent._forElementList(this);

  /// Stream of `mouseleave` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseLeave =>
      Element.mouseLeaveEvent._forElementList(this);

  /// Stream of `mousemove` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseMove =>
      Element.mouseMoveEvent._forElementList(this);

  /// Stream of `mouseout` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseOut =>
      Element.mouseOutEvent._forElementList(this);

  /// Stream of `mouseover` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseOver =>
      Element.mouseOverEvent._forElementList(this);

  /// Stream of `mouseup` events handled by this [Element].
  @override
  ElementStream<MouseEvent> get onMouseUp =>
      Element.mouseUpEvent._forElementList(this);

  /// Stream of `mousewheel` events handled by this [Element].
  @override
  ElementStream<WheelEvent> get onMouseWheel =>
      Element.mouseWheelEvent._forElementList(this);

  /// Stream of `paste` events handled by this [Element].
  @override
  ElementStream<ClipboardEvent> get onPaste =>
      Element.pasteEvent._forElementList(this);

  @override
  ElementStream<Event> get onPause => Element.pauseEvent._forElementList(this);

  @override
  ElementStream<Event> get onPlay => Element.playEvent._forElementList(this);

  @override
  ElementStream<Event> get onPlaying =>
      Element.playingEvent._forElementList(this);

  @override
  ElementStream<Event> get onRateChange =>
      Element.rateChangeEvent._forElementList(this);

  /// Stream of `reset` events handled by this [Element].
  @override
  ElementStream<Event> get onReset => Element.resetEvent._forElementList(this);

  @override
  ElementStream<Event> get onResize =>
      Element.resizeEvent._forElementList(this);

  /// Stream of `scroll` events handled by this [Element].
  @override
  ElementStream<Event> get onScroll =>
      Element.scrollEvent._forElementList(this);

  /// Stream of `search` events handled by this [Element].
  @override
  ElementStream<Event> get onSearch =>
      Element.searchEvent._forElementList(this);

  @override
  ElementStream<Event> get onSeeked =>
      Element.seekedEvent._forElementList(this);

  @override
  ElementStream<Event> get onSeeking =>
      Element.seekingEvent._forElementList(this);

  /// Stream of `select` events handled by this [Element].
  @override
  ElementStream<Event> get onSelect =>
      Element.selectEvent._forElementList(this);

  /// Stream of `selectstart` events handled by this [Element].
  @override
  ElementStream<Event> get onSelectStart =>
      Element.selectStartEvent._forElementList(this);

  @override
  ElementStream<Event> get onStalled =>
      Element.stalledEvent._forElementList(this);

  /// Stream of `submit` events handled by this [Element].
  @override
  ElementStream<Event> get onSubmit =>
      Element.submitEvent._forElementList(this);

  @override
  ElementStream<Event> get onSuspend =>
      Element.suspendEvent._forElementList(this);

  @override
  ElementStream<Event> get onTimeUpdate =>
      Element.timeUpdateEvent._forElementList(this);

  /// Stream of `touchcancel` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchCancel =>
      Element.touchCancelEvent._forElementList(this);

  /// Stream of `touchend` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchEnd =>
      Element.touchEndEvent._forElementList(this);

  /// Stream of `touchenter` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchEnter =>
      Element.touchEnterEvent._forElementList(this);

  /// Stream of `touchleave` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchLeave =>
      Element.touchLeaveEvent._forElementList(this);

  /// Stream of `touchmove` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchMove =>
      Element.touchMoveEvent._forElementList(this);

  /// Stream of `touchstart` events handled by this [Element].
  @override
  ElementStream<TouchEvent> get onTouchStart =>
      Element.touchStartEvent._forElementList(this);

  /// Stream of `transitionend` events handled by this [Element].
  @SupportedBrowser(SupportedBrowser.CHROME)
  @SupportedBrowser(SupportedBrowser.FIREFOX)
  @SupportedBrowser(SupportedBrowser.IE, '10')
  @SupportedBrowser(SupportedBrowser.SAFARI)
  @override
  ElementStream<TransitionEvent> get onTransitionEnd =>
      Element.transitionEndEvent._forElementList(this);

  @override
  ElementStream<Event> get onVolumeChange =>
      Element.volumeChangeEvent._forElementList(this);

  @override
  ElementStream<Event> get onWaiting =>
      Element.waitingEvent._forElementList(this);

  @override
  ElementStream<WheelEvent> get onWheel =>
      Element.wheelEvent._forElementList(this);

  @override
  CssRect get paddingEdge => first.paddingEdge;

  @override
  List<Node> get rawList => _nodeList;

  @override
  E get single => _nodeList.single as E;

  @override
  CssStyleDeclarationBase get style => _CssStyleDeclarationSet(this);

  @override
  E operator [](int index) => _nodeList[index] as E;

  @override
  void operator []=(int index, E value) {
    throw UnsupportedError('Cannot modify list');
  }

  @override
  void shuffle([Random? random]) {
    throw UnsupportedError('Cannot shuffle list');
  }

  @override
  void sort([Comparator<E>? compare]) {
    throw UnsupportedError('Cannot sort list');
  }
}
