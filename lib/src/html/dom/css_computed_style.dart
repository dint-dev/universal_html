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

class _ComputedStyle extends CssStyleDeclaration {
  final Element _element;
  final String? _pseudoElement;

  CssStyleDeclaration? _style;

  _ComputedStyle._(this._element, this._pseudoElement) : super._();

  @override
  int get length => compute().length;

  @override
  CssRule get parentRule {
    throw UnimplementedError();
  }

  CssStyleDeclaration compute() {
    final cachedStyle = _style;
    if (cachedStyle != null) {
      return cachedStyle;
    }

    final sheets = <StyleSheet>[];
    _findStyleSheets(_element, sheets);

    final prioritizedRules = <_PriotizedCssStyleRule>[];

    for (final sheet in sheets) {
      // For each stylesheet
      if (sheet is CssStyleSheet) {
        // For each CSS rule
        for (var rule in sheet.cssRules) {
          if (rule is CssStyleRule) {
            // Find highest priority selector of this rule
            var highestPriority = 0;

            // For each selector
            for (var parsedSelector in rule._parsedSelectors) {
              final selector = parsedSelector.selector;
              if (_matchesSelector(
                  _element,
                  selector,
                  selector.simpleSelectorSequences.length - 1,
                  _pseudoElement)) {
                // Selector matches.
                // Is the priority the highest so far?
                final priority = parsedSelector.priority;
                if (priority > highestPriority) {
                  highestPriority = priority;
                }
              }
            }
            if (highestPriority > 0) {
              prioritizedRules
                  .add(_PriotizedCssStyleRule(highestPriority, rule));
            }
          }
        }
      }
    }

    // Sort rules
    prioritizedRules
        .sort((left, right) => -left.priority.compareTo(right.priority));

    // Create style
    final result = _element._getOrCreateStyle()._clone();

    // Set style properties
    for (var prioritizedRule in prioritizedRules) {
      final style = prioritizedRule.rule.style;
      final length = style.length;
      for (var i = 0; i < length; i++) {
        final name = style.item(i);
        result.setProperty(name, style.getPropertyValue(name));
      }
    }
    _style = result;
    return result;
  }

  @override
  String getPropertyPriority(String property) {
    throw UnimplementedError();
  }

  @override
  String getPropertyValue(String name) => compute().getPropertyValue(name);

  @override
  String item(int index) => compute().item(index);

  @override
  String removeProperty(String name) {
    throw UnsupportedError("Computed style can't be modified.");
  }

  @override
  void setProperty(String name, String? value, [String? priority]) {
    throw UnsupportedError("Computed style can't be modified.");
  }

  void _findStyleSheets(Node node, List<StyleSheet> result) {
    for (var child in node.childNodes) {
      if (child is StyleElement) {
        final sheet = child.sheet;
        if (sheet != null) {
          result.add(sheet);
        }
      }
    }
    final parent = node.parent;
    if (parent == null) {
      for (var styleSheet in (node.ownerDocument as HtmlDocument).styleSheets ??
          const <StyleSheet>[]) {
        if (!result.contains(styleSheet)) {
          result.add(styleSheet);
        }
      }
      return;
    } else {
      _findStyleSheets(parent, result);
    }
  }
}

class _PriotizedCssStyleRule {
  final int priority;
  final CssStyleRule rule;

  _PriotizedCssStyleRule(this.priority, this.rule);
}
