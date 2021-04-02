[![Pub Package](https://img.shields.io/pub/v/universal_html.svg)](https://pub.dartlang.org/packages/universal_html)
[![Github Actions CI](https://github.com/dint-dev/universal_html/workflows/Dart%20CI/badge.svg)](https://github.com/dint-dev/universal_html/actions?query=workflow%3A%22Dart+CI%22)

# Introduction
A cross-platform `dart:html`:
  * __Eases cross-platform development__
    * You can use this package in browsers, mobile, desktop, and server-side VM, and server-side
      Javascript (Node.JS, Cloud Functions, etc.).
    * Just replace `dart:html` imports with `package:universal_html/html.dart`. Normal
      _dart:html_ will continue to be used when application run in browsers.
  * __Extensive support for processing HTML and XML documents__
    * Parse, manipulate, and print [DOM nodes](https://pub.dev/documentation/universal_html/latest/universal_html/Node-class.html).
    * Find DOM nodes with [querySelectorAll](https://pub.dev/documentation/universal_html/latest/universal_html/querySelectorAll.html)
      and other CSS query methods.
    * Submit forms and more.
  * __EventSource streaming support__
    * Implements _dart:html_ [EventSource API](https://developer.mozilla.org/en-US/docs/Web/API/EventSource).

The project is licensed under the [Apache License 2.0](LICENSE). Some of the source code was adopted
from the original [dart:html](https://github.com/dart-lang/sdk/tree/master/tools/dom), which is
documented in the relevant files.

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
  universal_html: ^2.0.8
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

## Implemented APIs
### Summary
  * __Document node classes__
  * __DOM parsing__
    * Use _element.innerHtml_ setter, _DomParser_, or _package:universal_html/parsing.dart_.
    * HTML parsing uses [package:html](https://pub.dev/packages/html), CSS parsing uses
      [package:csslib](https://pub.dev/packages/csslib), and XML parsing uses our own parser.
  * __DOM printing__
    * Use _element.innerHtml_ or _element.outerHtml_.
  * __DOM events__
    * For example, _element.onClick.listen(...)_ receives invocation of _element.click()_.
  * __CSS classes__ (_CssStyleDeclaration_, etc.)
  * __Most CSS queries__

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
import 'package:universal_html/controller.dart';

Future main() async {
  // Load a document.
  final controller = WindowController();
  await controller.openHttp(
    uri: Uri.parse("https://news.ycombinator.com/"),
  );

  // Select the top story using a CSS query
  final topStoryTitle = controller.document.querySelectorAll(".athing > .title").first.text;

  // Print result
  print("Top Hacker News story is: $topStoryTitle");
}
```