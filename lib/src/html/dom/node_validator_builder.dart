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

part of universal_html.internal;

/// Class which helps construct standard node validation policies.
///
/// By default this will not accept anything, but the 'allow*' functions can be
/// used to expand what types of elements or attributes are allowed.
///
/// All allow functions are additive- elements will be accepted if they are
/// accepted by any specific rule.
///
/// It is important to remember that sanitization is not just intended to prevent
/// cross-site scripting attacks, but also to prevent information from being
/// displayed in unexpected ways. For example something displaying basic
/// formatted text may not expect `<video>` tags to appear. In this case an
/// empty NodeValidatorBuilder with just [allowTextElements] might be
/// appropriate.
class NodeValidatorBuilder implements NodeValidator {
  final List<NodeValidator> _validators = <NodeValidator>[];

  NodeValidatorBuilder();

  /// Creates a new NodeValidatorBuilder which accepts common constructs.
  ///
  /// By default this will accept HTML5 elements and attributes with the default
  /// [UriPolicy] and templating elements.
  ///
  /// Notable syntax which is filtered:
  ///
  /// * Only known-good HTML5 elements and attributes are allowed.
  /// * All URLs must be same-origin, use [allowNavigation] and [allowImages] to
  /// specify additional URI policies.
  /// * Inline-styles are not allowed.
  /// * Custom element tags are disallowed, use [allowCustomElement].
  /// * Custom tags extensions are disallowed, use [allowTagExtension].
  /// * SVG Elements are not allowed, use [allowSvg].
  ///
  /// For scenarios where the HTML should only contain formatted text
  /// [allowTextElements] is more appropriate.
  ///
  /// Use [allowSvg] to allow SVG elements.
  NodeValidatorBuilder.common() {
    allowHtml5();
    allowTemplating();
  }

  /// Add an additional validator to the current list of validators.
  ///
  /// Elements and attributes will be accepted if they are accepted by any
  /// validators.
  void add(NodeValidator validator) {
    _validators.add(validator);
  }

  /// Allow custom elements with the specified tag name and specified attributes.
  ///
  /// This will allow the elements as custom tags (such as <x-foo></x-foo>),
  /// but will not allow tag extensions. Use [allowTagExtension] to allow
  /// tag extensions.
  void allowCustomElement(
    String tagName, {
    UriPolicy? uriPolicy,
    Iterable<String>? attributes,
    Iterable<String>? uriAttributes,
  }) {
    var tagNameUpper = tagName.toUpperCase();
    var attrs = attributes
            ?.map<String>((name) => '$tagNameUpper::${name.toLowerCase()}') ??
        const [];
    var uriAttrs = uriAttributes
            ?.map<String>((name) => '$tagNameUpper::${name.toLowerCase()}') ??
        const [];
    uriPolicy ??= UriPolicy();

    add(
      _CustomElementNodeValidator(
        uriPolicy,
        [tagNameUpper],
        attrs,
        uriAttrs,
        false,
        true,
      ),
    );
  }

  void allowElement(
    String tagName, {
    UriPolicy? uriPolicy,
    Iterable<String>? attributes,
    Iterable<String>? uriAttributes,
  }) {
    allowCustomElement(tagName,
        uriPolicy: uriPolicy,
        attributes: attributes,
        uriAttributes: uriAttributes);
  }

  /// Allow common safe HTML5 elements and attributes.
  ///
  /// This list is based off of the Caja whitelists at:
  /// https://code.google.com/p/google-caja/wiki/CajaWhitelists.
  ///
  /// Common things which are not allowed are script elements, style attributes
  /// and any script handlers.
  void allowHtml5({UriPolicy? uriPolicy}) {
    add(_Html5NodeValidator(uriPolicy: uriPolicy));
  }

  /// Allows image elements.
  ///
  /// The UriPolicy can be used to restrict the locations the images may be
  /// loaded from. By default this will use the default [UriPolicy].
  void allowImages([UriPolicy? uriPolicy]) {
    uriPolicy ??= UriPolicy();
    add(_SimpleNodeValidator.allowImages(uriPolicy));
  }

  /// Allow inline styles on elements.
  ///
  /// If [tagName] is not specified then this allows inline styles on all
  /// elements. Otherwise tagName limits the styles to the specified elements.
  void allowInlineStyles({String? tagName}) {
    if (tagName == null) {
      tagName = '*';
    } else {
      tagName = tagName.toUpperCase();
    }
    add(_SimpleNodeValidator(null, allowedAttributes: ['$tagName::style']));
  }

