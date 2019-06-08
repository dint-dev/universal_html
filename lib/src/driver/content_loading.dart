import 'package:meta/meta.dart';
import 'package:universal_html/src/html.dart';

/// A resource (such as image) described by an element in a DOM tree.
class HtmlResource {
  final Uri uri;
  final String cspType;
  final Element element;

  HtmlResource(this.uri, {@required this.cspType, this.element});
}

/// Loads resources such as images.
class HtmlResourceLoader {
  Iterable<HtmlResource> findResourcesInDocument(Node root) sync* {
    var node = root;
    while (true) {
      final contentReference = _contentReferenceFromNode(node);
      if (contentReference != null) {
        yield (contentReference);
      }
      var firstChild = node.firstChild;
      if (firstChild != null) {
        node = firstChild;
        continue;
      }
      while (true) {
        var nextNode = node.nextNode;
        if (nextNode != null) {
          node = nextNode;
          break;
        }
        node = node.parent;
      }
    }
  }

  HtmlResource _contentReferenceFromNode(Node node) {
    if (node is IFrameElement) {
      final uri = Uri.tryParse(node.src);
      if (uri == null) {
        return null;
      }
      return HtmlResource(
        uri,
        cspType: "iframe-src",
        element: node,
      );
    }
    if (node is ImageElement) {
      final uri = Uri.tryParse(node.src);
      if (uri == null) {
        return null;
      }
      return HtmlResource(
        uri,
        cspType: "image-src",
        element: node,
      );
    }
    if (node is ScriptElement) {
      final uri = Uri.tryParse(node.src);
      if (uri == null) {
        return null;
      }
      return HtmlResource(
        uri,
        cspType: "script-src",
        element: node,
      );
    }
    return null;
  }
}
