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
