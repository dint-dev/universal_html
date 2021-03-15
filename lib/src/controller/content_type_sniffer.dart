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

/// Suggests MIME type based on the content.
class ContentTypeSniffer {
  static final RegExp _htmlRegExp = RegExp(
    r'^(:?<!DOCTYPE html[ >]|<html[ >])',
    caseSensitive: false,
  );

  static final RegExp _xmlRegExp = RegExp(
    r'^<\??xml[ >]',
    caseSensitive: false,
  );

  const ContentTypeSniffer();

  /// Sniffs MIME type from content.
  String? sniffMime(String content) {
    // Trim whitespace and comments
    content = _trimLeftXmlLike(content);
    if (_htmlRegExp.hasMatch(content)) {
      return 'text/html';
    }
    if (_xmlRegExp.hasMatch(content)) {
      return 'text/xml';
    }
    return null;
  }

  /// Trims initial spaces, newlines, and HTML/XML comments.
  static String _trimLeftXmlLike(String content) {
    var i = 0;
    while (i < content.length) {
      final s = content.substring(i, i + 1);
      if (s == ' ' || s == '\n') {
        i++;
        continue;
      }
      if (s == '<') {
        // Does it start with '<!--'?
        const commentPrefix = '<!--';
        if (content.startsWith(commentPrefix, i)) {
          // Skip it
          i += commentPrefix.length;

          // Find '-->'
          const commentSuffix = '-->';
          final end = content.indexOf(commentSuffix, i);
          if (end < 0) {
            return '';
          }

          // Skip it
          i = end + commentSuffix.length;
          continue;
        }
      }

      // No more trimming
      break;
    }
    return content.substring(i);
  }
}
