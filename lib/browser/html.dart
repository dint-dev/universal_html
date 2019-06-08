/// Exports _dart:html_. In VM and Flutter, exports our implementation.
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
library browser.html;

export 'dart:html' if (dart.library.io) '../html.dart';
