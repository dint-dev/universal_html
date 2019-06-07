import 'package:meta/meta.dart';
import 'package:universal_html/src/html.dart';

class Resource {
  final Uri uri;
  final String cspType;
  final Element element;

  Resource(this.uri, {@required this.cspType, this.element});
}

class RsourceLoader {
  /// Finds loadable subresources in a DOM tree.
  Iterable<Resource> findResourcesInDocument(Node root) sync* {
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

  Resource _contentReferenceFromNode(Node node) {
    if (node is IFrameElement) {
      final uri = Uri.tryParse(node.src);
      if (uri == null) {
        return null;
      }
      return Resource(
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
      return Resource(
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
      return Resource(
        uri,
        cspType: "script-src",
        element: node,
      );
    }
    return null;
  }
}
