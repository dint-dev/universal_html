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

import 'package:charcode/ascii.dart';
import 'package:universal_html/src/html.dart';

const _xmlEntities = <String, String>{
  'amp': '&',
  'apos': "'",
  'gt': '>',
  'lt': '<',
  'quot': '"',
};

XmlDocument parseXml(
  String input, {
  String mime = 'text/xml',
  String? origin,
}) {
  final document = XmlDocument.internal(
    window: window,
    contentType: mime,
    origin: origin,
  );
  final state = _XmlParserState._(input, document);
  state.parse();
  return document;
}

class _XmlParserState {
  static const _stateText = 0;
  static const _stateElementName = 1;
  static const _stateAttributes = 2;
  static const _stateAttributeName = 3;
  static const _stateAttributeValue = 4;
  static const _stateElementClosingName = 5;

  /// Original input.
  final String _input;

  /// Original document.
  final XmlDocument _document;

  /// Buffer for whatever we are scanning.
  final _sb = StringBuffer();

  /// Top-most element on the stack.
  Element? _parent;

  /// Current state.
  int _state = _stateText;

  /// Scanned attribute name.
  String? _attributeName;

  /// Whether the attribute value was missing quotes.
  var _attributeValueIsMissingQuotes = false;

  _XmlParserState._(this._input, this._document);

  XmlDocument parse() {
    final sb = _sb;
    loop:
    for (var i = 0; i < _input.length; i++) {
      final charCode = _input.codeUnitAt(i);
      switch (charCode) {
        case $amp:
          final end = _input.indexOf(';', i + 1);
          if (end < 0 && end - i > 64) {
            // ERROR: No ending / no ending within 64 codepoints
            sb.write('&');
            continue loop;
          }
          final entityName = _input.substring(i + 1, end);
          final value = _xmlEntities[entityName];
          if (value == null) {
            final parent = _parent!;
            parent.appendText('Entity \'$entityName\' not defined');
            i = end;
            continue loop;
          }
          sb.write(value);
          i = end;
          continue loop;

        case $less_than:
          if (_state == _stateText) {
            if (sb.isNotEmpty) {
              final value = sb.toString();
              sb.clear();
              _parent?.appendText(value);
            }

            const doctypePrefix = '<!DOCTYPE ';
            if (_input.startsWith(doctypePrefix, i)) {
              final end = _input.indexOf('>', i + doctypePrefix.length);
              if (end < 0) {
                break;
              }
              final value = _input.substring(i + doctypePrefix.length, end);
              i = end;
              _document.append(
                InternalDocumentType.internal(
                  _document,
                  value,
                ),
              );
              continue loop;
            }

            const commentPrefix = '<!--';
            if (_input.startsWith(commentPrefix, i)) {
              //
              // Comment
              //
              i += commentPrefix.length;

              const commentSuffix = '-->';
              final end = _input.indexOf(commentSuffix, i);
              if (end < 0) {
                // ERROR: No ending
                final value = _input.substring(i);
                final node = Comment.internal(
                  _document,
                  value,
                );
                final parent = _parent;
                if (parent == null) {
                  _document.append(node);
                } else {
                  parent.append(node);
                }
                break loop;
              }
              final value = _input.substring(i, end);
              i = end + commentSuffix.length - 1;
              final node = Comment.internal(
                _document,
                value,
              );
              final parent = _parent;
              if (parent == null) {
                _document.append(node);
              } else {
                parent.append(node);
              }
              continue loop;
            }

            const cdataPrefix = '<![CDATA[';
            if (_input.startsWith(cdataPrefix, i)) {
              //
              // CDATA
              //
              i += cdataPrefix.length;

              const cdataSuffix = ']]>';
              final end = _input.indexOf(cdataSuffix, i);
              if (end < 0) {
                // ERROR: No ending
                final value = _input.substring(i);
                final node = Text.internal(
                  _document,
                  value,
                );
                _parent?.append(node);
                break loop;
              }
              final value = _input.substring(i, end);
              i = end + cdataSuffix.length - 1;
              final node = Text.internal(
                _document,
                value,
              );
              _parent?.append(node);
              continue loop;
            }

            if (i + 1 < _input.length && _input.startsWith('/', i + 1)) {
              // </tag>
              _state = _stateElementClosingName;
              i++;
              continue loop;
            }

            //
            // ELEMENT START
            //
            _state = _stateElementName;
            continue loop;
          }
          break;

        case $greater_than:
          if (_state == _stateElementName) {
            // Examples:
            //   * `<tag` + `>`
            _endElementName();
            _state = _stateText;
            continue loop;
          }

          if (_state == _stateAttributes) {
            // Examples:
            //   * `<tag attributeName=""` + `>`
            //   * `<tag ` + `>`
            _state = _stateText;
            continue loop;
          }

          if (_state == _stateAttributeName) {
            // Examples:
            //   * `<tag attributeName` + `>`
            _endAttributeNameWithoutValue();
            _state = _stateText;
            continue loop;
          }

          if (_state == _stateAttributeValue) {
            // Examples:
            //   * `<tag` + `>`
            //   * `<tag attributeName=attributeValue` + `>`
            _endAttributeValue();
            _state = _stateText;
            continue loop;
          }

          if (_state == _stateElementClosingName) {
            // Examples:
            //   * `</tag>`
            final name = sb.toString();
            sb.clear();
            if (name != _parent?.tagName) {
              // ERROR
              throw StateError(
                'Expected ending tag for ${_parent?.tagName}, got ending tag for $name,',
              );
            }
            final parent = _parent!;
            _parent = parent.parent;
            _state = _stateText;
            continue loop;
          }

          //
          // Non-special character: >
          //
          break;

        case $slash:
          if (_input.startsWith('/>', i)) {
            if (_state == _stateElementName) {
              _endElementName();
              final parent = _parent!;
              _parent = parent.parent;
              i++;
              _state = _stateText;
              continue loop;
            }
            if (_state == _stateAttributes) {
              final parent = _parent!;
              _parent = parent.parent;
              i++;
              _state = _stateText;
              continue loop;
            }
            if (_state == _stateAttributeName) {
              _endAttributeNameWithoutValue();
              final parent = _parent!;
              _parent = parent.parent;
              i++;
              _state = _stateText;
              continue loop;
            }
            if (_state == _stateAttributeValue) {
              _endAttributeValue();
              final parent = _parent!;
              _parent = parent.parent;
              i++;
              _state = _stateText;
              continue loop;
            }
          }
          break;

        case $equal:
          if (_state == _stateAttributeName) {
            _attributeName = sb.toString();
            sb.clear();
            if (_input.startsWith('="', i)) {
              i++;
            } else {
              _attributeValueIsMissingQuotes = true;
            }
            _state = _stateAttributeValue;
            continue loop;
          }

          //
          // Non-special character: =
          //
          break;

        case $quot:
          if (_state == _stateAttributeValue) {
            _endAttributeValue();
            _state = _stateAttributes;
            continue loop;
          }
          //
          // Non-special character: "
          //
          break;

        case $question:
          final parent = _parent;
          if (_state == _stateAttributes &&
              _input.startsWith('?>', i) &&
              parent!.tagName.startsWith('?')) {
            _parent = parent.parent;
            _state = _stateText;
            continue loop;
          }
          if (_state == _stateAttributes) {
            sb.writeCharCode(charCode);
            _state = _stateAttributeName;
            continue loop;
          }
          //
          // Non-special character: ?
          //
          break;

        default:
          if (charCode <= 32) {
            //
            // WHITESPACE
            //
            if (_state == _stateElementName) {
              _endElementName();
              continue loop;
            }

            if (_state == _stateAttributeName) {
              _endAttributeNameWithoutValue();
              _state = _stateAttributes;
              continue loop;
            }

            if (_state == _stateAttributeValue &&
                _attributeValueIsMissingQuotes) {
              _attributeValueIsMissingQuotes = false;
              _endAttributeValue();
              _state = _stateAttributes;
              continue loop;
            }

            if (_state == _stateAttributes) {
              continue loop;
            }
          } else {
            if (_state == _stateAttributes) {
              sb.writeCharCode(charCode);
              _state = _stateAttributeName;
              continue loop;
            }
          }

          //
          // Non-special character
          //
          break;
      }
      sb.writeCharCode(charCode);
    }
    return _document;
  }

