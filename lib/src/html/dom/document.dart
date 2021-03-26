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

abstract class Document extends Node
    with _ElementOrDocument, _DocumentOrFragment {
  static const EventStreamProvider<Event> pointerLockChangeEvent =
      EventStreamProvider<Event>('pointerlockchange');

  static const EventStreamProvider<Event> pointerLockErrorEvent =
      EventStreamProvider<Event>('pointerlockerror');

  /// Static factory designed to expose `readystatechange` events to event
  /// handlers that are not necessarily instances of [Document].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> readyStateChangeEvent =
      EventStreamProvider<Event>('readystatechange');

  /// Static factory designed to expose `securitypolicyviolation` events to event
  /// handlers that are not necessarily instances of [Document].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<SecurityPolicyViolationEvent>
      securityPolicyViolationEvent =
      EventStreamProvider<SecurityPolicyViolationEvent>(
          'securitypolicyviolation');

  /// Static factory designed to expose `selectionchange` events to event
  /// handlers that are not necessarily instances of [Document].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> selectionChangeEvent =
      EventStreamProvider<Event>('selectionchange');

  final String contentType;

  final String _readyState = 'complete';

  final String? origin;

  String? cookie;

  Element? rootScroller;

  final Window window;

  factory Document() {
    return XmlDocument.internal(
      window: universal_html.window,
      contentType: 'text/html',
    );
  }

  Document._({
    required this.contentType,
    required this.window,
    this.origin,
  }) : super._document();

  /// Outside the browser, returns null.
  Element? get activeElement => null;

  String? get addressSpace => null;

  @override
  String? get baseUri {
    return window.location.href;
  }

  ScriptElement? get currentScript => null;

  Element? get documentElement {
    var node = firstChild;
    while (node != null) {
      if (node is Element) {
        return node;
      }
      node = node.nextNode;
    }
    return null;
  }

  String? get domain => null;

  Element? get fullscreenElement => null;

  bool? get fullscreenEnabled => false;

  bool? get hidden => false;

  DomImplementation? get implementation => DomImplementation._();

  @override
  int get nodeType => Node.DOCUMENT_NODE;

  /// Stream of `abort` events handled by this [Document].
  Stream<Event> get onAbort => Element.abortEvent.forTarget(this);

  /// Stream of `beforecopy` events handled by this [Document].
  Stream<Event> get onBeforeCopy => Element.beforeCopyEvent.forTarget(this);

  /// Stream of `beforecut` events handled by this [Document].
  Stream<Event> get onBeforeCut => Element.beforeCutEvent.forTarget(this);

  /// Stream of `beforepaste` events handled by this [Document].
  Stream<Event> get onBeforePaste => Element.beforePasteEvent.forTarget(this);

  /// Stream of `blur` events handled by this [Document].
  Stream<Event> get onBlur => Element.blurEvent.forTarget(this);

  Stream<Event> get onCanPlay => Element.canPlayEvent.forTarget(this);

  Stream<Event> get onCanPlayThrough =>
      Element.canPlayThroughEvent.forTarget(this);

  /// Stream of `change` events handled by this [Document].
  Stream<Event> get onChange => Element.changeEvent.forTarget(this);

  /// Stream of `click` events handled by this [Document].
  Stream<MouseEvent> get onClick => Element.clickEvent.forTarget(this);

  /// Stream of `contextmenu` events handled by this [Document].
  Stream<MouseEvent> get onContextMenu =>
      Element.contextMenuEvent.forTarget(this);

  /// Stream of `copy` events handled by this [Document].
  Stream<ClipboardEvent> get onCopy => Element.copyEvent.forTarget(this);

  /// Stream of `cut` events handled by this [Document].
  Stream<ClipboardEvent> get onCut => Element.cutEvent.forTarget(this);

  /// Stream of `doubleclick` events handled by this [Document].
  @DomName('Document.ondblclick')
  Stream<Event> get onDoubleClick => Element.doubleClickEvent.forTarget(this);

  /// Stream of `drag` events handled by this [Document].
  Stream<MouseEvent> get onDrag => Element.dragEvent.forTarget(this);

  /// Stream of `dragend` events handled by this [Document].
  Stream<MouseEvent> get onDragEnd => Element.dragEndEvent.forTarget(this);

  /// Stream of `dragenter` events handled by this [Document].
  Stream<MouseEvent> get onDragEnter => Element.dragEnterEvent.forTarget(this);

  /// Stream of `dragleave` events handled by this [Document].
  Stream<MouseEvent> get onDragLeave => Element.dragLeaveEvent.forTarget(this);

  /// Stream of `dragover` events handled by this [Document].
  Stream<MouseEvent> get onDragOver => Element.dragOverEvent.forTarget(this);

  /// Stream of `dragstart` events handled by this [Document].
  Stream<MouseEvent> get onDragStart => Element.dragStartEvent.forTarget(this);

  /// Stream of `drop` events handled by this [Document].
  Stream<MouseEvent> get onDrop => Element.dropEvent.forTarget(this);

  Stream<Event> get onDurationChange =>
      Element.durationChangeEvent.forTarget(this);

  Stream<Event> get onEmptied => Element.emptiedEvent.forTarget(this);

  Stream<Event> get onEnded => Element.endedEvent.forTarget(this);

  /// Stream of `error` events handled by this [Document].
  Stream<Event> get onError => Element.errorEvent.forTarget(this);

  /// Stream of `focus` events handled by this [Document].
  Stream<Event> get onFocus => Element.focusEvent.forTarget(this);

  /// Stream of `fullscreenchange` events handled by this [Document].
  Stream<Event> get onFullscreenChange =>
      Element.fullscreenChangeEvent.forTarget(this);

  /// Stream of `fullscreenerror` events handled by this [Document].
  Stream<Event> get onFullscreenError =>
      Element.fullscreenErrorEvent.forTarget(this);

  /// Stream of `input` events handled by this [Document].
  Stream<Event> get onInput => Element.inputEvent.forTarget(this);

  /// Stream of `invalid` events handled by this [Document].
  Stream<Event> get onInvalid => Element.invalidEvent.forTarget(this);

  /// Stream of `keydown` events handled by this [Document].
  Stream<KeyboardEvent> get onKeyDown => Element.keyDownEvent.forTarget(this);

  /// Stream of `keypress` events handled by this [Document].
  Stream<KeyboardEvent> get onKeyPress => Element.keyPressEvent.forTarget(this);

  /// Stream of `keyup` events handled by this [Document].
  Stream<KeyboardEvent> get onKeyUp => Element.keyUpEvent.forTarget(this);

  /// Stream of `load` events handled by this [Document].
  Stream<Event> get onLoad => Element.loadEvent.forTarget(this);

  Stream<Event> get onLoadedData => Element.loadedDataEvent.forTarget(this);

  Stream<Event> get onLoadedMetadata =>
      Element.loadedMetadataEvent.forTarget(this);

  /// Stream of `mousedown` events handled by this [Document].
  Stream<MouseEvent> get onMouseDown => Element.mouseDownEvent.forTarget(this);

  /// Stream of `mouseenter` events handled by this [Document].
  Stream<MouseEvent> get onMouseEnter =>
      Element.mouseEnterEvent.forTarget(this);

  /// Stream of `mouseleave` events handled by this [Document].
  Stream<MouseEvent> get onMouseLeave =>
      Element.mouseLeaveEvent.forTarget(this);

  /// Stream of `mousemove` events handled by this [Document].
  Stream<MouseEvent> get onMouseMove => Element.mouseMoveEvent.forTarget(this);

  /// Stream of `mouseout` events handled by this [Document].
  Stream<MouseEvent> get onMouseOut => Element.mouseOutEvent.forTarget(this);

  /// Stream of `mouseover` events handled by this [Document].
  Stream<MouseEvent> get onMouseOver => Element.mouseOverEvent.forTarget(this);

  /// Stream of `mouseup` events handled by this [Document].
  Stream<MouseEvent> get onMouseUp => Element.mouseUpEvent.forTarget(this);

  /// Stream of `mousewheel` events handled by this [Document].
  Stream<WheelEvent> get onMouseWheel =>
      Element.mouseWheelEvent.forTarget(this);

  /// Stream of `paste` events handled by this [Document].
  Stream<ClipboardEvent> get onPaste => Element.pasteEvent.forTarget(this);

  Stream<Event> get onPause => Element.pauseEvent.forTarget(this);

  Stream<Event> get onPlay => Element.playEvent.forTarget(this);

  Stream<Event> get onPlaying => Element.playingEvent.forTarget(this);

  Stream<Event> get onPointerLockChange =>
      pointerLockChangeEvent.forTarget(this);

  Stream<Event> get onPointerLockError => pointerLockErrorEvent.forTarget(this);

  Stream<Event> get onRateChange => Element.rateChangeEvent.forTarget(this);

  /// Stream of `readystatechange` events handled by this [Document].
  Stream<Event> get onReadyStateChange => readyStateChangeEvent.forTarget(this);

  /// Stream of `reset` events handled by this [Document].
  Stream<Event> get onReset => Element.resetEvent.forTarget(this);

  Stream<Event> get onResize => Element.resizeEvent.forTarget(this);

  /// Stream of `scroll` events handled by this [Document].
  Stream<Event> get onScroll => Element.scrollEvent.forTarget(this);

  /// Stream of `search` events handled by this [Document].
  Stream<Event> get onSearch => Element.searchEvent.forTarget(this);

  /// Stream of `securitypolicyviolation` events handled by this [Document].
  Stream<SecurityPolicyViolationEvent> get onSecurityPolicyViolation =>
      securityPolicyViolationEvent.forTarget(this);

  Stream<Event> get onSeeked => Element.seekedEvent.forTarget(this);

  Stream<Event> get onSeeking => Element.seekingEvent.forTarget(this);

  /// Stream of `select` events handled by this [Document].
  Stream<Event> get onSelect => Element.selectEvent.forTarget(this);

  /// Stream of `selectionchange` events handled by this [Document].
  Stream<Event> get onSelectionChange => selectionChangeEvent.forTarget(this);

  /// Stream of `selectstart` events handled by this [Document].
  Stream<Event> get onSelectStart => Element.selectStartEvent.forTarget(this);

  Stream<Event> get onStalled => Element.stalledEvent.forTarget(this);

  /// Stream of `submit` events handled by this [Document].
  Stream<Event> get onSubmit => Element.submitEvent.forTarget(this);

  Stream<Event> get onSuspend => Element.suspendEvent.forTarget(this);

  Stream<Event> get onTimeUpdate => Element.timeUpdateEvent.forTarget(this);

  /// Stream of `touchcancel` events handled by this [Document].
  Stream<TouchEvent> get onTouchCancel =>
      Element.touchCancelEvent.forTarget(this);

  /// Stream of `touchend` events handled by this [Document].
  Stream<TouchEvent> get onTouchEnd => Element.touchEndEvent.forTarget(this);

  /// Stream of `touchmove` events handled by this [Document].
  Stream<TouchEvent> get onTouchMove => Element.touchMoveEvent.forTarget(this);

  /// Stream of `touchstart` events handled by this [Document].
  Stream<TouchEvent> get onTouchStart =>
      Element.touchStartEvent.forTarget(this);

  Stream<Event> get onVolumeChange => Element.volumeChangeEvent.forTarget(this);

  Stream<Event> get onWaiting => Element.waitingEvent.forTarget(this);

  Element? get pointerLockElement => null;

  String? get readyState => _readyState;

  Element? get rootElement => documentElement;

  Element? get scrollingElement => null;

  String? get suborigin => null;

  bool get supportsRegister => false;

  bool get supportsRegisterElement => false;

  @override
  String? get text => null;

  DocumentTimeline get timeline => throw UnimplementedError();

  String? get visibilityState => null;

  bool get _isXml => false;

  Node adoptNode(Node node) {
    final clone = node.internalCloneWithOwnerDocument(this, true);
    clone._parent = null;
    return clone;
  }

  DocumentFragment createDocumentFragment() {
    return DocumentFragment.internal(this);
  }

  Element createElement(String tagName, [String? typeExtension]) {
    return Element.internalTag(this, tagName, typeExtension);
  }

  Element createElementNS(String namespaceUri, String qualifiedName,
      [String? typeExtension]) {
    return Element.internalTagNS(
        this, namespaceUri, qualifiedName, typeExtension);
  }

  bool execCommand(String commandId, [bool? showUI, String? value]) {
    return false;
  }

  void exitFullscreen() {}

  void exitPointerLock() {}

  List<Node> getElementsByClassName(String classNames) {
    final result = <Node>[];
    final classNameList = classNames.split(' ');
    _forEachElementInTree((element) {
      for (var className in classNameList) {
        if (!element.classes.contains(className)) {
          return;
        }
      }
      result.add(element);
    });
    return result;
  }

  List<Node> getElementsByName(String name) {
    final result = <Node>[];
    _forEachElementInTree((element) {
      if (element.getAttribute('name') == name) {
        result.add(element);
      }
    });
    return result;
  }

  List<Node> getElementsByTagName(String tagName) {
    final result = <Node>[];
    if (_isXml) {
      _forEachElementInTree((element) {
        if (element._nodeName == tagName) {
          result.add(element);
        }
      });
    } else {
      final lowerCaseTagName = tagName.toLowerCase();
      _forEachElementInTree((element) {
        if (element._lowerCaseTagName == lowerCaseTagName) {
          result.add(element);
        }
      });
    }
    return result;
  }

  Node importNode(Node node, [bool? deep]) => throw UnimplementedError();

  @override
  void insertBefore(Node node, Node? before) {
    if (node is Element) {
      if (_firstElementChild != null) {
        throw DomException._failedToExecute(
          DomException.HIERARCHY_REQUEST,
          'Node',
          'appendChild',
          'Only one element on document allowed.',
        );
      }
    } else if (node is InternalDocumentType) {
      // OK
    } else if (node is Comment) {
      // OK
    } else if (node is Text) {
      // Check that the text is whitespace
      final value = node.text!.replaceAll('\n', '').trim();
      if (value.isNotEmpty) {
        throw DomException._mayNotBeInsertedInside(
          'Document',
          'insertBefore',
          node,
          this,
        );
      }
      // Ignore the text
      return;
    } else {
      throw DomException._mayNotBeInsertedInside(
        'Document',
        'insertBefore',
        node,
        this,
      );
    }

    // Insert
    super.insertBefore(node, before);
  }

  bool queryCommandEnabled(String commandId) => throw UnimplementedError();

  bool queryCommandIndeterm(String commandId) => throw UnimplementedError();

  bool queryCommandState(String commandId) => throw UnimplementedError();

  bool queryCommandSupported(String commandId) => throw UnimplementedError();

  String queryCommandValue(String commandId) => throw UnimplementedError();

  void registerElement(String tag, Type customElementClass,
      {String? extendsTag}) {
    registerElement2(
        tag, {'prototype': customElementClass, 'extends': extendsTag});
  }

  /// Register a custom subclass of Element to be instantiatable by the DOM.
  ///
  /// This is necessary to allow the construction of any custom elements.
  ///
  /// The class being registered must either subclass HtmlElement or SvgElement.
  /// If they subclass these directly then they can be used as:
  ///
  ///     class FooElement extends HtmlElement{
  ///        void created() {
  ///          print('FooElement created!');
  ///        }
  ///     }
  ///
  ///     main() {
  ///       document.registerElement('x-foo', FooElement);
  ///       var myFoo = new Element.tag('x-foo');
  ///       // prints 'FooElement created!' to the console.
  ///     }
  ///
  /// The custom element can also be instantiated via HTML using the syntax
  /// `<x-foo></x-foo>`
  ///
  /// Other elements can be subclassed as well:
  ///
  ///     class BarElement extends InputElement{
  ///        void created() {
  ///          print('BarElement created!');
  ///        }
  ///     }
  ///
  ///     main() {
  ///       document.registerElement('x-bar', BarElement);
  ///       var myBar = new Element.tag('input', 'x-bar');
  ///       // prints 'BarElement created!' to the console.
  ///     }
  ///
  /// This custom element can also be instantiated via HTML using the syntax
  /// `<input is="x-bar"></input>`
  ///
  Function registerElement2(String tag, [Map? options]) {
    throw UnimplementedError();
  }

  @override
  void remove() {
    throw UnsupportedError('Can\'t be removed');
  }
}

