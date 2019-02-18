part of universal_html;

typedef EventListener(Event event);

class ElementStream<T extends Event> extends Stream<T> {
  final Element _element;
  final EventStreamProvider<T> _eventStreamProvider;
  final bool _useCapture;

  ElementStream._(this._element, this._eventStreamProvider, this._useCapture);

  StreamSubscription<T> capture(void onData(T event)) => this.listen(onData);

  StreamSubscription<T> listen(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    return _eventStreamProvider
        .forTarget(_element, useCapture: _useCapture)
        .listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
  }

  Stream<T> matches(String selector) => this.where((T event) => null);
}

abstract class Event {
  /// This event is being handled by the event target.
  static const int AT_TARGET = 2;

  /// This event is bubbling up through the target's ancestors.
  static const int BUBBLING_PHASE = 3;

  /// This event is propagating through the target's ancestors, starting from the document.
  static const int CAPTURING_PHASE = 1;

  /// This event is propagating through the target's ancestors, starting from the document.
  static const int _INITIAL_PHASE = 0;

  final String type;

  final bool bubbles;

  final bool cancelable;

  bool _composed = false;

  EventTarget _currentTarget;

  bool _defaultPrevented = false;

  int _eventPhase = _INITIAL_PHASE;

  bool _stoppedImmediatePropagation = false;

  bool _stoppedPropagation = false;

  EventTarget _target;

  final num timeStamp;

  @visibleForTesting
  Event.constructor(this.type, {this.bubbles = true, this.cancelable = false})
      : assert(type != null && type.length > 0),
        this.timeStamp = DateTime.now().microsecondsSinceEpoch;

  bool get composed => _composed;

  EventTarget get currentTarget => _currentTarget;

  bool get defaultPrevented => _defaultPrevented;

  int get eventPhase => _eventPhase;

  EventTarget get matchingTarget => null;

  List<EventTarget> get path => const [];

  EventTarget get target => _target;

  List<EventTarget> composedPath() => const [];

  void preventDefault() {
    _defaultPrevented = true;
  }

  void stopImmediatePropagation() {
    _stoppedPropagation = true;
  }

  void stopPropagation() {
    _stoppedPropagation = true;
  }
}

class EventStreamProvider<T extends Event> {
  final String _type;

  const EventStreamProvider(this._type);

  ElementStream<T> forElement(Element e, {bool useCapture = false}) {
    assert(useCapture != null);
    return ElementStream<T>._(e, this, useCapture);
  }

  Stream<T> forTarget(EventTarget e, {bool useCapture = false}) {
    assert(useCapture != null);
    return _EventStream<T>(e, this._type, useCapture);
  }

  String getEventType(EventTarget target) {
    throw UnimplementedError();
  }
}

abstract class EventTarget {
  List<_AddedEventListener> _eventListeners;

  EventTarget get _parentEventTarget => null;

  void addEventListener(String type, EventListener listener,
      [bool useCapture]) {
    final eventListeners = this._eventListeners ?? (this._eventListeners = []);
    eventListeners
        .add(_AddedEventListener(type, listener, useCapture ?? false));
  }

  bool dispatchEvent(Event event) {
    if (event._eventPhase != Event._INITIAL_PHASE) {
      throw ArgumentError("Event.eventPhase is not 0");
    }
    event._eventPhase = Event.AT_TARGET;
    event._target = this;

    // Capturing
    event._eventPhase = Event.CAPTURING_PHASE;
    _dispatchEventCapturing(event);
    if (!event._stoppedPropagation) {
      // Bubbling
      if (event.bubbles) {
        event._eventPhase = Event.BUBBLING_PHASE;
        _dispatchEventBubbling(event);
      }
    }

    // Return
    return event._defaultPrevented;
  }

  void removeEventListener(String type, EventListener listener,
      [bool useCapture]) {
    useCapture ??= false;
    _eventListeners?.removeWhere((e) =>
        e._type == type &&
        e._listener == listener &&
        e._useCapture == useCapture);
  }

  void _dispatchEventBubbling(Event event) {
    final eventListeners = this._eventListeners;
    if (eventListeners != null) {
      final eventType = event.type;
      event._currentTarget = this;
      for (var el in eventListeners) {
        if (el._type == eventType && el._useCapture == false) {
          el._listener(event);
          if (event._stoppedImmediatePropagation) {
            break;
          }
          if (event._stoppedPropagation) {
            return;
          }
        }
      }
    }
    final parent = this._parentEventTarget;
    if (parent != null) {
      parent._dispatchEventBubbling(event);
    }
  }

  void _dispatchEventCapturing(Event event) {
    final parent = this._parentEventTarget;
    if (parent != null) {
      parent._dispatchEventCapturing(event);
      if (event._stoppedPropagation) {
        return;
      }
    }
    final eventListeners = this._eventListeners;
    if (eventListeners != null && !event._stoppedPropagation) {
      event._currentTarget = this;
      final eventType = event.type;
      for (var el in eventListeners) {
        if (el._useCapture && el._type == eventType) {
          el._listener(event);
          if (event._stoppedImmediatePropagation || event._stoppedPropagation) {
            return;
          }
        }
      }
    }
  }
}

class _AddedEventListener {
  final String _type;
  final EventListener _listener;
  final bool _useCapture;

  _AddedEventListener(this._type, this._listener, this._useCapture)
      : assert(_useCapture is bool);
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
