part of universal_html;

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