abstract class DocumentOrShadowRoot {
  DocumentOrShadowRoot._();

  Element? get activeElement;

  Element? get fullscreenElement;

  Element? get pointerLockElement;

  List<StyleSheet>? get styleSheets;

  Element? elementFromPoint(int x, int y);

  List<Element> elementsFromPoint(int x, int y);
}

class DomImplementation {
  DomImplementation._();

  XmlDocument createDocument(String? namespaceURI, String qualifiedName,
      InternalDocumentType? doctype) {
    final result = XmlDocument.internal(
      window: window,
      contentType: 'text/xml',
    );
    if (doctype != null) {
      result.append(doctype.internalCloneWithOwnerDocument(result, true));
    }
    final element = result.createElement(qualifiedName);
    if (namespaceURI != null) {
      element.setAttribute('xmlns', namespaceURI);
    }
    return result;
  }

  InternalDocumentType createDocumentType(
      String qualifiedName, String publicId, String systemId) {
    return InternalDocumentType.internal(window.document, null);
  }

  HtmlDocument createHtmlDocument([String? title]) {
    return HtmlDocument.internal(
      window: window,
      contentType: 'text/html',
      filled: false,
    );
  }
}

mixin _DocumentOrFragment implements Node, _ElementOrDocument {
  Element? getElementById(String id) {
    Element? result;
    _forEachElementInTree((element) {
      if (element.id == id) {
        result = element;
      }
    });
    return result;
  }

  @override
  void remove() {
    throw UnsupportedError('Can\'t be removed');
  }
}

mixin _DocumentOrShadowRoot implements DocumentOrShadowRoot {
  @override
  Element? get activeElement => null;

  @override
  Element? get fullscreenElement => null;

  @override
  Element? get pointerLockElement => null;

  @override
  List<StyleSheet>? get styleSheets => <StyleSheet>[];

  @override
  Element? elementFromPoint(int x, int y) => null;

  @override
  List<Element> elementsFromPoint(int x, int y) => <Element>[];
}
