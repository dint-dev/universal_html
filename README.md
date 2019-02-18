[![Pub Package](https://img.shields.io/pub/v/universal_html.svg)](https://pub.dartlang.org/packages/universal_html)
# Introduction
This package is a pure Dart implemention of a subset of _dart:html_.
The package works in all platforms (VM, Flutter, and browser).

The project is licensed under the [MIT license](LICENSE).

## Development
  * Star the project at [github.com/terrier989/dart-universal_html](https://github.com/terrier989/dart-universal_html).
  * Report issues at the [Github issue tracker](https://github.com/terrier989/dart-universal_html/issues).
  * Share contributions by creating a pull request.

## Use cases
  * Parsing/scraping HTML in the server/Flutter + browser.
  * Generating HTML in the server/Flutter + browser.

## Features
### DOM APIs
  * Node classes (`Node`, `Element`, `CheckboxInputElement`, etc.)
  * Printing (`element.outerHtml`, etc.)
  * Parsing (`DomParser`)
  * Queries (`document.querySelector`, `node.matchesSelector`)
  * Event handlers

### Other APIs
We have implemented various other APIs such as subsets of`window` and `navigator`.
Non-implemented APIs either throw `UnimplementedError` or fail silently when used in non-browser
environment.

### Correctness
We test that the APIs behave identically to _dart:html_ code running in Chrome.
There are some failing tests.

For parsing, we use:
  * [html](https://github.com/dartlang/html)
  * [csslib](https://github.com/dartlang/csslib)

# Getting started
In `pubspec.yaml`:
```yaml
name: example
dependencies:
  universal_html: ^0.1.0
```

Now you can replace usage of "dart:html" with "package:universal_html/html.dart":

```dart
import "package:universal_html/html.dart";

void main() {
  // Create a DOM tree
  final element = new Element.tag("h1")..appendText("Hello world!");

  // Print outer HTML
  print(element.outerHtml);
}
```
