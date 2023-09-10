[![Pub Package](https://img.shields.io/pub/v/universal_html.svg)](https://pub.dartlang.org/packages/universal_html)
[![package publisher](https://img.shields.io/pub/publisher/universal_html.svg)](https://pub.dev/packages/universal_html/publisher)
[![Github Actions CI](https://github.com/dint-dev/universal_html/workflows/Dart%20CI/badge.svg)](https://github.com/dint-dev/universal_html/actions)

# Introduction
A cross-platform `dart:html`:
  * __Eases cross-platform development__
    * You can use this package in browsers, mobile, desktop, and server-side VM, and Node.JS.
    * Just replace `dart:html` imports with `package:universal_html/html.dart`. Normal
      _dart:html_ will continue to be used when application run in browsers.
  * __Extensive support for processing HTML and XML documents__
    * Parse, manipulate, and print [DOM nodes](https://api.dart.dev/stable/2.19.3/dart-html/Node-class.html).
    * Find DOM nodes with [querySelectorAll](https://api.dart.dev/stable/2.19.3/dart-html/querySelectorAll.html)
      and other CSS query methods.
  * __EventSource streaming support__
    * Cross-platform _dart:html_ `EventSource` ("application/event-stream").
    * If you want to customize EventSource HTTP headers outside browsers, see
      [EventSourceOutsideBrowser](https://pub.dev/documentation/universal_html/latest/universal_html/EventSourceOutsideBrowser-class.html).

The project is licensed under the [Apache License 2.0](LICENSE). Some of the source code was adopted
from the original [dart:html](https://github.com/dart-lang/sdk/tree/master/tools/dom) in Dart SDK,
which is documented in the relevant files.

## Documentation
  * [API reference](https://pub.dev/documentation/universal_html/latest/)
  * [Github project](https://github.com/dint-dev/universal_html)
    * We appreciate feedback, issue reports, and pull requests.

## Similar projects
  * [universal_io](https://pub.dev/packages/universal_io) (cross-platform _dart:io_)
  * [jsdom](https://www.npmjs.com/package/jsdom) (DOM implementation in Javascript)

# Getting started
## 1. Add dependency
In `pubspec.yaml`:
```yaml
dependencies:
  universal_html: ^2.2.4
```

## 2. Use
```dart
import "package:universal_html/html.dart";

void main() {
  // Create a DOM tree
  final div = DivElement();
  div.append(Element.tag("h1")
    ..classes.add("greeting")
    ..appendText("Hello world!"));

  // Print outer HTML
  print(div.outerHtml);
  // --> <div><h1>Hello world</h1></div>

  // Do a CSS query
  print(div.querySelector("div > .greeting").text);
  // --> Hello world
}
```

# Examples
## Parsing HTML
Use [parseHtmlDocument](https://pub.dev/documentation/universal_html/latest/universal_html.parsing/parseHtmlDocument.html):

```dart
import 'package:universal_html/parsing.dart';

void main() {
  final htmlDocument = parseHtmlDocument('<html>...</html>');
}
```

## Parsing XML
Use [parseXmlDocument](https://pub.dev/documentation/universal_html/latest/universal_html.parsing/parseXmlDocument.html):

```dart
import 'package:universal_html/parsing.dart';

void main() {
  final xmlDocument = parseXmlDocument('<xml>...</xml>');
}
```

## Scraping a website
Load a _Window_ with [WindowController](https://pub.dev/documentation/universal_html/latest/universal_html.controller/WindowController-class.html):

```dart
import 'dart:io' show Cookie;
import 'package:universal_html/controller.dart';

Future main() async {
  // Load a document.
  final controller = WindowController();
  controller.defaultHttpClient.userAgent = 'My Hacker News client';
  await controller.openHttp(
    method: 'GET',
    uri: Uri.parse("https://news.ycombinator.com/"),
    onRequest: (HttpClientRequest request) {
      // Add custom headers
      request.headers.set('Authorization', 'headerValue');
      request.cookies.add(Cookie('cookieName', 'cookieValue'));
    },
    onResponse: (HttpClientResponse response) {
      print('Status code: ${response.statusCode}');
    },
  );

  // Select the top story using a CSS query
  final titleElements = controller.document.querySelectorAll(".athing > .title");
  final topStoryTitle = titleElements.first.text;

  // Print result
  print("Top Hacker News story is: $topStoryTitle");
}
```

## EventSource
`EventSource` ([see mozilla.org](https://developer.mozilla.org/en-US/docs/Web/API/EventSource))
is a browser API for reading "application/event-stream" streams. It has been supported by browsers
for a long time.

```dart
import 'package:universal_html/html.dart';

Future<void> main() async {
  final eventSource = EventSource('http://example.com/events');
  await for (var message in event.onMessage) {
    print('Event type: ${message.type}');
    print('Event data: ${message.data}');
  }
}
```

EventSource requests from real browsers are typically authenticated using cookies.
If you want to add cookies or customize other HTTP headers, you need to use
[EventSourceOutsideBrowser](https://pub.dev/documentation/universal_html/latest/universal_html/EventSourceOutsideBrowser-class.html):
```dart
import 'package:universal_html/universal_html.dart';
import 'dart:io' show Cookie;

Future<void> main() async {
  final eventSource = EventSource('http://example.com/events');
  
  // The following block will NOT be executed in browsers.
  // Because compiler can infer instances of EventSourceOutsideBrowser are never constructed,
  // it will not appear in Javascript either.
  if (eventSource is EventSourceOutsideBrowser) {
    eventSource.onHttpClientRequest = (eventSource, request) {
      request.headers.set('Authorization', 'example');
      request.cookies.add(Cookie('name', 'value'));
    };
    eventSource.onHttpClientResponse = (eventSource, request, response) {
      // ...
    };
  }
  
  await for (var message in eventSource.onMessage) {
    print('Event:');
    print('  type: ${message.type}');
    print('  data: ${message.data}');
  }
}
```

## Testing
```dart
import 'package:universal_html/controller.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    WindowController.instance = WindowController();
  });
  
  test('test #1', () {
    // ...
  });
  
  test('test #2', () {
    // ...
  });
}
```