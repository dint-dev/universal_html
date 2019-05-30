import 'src/cloning.dart' as cloning;
import 'src/css.dart' as css;
import 'src/document.dart' as document;
import 'src/element.dart' as element;
import 'src/event.dart' as event;
import 'src/node.dart' as node;
import 'src/history.dart' as history;
import 'src/parsing_and_printing.dart' as parsing_and_printing;

void main() {
  node.main();
  element.main();
  parsing_and_printing.main();
  cloning.main();
  css.main();
  event.main();
  document.main();
  history.main();
}
