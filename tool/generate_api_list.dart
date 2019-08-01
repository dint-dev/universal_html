import '../test/reflection_test.dart' as test;
import 'dart:io';

final universalHtml = test.elementsForUniversalHtml.toSet();

void main() {
  _generateAPIs();
}

void _generateAPIs() {
  final file = File("API_LIST.md");
  print("Generating '${file.path}'");

  // Write documentation
  final sb = StringBuffer();
  sb.writeln("# Missing APIs");
  for (var element in universalHtml.toList()..sort()) {
    sb.writeln("  * $element");
  }
  file.writeAsStringSync(sb.toString());
}