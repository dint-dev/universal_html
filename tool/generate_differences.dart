import '../test/reflection_test.dart' as test;
import 'dart:io';

final html = test.elementsForSdkHtml.toSet();
final universalHtml = test.elementsForUniversalHtml.toSet();

void main() {
  _generateMissingAPIs();
}

void _generateMissingAPIs() {
  final file = File("DIFFERENCES.md");
  print("Generating '${file.path}'");

  // Find missing APIs
  final missingAPIs = html.where((e) {
    if (universalHtml.contains(e)) {
      return false;
    }
    // If it's a class member, include it only if the class is not in the set.
    final i = e.indexOf(".");
    if (i < 0) {
      return true;
    }
    final className = e.substring(0, i);
    return universalHtml.contains("$className (class)");
  }).toList()
    ..sort();

  // Write documentation
  final sb = StringBuffer();
  sb.writeln("# Missing APIs");
  for (var element in missingAPIs) {
    sb.writeln("  * $element");
  }
  file.writeAsStringSync(sb.toString());
}