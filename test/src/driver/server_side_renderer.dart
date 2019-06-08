part of driver_test;

class _RequestAndResponse {
  final HttpRequest request;
  final Future<HttpClientResponse> response;
  _RequestAndResponse(this.request, this.response);
}

void _testServerSideRenderer() {
  group("ServerSideRenderer", () {
    group("handleHttpRequest", () {
      // Set up HTTP server for all tests in this group
      HttpServer httpServer;
      StreamQueue<HttpRequest> httpRequestQueue;
      setUpAll(() async {
        httpServer = await HttpServer.bind("localhost", 0);
        httpRequestQueue = StreamQueue<HttpRequest>(httpServer);
      });
      tearDownAll(() {
        httpServer.close();
      });

      // Set up a real HTTP request that we can test
      Future<_RequestAndResponse> mockRequestAndResponse(String path) async {
        final httpClient = HttpClient();

        // Send HTTP request
        final httpClientRequest = await httpClient.get(
          httpServer.address.host,
          httpServer.port,
          "/",
        );
        final httpClientResponseFuture = httpClientRequest.close();

        // Wait for the HTTP request to arrive
        final httpRequest = await httpRequestQueue.next;

        // Force closing of the response
        addTearDown(() {
          httpRequest.response.close();
        });

        return _RequestAndResponse(httpRequest, httpClientResponseFuture);
      }

      ;

      test("Basic use", () async {
        final renderer = ServerSideRenderer(() {
          document.body.appendText("Hello world!");
        });

        // Render
        final mock = await mockRequestAndResponse("/");
        await renderer.handleHttpRequest(mock.request);

        // Get the HTTP response
        final httpClientResponse = await mock.response;

        // ------------------
        // Status and content
        // ------------------
        expect(httpClientResponse.statusCode, 200);
        final content = await utf8.decodeStream(httpClientResponse);
        expect(
          content,
          "<!doctype><html><head></head><body>Hello world!</body></html>",
        );

        // -------
        // Headers
        // -------
        expect(
          httpClientResponse.headers.value("Content-Type"),
          "text/html; charset=UTF-8",
        );

        expect(
          httpClientResponse.headers.value("X-Frame-Options"),
          "DENY",
        );

        expect(
          httpClientResponse.headers.value("X-Xss-Protection"),
          "1; mode=block",
        );

        expect(
          httpClientResponse.headers.value("Content-Security-Policy"),
          null, // By default, no CSP
        );
      });

      test("With CSP", () async {
        final renderer = ServerSideRenderer(() {}, csp: Csp.allowNone);

        // Render
        final mock = await mockRequestAndResponse("/");
        await renderer.handleHttpRequest(mock.request);

        // Get the HTTP response
        final httpClientResponse = await mock.response;

        // Is the header correct?
        expect(
          httpClientResponse.headers.value("Content-Security-Policy"),
          "default-src: 'none'",
        );
      });
    });
  });
}
