/// Sniffs MIME type of content.
class ContentTypeSniffer {
  static final RegExp _htmlRegExp = RegExp(
    r"^(:?<!DOCTYPE html[ >]|<html[ >])",
    caseSensitive: false,
  );

  static final RegExp _xmlRegExp = RegExp(
    r"^<\??xml[ >]",
    caseSensitive: false,
  );

  const ContentTypeSniffer();

  /// Sniffs MIME type from content.
  String sniffMime(String content) {
    // Trim whitespace and comments
    content = _trimLeftXmlLike(content);
    if (_htmlRegExp.hasMatch(content)) {
      return "text/html";
    }
    if (_xmlRegExp.hasMatch(content)) {
      return "text/xml";
    }
    return null;
  }

  /// Trims initial spaces, newlines, and HTML/XML comments.
  static String _trimLeftXmlLike(String content) {
    var i = 0;
    while (i < content.length) {
      final s = content.substring(i, i + 1);
      if (s == " " || s == "\n") {
        i++;
        continue;
      }
      if (s == "<") {
        // Does it start with "<!--"?
        const commentPrefix = "<!--";
        if (content.startsWith(commentPrefix, i)) {
          // Skip it
          i += commentPrefix.length;

          // Find '-->'
          const commentSuffix = "-->";
          final end = content.indexOf(commentSuffix, i);
          if (end < 0) {
            return "";
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
