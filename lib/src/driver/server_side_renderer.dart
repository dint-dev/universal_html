import 'package:universal_io/io.dart';
import 'dart:async';
import 'package:universal_html/driver.dart';
import 'package:universal_html/src/html.dart' hide HttpRequest;

class ServerSideRenderer {
  /// Main function of the web application.
  final FutureOr<void> Function() main;

  /// HTML file URI. Can be null.
  final String fileUri;

  /// Minimum delay before returning DOM.
  final Duration minDuration;

  /// Maximum delay before returning DOM.
  final Duration maxDuration;

  /// Maximum cache age.
  final Duration cacheAge;

  /// Content Security Policy (CSP) declaration.
  final Csp csp;

  final List<HttpServer> _servers = <HttpServer>[];

  /// Construct a new server-side renderer.
  ///
  /// Parameter [main] is the _main_ function of the web application.
  ///
  /// Parameter [fileUri] is location of the HTML file loaded into the browser
  /// simulator before [main] is called. If null, the browser simulator will be
  /// initialized with empty HTML document.
  ///
  /// If [minDuration] is non-null, the renderer always waits at least that
  /// amount of time. The default is 10 milliseconds.
  ///
  /// If [maxDuration] is non-null, the renderer stops after that amount of
  /// time. The default is 200 milliseconds.
  ///
  /// If [cacheAge] is non-null, it determines value for Cache-Control header.
  /// Default is 1 second.
  ///
  /// If [csp] is non-null, it will be used to write a "Content-Security-Policy"
  /// header. Otherwise no "Content-Security-Policy" header will be used.
  ServerSideRenderer(
    this.main, {
    this.fileUri,
    this.minDuration = const Duration(milliseconds: 10),
    this.maxDuration = const Duration(seconds: 1),
    this.cacheAge = const Duration(seconds: 1),
    this.csp,
  });

  /// A convenience method for creating a server with [HttpServer.bind]
  /// and handling received HTTP requests with [handleHttpRequest].
  ///
  /// Calling [close] will close the server.
  Future<void> bind(Object address, int port,
      {void onReady(HttpServer server)}) async {
    final server = await HttpServer.bind(address, port);
    onReady(server);
    _servers.add(server);
    await server.listen(handleHttpRequest).asFuture();
  }

  /// A convenience method for creating a server with [HttpServer.bindSecure]
  /// and handling received HTTP requests with [handleHttpRequest].
  ///
  /// Calling [close] will close the server.
  Future<void> bindSecure(
    Object address,
    int port,
    SecurityContext context, {
    void onReady(HttpServer server),
  }) async {
    final server = await HttpServer.bindSecure(address, port, context);
    onReady(server);
    _servers.add(server);
    await server.listen(handleHttpRequest).asFuture();
  }

  /// Closes all HTTP servers created with [bind] and [bindSecure].
  Future<void> close({bool force = false}) async {
    for (var server in _servers) {
      await server.close(force: force);
    }
  }

  /// Handles the HTTP request.
  Future<void> handleHttpRequest(HttpRequest httpRequest) async {
    // Prepare HTTP response with security-related headers
    final httpResponse = httpRequest.response;
    httpResponse.headers.set("Content-Type", "text/html; charset=UTF-8");
    httpResponse.headers.set("X-Frame-Options", "DENY");
    httpResponse.headers.set("X-Xss-Protection", "1; mode=block");
    if (csp != null) {
      httpResponse.headers.set("Content-Security-Policy", csp.toString());
    }

    // Is it GET?
    if (httpRequest.method != "GET") {
      // No, return an error code
      httpResponse.statusCode = HttpStatus.methodNotAllowed;
      httpResponse.write(
        "<html><body><h1>Unsupported HTTP method</h1></body></html>",
      );
      await httpResponse.close();
      return;
    }

    // Set "Cache-Control" header
    final cacheAge = this.cacheAge;
    if (cacheAge != null) {
      httpResponse.headers.set(
        "Cache-Control",
        "maxage=${cacheAge.inSeconds}, private, max-age=0",
      );
    }

    // Render
    final String content = await renderUri(httpRequest.uri);

    // Serve HTTP request
    httpResponse.write(content);
    await httpResponse.close();
  }

  Future<void> _runInForkedZone() async {
    // Run main function
    await main();

    // Dispatch load event
    document.dispatchEvent(Event("load"));

    // Wait a fixed delay
    if (minDuration != null) {
      await Future.delayed(minDuration);
    }
  }

  Future<String> renderUri(Uri uri) async {
    // Create a browser simulator
    final htmlDriver = HtmlDriver();

    // Set URL
    htmlDriver.setDocument(null, uri: uri);

    // Run main function.
    final forkedZone = HtmlDriver.zoneLocal.forkZoneWithValue(htmlDriver);
    await forkedZone
        .run(_runInForkedZone)
        .timeout(maxDuration, onTimeout: () => null)
        .catchError((error, stackTrace) {
      renderingFailed(htmlDriver, error, stackTrace);
    });

    // Produce HTML representation of the current DOM tree
    return BrowserImplementationUtils.nodeToString(htmlDriver.document);
  }

  /// Called when rendering throws an error.
  ///
  /// Default implementation prints error and stacktrace as the first child
  /// of HTML document _body_.
  void renderingFailed(
      HtmlDriver htmlDriver, Object error, StackTrace stackTrace) {
    // Print error message
    final element = DivElement();
    element.append(
      HeadingElement.h1()..appendText("Error!"),
    );
    element.append(
      HeadingElement.h3()..appendText("Message"),
    );
    element.append(
      ParagraphElement()..appendText(error.toString()),
    );
    element.append(
      HeadingElement.h3()..appendText("Stacktrace"),
    );
    element.append(
      ParagraphElement()..appendText(stackTrace.toString()),
    );
    final body = htmlDriver.document.body;
    body.insertBefore(element, body.firstChild);
  }
}
