import '../test/reflection_test.dart' as test;
import 'dart:io';

final dartHtmlApis = test.elementsForSdkHtml.toSet();
final universalHtmlApis = test.elementsForUniversalHtml.toSet();
final file = File('DIFFERENCES.md');

void main() {
  // Print debug information
  print('Generating "${file.path}"');

  // Tests already check that 'universal_html' doesn't export APIs that are not
  // exported by 'dart:html'.
  //
  // So we all have to do is find missing APIs.
  final missingAPIs = dartHtmlApis.where((e) {
    // Is the 'dart:html' element in 'universal_html'?
    if (universalHtmlApis.contains(e)) {
      // Not a difference
      return false;
    }

    // If it's a class member, include it only if the class is not in the set.
    final i = e.indexOf('.');
    if (i < 0) {
      // A top-level difference
      return true;
    }

    // A class-level difference
    final className = e.substring(0, i);
    return e == '$className (class)' ||
        universalHtmlApis.contains('$className (class)');
  }).toList()
    ..sort();

  // Generate a Markdown file
  final sb = StringBuffer();
  sb.writeln('${dartHtmlApis.length} APIs in "dart:html"');
  sb.writeln(
      '${universalHtmlApis.length} APIs in "package:universal_html/html.dart"');
  sb.writeln('');
  sb.writeln('# Missing APIs');
  for (var element in missingAPIs) {
    sb.writeln('  * $element');
  }

  // Save the file
  file.writeAsStringSync(sb.toString());
}
