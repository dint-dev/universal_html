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

// Called by package:test
Future<void> handleHttpRequest(HttpRequest request) async {
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

      case '/hello_world.html':
        response.headers.contentType = ContentType.html;
        response.write('<html><body><h1>Hello world!</h1></body></html>');
        break;

      case '/http_request/ok':
        response.headers.contentType = ContentType.text;
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
id:id_$eventId
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
}

void hybridMain(StreamChannel streamChannel, Object message) async {
  final httpServer = await HttpServer.bind('localhost', 0);
  print('Listening at: http://localhost:${httpServer.port}/');
  final subscription = httpServer.listen(handleHttpRequest);

  streamChannel.sink.add(httpServer.port);

  Timer(const Duration(minutes: 5), () {
    httpServer.close();
  });
  streamChannel.stream.listen((event) {}, onDone: () {
    httpServer.close();
  });
  subscription.onDone(() {
    streamChannel.sink.close();
  });
}
