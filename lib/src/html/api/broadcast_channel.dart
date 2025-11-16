part of '../../html.dart';

class BroadcastChannel {
  final String name;

  BroadcastChannel(this.name);

  void close() {}

  void postMessage(Object message) {}

  Stream<dynamic> get onMessage => const Stream.empty();
}
