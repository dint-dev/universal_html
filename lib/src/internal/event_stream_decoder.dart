import 'dart:async';
import 'package:universal_html/src/html.dart';

/// Decodes "application/event-stream" streams.
class EventStreamDecoder
    extends StreamTransformerBase<List<int>, MessageEvent> {
  final void Function(Duration timeout) onReceivedTimeout;
  EventStreamDecoder({this.onReceivedTimeout});

  @override
  Stream<MessageEvent> bind(Stream<List<int>> stream) async* {
    throw UnimplementedError();
  }
}
