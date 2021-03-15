/*
Source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

library metadata;

/// Metadata that specifies that that member is editable through generated
/// files.
class DocsEditable {
  const DocsEditable();
}

/// Annotation that specifies that a member is editable through generate files.
///
/// This is used for API generation.
///
/// [name] should be formatted as `interface.member`.
class DomName {
  final String name;
  const DomName(this.name);
}

/// An annotation used to mark an API as being experimental.
///
/// An API is considered to be experimental if it is still going through the
/// process of stabilizing and is subject to change or removal.
///
/// See also:
///
/// * [W3C recommendation](http://en.wikipedia.org/wiki/W3C_recommendation)
class Experimental {
  const Experimental();
}

/// A metadata annotation placed on native methods and fields of native classes
/// to specify the JavaScript name.
///
/// This example declares a Dart field + getter + setter called `$dom_title`
/// that corresponds to the JavaScript property `title`.
///
///     class Document native "*Foo" {
///       @JSName('title')
///       String $dom_title;
///     }
class JSName {
  final String name;
  const JSName(this.name);
}

/// Marks a class as native and defines its JavaScript name(s).
class Native {
  final String name;
  const Native(this.name);
}

/// An annotation used to mark a feature as only being supported by a subset
/// of the browsers that Dart supports by default.
///
/// If an API is not annotated with [SupportedBrowser] then it is assumed to
/// work on all browsers Dart supports.
class SupportedBrowser {
  static const String CHROME = 'Chrome';
  static const String FIREFOX = 'Firefox';
  static const String IE = 'Internet Explorer';
  static const String OPERA = 'Opera';
  static const String SAFARI = 'Safari';

  /// The name of the browser.
  final String browserName;

  /// The minimum version of the browser that supports the feature, or null
  /// if supported on all versions.
  final String? minimumVersion;

  const SupportedBrowser(this.browserName, [this.minimumVersion]);
}

/// Annotation that indicates that an API is not expected to change but has
/// not undergone enough testing to be considered stable.
class Unstable {
  const Unstable();
}
