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

part of main_test;

void _expectSaneDocument(Document document) {
  _expectSaneTree(document, expectedOwnerDocument: document);
}

/// Does sanity checks on the tree.
void _expectSaneTree(
  Node node, {
  Document? expectedOwnerDocument,
  Node? expectedParentNode,
}) {
  // 'ownerDocument'
  if (expectedOwnerDocument != null && node is! Document) {
    expect(node.ownerDocument, expectedOwnerDocument,
        reason: "Node '$node' has incorrect 'ownerDocument': $node");
  }

  // 'parentNode'
  if (expectedParentNode != null) {
    expect(node.parentNode, same(expectedParentNode),
        reason: "Node '$node' has incorrect 'parentNode': $node");
  }

  // 'previousNode.nextNode' or 'parentNode.firstChild'
  if (node.previousNode == null) {
    if (node.parent != null) {
      expect(
        node.parent!.firstChild,
        same(node),
        reason: "'node.parentNode.firstNode' should be same as 'node'",
      );
    }
  } else {
    expect(
      node.previousNode!.nextNode,
      same(node),
      reason: "'node.previousNode.nextNode' should be same as 'node'",
    );
  }

  // 'nextNode.previousNode' or 'parentNode.lastChild'
  if (node.nextNode == null) {
    if (node.parent != null) {
      expect(
        node.parent!.lastChild,
        same(node),
        reason: "'node.parentNode.lastNode' should be same as 'node'",
      );
    }
  } else {
    expect(
      node.nextNode!.previousNode,
      same(node),
      reason: "'node.nextNode.previousNode' should be same as 'node'",
    );
  }

  // Test that children are sane too.
  Node? previousChild;
  var nextChild = node.firstChild;
  while (nextChild != null) {
    _expectSaneTree(nextChild,
        expectedOwnerDocument: expectedOwnerDocument, expectedParentNode: node);
    previousChild = nextChild;
    nextChild = nextChild.nextNode;
  }
  expect(node.lastChild, same(previousChild));
}

void _temporarilyRemoveChildrenFromDocument({Node? root}) {
  // Save nodes
  root ??= universal_html.document;

  // Remove nodes
  final nodes = List<Node>.from(root.childNodes);
  for (var node in nodes) {
    node.remove();
  }

  final finalRoot = root;
  addTearDown(() {
    // Removes
    while (finalRoot.firstChild != null) {
      finalRoot.firstChild!.remove();
    }
    // Restore old nodes
    for (var node in nodes) {
      finalRoot.append(node);
    }
  });
}
