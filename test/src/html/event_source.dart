part of main_test;

void _testEventSource() {
  Stream<Uint8List> _input(String s) {
    return Stream<Uint8List>.fromIterable([utf8.encode(s)]);
  }

  group("EventSource: ", () {
    group("connection: ", () {
      test("checks content-type", () async {
        final httpServer = await io.HttpServer.bind(
          io.InternetAddress.anyIPv4,
          0,
        );
        addTearDown(() {
          httpServer.close();
        });
        httpServer.listen((request) {
          expect(request.headers.value("Accept"), "text/event-stream");

          final response = request.response;
          response.statusCode = 200;
          response.headers.contentType = io.ContentType("text", "plain");
          response.write("""
data: abc

""");
          response.close();
        });

        // Connect
        final eventSource = EventSource("http://localhost:${httpServer.port}/");

        // Collect events
        final errors = <Event>[];
        final messages = <MessageEvent>[];
        eventSource.onError.listen((error) {
          errors.add(error);
        });
        eventSource.onMessage.listen((event) {
          messages.add(event);
        });

        // Wait for 100 ms
        await Future.delayed(const Duration(milliseconds: 100));

        // Check
        expect(errors, hasLength(1));
        expect(messages, hasLength(0));
      });

      test("ok", () async {
        final httpServer = await io.HttpServer.bind(
          io.InternetAddress.anyIPv4,
          0,
        );
        addTearDown(() {
          httpServer.close();
        });
        httpServer.listen((request) {
          expect(request.headers.value("Accept"), "text/event-stream");

          final response = request.response;
          response.statusCode = 200;
          response.headers.contentType = io.ContentType("text", "event-stream");
          response.write("""
data: abc

""");
          response.close();
        });

        // Connect
        final eventSource = EventSource("http://localhost:${httpServer.port}/");

        // Collect events
        final errors = <Event>[];
        final messages = <MessageEvent>[];
        eventSource.onError.listen((error) {
          errors.add(error);
        });
        eventSource.onMessage.listen((event) {
          messages.add(event);
        });

        // Wait for 100 ms
        await Future.delayed(const Duration(milliseconds: 100));

        // Check
        if (errors.isNotEmpty) {
          fail(errors.first.toString());
        }
        expect(messages, hasLength(1));
        expect(messages[0].type, "message");
        expect(messages[0].data, "abc");
        expect(messages[0].lastEventId, null);
      });

      test("last-event-id", () async {
        final httpServer = await io.HttpServer.bind(
          io.InternetAddress.anyIPv4,
          0,
        );
        addTearDown(() {
          httpServer.close();
        });
        httpServer.listen((request) {
          final lastEventId = request.headers.value("Last-Event-ID");
          final id = int.parse(lastEventId ?? "-1") + 1;
          final response = request.response;
          response.statusCode = 200;
          response.headers.contentType = io.ContentType("text", "event-stream");
          response.write("retry:1\nid: $id\n\n");
          response.close();
        });

        // Connect
        final eventSource = EventSource("http://localhost:${httpServer.port}/");

        // Collect messages
        final messages = <MessageEvent>[];
        eventSource.onMessage.listen((event) {
          messages.add(event);
        });

        // Wait for 100 ms
        await Future.delayed(const Duration(milliseconds: 100));

        expect(eventSource.readyState, EventSource.OPEN);
        expect(messages[0].lastEventId, "0");
        expect(messages[1].lastEventId, "1");
        expect(messages[2].lastEventId, "2");
      });

      test("retry", () async {
        final httpServer =
            await io.HttpServer.bind(io.InternetAddress.anyIPv4, 0);
        addTearDown(() {
          httpServer.close();
        });
        var count = 0;
        httpServer.listen((request) {
          count++;
          final response = request.response;
          response.statusCode = 200;
          response.headers.contentType = io.ContentType("text", "event-stream");
          response.write("retry: 1\n");
          response.close();
        });

        final eventSource = EventSource("http://localhost:${httpServer.port}/");

        // Wait for 100 ms
        await Future.delayed(const Duration(milliseconds: 100));

        expect(eventSource.readyState, EventSource.OPEN);
        expect(count, greaterThan(2));

        eventSource.close();
        expect(eventSource.readyState, EventSource.CLOSED);
      });

      test("retry not specified", () async {
        final httpServer =
            await io.HttpServer.bind(io.InternetAddress.anyIPv4, 0);
        addTearDown(() {
          httpServer.close();
        });
        var count = 0;
        httpServer.listen((request) {
          count++;
          final response = request.response;
          response.statusCode = 200;
          response.headers.contentType = io.ContentType("text", "event-stream");
          response.write("");
          response.close();
        });

        final eventSource = EventSource("http://localhost:${httpServer.port}/");

        // Wait for 100 ms
        await Future.delayed(const Duration(milliseconds: 100));

        expect(eventSource.readyState, EventSource.OPEN);
        expect(count, 1);

        eventSource.close();
        expect(eventSource.readyState, EventSource.CLOSED);
      });
    }, testOn: "vm");

    group("parsing: ", () {
      test("empty", () async {
        final input = _input("");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, []);
      });

      test("comment", () async {
        final input = _input(":comment");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, []);
      });

      test("comment, newline", () async {
        final input = _input(":comment\n");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, []);
      });

      test("comment, newline, newline", () async {
        final input = _input(":comment\n\n");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, hasLength(1));
        expect(output.single.type, "message");
        expect(output.single.lastEventId, isNull);
        expect(output.single.data, "");
      });

      test(r"''", () async {
        final input = _input("data: \n\n");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, hasLength(1));
        expect(output.single.type, "message");
        expect(output.single.lastEventId, isNull);
        expect(output.single.data, "");
      });

      test(r"'a'", () async {
        final input = _input("data: a\n\n");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, hasLength(1));
        expect(output.single.type, "message");
        expect(output.single.lastEventId, isNull);
        expect(output.single.data, "a");
      });

      test(r"'a\nb'", () async {
        final input = _input("data:a\ndata: b\n\n");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();
        expect(output, hasLength(1));
        expect(output.single.type, "message");
        expect(output.single.lastEventId, isNull);
        expect(output.single.data, "a\nb");
      });

      test("type", () async {
        final input = _input("""
type:x0

type: x1
data: some data

type: x2

""");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();

        expect(output[0].type, "x0");
        expect(output[0].lastEventId, null);
        expect(output[0].data, "");

        expect(output[1].type, "x1");
        expect(output[1].lastEventId, null);
        expect(output[1].data, "some data");

        expect(output[2].type, "x2");
        expect(output[2].lastEventId, null);
        expect(output[2].data, "");

        expect(output, hasLength(3));
      });

      test("id", () async {
        final input = _input("""
id:x0

id: x1
data: some data

id: x2

""");
        final decoder = EventStreamDecoder();
        final output = await decoder.bind(input).toList();

        expect(output[0].type, "message");
        expect(output[0].lastEventId, "x0");
        expect(output[0].data, "");

        expect(output[1].type, "message");
        expect(output[1].lastEventId, "x1");
        expect(output[1].data, "some data");

        expect(output[2].type, "message");
        expect(output[2].lastEventId, "x2");
        expect(output[2].data, "");

        expect(output, hasLength(3));
      });

      test("retry", () async {
        final input = _input("""
retry:1
retry: 2
""");
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
