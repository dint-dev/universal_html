import 'dart:async';
import 'dart:typed_data';

import 'package:typed_data/typed_buffers.dart';
import 'package:universal_html/src/html.dart';
import 'dart:convert';

/// Decodes "application/event-stream" streams.
class EventStreamDecoder
    extends StreamTransformerBase<Uint8List, MessageEvent> {
  final void Function(Duration timeout) onReceivedTimeout;
  EventStreamDecoder({this.onReceivedTimeout});

  @override
  Stream<MessageEvent> bind(Stream<Uint8List> stream) async* {
    var sb = StringBuffer();
    String id;
    String type;

    var buffer = Uint8Buffer();
    await for (var chunk in stream) {
      while (chunk.isNotEmpty) {
        // Find newline
        var i = chunk.indexOf("\n".codeUnitAt(0));
        if (i < 0) {
          // No newline
          buffer.addAll(chunk);
          break;
        }

        // Add part of the chunk into buffer
        buffer.addAll(chunk.sublist(0, i));
        chunk = chunk.sublist(i + 1);

        // Get line
        final line = utf8.decode(buffer);
        buffer.clear();
        if (line.isEmpty) {
          // End of message
          yield (MessageEvent(
            type ?? "message",
            lastEventId: id,
            data: sb.toString(),
          ));
          sb.clear();
          id = null;
          type = null;
        } else if (line.startsWith(":")) {
          // Comment
        } else {
          final i = line.indexOf(":");

          // "name:value"
          final name = line.substring(0, i);
          var value = line.substring(i + 1);

          // "name: value"
          if (value.startsWith(" ")) {
            value = value.substring(1);
          }
          switch (name) {
            case "retry":
              final amount = int.tryParse(value);
              if (amount != null && onReceivedTimeout != null) {
                onReceivedTimeout(Duration(milliseconds: amount));
              }
              break;

            case "data":
              if (sb.length > 0) {
                sb.write("\n");
              }
              sb.write(value);
              break;

            case "id":
              id = value;
              break;

            case "type":
              type = value;
              break;
          }
        }
      }
    }
  }
}
