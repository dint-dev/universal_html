[![Pub Package](https://img.shields.io/pub/v/universal_html.svg)](https://pub.dartlang.org/packages/universal_html)
# Introduction
This package implements _dart:html_ in all platforms (Flutter, VM, Node.JS, browser, etc.).

In browser, _'package:universal_html'_ exports _'dart:html'_. In other words, using the package has
almost no downsides. Your _dart2js_ build sizes won't grow.
 
The project is licensed under the [MIT license](LICENSE).

## Issues?
  * Please report issues at the [Github issue tracker](https://github.com/terrier989/dart-universal_html/issues).
  * Have a fix? Just create a pull request in Github.
    * Frequent contributors will be invited to become project administrators.

### Similar projects
  * [universal_io](https://pub.dev/packages/universal_io) (cross-platform implementation of
    _dart:io_)
  * [jsdom](https://www.npmjs.com/package/jsdom) (DOM implementation in Javascript).

# Getting started
In `pubspec.yaml`:
```yaml
name: example
dependencies:
  universal_html: ^1.0.4
```

Now you can replace usage of "dart:html" with "package:universal_html/html.dart".

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

# Controlling "browser instance"
  * Library _"package:universal_html/driver.dart"_ lets you control the "browser instance".
  * You can manipulate global variables like _document_, _navigator_ and _window_:
    * Want to have zone-local values? Use _HtmlIsolate.zoneLocal_.
    * Want to reset the values to defaults (after a test)? Use _HtmlIsolate.current.setDocument(null)_.

## Example
```dart
import 'package:universal_html/driver.dart';
import 'package:universal_html/html.dart';

main() async {
  // Construct a driver
  final driver = new HtmlDriver(userAgent:"My scraper");
  
  // Load a document.
  // Content type will be determined using HTTP headers or content sniffing.
  await driver.setDocumentFromUri(Uri.parse("https://example.com/"));
  
  // Set as default instance
  HtmlDriver.zoneLocal.freezeDefault(driver);
  
  // Print some node
  print(querySelector(".results:first").text);
}
```

# Implemented APIs
## Principles
  * Our goal is that the implemented APIs behave identically to _dart:html_ code running in Chrome.
  * Non-implemented APIs either throw `UnimplementedError` or fail silently.
  * We accept pull requests for more API implementations!

## Incomplete list of implemented APIs
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