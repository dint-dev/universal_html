part of universal_html;

typedef EventListener = Function(Event event);

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

  Event.internalConstructor(this.type,
      {this.bubbles = true, this.cancelable = false})
      : assert(type != null && type.isNotEmpty),
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
  List<_AddedEventListener> _listeners;

  EventTarget get _parentEventTarget => null;

  void addEventListener(String type, EventListener listener,
      [bool useCapture]) {
    final eventListener = _AddedEventListener(
      type,
      listener,
      useCapture ?? false,
    );
    final eventListeners = this._listeners ?? (this._listeners = []);
    eventListeners.add(eventListener);
  }

  bool dispatchEvent(Event event) {
    if (event._eventPhase != Event._INITIAL_PHASE) {
      throw ArgumentError("Event.eventPhase is not Event._INITIAL_PHASE");
    }
    event._eventPhase = Event.AT_TARGET;
    event._target = this;

    // Capturing phase
    event._eventPhase = Event.CAPTURING_PHASE;
    _invokeCapturingListeners(event);

    // Was the event stopped?
    if (event._stoppedPropagation) {
      return event._defaultPrevented;
    }

    // Bubbling phase
    if (event.bubbles) {
      event._eventPhase = Event.BUBBLING_PHASE;
      _invokeBubblingListeners(event);
    }

    // Return
    return event._defaultPrevented;
  }

  void removeEventListener(String type, EventListener listener,
      [bool useCapture]) {
    useCapture ??= false;
    _listeners?.removeWhere((e) =>
        e._type == type &&
        e._listener == listener &&
        e._useCapture == useCapture);
  }

  void _invokeBubblingListeners(Event event) {
    // Does this target have event listeners?
    final listeners = this._listeners;
    if (listeners != null) {
      // Set current target
      event._currentTarget = this;

      // For each matching listener
      final eventType = event.type;
      for (var listener in listeners) {
        // Does the event type match?
        if (listener._type != eventType) {
          continue;
        }

        // Is it a capturing listener?
        if (listener._useCapture) {
          continue;
        }

        // Call listener
        listener._listener(event);

        // Did the listener stop immediate propagation?
        if (event._stoppedImmediatePropagation) {
          break;
        }

        // Did the listener stop propagation?
        if (event._stoppedPropagation) {
          return;
        }
      }
    }

    // Does the target have a parent?
    final parent = this._parentEventTarget;
    if (parent != null) {
      parent._invokeBubblingListeners(event);
    }
  }

  void _invokeCapturingListeners(Event event) {
    // Call parent target
    final parent = this._parentEventTarget;
    if (parent != null) {
      parent._invokeCapturingListeners(event);
      if (event._stoppedPropagation) {
        return;
      }
    }

    // Did a parent target stop propagation?
    if (event._stoppedPropagation) {
      return;
    }

    // Do we have listeners?
    final listeners = this._listeners;
    if (listeners == null) {
      return;
    }

    // Set current target
    event._currentTarget = this;

    // For each listener
    final eventType = event.type;
    for (var listener in listeners) {
      // Is it a bubbling listener?
      if (!listener._useCapture) {
        // Yes, skip
        continue;
      }

      // Is the even type the same?
      if (listener._type != eventType) {
        continue;
      }

      // Call it
      listener._listener(event);

      // Did the listener stop propagation?
      if (event._stoppedImmediatePropagation || event._stoppedPropagation) {
        return;
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
