## 1.1.4
* Made it easier to implement file access APIs.

## 1.1.3
* Fixed problematic dependency constraints.
* Improved documentation and developer scripts.

## 1.1.2
* Fixed a test failure caused by Dart SDK 2.5.0-dev-2.0.
* Improved documentation.

## 1.1.1
* EventTarget now has a private getter `_htmlDriver`.
* _BrowserImplementation_ now receives events unless `event.preventDefault()` is called.
* Replaced _BrowserImplementation_ getter _browserClassFactory_ with getter _browserImplementation_. Deprecated the old method.
* Improved tests of various elements and fixed a few small bugs.
* Improved tests that compare 'dart:html' and 'package:universal_html'.
* Added various missing classes/class members.
* Improved documentation and formatting.
* Improved explanation that 'src/html/html_common/*.dart' were adopted from Dart SDK without much
  modifications.

## 1.1.0
* The sole copyright owner (except for code derived from the Dart SDK as noted in the relevant
  files) decided to publish the source code the Apache License 2.0. to make the project more
  enterprise-happy. Previous versions were published under the MIT License.
* Many new tests and bug fixes.
* Many new _dart:html_ APIs.
* Removed class factory APIs in _HtmlDriver_ in favor of separate _BrowserImplementation_ and
  _BrowserImplementationUtils_.
* Deprecated "package:universal_html/browser/(library).dart" in favor of more descriptive
  "package:universal_html/prefer_sdk/(library).dart". Deprecated APIs will be removed in future.
* Added "package:universal_html/prefer_universal/(library).dart".

## 1.0.13
* Fixed dependencies.

## 1.0.12
* A fix related to Dart SDK 2.5.

## 1.0.11
* Fixes compatibility with Dart SDK 2.5.
* EventSource support.

## 1.0.10
* Eliminated the following error that Dart build system threw in some cases:
  _Unsupported conditional import of dart:html found in universal_html|lib/html.dart_

## 1.0.9

* Fixed bugs related to XML handling.

## 1.0.8

* Fixed various bugs.

## 1.0.7

* Fixed various bugs.

## 1.0.6

* Fixed various bugs.
* Added _browser/html.dart_ and related documentation.
* Added _ServerSideRenderer_.

## 1.0.5

* Fixed a dependency.

## 1.0.4

* Fixed various bugs and added dart:html APIs.

## 1.0.3

* Fixed various bugs.

## 1.0.2

* Added dart:html APIs (HttpRequest, etc.) and new libraries (js.dart, js_util.dart, etc.).

## 1.0.1

* Fixed various bugs and added dart:html APIs.

## 0.0.1

* Initial release