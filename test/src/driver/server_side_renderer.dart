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
