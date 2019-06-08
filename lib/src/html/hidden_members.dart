part of universal_html;

// IMPORTANT: This is NOT exported by 'package:universal/html.dart'.
// The method declared here so it will have access to private members.
//
// The method is exported by 'package:universal/html_driver.dart'.
/// Produces string representation of DOM tree.
String nodeToString(Node node) {
  if (node == null) {
    return "";
  }
  final sb = StringBuffer();
  _printNode(sb, _getPrintingFlags(node), node);
  return sb.toString();
}

// IMPORTANT: This is NOT exported by 'package:universal/html.dart'.
// The method declared here so it will have access to private members.
//
// The method is exported by 'package:universal/html_driver.dart'.
/// Contains data for layout queries.
///
/// Elements request this object from [HtmlDriver],  which can use [setAttached]
/// and [getAttached] methods for caching.
class RenderData {
  Rectangle<int> client = Rectangle<int>(0, 0, 0, 0);
  Rectangle<int> offset = Rectangle<int>(0, 0, 0, 0);
  Rectangle<int> scroll = Rectangle<int>(0, 0, 0, 0);

  static void setAttached(Element element, RenderData data) {
    element._renderData = data;
  }

  static RenderData getAttached(Element element) {
    return element._renderData;
  }
}
