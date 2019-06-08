/// Exports _dart:js_util_. In VM and Flutter, exports our implementation.
///
/// # Introduction
///
/// Utility methods to efficiently manipulate typed JSInterop objects in cases
/// where the name to call is not known at runtime. You should only use these
/// methods when the same effect cannot be achieved with @JS annotations.
/// These methods would be extension methods on JSObject if Dart supported
/// extension methods.
library browser.js_util;

export 'dart:js_util' if (dart.library.io) '../js_util.dart';
