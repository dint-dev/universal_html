library universal_svg;

import 'html.dart';

// Declared because this is needed by 'html.dart'.
abstract class Matrix {
  Matrix flipX();

  Matrix flipY();

  Matrix inverse();

  Matrix multiply(Matrix secondMatrix);

  Matrix rotate(num angle);

  Matrix rotateFromVector(num x, num y);

  Matrix scale(num scaleFactor);

  Matrix scaleNonUniform(num scaleFactorX, num scaleFactorY);

  Matrix skewX(num angle);

  Matrix skewY(num angle);

  Matrix translate(num x, num y);
}

class SvgElement extends Element {
  factory SvgElement.svg(String svg,
      {NodeValidator validator, NodeTreeSanitizer treeSanitizer}) {
    throw UnimplementedError();
  }

  factory SvgElement.tag(String tag) {
    return SvgElement.internalTagWithDocument(null, tag);
  }

  factory SvgElement.internalTagWithDocument(Document document, String tag) {
    switch (tag) {
      case "script":
        return ScriptElement();
      default:
        return SvgElement._(document, tag);
    }
  }

  SvgElement._(Document document, String tagName)
      // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
      : super.internal(document, tagName);

  // We need to reimplement this because superclass implementation depends
  // on implementing a private method.
  @override
  Element internalCloneWithOwnerDocument(Document document, bool deep) {
    // Create a new instance of the same class
    final clone = SvgElement.tag(tagName);

    // Clone attributes
    this.attributes.forEach((name, value) {
      clone.setAttribute(name, value);
    });

    // Clone children
    if (deep != false) {
      for (var childNode in this.childNodes) {
        // ignore: INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
        clone.append(childNode.internalCloneWithOwnerDocument(document, deep));
      }
    }

    return clone;
  }
}

// Declared because this is needed by 'html.dart'.
class ScriptElement extends SvgElement {
  ScriptElement() : super._(null, "script");
}
