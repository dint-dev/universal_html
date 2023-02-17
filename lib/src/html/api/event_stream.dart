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

/// A specialized Stream available to [Element]s to enable event delegation.
abstract class ElementStream<T extends Event> implements Stream<T> {
  /// Adds a capturing subscription to this stream.
  ///
  /// If the target of the event is a descendant of the element from which this
  /// stream derives then [onData] is called before the event propagates down to
  /// the target. This is the opposite of bubbling behavior, where the event
  /// is first processed for the event target and then bubbles upward.
  ///
  /// ## Other resources
  ///
  /// * [Event Capture](http://www.w3.org/TR/DOM-Level-2-Events/events.html#Events-flow-capture)
  ///   from the W3C DOM Events specification.
  StreamSubscription<T> capture(void Function(T event) onData);

  /// Return a stream that only fires when the particular event fires for
  /// elements matching the specified CSS selector.
  ///
  /// This is the Dart equivalent to jQuery's
  /// [delegate](http://api.jquery.com/delegate/).
  Stream<T> matches(String selector);
}

/// A factory to expose DOM events as Streams.
class EventStreamProvider<T extends Event> {
  final String _eventType;

  const EventStreamProvider(this._eventType);

  /// Gets an [ElementEventStream] for this event type, on the specified element.
  ///
  /// This will always return a broadcast stream so multiple listeners can be
  /// used simultaneously.
  ///
  /// This may be used to capture DOM events:
  ///
  ///     Element.keyDownEvent.forElement(element, useCapture: true).listen(...);
  ///
  ///     // Alternate method:
  ///     Element.keyDownEvent.forElement(element).capture(...);
  ///
  /// Or for listening to an event which will bubble through the DOM tree:
  ///
  ///     MediaElement.pauseEvent.forElement(document.body).listen(...);
  ///
  /// See also:
  ///
  /// * [EventTarget.addEventListener](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener)
  ///   from MDN.
  ElementStream<T> forElement(Element e, {bool useCapture = false}) {
    return _ElementEventStreamImpl<T>(e, _eventType, useCapture);
  }

  /// Gets a [Stream] for this event type, on the specified target.
  ///
  /// This will always return a broadcast stream so multiple listeners can be
  /// used simultaneously.
  ///
  /// This may be used to capture DOM events:
  ///
  ///     Element.keyDownEvent.forTarget(element, useCapture: true).listen(...);
  ///
  ///     // Alternate method:
  ///     Element.keyDownEvent.forTarget(element).capture(...);
  ///
  /// Or for listening to an event which will bubble through the DOM tree:
  ///
  ///     MediaElement.pauseEvent.forTarget(document.body).listen(...);
  ///
  /// See also:
  ///
  /// * [EventTarget.addEventListener](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener)
  ///   from MDN.
  Stream<T> forTarget(EventTarget e, {bool useCapture = false}) =>
      _EventStream<T>(e, _eventType, useCapture);

  /// Gets the type of the event which this would listen for on the specified
  /// event target.
  ///
  /// The target is necessary because some browsers may use different event names
  /// for the same purpose and the target allows differentiating browser support.
  String getEventType(EventTarget target) {
    return _eventType;
  }

  /// Gets an [ElementEventStream] for this event type, on the list of elements.
  ///
  /// This will always return a broadcast stream so multiple listeners can be
  /// used simultaneously.
  ///
  /// This may be used to capture DOM events:
  ///
  ///     Element.keyDownEvent._forElementList(element, useCapture: true).listen(...);
  ///
  /// See also:
  ///
  /// * [EventTarget.addEventListener](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener)
  ///   from MDN.
  ElementStream<T> _forElementList(ElementList<Element> e) {
    throw UnimplementedError();
  }
}

/// Adapter for exposing DOM Element events as streams, while also allowing
/// event delegation.
class _ElementEventStreamImpl<T extends Event> extends _EventStream<T>
    implements ElementStream<T> {
  _ElementEventStreamImpl(target, eventType, useCapture)
      : super(target, eventType, useCapture);

  @override
  StreamSubscription<T> capture(void Function(T event) onData) =>
      throw UnimplementedError();

  @override
  Stream<T> matches(String selector) => throw UnimplementedError();
}

class _EventStream<T extends Event> extends Stream<T> {
  final EventTarget target;
  final String type;
  final bool useCapture;

  _EventStream(this.target, this.type, this.useCapture);

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final controller = StreamController<T>();
    listener(Event event) {
      if (event is T) {
        controller.add(event);
      }
    }

    target.addEventListener(type, listener, useCapture);
    controller.onCancel = () {
      target.removeEventListener(type, listener, useCapture);
    };
    return controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