  void _endAttributeNameWithoutValue() {
    // Attribute value will be "".
    final name = _sb.toString();
    _sb.clear();
    _parent!.internalSetAttributeNSFromParser(
      namespaceUri: '',
      qualifiedName: name,
      localName: name,
      value: '',
    );
  }

  void _endAttributeValue() {
    // Attribute namespace, qualified name, local name, and value.
    var namespaceUri = '';
    var qualifiedName = _attributeName;
    var localName = qualifiedName!;
    final value = _sb.toString();

    // Mutate parsing state.
    _attributeName = null;
    _sb.clear();

    // Can we split it into "prefix:localName"?
    final i = localName.indexOf(':');
    if (i > 0) {
      // Yes, we can split
      localName = qualifiedName.substring(i + 1);
      final prefix = qualifiedName.substring(0, i);
      if (prefix == 'xmlns') {
        // "xmlns" is a special prefix for declaring namespaces
        namespaceUri = 'http://www.w3.org/2000/xmlns/';
      } else {
        // The prefix refers to a namespace declared by parent node.
        var parent = _parent;
        while (parent != null) {
          // See whether the element declares the prefix.
          final foundNamespaceUri = parent.getAttributeNS(
            'http://www.w3.org/2000/xmlns/',
            prefix,
          );
          if (foundNamespaceUri != null) {
            // Yes, this element defines it.
            namespaceUri = foundNamespaceUri;
            break;
          }

          // No, the element does not declare the prefix.
          parent = parent.parent;
        }
      }
    }

    // Set attribute in the element.
    _parent!.internalSetAttributeNSFromParser(
      namespaceUri: namespaceUri,
      qualifiedName: qualifiedName,
      localName: localName,
      value: value,
    );
  }

  void _endElementName() {
    //
    // END OF ELEMENT NAME
    //
    final name = _sb.toString();
    _sb.clear();
    if (name.isEmpty) {
      //
      // "<" was not followed by an element name
      //
      _sb.write('<');
      return;
    }
    final element = UnknownElement.internal(
      _document,
      null,
      name,
    );
    final parent = _parent;
    if (parent == null) {
      if (!name.startsWith('?')) {
        _document.append(element);
        _parent = element;
      }
    } else {
      parent.append(element);
    }
    _parent = element;
    _state = _stateAttributes;
  }
}
