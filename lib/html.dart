/// Implements 'dart:html' in all platforms.
library universal_html;

export 'src/html.dart' if (dart.library.html) 'dart:html';
