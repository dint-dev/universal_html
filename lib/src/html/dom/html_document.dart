// Copyright 2019 terrier989@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
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
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
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

part of universal_html.internal;

class HtmlDocument extends Document
    with _DocumentOrShadowRoot
    implements DocumentOrShadowRoot {
  /// Static factory designed to expose `visibilityChange` events to event
  /// handlers that are not necessarily instances of [Window].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> visibilityChangeEvent =
      EventStreamProvider<Event>('visibilitychange');

  /// An internal constructor that's NOT part of "dart:html".
  ///
  /// This API is not for public use.
  /// We may do backwards-incompatible changes.
  ///
  /// If [filled] is true, returns document:
  ///
  /// ```html
  /// <doctype html>
  /// <html>
  /// <head></head>
  /// <body></body>
  /// </html>
  /// ```
  HtmlDocument.internal({
    required Window window,
    required String contentType,
    required bool filled,
    String? origin,
  }) : super._(
          window: window,
          contentType: contentType,
          origin: origin,
        ) {
    if (filled) {
      final docType = InternalDocumentType.internal(this, 'html');
      append(docType);
      final htmlElement = HtmlHtmlElement._(this);
      append(htmlElement);
      htmlElement.append(HeadElement._(this));
      htmlElement.append(BodyElement._(this));
    }
  }

  @override
  String? get baseUri {
    if (head != null) {
      for (var child in head?.children ?? const []) {
        if (child is BaseElement) {
          return child.href;
        }
      }
    }
    return super.baseUri;
  }

  BodyElement? get body {
    var element = _html?._firstElementChild;
    while (element != null) {
      if (element is BodyElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  set body(BodyElement? newValue) {
    final existing = head;
    if (existing == null) {
      if (newValue != null) {
        _html?.append(newValue);
      }
    } else {
      if (newValue == null) {
        existing.remove();
      } else {
        existing.replaceWith(newValue);
      }
    }
    assert(identical(body, newValue));
  }

  HeadElement? get head {
    var element = _html?._firstElementChild;
    while (element != null) {
      if (element is HeadElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  Stream<Event> get onVisibilityChange => visibilityChangeEvent.forTarget(this);

  String? get referrer => null;

  @override
  List<StyleSheet>? get styleSheets {
    final list = <StyleSheet>[];
    _forEachElementInTree((element) {
      if (element is StyleElement) {
        final sheet = element.sheet;
        if (sheet != null) {
          list.add(sheet);
        }
      }
    });
    return list;
  }

  String? get title {
    var head = this.head;
    if (head == null) {
      final documentElement = this.documentElement!;
      documentElement.append(HeadElement());
      head = this.head!;
    }
    for (var element in head.children) {
      if (element is TitleElement) {
        return element.text;
      }
    }
    return null;
  }

  set title(String? value) {
    var head = this.head;
    if (head == null) {
      final documentElement = this.documentElement!;
      documentElement.append(HeadElement());
      head = this.head!;
    }
    for (var element in head.children) {
      if (element is TitleElement) {
        element.text = value;
        return;
      }
    }
    head.append(TitleElement()..text = value);
  }

  HtmlHtmlElement? get _html {
    var element = _firstElementChild;
    while (element != null) {
      if (element is HtmlHtmlElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  @visibleForTesting
  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool? deep) {
    final clone = HtmlDocument.internal(
      window: window,
      contentType: contentType,
      filled: false,
    );
    if (deep != false) {
      Node._cloneChildrenFrom(
        clone,
        newParent: clone,
        oldParent: this,
      );
    }
    return clone;
  }
}
