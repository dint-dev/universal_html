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

typedef EventListener = Function(Event event);

class Event {
  /// This event is being handled by the event target.
  ///
  /// ## Other resources
  ///
  /// * [Target phase](http://www.w3.org/TR/DOM-Level-3-Events/#target-phase)
  ///   from W3C.
  static const int AT_TARGET = 2;

  /// This event is bubbling up through the target's ancestors.
  ///
  /// ## Other resources
  ///
  /// * [Bubble phase](http://www.w3.org/TR/DOM-Level-3-Events/#bubble-phase)
  ///   from W3C.
  static const int BUBBLING_PHASE = 3;

  /// This event is propagating through the target's ancestors, starting from the
  /// document.
  ///
  /// ## Other resources
  ///
  /// * [Bubble phase](http://www.w3.org/TR/DOM-Level-3-Events/#bubble-phase)
  ///   from W3C.
  static const int CAPTURING_PHASE = 1;

  /// This event is propagating through the target's ancestors, starting from the document.
  static const int _INITIAL_PHASE = 0;

  final String type;

  final bool? bubbles;

  final bool? cancelable;

  EventTarget? _currentTarget;

  bool _defaultPrevented = false;

  // ignore: prefer_final_fields
  int _eventPhase = _INITIAL_PHASE;

  final bool _stoppedImmediatePropagation = false;

  bool _stoppedPropagation = false;

  final num? timeStamp;

  // In JS, canBubble and cancelable are technically required parameters to
  // init*Event. In practice, though, if they aren't provided they simply
  // default to false (since that's Boolean(undefined)).
  //
  // Contrary to JS, we default canBubble and cancelable to true, since that's
  // what people want most of the time anyway.
  EventTarget? _target;
  final bool? composed;

  factory Event(String type, {bool canBubble = true, bool cancelable = true}) {
    return Event.eventType(
      'Event',
      type,
      canBubble: canBubble,
      cancelable: cancelable,
    );
  }

  /// Creates a new Event object of the specified type.
  ///
  /// This is analogous to document.createEvent.
  /// Normally events should be created via their constructors, if available.
  ///
  ///     var e = new Event.type('MouseEvent', 'mousedown', true, true);
  ///
  factory Event.eventType(String type, String name,
      {bool canBubble = true, bool cancelable = true}) {
    switch (type) {
      case 'KeyboardEvent':
        return KeyboardEvent(name);
      case 'MessageEvent':
        return MessageEvent(name);
      case 'MouseEvent':
        return MouseEvent(name);
      case 'PopStateEvent':
        return PopStateEvent(name);
      case 'TouchEvent':
        return TouchEvent.constructor(name);
      default:
        return Event.internal(type);
    }
  }

  @visibleForTesting
  Event.internal(
    this.type, {
    EventTarget? target,
    this.composed = false,
    bool canBubble = true,
    this.cancelable = true,
  })  : bubbles = canBubble,
        _target = target,
        timeStamp = DateTime.now().microsecondsSinceEpoch;

  EventTarget? get currentTarget => _currentTarget;

  bool get defaultPrevented => _defaultPrevented;

  int get eventPhase => _eventPhase;

  bool? get isTrusted => true;

  /// A pointer to the element whose CSS selector matched within which an event
  /// was fired. If this Event was not associated with any Event delegation,
  /// accessing this value will throw an [UnsupportedError].
  Element get matchingTarget {
    throw UnsupportedError('No matchingTarget');
  }

  List<EventTarget> get path => const [];

  EventTarget? get target => _target;

  List<EventTarget> composedPath() => const [];

  void internalSetTarget(EventTarget? target) {
    _target = target;
  }

  void preventDefault() {
    if (cancelable ?? true) {
      _defaultPrevented = true;
    }
  }

  void stopImmediatePropagation() {
    if (cancelable ?? true) {
      _stoppedPropagation = true;
    }
  }

  void stopPropagation() {
    if (cancelable ?? true) {
      _stoppedPropagation = true;
    }
  }
}
