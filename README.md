[![Pub Package](https://img.shields.io/pub/v/universal_html.svg)](https://pub.dartlang.org/packages/universal_html)
# Introduction
Cross-platform _dart:html_ that works in browser, Flutter, Dart VM, and Node.JS.
 
The project is licensed under the [MIT license](LICENSE).

## Issues?
  * Have a bug report or feature request? Go to [Github issue tracker](https://github.com/terrier989/dart-universal_html/issues).
  * Have a fix? Just [create a pull request](https://github.com/terrier989/dart-universal_html/issues).
  * API documentation can be found [here](https://pub.dev/documentation/universal_html/latest/).
  
### Similar projects
  * [universal_io](https://pub.dev/packages/universal_io) (cross-platform _dart:io_)
  * [jsdom](https://www.npmjs.com/package/jsdom) (DOM implementation in Javascript).

# Getting started
## 1. Add dependency
In `pubspec.yaml`:
```yaml
name: example
dependencies:
  universal_html: ^1.0.6
```

Now you can replace usage of "dart:html" with "package:universal_html/html.dart".

## 2. Choose library
### Recommended
```dart
import 'package:universal_html/html.dart';
```

This library exports our implementation by default. The library exports _dart:html_ only in
browsers.

Getting warnings? If you exchange DOM elements with packages that use _dart:html_, your IDE/compiler
may produce type warnings ("universal_html Element is not dart:html Element"). You can eliminate the
warnings by using the package below.

### Library that exports dart:html by default
```dart
import 'package:universal_html/browser/html.dart';
```
This library exports _dart:html_ by default. The library exports our implementation only when
_dart:io_ is available.

If you use this library:
  * Dart tools may mistakenly think that your package is not compatible with VM/Flutter.
  * Your package will not compile in Node.JS.

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
### Principles
  * Our goal is that the implemented APIs behave identically to _dart:html_ code running in Chrome.
  * Non-implemented APIs either throw `UnimplementedError` or fail silently.
  * We accept pull requests for more API implementations!

### An incomplete list
  * __Document nodes__
    * All the core classes (_Node_, _Element_, etc.)
    * Much of the element subclasses (_CheckboxInputElement_, _ResetButtonElement_, etc.)
    * Much of the CSS classes (_CssStyleDeclaration_, etc.)
  * __DOM parsing__
    * _DomParser_, _innerHtml/outerHtml_ setters
    * Uses [package:html](https://github.com/dartlang/html) and [package:csslib](https://github.com/dartlang/csslib)
  * __DOM printing__
    * _element.innerHtml_
    * _element.outerHtml_
  * __DOM events__
    * For example, _element.onClick.listen(...)_ would receive invocation of _element.click()_.
  * __CSS selectors__
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
  * __HttpRequest__
    * Does not implement same-origin security policies that browsers have.
  * __Related libraries__ (_dart:js_, _dart:svg_, etc.).
    * Just API declarations. Any attempt to use APIs will throw _UnimplementedException_.
    * Available in:
      * "package:universal_html/indexed_db.dart"
      * "package:universal_html/js.dart"
      * "package:universal_html/js_util.dart"
      * "package:universal_html/svg.dart"