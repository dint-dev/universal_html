# Overview
Web browser and HTML rendering widgets for Flutter application. Licensed under the
[Apache License 2.0](LICENSE).

# Getting started
## Adding dependency
In _pubspec.yaml_:
```yaml
dependencies:
  web_browser: any
```

## 2.Configure your project
In _ios/Runner/Info.plist_, add:
```dart:s
<key>io.flutter.embedded_views_preview</key>
<true />
```

## 3.Use widgets

### WebText
[WebText](https://pub.dev/documentation/universal_html/latest/web_browser/WebText-class.html) renders non-navigatable HTML in a borderless box.
  * In Android/iOS, it uses [webview_flutter](https://pub.dev/packages/webview_flutter), which is
    maintained by Google.
  * In browsers, the widget uses `<div>...</div>`.

```dart
import 'package:web_browser/web_browser';

const greeting = WebText('<h1 style="color:navy">Hello world!</h1>');
```

### WebNode
[WebNode](https://pub.dev/documentation/universal_html/latest/web_browser/WebNode-class.html) renders non-navigatable HTML in a borderless box.
  * In Android/iOS, it uses [webview_flutter](https://pub.dev/packages/webview_flutter), which is
    maintained by Google.
  * In browsers, the widget uses `<div>...</div>`.

```dart
import 'package:web_browser/html';
import 'package:web_browser/web_browser';

final element = HeadingElement.h1()..appendText('Hello world!');
final greeting = WebNode(element);
```

### WebBrowser
[WebBrowser](https://pub.dev/documentation/universal_html/latest/web_browser/WebBrowser-class.html) renders a navigatable web page.
  * In Android/iOS, it uses [webview_flutter](https://pub.dev/packages/webview_flutter), which is
    maintained by Google.
  * In browsers, it uses `iframe`.

```dart
import 'package:web_browser/web_browser';

const webBrowser = WebBrowser(
  initialUrl: 'https://dart.dev/',
  javascript: true,
);
```