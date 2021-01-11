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
import 'dart:io';

import 'package:stream_channel/stream_channel.dart';

/// For debugging in the console.
///
/// After starting server, you must set fixed port number in 'networking.dart'.
Future<void> main() async {
  final streamController = StreamController();
  final sinkController = StreamController();
  final streamChannel = StreamChannel(
    streamController.stream,
    sinkController.sink,
  );
  // ignore: unawaited_futures
  hybridMain(streamChannel, null);
  final port = (await sinkController.stream.first) as int;
  print('Listening at: http://localhost:$port/');
}

/// Called by spawnHybridUri(...) in 'networking.dart'.
Future<void> hybridMain(StreamChannel channel, Object message) async {
  final httpServer = await HttpServer.bind('localhost', 0);
  httpServer.listen((request) async {
    print('${request.method} ${request.uri.path}');
    final response = request.response;
    response.headers.persistentConnection = false;
    try {
      response.statusCode = 200;
      final origin = request.headers.value('Origin');

      // CORS
      if (origin != null) {
        response.headers.set('Access-Control-Request-Headers', '*');
        response.headers.set('Access-Control-Allow-Methods', 'GET');
        response.headers.set('Access-Control-Allow-Origin', '*');
        response.headers.set('Access-Control-Expose-Headers', '*');
      }

      // Other headers
      response.headers.set('Cache-Control', 'no-cache');
      response.headers.set('X-Example', 'example value');

      var eventId = 0;
      final lastEventId = request.headers.value('Last-Event-ID');
      if (lastEventId != null) {
        eventId = int.parse(lastEventId.substring('id_'.length)) + 1;
      }

      switch (request.uri.path) {
        // -----------------
        // HttpRequest tests
        // -----------------

        case '/http_request/ok':
          response.write('hello');
          break;

        case '/http_request/json':
          response.headers.contentType = ContentType.json;
          response.write('''{"greeting":"hello"}''');
          break;

        // -----------------
        // EventSource tests
        // -----------------
        case '/event_source/single_poll':
          response.headers.contentType = ContentType('text', 'event-stream');
          response.write('''
retry:3000
data:data_${eventId}_line_0
data: data_${eventId}_line_1
:comment

data: data_${eventId + 1}

''');
          break;

        case '/event_source/many_polls':
          response.headers.contentType = ContentType('text', 'event-stream');
          response.write('''
retry:1
id:id_${eventId}
data:a

data: b
id:id_${eventId + 1}

''');
          break;

        case '/event_source/custom_event_type':
          response.headers.contentType = ContentType('text', 'event-stream');
          response.write('''
event: event_type_0
data: data_0

event: event_type_1
data: data_1

''');
          break;

        case '/event_source/type_no_data':
          response.headers.contentType = ContentType('text', 'event-stream');
          response.write('''
event: type_0

''');
          break;

        case '/event_source/id_no_data':
          response.headers.contentType = ContentType('text', 'event-stream');
          response.write('''
id: id_0

''');
          break;

        case '/event_source/wrong_content_type':
          response.write('''
data: abc

''');
          break;

        default:
          response.statusCode = 404;
          break;
      }
    } finally {
      print(' ${response.statusCode} (${response.reasonPhrase})');
      // Close HTTP response
      await response.close();
    }
  });

  // Announce port
  channel.sink.add(httpServer.port);
}
