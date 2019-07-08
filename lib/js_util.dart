/// Implements _dart:js_util_ in VM and Flutter. In browser, exports
/// _"dart:js_util"_.
///
/// # Introduction
///
/// Utility methods to efficiently manipulate typed JSInterop objects in cases
/// where the name to call is not known at runtime. You should only use these
/// methods when the same effect cannot be achieved with @JS annotations.
/// These methods would be extension methods on JSObject if Dart supported
/// extension methods.
///
library vm.js_util;

export 'src/js_util.dart' if (dart.library.js_util) 'src/_sdk/js_util.dart';
