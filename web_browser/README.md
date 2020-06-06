[![Pub Package](https://img.shields.io/pub/v/web_browser.svg)](https://pub.dartlang.org/packages/web_browser)
[![Github Actions CI](https://github.com/dint-dev/web_browser/workflows/Dart%20CI/badge.svg)](https://github.com/dint-dev/web_browser/actions?query=workflow%3A%22Dart+CI%22)

# Overview
Web browser and HTML rendering widgets for Flutter application. Licensed under the
[Apache License 2.0](LICENSE).

In Android and iOS, this package uses [webview_flutter](https://pub.dev/packages/webview_flutter),
which is maintained by Google. However, _webview_flutter_ works only in Android and iOS. This
package works in browsers too by using `<iframe>` and other HTML elements. The iframe relies on a
_dart:ui_ API that is currently undocumented.

For easy cross-platform DOM manipulation, the package also exports `package:web_browser/html.dart`,
which is a cross-platform _dart:html_ taken from [universal_html](https://pub.dev/packages/universal_html),
a sibling project of this package.

The main widgets in this package are:
  * [WebBrowser](https://pub.dev/documentation/universal_html/latest/web_browser/WebBrowser-class.html)
    * Shows any web page. By default, gives you address bar and navigation bar.
    * By default, gives you:
      * Address bar
      * "Share link" button
      * "Back" button
      * "Forward" button
  * [WebNode](https://pub.dev/documentation/universal_html/latest/web_browser/WebNode-class.html)
    * Shows any DOM node. DOM nodes work in Android and iOS too, thanks to
      [universal_html](https://pub.dev/packages/universal_html).

## Contributing
  * Pull request are welcome!
  * Please test your changes manually with the example application.

## Known issues
  * Flickering in browsers ([Flutter issue #51865](https://github.com/flutter/flutter/issues/51865))

## Links
  * [API reference](https://pub.dev/documentation/web_browser/latest/web_browser/web_browser-library.html)
  * [Github project](https://github.com/dint-dev/web_browser)
  * [Issue tracker](https://github.com/dint-dev/web_browser/issues)

# Setting up
## Adding dependency
In _pubspec.yaml_:
```yaml
dependencies:
  web_browser: ^0.2.0
```

## 2.Configure your project
Follow the standard [webview_flutter](https://pub.dev/packages/webview_flutter) instructions, which
means adding the following snippet in `ios/Runner/Info.plist`:
```xml
<key>io.flutter.embedded_views_preview</key>
<true />
```

## 3. Try it
```dart
import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

void main() {
  runApp(MaterialApp(
    body: Scaffold(
      body: SafeArea(
        child: WebBrowser(
          initialUrl: 'https://flutter.dev/',
          javascriptEnabled: true,
        ),
      ),
    ),
  ));
}
```