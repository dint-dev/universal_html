part of universal_html;

/// A specialized Stream available to [Element]s to enable event delegation.
abstract class ElementStream<T extends Event> implements Stream<T> {
  /// Return a stream that only fires when the particular event fires for
  /// elements matching the specified CSS selector.
  ///
  /// This is the Dart equivalent to jQuery's
  /// [delegate](http://api.jquery.com/delegate/).
  Stream<T> matches(String selector);

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
  StreamSubscription<T> capture(void onData(T event));
}

class _EventStream<T extends Event> extends Stream<T> {
  final EventTarget target;
  final String type;
  final bool useCapture;

  _EventStream(this.target, this.type, this.useCapture);

  @override
  StreamSubscription<T> listen(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    final controller = StreamController<T>();
    final listener = (Event event) {
      controller.add(event);
    };
    target.addEventListener(type, listener, useCapture);
    controller.onCancel = () {
      this.target.removeEventListener(type, listener, useCapture);
    };
    return controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

/// A factory to expose DOM events as Streams.
class EventStreamProvider<T extends Event> {
  final String _eventType;

  const EventStreamProvider(this._eventType);

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
  ElementStream<T> _forElementList(ElementList<Element> e,
      {bool useCapture = false}) {
    throw UnimplementedError();
  }

  /// Gets the type of the event which this would listen for on the specified
  /// event target.
  ///
  /// The target is necessary because some browsers may use different event names
  /// for the same purpose and the target allows differentiating browser support.
  String getEventType(EventTarget target) {
    return _eventType;
  }
}

/// Adapter for exposing DOM Element events as streams, while also allowing
/// event delegation.
class _ElementEventStreamImpl<T extends Event> extends _EventStream<T>
    implements ElementStream<T> {
  _ElementEventStreamImpl(target, eventType, useCapture)
      : super(target, eventType, useCapture);

  Stream<T> matches(String selector) => throw UnimplementedError();

  StreamSubscription<T> capture(void onData(T event)) =>
      throw UnimplementedError();
}
