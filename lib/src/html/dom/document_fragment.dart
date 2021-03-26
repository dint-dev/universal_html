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

class DocumentFragment extends Node
    with _ElementOrDocument, _DocumentOrFragment {
  factory DocumentFragment() {
    return DocumentFragment.internal(window.document);
  }

  factory DocumentFragment.html(
    String? input, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    input ??= 'null';
    return const DomParserDriver().parseDocumentFragmentFromHtml(
      ownerDocument: window.document,
      content: input,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
  }

  /// Internal constructor. __Not part of dart:html__.
  DocumentFragment.internal(Document ownerDocument) : super._(ownerDocument);

  factory DocumentFragment.svg(
    String input, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    return const DomParserDriver().parseDocumentFragmentFromSvg(
      ownerDocument: window.document,
      content: input,
      validator: validator,
      treeSanitizer: treeSanitizer,
    );
  }

  List<Element> get children {
    return _ElementChildren(this);
  }

  set children(List<Element> value) {
    // Copy list first since we don't want liveness during iteration.
    var copy = value.toList();
    var children = this.children;
    children.clear();
    children.addAll(copy);
  }

  String? get innerHtml {
    final e = DivElement();
    e.append(clone(true));
    return e.innerHtml;
  }

  set innerHtml(String? value) {
    setInnerHtml(value);
  }

  @override
  int get nodeType => Node.DOCUMENT_FRAGMENT_NODE;

  /// Parses the specified text as HTML and adds the resulting node after the
  /// last child of this document fragment.
  void appendHtml(
    String html, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    append(Element.html(
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    ));
  }

  /// Adds the specified text as a text node after the last child of this
  /// document fragment.
  void appendText(String text) {
    append(Text(text));
  }

  @visibleForTesting
  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool? deep) {
    final clone = DocumentFragment();
    if (deep != false) {
      Node._cloneChildrenFrom(
        ownerDocument,
        newParent: clone,
        oldParent: this,
      );
    }
    return clone;
  }

  void setInnerHtml(
    String? html, {
    NodeValidator? validator,
    NodeTreeSanitizer? treeSanitizer,
  }) {
    html ??= '';
    nodes.clear();
    append(Element.html(
      html,
      validator: validator,
      treeSanitizer: treeSanitizer,
    ));
  }
}

abstract class ShadowRoot extends DocumentFragment {
  static bool get supported => false;

  factory ShadowRoot._() {
    throw UnimplementedError();
  }

  Element? get activeElement;

  @deprecated
  bool get applyAuthorStyles {
    throw UnimplementedError();
  }

  @deprecated
  set applyAuthorStyles(bool value) {
    throw UnimplementedError();
  }

  bool? get delegatesFocus;

  // From DocumentOrShadowRoot

  Element? get fullscreenElement;

  Element? get host;

  String? get mode;

  ShadowRoot? get olderShadowRoot;

  Element? get pointerLockElement;

  @deprecated
  bool get resetStyleInheritance {
    throw UnimplementedError();
  }

  @deprecated
  set resetStyleInheritance(bool value) {
    throw UnimplementedError();
  }

  List<StyleSheet>? get styleSheets;

  Element elementFromPoint(int x, int y) {
    throw UnimplementedError();
  }

  List<Element> elementsFromPoint(int x, int y) {
    throw UnimplementedError();
  }

  Selection getSelection() {
    throw UnimplementedError();
  }
}
