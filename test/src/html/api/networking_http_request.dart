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

part of main_test;

void _testHttpRequest() {
  group('HttpRequest', () {
    late HttpRequest request;
    late StreamQueue<ProgressEvent> onError, onTimeout, onLoadEnd;
    setUp(() {
      request = HttpRequest();
      onError = StreamQueue<ProgressEvent>(request.onError);
      onTimeout = StreamQueue<ProgressEvent>(request.onTimeout);
      onLoadEnd = StreamQueue<ProgressEvent>(request.onLoadEnd);
    });

    test('GET', () async {
      //
      // Request #1
      //
      // Initial state
      expect(request.readyState, HttpRequest.UNSENT);

      // Open
      request.open('GET', 'http://localhost:$_httpServerPort/http_request/ok');
      expect(request.readyState, HttpRequest.OPENED);

      // Send
      request.send();

      // Wait
      final event = await onLoadEnd.next.timeout(
        const Duration(seconds: 5),
      );
      expect(event, isA<ProgressEvent>());
      expect(request.status, 200);
      expect(request.statusText, isNotEmpty);
      expect(
        request.responseHeaders,
        containsPair('x-example', 'example value'),
      );
      expect(request.response, 'hello');

      // No error
      expect(onError.eventsDispatched, 0);
      expect(onTimeout.eventsDispatched, 0);
    }, timeout: Timeout(Duration(seconds: 5)));

    test('GET, type "text"', () async {
      request.open('GET', 'http://localhost:$_httpServerPort/http_request/ok');
      request.responseType = 'text';
      request.send();
      final event = await onLoadEnd.next.timeout(
        const Duration(milliseconds: 200),
      );
      expect(event, isA<ProgressEvent>());
      expect(request.status, 200);
      expect(request.statusText, isNotEmpty);
      expect(
        request.responseHeaders,
        containsPair('x-example', 'example value'),
      );
      expect(request.response, 'hello');

      // No error
      expect(onError.eventsDispatched, 0);
      expect(onTimeout.eventsDispatched, 0);
    }, timeout: Timeout(Duration(seconds: 5)));

    test('GET, type "arraybuffer"', () async {
      request.open('GET', 'http://localhost:$_httpServerPort/http_request/ok');
      request.responseType = 'arraybuffer';
      request.send();
      final event = await onLoadEnd.next.timeout(
        const Duration(milliseconds: 200),
      );
      expect(event, isA<ProgressEvent>());
      expect(request.status, 200);
      expect(request.statusText, isNotEmpty);
      expect(
        request.responseHeaders,
        containsPair('x-example', 'example value'),
      );
      expect(request.response, isA<ByteBuffer>());
      expect(
        utf8.decode(Uint8List.view(request.response as ByteBuffer)),
        'hello',
      );

      // No error
      expect(onError.eventsDispatched, 0);
      expect(onTimeout.eventsDispatched, 0);
    }, timeout: Timeout(Duration(seconds: 5)));

    test('GET, type "json"', () async {
      request.open(
          'GET', 'http://localhost:$_httpServerPort/http_request/json');
      request.responseType = 'json';
      request.send();
      final event = await onLoadEnd.next.timeout(
        const Duration(milliseconds: 200),
      );
      expect(event, isA<ProgressEvent>());
      expect(request.status, 200);
      expect(request.statusText, isNotEmpty);
      expect(
        request.responseHeaders,
        containsPair('x-example', 'example value'),
      );
      expect(request.response, {'greeting': 'hello'});

      // No error
      expect(onError.eventsDispatched, 0);
      expect(onTimeout.eventsDispatched, 0);
    }, timeout: Timeout(Duration(seconds: 5)));

    test('Failing request', () async {
      //
      // Declare HttpRequest
      //
      final request = HttpRequest();
      final onError = StreamQueue<ProgressEvent>(request.onError);

      //
      // Request #1
      //
      // Initial state
      expect(request.readyState, HttpRequest.UNSENT);

      // Open
      // We assume port 314 doesn't have HTTP server
      request.open(
        'GET',
        'http://localhost:$_httpServerWrongPort/http_request/ok',
      );
      expect(request.readyState, HttpRequest.OPENED);

      // Send
      request.send();

      // Wait
      final event = await onError.next.timeout(
        const Duration(milliseconds: 200),
      );
      expect(event, isA<ProgressEvent>());
      expect(request.status, 0);
      expect(request.statusText, '');
      expect(request.responseText, '');
    }, timeout: Timeout(Duration(seconds: 5)));
  });
}
