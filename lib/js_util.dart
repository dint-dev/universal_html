/// A version of 'dart:js_util' that works in all platforms.
///
/// Utility methods to efficiently manipulate typed JSInterop objects in cases
/// where the name to call is not known at runtime. You should only use these
/// methods when the same effect cannot be achieved with @JS annotations.
/// These methods would be extension methods on JSObject if Dart supported
/// extension methods.
///
/// ## Implementation in universal_html
///
/// We use the following conditional export:
/// ```dart
/// export 'src/js_util.dart' if (dart.library.js_util) 'dart:js_util';
/// ```
///
/// The above means that, when you use a Dart-to-Javascript compiler,
/// "package:universal_html/js_util.dart" will actually export 'dart:js_util'.
library universal_html.js_util;

export 'src/js_util.dart' if (dart.library.js_util) 'dart:js_util';
