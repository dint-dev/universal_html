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

void _testEventSource() {
  Stream<List<int>> makeStream(String s) {
    return Stream<List<int>>.fromIterable([utf8.encode(s)]);
  }

  group('EventSource: ', () {
    late String origin;
    late String baseUrl;

    setUp(() {
      origin = 'http://localhost:$_httpServerPort';
      baseUrl = '$origin/event_source';
    });

    test(
      'with `newEventSource(...)`',
      () async {
        final eventSource = EventSource('$baseUrl/single_poll');
        if (eventSource is EventSourceOutsideBrowser) {
          eventSource.onHttpClientRequest =
              expectAsync2((eventSource, request) {});
          eventSource.onHttpClientResponse =
              expectAsync3((eventSource, request, response) {});
        }
        addTearDown(() {
          eventSource.close();
        });
        expect(eventSource.readyState, EventSource.CONNECTING);
        await Future.delayed(const Duration(milliseconds: 200));
        eventSource.close();
      },
      timeout: Timeout(const Duration(seconds: 5)),
    );

    test('a single poll', () async {
      // -----------------------------------------------------------------------
      // Construct EventStream
      // -----------------------------------------------------------------------
      final eventSource = EventSource('$baseUrl/single_poll');
      expect(eventSource.readyState, EventSource.CONNECTING);

      addTearDown(() {
        eventSource.close();
      });

      // -----------------------------------------------------------------------
      // Listen events
      // -----------------------------------------------------------------------
      final openEvents = <Event>[];
      final messageEvents = <MessageEvent>[];
      final errorEvents = <Event>[];

      var openEventsDone = false;
      var messageEventsDone = false;
      var errorEventsDone = false;

      eventSource.onOpen.listen((event) {
        openEvents.add(event);
      }, onDone: () {
        openEventsDone = true;
      });
      eventSource.onMessage.listen((event) {
        messageEvents.add(event);
      }, onDone: () {
        messageEventsDone = true;
      });
      eventSource.onError.listen((event) {
        errorEvents.add(event);
      }, onDone: () {
        errorEventsDone = true;
      });

      // Check state
      expect(eventSource.readyState, EventSource.CONNECTING);
      expect(openEvents, hasLength(0));
      expect(messageEvents, hasLength(0));
      expect(errorEvents, hasLength(0));

      // -----------------------------------------------------------------------
      // Wait 50 milliseconds
      // -----------------------------------------------------------------------
      await Future.delayed(const Duration(milliseconds: 50));

      // Check state
      expect(eventSource.readyState, EventSource.CONNECTING);
      expect(openEvents, hasLength(1));
      expect(openEvents.single.type, 'open');
      expect(messageEvents, hasLength(2));
      expect(errorEvents, hasLength(1));
      expect(errorEvents.single.type, 'error');

      // -----------------------------------------------------------------------
      // Close
      // -----------------------------------------------------------------------
      eventSource.close();

      // Check state
      expect(eventSource.readyState, EventSource.CLOSED);
      expect(openEvents, hasLength(1));
      expect(messageEvents, hasLength(2));
      expect(errorEvents, hasLength(1));

      // Check 'open' event
      expect(openEvents[0], isNotNull);
      // Check first message
      expect(messageEvents[0].type, 'message');
      expect(messageEvents[0].data, 'data_0_line_0\ndata_0_line_1');
      expect(messageEvents[0].lastEventId, '');
      expect(messageEvents[0].origin, origin);
      expect(messageEvents[0].source, isNull);
      expect(messageEvents[0].ports, <MessagePort>[]);

      // Check second message
      expect(messageEvents[1].type, 'message');
      expect(messageEvents[1].data, 'data_1');
      expect(messageEvents[1].lastEventId, '');
      expect(messageEvents[1].origin, origin);
      expect(messageEvents[1].source, isNull);
      expect(messageEvents[1].ports, <MessagePort>[]);

      // Check 'end-of-stream' error
      expect(errorEvents[0], isNotNull);

      // Streams should not be closed
      expect(openEventsDone, isFalse);
      expect(messageEventsDone, isFalse);
      expect(errorEventsDone, isFalse);
    });

    test('many polls', () async {
      final eventSource = EventSource('$baseUrl/many_polls');
      addTearDown(() {
        eventSource.close();
      });

      // Collect messages
      final messages = <MessageEvent>[];
      eventSource.onMessage.listen((event) {
        messages.add(event);
      });

      // Wait for 100 ms
      await Future.delayed(const Duration(milliseconds: 100));

      expect(messages, hasLength(greaterThanOrEqualTo(5)));
      expect(messages[0].lastEventId, 'id_0');
      expect(messages[1].lastEventId, 'id_1');
      expect(messages[2].lastEventId, 'id_2');
      expect(messages[3].lastEventId, 'id_3');
      expect(messages[4].lastEventId, 'id_4');
    });

    test('custom event type', () async {
      const eventType0 = 'event_type_0';
      const eventType1 = 'event_type_1';
      final eventSource = EventSource('$baseUrl/custom_event_type');
      addTearDown(() {
        eventSource.close();
      });

      // -----------------------------------------------------------------------
      // Collect events
      // -----------------------------------------------------------------------
      // 'message'
      final messages = <MessageEvent>[];
      eventSource.onMessage.listen((event) {
        messages.add(event);
      });

      // 'event_type_0'
      final eventType0Messages = <MessageEvent>[];
      eventSource.addEventListener(eventType0, (event) {
        eventType0Messages.add(event as MessageEvent);
      });

      // 'event_type_1'
      final eventType1Messages = <MessageEvent>[];
      eventSource.addEventListener(eventType1, (event) {
        eventType1Messages.add(event as MessageEvent);
      });

      // -----------------------------------------------------------------------
      // Wait 50 milliseconds
      // -----------------------------------------------------------------------
      await Future.delayed(const Duration(milliseconds: 50));

      // -----------------------------------------------------------------------
      // Check state
      // -----------------------------------------------------------------------
      expect(messages, hasLength(0));

      expect(eventType0Messages, hasLength(1));
      expect(eventType0Messages[0].type, eventType0);
      expect(eventType0Messages[0].data, 'data_0');

      expect(eventType1Messages, hasLength(1));
      expect(eventType1Messages[0].type, eventType1);
      expect(eventType1Messages[0].data, 'data_1');
    });

    test('type, no data', () async {
      final eventSource = EventSource('$baseUrl/type_no_data');
      addTearDown(() {
        eventSource.close();
      });

      // Collect messages
      final messages = <MessageEvent>[];
      eventSource.onMessage.listen((event) {
        messages.add(event);
      });

      // Wait for 100 ms
      //
      await Future.delayed(const Duration(milliseconds: 50));

      // -----------------------------------------------------------------------
      // Wait 50 milliseconds
      // -----------------------------------------------------------------------
      expect(messages, hasLength(0));
    });

    test('id, no data', () async {
      final eventSource = EventSource('$baseUrl/id_no_data');
      addTearDown(() {
        eventSource.close();
      });

      // Collect messages
      final messages = <MessageEvent>[];
      eventSource.onMessage.listen((event) {
        messages.add(event);
      });

      // Wait for 100 ms
      //
      await Future.delayed(const Duration(milliseconds: 50));

      // -----------------------------------------------------------------------
      // Wait 50 milliseconds
      // -----------------------------------------------------------------------
      expect(messages, hasLength(0));
    });

    test('fails when response header "Content-Type" is wrong', () async {
      final eventSource = EventSource('$baseUrl/wrong_content_type');
      addTearDown(() {
        eventSource.close();
      });

      // Collect events
      final errors = <Event>[];
      final messages = <MessageEvent>[];
      eventSource.onError.listen((event) {
        errors.add(event);
      });
      eventSource.onMessage.listen((event) {
        messages.add(event);
      });

      // -----------------------------------------------------------------------
      // Wait 50 milliseconds
      // -----------------------------------------------------------------------
      await Future.delayed(const Duration(milliseconds: 50));

      // Check
      expect(errors, hasLength(1));
      expect(messages, hasLength(0));
    });

    group('parsing: ', () {
      test('empty', () async {
        final input = makeStream('');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, []);
      });

      test('comment', () async {
        final input = makeStream(':comment');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, []);
      });

      test('comment, newline', () async {
        final input = makeStream(':comment\n');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, []);
      });

      test('comment, newline, newline', () async {
        final input = makeStream(':comment\ndata:\n\n');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, hasLength(1));
        expect(output.single.type, 'message');
        expect(output.single.lastEventId, '');
        expect(output.single.data, '');
      });

      test(r'""', () async {
        final input = makeStream('data: \n\n');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, hasLength(1));
        expect(output.single.type, 'message');
        expect(output.single.lastEventId, '');
        expect(output.single.data, '');
      });

      test('"a"', () async {
        final input = makeStream('data: a\n\n');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, hasLength(1));
        expect(output.single.type, 'message');
        expect(output.single.lastEventId, '');
        expect(output.single.data, 'a');
      });

      test('"a\\nb"', () async {
        final input = makeStream('data:a\ndata: b\n\n');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, hasLength(1));
        expect(output.single.type, 'message');
        expect(output.single.lastEventId, '');
        expect(output.single.data, 'a\nb');
      });

      test('type', () async {
        final input = makeStream('''
event:x0

event: x1
data: some data

event: x2

''');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();

        expect(output[0].type, 'x1');
        expect(output[0].lastEventId, '');
        expect(output[0].data, 'some data');

        expect(output[1].type, 'x2');
        expect(output[1].lastEventId, '');
        expect(output[1].data, '');

        expect(output, hasLength(2));
      });

      test('id', () async {
        final input = makeStream('''
id: ignored because this one has no data

id:x1
data: some data

id: x2

''');
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();

        expect(output[0].type, 'message');
        expect(output[0].lastEventId, 'x1');
        expect(output[0].data, 'some data');

        expect(output[1].type, 'message');
        expect(output[1].lastEventId, 'x2');
        expect(output[1].data, '');

        expect(output, hasLength(2));
      });

      test('retry', () async {
        final input = makeStream('''
retry:1
retry: 2
''');
        final retryValues = <Duration>[];
        final decoder = EventStreamDecoder(onReceivedTimeout: (value) {
          retryValues.add(value);
        });
        await decoder.bind(input).toList();
        expect(retryValues, [
          Duration(milliseconds: 1),
          Duration(milliseconds: 2),
        ]);
      });
    });
  });
}
