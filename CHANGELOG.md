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