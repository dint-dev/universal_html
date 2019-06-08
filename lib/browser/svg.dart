/// Exports _dart:svg_. In VM and Flutter, exports our implementation.
library browser.svg;

export 'dart:svg' if (dart.library.io) '../svg.dart';
