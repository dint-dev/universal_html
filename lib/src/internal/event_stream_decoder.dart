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

import 'dart:async';
import 'dart:convert';

import 'package:typed_data/typed_buffers.dart';
// ignore: deprecated_member_use_from_same_package
import 'package:universal_html/src/html.dart';

/// Decodes 'application/event-stream' streams.
class EventStreamDecoder
    extends StreamTransformerBase<List<int>, MessageEvent> {
  final String? origin;
  final void Function(Duration timeout)? onReceivedTimeout;

  EventStreamDecoder({this.origin, this.onReceivedTimeout});

  @override
  Stream<MessageEvent> bind(Stream<List<int>> stream) async* {
    var dataBuilder = StringBuffer();
    var hasData = false;
    String? id;
    String? type;

    var buffer = Uint8Buffer();
    await for (var chunk in stream) {
      while (chunk.isNotEmpty) {
        // Find newline
        var i = chunk.indexOf('\n'.codeUnitAt(0));
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
          if (hasData) {
            // End of message
            yield (MessageEvent(
              type ?? 'message',
              lastEventId: id,
              data: dataBuilder.toString(),
              origin: origin,
              messagePorts: const <MessagePort>[],
            ));
          }
          dataBuilder.clear();
          id = null;
          type = null;
        } else if (line.startsWith(':')) {
          // Comment
        } else {
          final i = line.indexOf(':');

          // 'name:value'
          final name = line.substring(0, i);
          var value = line.substring(i + 1);

          // 'name: value'
          if (value.startsWith(' ')) {
            value = value.substring(1);
          }
          switch (name) {
            case 'retry':
              final amount = int.tryParse(value);
              final onReceivedTimeout = this.onReceivedTimeout;
              if (amount != null && onReceivedTimeout != null) {
                onReceivedTimeout(Duration(milliseconds: amount));
              }
              break;

            case 'data':
              hasData = true;
              if (dataBuilder.length > 0) {
                dataBuilder.write('\n');
              }
              dataBuilder.write(value);
              break;

            case 'id':
              id = value;
              break;

            case 'event':
              type = value;
              break;
          }
        }
      }
    }
  }
}