  /// Allows navigation elements- Form and Anchor tags, along with common
  /// attributes.
  ///
  /// The UriPolicy can be used to restrict the locations the navigation elements
  /// are allowed to direct to. By default this will use the default [UriPolicy].
  void allowNavigation([UriPolicy? uriPolicy]) {
    uriPolicy ??= UriPolicy();
    add(_SimpleNodeValidator.allowNavigation(uriPolicy));
  }

  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    return _validators
        .any((v) => v.allowsAttribute(element, attributeName, value));
  }

  @override
  bool allowsElement(Element element) {
    return _validators.any((v) => v.allowsElement(element));
  }

  /// Allow SVG elements and attributes except for known bad ones.
  void allowSvg() {
    add(_SvgNodeValidator());
  }

  /// Allow custom tag extensions with the specified type name and specified
  /// attributes.
  ///
  /// This will allow tag extensions (such as <div is='x-foo'></div>),
  /// but will not allow custom tags. Use [allowCustomElement] to allow
  /// custom tags.
  void allowTagExtension(String tagName, String baseName,
      {UriPolicy? uriPolicy,
      Iterable<String>? attributes,
      Iterable<String>? uriAttributes}) {
    var baseNameUpper = baseName.toUpperCase();
    var tagNameUpper = tagName.toUpperCase();
    var attrs = attributes
            ?.map<String>((name) => '$baseNameUpper::${name.toLowerCase()}') ??
        const [];
    var uriAttrs = uriAttributes
            ?.map<String>((name) => '$baseNameUpper::${name.toLowerCase()}') ??
        const [];
    uriPolicy ??= UriPolicy();

    add(
      _CustomElementNodeValidator(
        uriPolicy,
        [tagNameUpper, baseNameUpper],
        attrs,
        uriAttrs,
        true,
        false,
      ),
    );
  }

  /// Allow templating elements (such as <template> and template-related
  /// attributes.
  ///
  /// This still requires other validators to allow regular attributes to be
  /// bound (such as [allowHtml5]).
  void allowTemplating() {
    add(_TemplatingNodeValidator());
  }

  /// Allow basic text elements.
  ///
  /// This allows a subset of HTML5 elements, specifically just these tags and
  /// no attributes.
  ///
  /// * B
  /// * BLOCKQUOTE
  /// * BR
  /// * EM
  /// * H1
  /// * H2
  /// * H3
  /// * H4
  /// * H5
  /// * H6
  /// * HR
  /// * I
  /// * LI
  /// * OL
  /// * P
  /// * SPAN
  /// * UL
  void allowTextElements() {
    add(_SimpleNodeValidator.allowTextElements());
  }
}

class _CustomElementNodeValidator extends _SimpleNodeValidator {
  final bool allowTypeExtension;
  final bool allowCustomTag;

  _CustomElementNodeValidator(
      UriPolicy uriPolicy,
      Iterable<String> allowedElements,
      Iterable<String> allowedAttributes,
      Iterable<String> allowedUriAttributes,
      bool allowTypeExtension,
      bool allowCustomTag)
      : allowTypeExtension = allowTypeExtension == true,
        allowCustomTag = allowCustomTag == true,
        super(uriPolicy,
            allowedElements: allowedElements,
            allowedAttributes: allowedAttributes,
            allowedUriAttributes: allowedUriAttributes);

  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    if (allowsElement(element)) {
      if (allowTypeExtension &&
          attributeName == 'is' &&
          allowedElements.contains(value.toUpperCase())) {
        return true;
      }
      return super.allowsAttribute(element, attributeName, value);
    }
    return false;
  }

  @override
  bool allowsElement(Element element) {
    if (allowTypeExtension) {
      var isAttr = element.attributes['is'];
      if (isAttr != null) {
        return allowedElements.contains(isAttr.toUpperCase()) &&
            allowedElements.contains(Element._safeTagName(element));
      }
    }
    return allowCustomTag &&
        allowedElements.contains(Element._safeTagName(element));
  }
}

class _SimpleNodeValidator implements NodeValidator {
  final Set<String> allowedElements = <String>{};
  final Set<String> allowedAttributes = <String>{};
  final Set<String> allowedUriAttributes = <String>{};
  final UriPolicy? uriPolicy;

