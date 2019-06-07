/// A version of 'dart:html' that works in all platforms.
///
/// We use the following conditional export:
/// ```dart
/// export 'src/html.dart' if (dart.library.html) 'dart:html';
/// ```
///
/// The above means that, when your compiler targets the browser,
/// "package:universal_html/html.dart" will actually export 'dart:html'.
library universal_html.html;

export 'src/html.dart' if (dart.library.html) 'dart:html'
    hide nodeToString, RenderData;
