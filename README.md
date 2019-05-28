[![Pub Package](https://img.shields.io/pub/v/universal_html.svg)](https://pub.dartlang.org/packages/universal_html)
# Introduction
This package implements _dart:html_ in all platforms (Flutter, VM, Node.JS, browser, etc.).

In browser, __Dart2js toolchain will use 'dart:html' directly__ (thanks to our use of conditional
imports). In other words, using _'package:universal_html'_ has zero cost (for build sizes, etc.).

Typical use cases include:
  * Cross-platform DOM scraping
  * Cross-platform DOM rendering

The project is licensed under the [MIT license](LICENSE).

## Issues?
  * Please report issues at the [Github issue tracker](https://github.com/gohilla/dart-universal_html/issues).
  * Have a fix? Just create a pull request in Github.
    * Frequent contributors will be invited to become project administrators.

# Getting started
In `pubspec.yaml`:
```yaml
name: example
dependencies:
  universal_html: ^1.0.0
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

# Controlling global variables and implementation details
  * Library _"package:universal_html/driver.dart"_ controls the HTML implementation.
  * You can manipulate global variables like _document_, _navigator_ and _window_:
    * Want to have zone-local values? Use _HtmlIsolate.zoneLocal_.
    * Want to reset the values to defaults (after a test)? Use _HtmlIsolate.current.resetState()_.

# Implemented APIs
In general:
  * The implemented APIs should behave identically to _dart:html_ code running in Chrome.
  * In non-browser environment, non-implemented APIs either throw `UnimplementedError` or fail silently.
  
We have implemented:
  * DOM classes
    * All the core classes (_Node_, _Element_, etc.)
    * Much of the element subclasses (_CheckboxInputElement_, _ResetButtonElement_, etc.)
    * Much of the CSS classes (_CssStyleDeclaration_, etc.)
  * DOM parsing
    * DomParser
    * Uses [package:html](https://github.com/dartlang/html) and [package:csslib](https://github.com/dartlang/csslib)
  * DOM printing
    * _element.innerHtml_
    * _element.outerHtml_
  * DOM queries
    * _element.querySelector(..)_, _element.querySelectorAll(..)_, _element.matchesSelector(..)_
    * Selectors support include:
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
  * DOM events
    * For example, _element.onClick.listen(...)_ would receive invocation of _element.click()_.
  * Navigator
    * _locale_, _userAgent_, etc.
  * Window
    * _console_
    * _history_
      * _back(...)_, _pushState(...)_, etc.
    * _location_
      * _origin_, _href_, etc.
    * _localStorage_ / _sessionStorage_
      * The implementation stores data in memory.

We accept pull requests for more API implementations!