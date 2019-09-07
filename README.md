[![Pub Package](https://img.shields.io/pub/v/universal_html.svg)](https://pub.dartlang.org/packages/universal_html)
[![Build Status](https://travis-ci.org/gohilla/universal_html.svg?branch=master)](https://travis-ci.org/gohilla/universal_html)

# Introduction
Cross-platform _dart:html_. Works in browser, server-side (Dart VM or Node.JS), and Flutter.
 
The project is licensed under the [Apache License 2.0](LICENSE).

## Contributing
  * This is an open-source project that welcomes new contributors. Don't be afraid to change things.
    Both small and big changes are welcome.
  * Bugs and enhancements are discussed in the [Github issue tracker](https://github.com/terrier989/universal_html/issues).
  * Have a contribution? [Create a pull request](https://github.com/terrier989/universal_html/pull/new/master).
    A contributor may be welcomed to become an administrator who can push changes without code
    review process.

### Credits
  * [terrier989](https://github.com/terrier989)
  * _Contributor? You can add your name._

## Similar projects
  * [universal_io](https://pub.dev/packages/universal_io) (cross-platform _dart:io_)
  * [jsdom](https://www.npmjs.com/package/jsdom) (DOM implementation in Javascript).

# Getting started
## 1. Add dependency
In `pubspec.yaml`:
```yaml
dependencies:
  universal_html: ^1.1.0
```

Now you can replace usage of "dart:html" with "package:universal_html/html.dart".

## 2. Choose library
### Option 1
```dart
import 'package:universal_html/prefer_sdk/html.dart';
```
This library exports _dart:html_ by default. The library exports our implementation only when
_dart:io_ is available.

If you use this library, your package will not compile in Node.JS. Dart tools may also mistakenly
think that your package is not compatible with VM/Flutter.

### Option 2
```dart
import 'package:universal_html/prefer_universal/html.dart';
```

This library exports our implementation by default. The library exports _dart:html_ only in
browsers.

Getting warnings? In some cases, when you mix _universal_io_ classes with _dart:html_ classes, your
IDE produces type warnings ("universal_html Element is not dart:html Element"). Your application
should still compile (in Dart2js, _universal_html_ classes will be _dart:html_ classes).

### Proposed future method
Dart SDK [feature request #37232](https://github.com/dart-lang/sdk/issues/37232) proposes that
developers could supply missing _dart:html_ in VM/Flutter in _pubspec.yaml_.

## 3. That's it!
```dart
import "package:universal_html/html.dart";

void main() {
  // Create a DOM tree
  final divElement = new DivElement();
  divElement.append(new Element.tag("h1")
    ..classes.add("greeting")
    ..appendText("Hello world!"));

  // Print outer HTML
  print(divElement.outerHtml);
  // --> <div><h1>Hello world</h1></div>

  // Do a CSS query
  print(divElement.querySelector("div > .greeting").text);
  // --> Hello world
}
```

# Manual
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

## Creating and using browser simulators
```dart
import 'package:universal_html/driver.dart';
import 'package:universal_html/html.dart';

Future main() async {
  // Construct a driver
  final driver = new HtmlDriver(userAgent:"My Hacker News bot");
  
  // Load a document.
  await driver.setDocumentFromUri(Uri.parse("https://news.ycombinator.com/"));
  
  // Select top story
  final topStoryTitle = driver.document.querySelectorAll(".athing > .title").first.text;
  print("Top Hacker News story is: ${topStoryTitle}");
}
```

## Implemented APIs
### Strategy
  * Our goal is that _universal_html_ behaves identically to _dart:html_ running in Chrome.
  * [DIFFERENCES.md](DIFFERENCES.md) contains automatically generated list of _dart:html_ APIs that
    are not yet declared by this package.
  * Some APIs are declared, but not implemented. These will either throw `UnimplementedError` or
    (when appropriate) fail silently.

### HTML
  * __Document nodes__
    * All core classes (_Node_, _Element_, etc.)
    * All _HtmlElement_ subclasses (_AnchorElement_, _ResetButtonElement_, etc.)
    * Most class members. For example, _anchorElement.href_ returns the resolved URI.
      Only a few class members are still missing (see [DIFFERENCES.md](DIFFERENCES.md)).
  * __DOM parsing__
    * You can parse HTML/XML with _innerHtml/outerHtml_ setters and _DomParser_
    * HTML parsing uses [package:html](https://pub.dev/packages/html)
    * CSS parsing uses [package:csslib](https://pub.dev/packages/csslib)
    * XML parsing uses [package:xml](https://pub.dev/packages/xml)
  * __DOM printing__
    * _element.innerHtml_, _element.outerHtml_
  * __DOM events__
    * For example, _element.onClick.listen(...)_ receives invocation of _element.click()_.

### CSS
  * Much of the CSS classes (_CssStyleDeclaration_, etc.)
  * __CSS queries__
    * Methods _element.querySelector(..)_, _element.querySelectorAll(..)_, _element.matchesSelector(..)_
    * Element name (`table`)
    * Element ID (`#id`)
    * Element class (`.classA.classB`)
    * Combinators:
      * `element.class#id`
      * `s0 s1 s2`
      * `s0 s1 s2`
      * `s0 > s1 > s2`
      * `s0 ~ s1 ~ s2`
      * `s0 + s1 + s2`
    * Pseudoselectors:
      * `:disabled`
      * `:first-child`
      * `:last-child`
      * `:not(x)`
      * `:nth-child(5)`
      * `:nth-child(even)`
      * `:nth-child(3n+1)`
      * `:only-child`
      * `:root`
    * Attribute selectors:
      * `[name]`
      * `[name=value]`
      * `[name~=value]`
      * `[name|=value]`
      * `[name^=value]`
      * `[name$=value]`
      * `[name*=value]`

### Layout
Currently, the library does not attempt to calculate layout for the elements.

Every DOM element has a private field _RenderData_, which you can get with
BrowserImplementationUtils.getRenderData(...)). When a property such as _element.offset_ is called,
the _RenderData_ instance is responsible for evaluating the answer. The default implementation
generally returns 0. If you want to implement layout engine, you can override
_BrowserImplementation.newRenderData(element)_.

### Networking
Currently, networking classes don't implement same-origin policies, CORS, and other security
specifications. We hope to fix this in future.

The package supports:
  * __HttpRequest__
    * Full support.
  * __EventSource__
    * Full support.

### Various browser APIs
  * __Navigator__
    * _locale_, _userAgent_, etc.
  * __Window__
    * _console_
    * _history_
      * _back(...)_, _pushState(...)_, etc.
    * _location_
      * _origin_, _href_, etc.
    * _localStorage_ / _sessionStorage_
      * Stores values in the heap.

### Other SDK libraries
We wrote mock implementation of the following SDK libraries:
  * dart:indexed_db
  * dart:js
  * dart:js_util
  * dart:svg
  * dart:web_gl

Any attempt to use these APIs will ead to _UnimplementedException_. The libraries are available in:
  * package:universal_html/(libraryName).dart
  * package:universal_html/prefer_sdk/(libraryName).dart
  * package:universal_html/prefer_universal/(libraryName).dart