import "package:universal_html/html.dart";

void main() {
  // Create a DOM tree
  final element = Element.tag("h1")..appendText("Hello world!");

  // Print outer HTML
  print(element.outerHtml);
}
