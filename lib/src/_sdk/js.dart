// -----------------------------------------------------------------------------
// PURPOSE OF THIS FILE
// -----------------------------------------------------------------------------
//
// When 'universal_html/X.dart' had a conditional export:
//   export 'src/X.dart' if (dart.library.X) 'dart:X'
//
// We observed 'package:build' throwing:
//   Invalid argument(s): Unsupported conditional import of `dart:X` found in
//   universal_html|lib/X.dart.
//
// See:
//   * Source code: https://github.com/dart-lang/build/blob/master/build_modules/lib/src/module_library.dart
//   * Commit code review: https://github.com/dart-lang/build/pull/1793
//
// This file solves the problem.
//
export 'dart:js';
