import 'package:test/test.dart';
import 'package:universal_html/html.dart';

void temporarilyRemoveChildrenFromDocument({Node root}) {
  // Save nodes
  root ??= document;

  // Remove nodes
  final nodes = new List<Node>.from(root.childNodes);
  for (var node in nodes) {
    node.remove();
  }

  addTearDown(() {
    // Removes
    while (root.firstChild != null) {
      root.firstChild.remove();
    }
    // Restore old nodes
    for (var node in nodes) {
      root.append(node);
    }
  });
}

void expectSaneDocument(Document document) {
  expectSaneTree(document, expectedOwnerDocument: document);
}

/// Does sanity checks on the tree.
void expectSaneTree(Node node,
    {Document expectedOwnerDocument, Node expectedParentNode}) {
  // 'ownerDocument'
  if (expectedOwnerDocument != null && node is! Document) {
    expect(node.ownerDocument, expectedOwnerDocument,
        reason: "Node '${node}' has incorrect 'ownerDocument': ${node}");
  }

  // 'parentNode'
  if (expectedParentNode != null) {
    expect(node.parentNode, same(expectedParentNode),
        reason: "Node '${node}' has incorrect 'parentNode': ${node}");
  }

  // 'previousNode.nextNode' or 'parentNode.firstChild'
  if (node.previousNode == null) {
    if (node.parent != null) {
      expect(node.parent.firstChild, same(node),
          reason: "'node.parentNode.firstNode' should be same as 'node'");
    }
  } else {
    expect(node.previousNode.nextNode, same(node),
        reason: "'node.previousNode.nextNode' should be same as 'node'");
  }

  // 'nextNode.previousNode' or 'parentNode.lastChild'
  if (node.nextNode == null) {
    if (node.parent != null) {
      expect(node.parent.lastChild, same(node),
          reason: "'node.parentNode.lastNode' should be same as 'node'");
    }
  } else {
    expect(node.nextNode.previousNode, same(node),
        reason: "'node.nextNode.previousNode' should be same as 'node'");
  }

  // Test that children are sane too.
  Node previousChild;
  Node nextChild = node.firstChild;
  while (nextChild != null) {
    expectSaneTree(nextChild,
        expectedOwnerDocument: expectedOwnerDocument, expectedParentNode: node);
    previousChild = nextChild;
    nextChild = nextChild.nextNode;
  }
  expect(node.lastChild, same(previousChild));
}
