part of universal_html;

class EventSource extends EventTarget {
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>("error");

  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>("message");

  static const EventStreamProvider<Event> openEvent =
      EventStreamProvider<Event>("open");

  static const int CLOSED = 2;
  static const int CONNECTING = 0;
  static const int OPEN = 1;

  Stream<Event> get onError => errorEvent.forTarget(this);

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Stream<Event> get onOpen => openEvent.forTarget(this);

  int get readyState => CLOSED;

  final String url;

  final bool withCredentials;

  EventSource(this.url, {this.withCredentials = false});

  void close() {}
}