  /// Elements must be uppercased tag names. For example `'IMG'`.
  /// Attributes must be uppercased tag name followed by :: followed by
  /// lowercase attribute name. For example `'IMG:src'`.
  _SimpleNodeValidator(this.uriPolicy,
      {Iterable<String>? allowedElements,
      Iterable<String>? allowedAttributes,
      Iterable<String>? allowedUriAttributes}) {
    this.allowedElements.addAll(allowedElements ?? const []);
    allowedAttributes = allowedAttributes ?? const [];
    allowedUriAttributes = allowedUriAttributes ?? const [];
    var legalAttributes = allowedAttributes
        .where((x) => !_Html5NodeValidator._uriAttributes.contains(x));
    var extraUriAttributes = allowedAttributes
        .where((x) => _Html5NodeValidator._uriAttributes.contains(x));
    this.allowedAttributes.addAll(legalAttributes);
    this.allowedUriAttributes.addAll(allowedUriAttributes);
    this.allowedUriAttributes.addAll(extraUriAttributes);
  }

  factory _SimpleNodeValidator.allowImages(UriPolicy uriPolicy) {
    return _SimpleNodeValidator(uriPolicy, allowedElements: const [
      'IMG'
    ], allowedAttributes: const [
      'IMG::align',
      'IMG::alt',
      'IMG::border',
      'IMG::height',
      'IMG::hspace',
      'IMG::ismap',
      'IMG::name',
      'IMG::usemap',
      'IMG::vspace',
      'IMG::width',
    ], allowedUriAttributes: const [
      'IMG::src',
    ]);
  }

  factory _SimpleNodeValidator.allowNavigation(UriPolicy uriPolicy) {
    return _SimpleNodeValidator(uriPolicy, allowedElements: const [
      'A',
      'FORM'
    ], allowedAttributes: const [
      'A::accesskey',
      'A::coords',
      'A::hreflang',
      'A::name',
      'A::shape',
      'A::tabindex',
      'A::target',
      'A::type',
      'FORM::accept',
      'FORM::autocomplete',
      'FORM::enctype',
      'FORM::method',
      'FORM::name',
      'FORM::novalidate',
      'FORM::target',
    ], allowedUriAttributes: const [
      'A::href',
      'FORM::action',
    ]);
  }

  factory _SimpleNodeValidator.allowTextElements() {
    return _SimpleNodeValidator(null, allowedElements: const [
      'B',
      'BLOCKQUOTE',
      'BR',
      'EM',
      'H1',
      'H2',
      'H3',
      'H4',
      'H5',
      'H6',
      'HR',
      'I',
      'LI',
      'OL',
      'P',
      'SPAN',
      'UL',
    ]);
  }

  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    var tagName = Element._safeTagName(element);
    if (allowedUriAttributes.contains('$tagName::$attributeName')) {
      return uriPolicy?.allowsUri(value) ?? true;
    } else if (allowedUriAttributes.contains('*::$attributeName')) {
      return uriPolicy?.allowsUri(value) ?? true;
    } else if (allowedAttributes.contains('$tagName::$attributeName')) {
      return true;
    } else if (allowedAttributes.contains('*::$attributeName')) {
      return true;
    } else if (allowedAttributes.contains('$tagName::*')) {
      return true;
    } else if (allowedAttributes.contains('*::*')) {
      return true;
    }
    return false;
  }

  @override
  bool allowsElement(Element element) {
    return allowedElements.contains(Element._safeTagName(element));
  }
}

class _SvgNodeValidator implements NodeValidator {
  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    if (attributeName == 'is' || attributeName.startsWith('on')) {
      return false;
    }
    return allowsElement(element);
  }

  @override
  bool allowsElement(Element element) {
    if (element is svg.ScriptElement) {
      return false;
    }
    // Firefox 37 has issues with creating foreign elements inside a
    // foreignobject tag as SvgElement. We don't want foreignobject contents
    // anyway, so just remove the whole tree outright. And we can't rely
    // on IE recognizing the SvgForeignObject type, so go by tagName. Bug 23144
    if (element is svg.SvgElement &&
        Element._safeTagName(element) == 'foreignObject') {
      return false;
    }
    if (element is svg.SvgElement) {
      return true;
    }
    return false;
  }
}

class _TemplatingNodeValidator extends _SimpleNodeValidator {
  static const _TEMPLATE_ATTRS = <String>[
    'bind',
    'if',
    'ref',
    'repeat',
    'syntax'
  ];

  final Set<String> _templateAttrs;

  _TemplatingNodeValidator()
      : _templateAttrs = Set<String>.from(_TEMPLATE_ATTRS),
        super(null,
            allowedElements: ['TEMPLATE'],
            allowedAttributes:
                _TEMPLATE_ATTRS.map((attr) => 'TEMPLATE::$attr'));

  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    if (super.allowsAttribute(element, attributeName, value)) {
      return true;
    }

    if (attributeName == 'template' && value == '') {
      return true;
    }

    if (element.attributes['template'] == '') {
      return _templateAttrs.contains(attributeName);
    }
    return false;
  }
}
