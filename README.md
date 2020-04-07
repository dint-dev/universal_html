[![Pub Package](https://img.shields.io/pub/v/universal_html.svg)](https://pub.dartlang.org/packages/universal_html)
[![Github Actions CI](https://github.com/dint-dev/universal_html/workflows/Dart%20CI/badge.svg)](https://github.com/dint-dev/universal_html/actions?query=workflow%3A%22Dart+CI%22)

# Introduction
A cross-platform `dart:html`:
  * __Extensive support for handling HTML and XML documents__
    * Parse, manipulate, and print _dart:html_ [nodes](https://pub.dev/documentation/universal_html/latest/universal_html/Node-class.html).
    * Find nodes with [querySelectorAll](https://pub.dev/documentation/universal_html/latest/universal_html/querySelectorAll.html)
      and other CSS query methods.
  * __Eases cross-platform development__
    * Just replace `dart:html` imports with `package:universal_html/html.dart`.

The project is licensed under the [Apache License 2.0](LICENSE). Some of the source code was adopted
from the original [dart:html](https://github.com/dart-lang/sdk/tree/master/tools/dom), which is
documented in the relevant files.

## Links
  * [API reference](https://pub.dev/documentation/universal_html/latest/universal_html/universal_html-library.html)
  * [Github project](https://github.com/dint-dev/universal_html)
  * [Issue tracker](https://github.com/dint-dev/universal_html/issues)

## Similar projects
  * [universal_io](https://pub.dev/packages/universal_io) (cross-platform _dart:io_)
  * [jsdom](https://www.npmjs.com/package/jsdom) (DOM implementation in Javascript)

# Getting started
## 1. Add dependency
In `pubspec.yaml`:
```yaml
dependencies:
  universal_html: ^1.2.1
```

## 2. Choose library
### Option A (recommended)
```dart
import 'package:universal_html/html.dart';
```

This library exports _dart:html_ by default.
You can also use `import 'package:universal_html/prefer_sdk/html.dart';`.

If you use this library, Dart tools may mistakenly think that your package is not compatible with
VM/Flutter.

### Option B
```dart
import 'package:universal_html/prefer_universal/html.dart';
```

This library exports our implementation by default. The main advantage of this library is easier
debugging. If you click "Go to declaration" in your IDE, you will see the implementation.

Getting warnings? In some cases, when you mix _universal_io_ classes with _dart:html_ classes, your
IDE produces type warnings ("universal_html Element is not dart:html Element"). Your application
should still compile (in browser, _universal_html_ classes will be _dart:html_ classes).


## 3. Use
```dart
import "package:universal_html/html.dart";

void main() {
  // Create a DOM tree
  final div = new DivElement();
  div.append(new Element.tag("h1")
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
### List of differences
[DIFFERENCES.md](DIFFERENCES.md) contains a programmatically generated list of _dart:html_ APIs
missing from this package.

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
  * __window.history__
  * __Form submitting__
  * __EventSource__ ("application/event-stream" client)


# Additional helpers
## Parsing HTML / XML
We recommend that you use `package:universal_html/parsing.dart` (instead of _DomParser_):
```dart
import 'package:universal_html/parsing.dart';

void main() {
  // HTML
  final htmlDocument = parseHtmlDocument('<html>...</html>');

  // XML
  final xmlDocument = parseXmlDocument('<xml>...</xml>');
}
```

## Server-side rendering
The package comes with _ServerSideRenderer_, which is a web server for rendering your web
application in the server-side.

```dart
import 'package:universal_html/driver.dart';
import 'package:universal_html/html.dart';

void main() {
  final renderer = new ServerSideRenderer(webAppMain);
  renderer.bind("localhost", 12345);
}

void webAppMain() {
  document.body.appendText("Hello world!");
}
```

## Browser simulators
```dart
import 'package:universal_html/driver.dart';
import 'package:universal_html/html.dart';

Future main() async {
  // Construct a browser simulator.
  final driver = new HtmlDriver();

  // Open a web page.
  await driver.setDocumentFromUri(Uri.parse("https://news.ycombinator.com/"));

  // Select the top story using a CSS query
  final topStoryTitle = driver.document.querySelectorAll(".athing > .title").first.text;

  // Print result
  print("Top Hacker News story is: ${topStoryTitle}");
}
```