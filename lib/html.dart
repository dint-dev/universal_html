/// Implements _dart:html_ in VM and Flutter. In browser, exports
/// _"dart:html"_.
///
/// # Introduction
///
/// HTML elements and other resources for web-based applications that need to
/// interact with the browser and the DOM (Document Object Model).
///
/// This library includes DOM element types, CSS styling, local storage,
/// media, speech, events, and more.
/// To get started,
/// check out the [Element] class, the base class for many of the HTML
/// DOM types.
///
/// For information on writing web apps with Dart, see https://webdev.dartlang.org.
library vm.html;

export 'src/html.dart' if (dart.library.html) 'src/_sdk/html.dart';
