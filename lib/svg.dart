/// A version of 'dart:svg' that works in all platforms.
///
/// ## Implementation in universal_html
///
/// We use the following conditional export:
/// ```dart
/// export 'src/svg.dart' if (dart.library.svg) 'dart:svg';
/// ```
///
/// The above means that, when you use a Dart-to-Javascript compiler,
/// "package:universal_html/svg.dart" will actually export 'dart:svg'.
library universal_html.svg;

export 'src/svg.dart' if (dart.library.svg) 'dart:svg';
