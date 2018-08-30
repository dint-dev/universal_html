# Overview
This package is a pure Dart implemention of a subset of _dart:html_.

Typical use cases are:
  * Parsing/scraping HTML in the server/Flutter + browser.
  * Generating HTML in the server/Flutter + browser.

This package works in all platforms (VM, Flutter, and browser). We test that the APIs behave identically to _dart:html_ code running in Chrome. There are some failing tests.

Behind the scenes, parsing is done with [html](https://github.com/dartlang/html) and [csslib](https://github.com/dartlang/csslib).

## Available APIs
The following APIs are available:
  * DOM
    * Node classes (`Node`, `Element`, `CheckboxInputElement`, etc.)
    * Printing (`element.outerHtml`, etc.)
    * Parsing (`DomParser`)
    * Queries (`document.querySelector`, `node.matchesSelector`)
    * Event handlers
  * Some `window`, `navigator` and other APIs.

We declare other APIs of _dart:html_, but they either throw `UnimplementedError` or fail
silently when used in non-browser environment.

# Example: Hello world
In `pubspec.yaml`:
```yaml
name: hello
dependencies:
  universal_html: ^0.0.1
```

Run `pub get`.

In `bin/hello.dart`:
```dart
import "package:universal_html/html.dart";

void main() {
  // Create a DOM tree
  final element = new Element.tag("h1")..appendText("Hello world!");

  // Print outer HTML
  print(element.outerHtml);
}
```

Run the program with `pub run hello`.