part of universal_html;

abstract class CanvasGradient {}

abstract class CanvasImageSource {}

abstract class CanvasPattern {}

abstract class CanvasRenderingContext {}

abstract class CanvasRenderingContext2D extends _CanvasRenderingContext2DBase {
  final CanvasElement canvas;

  @deprecated
  CanvasRenderingContext2D.constructor(this.canvas);

  factory CanvasRenderingContext2D._(CanvasElement element) =>
      HtmlDriver.current.newCanvasRenderingContext2D(element);
}

abstract class ImageData {}

abstract class OffscreenCanvas extends EventTarget {
  final int height;
  final int width;

  OffscreenCanvas(this.width, this.height);

  Future convertToBlob([Map options]);

  Object getContext(String contextType, [Map attributes]);

  ImageBitmap transferToImageBitmap();
}

abstract class OffscreenCanvasRenderingContext2D
    extends _CanvasRenderingContext2DBase {}

abstract class Path2D {
  Path2D([dynamic path_OR_text]);

  void addPath(Path2D path, [Matrix transform]);

  void arc(num x, num y, num radius, num startAngle, num endAngle,
      bool anticlockwise);

  void arcTo(num x1, num y1, num x2, num y2, num radius);

  void bezierCurveTo(num cp1x, num cp1y, num cp2x, num cp2y, num x, num y);

  void closePath();

  void ellipse(num x, num y, num radiusX, num radiusY, num rotation,
      num startAngle, num endAngle, bool anticlockwise);

  void lineTo(num x, num y);

  void moveTo(num x, num y);

  void quadraticCurveTo(num cpx, num cpy, num x, num y);

  void rect(num x, num y, num width, num height);
}

abstract class TextMetrics {}

abstract class _CanvasRenderingContext2DBase implements CanvasRenderingContext {
  Matrix currentTransform;
  String direction;
  Object fillStyle;
  String filter;
  String font;
  num globalAlpha;
  String globalCompositeOperation;
  bool imageSmoothingEnabled;
  String imageSmoothingQuality;
  String lineCap;
  num lineDashOffset;
  String lineJoin;
  num lineWidth;
  num miterLimit;
  num shadowBlur;
  String shadowColor;
  num shadowOffsetX;
  num shadowOffsetY;
  Object strokeStyle;
  String textAlign;
  String textBaseline;

  void addHitRegion([Map options]);

  void arc(num x, num y, num radius, num startAngle, num endAngle,
      [bool anticlockwise = false]);

  void arcTo(num x1, num y1, num x2, num y2, num radius);

  void beginPath();

  void bezierCurveTo(num cp1x, num cp1y, num cp2x, num cp2y, num x, num y);

  void clearHitRegions();

  void clearRect(num x, num y, num width, num height);

  void clip([dynamic path_OR_winding, String winding]);

  void closePath();

  ImageData createImageData(dynamic data_OR_imagedata_OR_sw,
      [int sh_OR_sw,
      dynamic imageDataColorSettings_OR_sh,
      Map imageDataColorSettings]);

  ImageData createImageDataFromImageData(ImageData imagedata);

  CanvasGradient createLinearGradient(num x0, num y0, num x1, num y1);

  CanvasPattern createPattern(Object image, String repetitionType);

  CanvasPattern createPatternFromImage(
      ImageElement image, String repetitionType);

  CanvasGradient createRadialGradient(
      num x0, num y0, num r0, num x1, num y1, num r1);

  void drawFocusIfNeeded(dynamic element_OR_path, [Element element]);

  void drawImage(CanvasImageSource source, num destX, num destY);

  void drawImageScaled(CanvasImageSource source, num destX, num destY,
      num destWidth, num destHeight);

  void drawImageScaledFromSource(
      CanvasImageSource source,
      num sourceX,
      num sourceY,
      num sourceWidth,
      num sourceHeight,
      num destX,
      num destY,
      num destWidth,
      num destHeight);

  void drawImageToRect(CanvasImageSource source, Rectangle<num> destRect,
      {Rectangle<num> sourceRect});

  void ellipse(num x, num y, num radiusX, num radiusY, num rotation,
      num startAngle, num endAngle, bool anticlockwise);

  void fill([dynamic path_OR_winding, String winding]);

  void fillRect(num x, num y, num width, num height);

  void fillText(String text, num x, num y, [num maxWidth]);

  Map getContextAttributes();

  ImageData getImageData(int sx, int sy, int sw, int sh);

  List<num> getLineDash();

  bool isContextLost();

  bool isPointInPath(dynamic path_OR_x, num x_OR_y,
      [dynamic winding_OR_y, String winding]);

  bool isPointInStroke(dynamic path_OR_x, num x_OR_y, [num y]);

  void lineTo(num x, num y);

  TextMetrics measureText(String text);

  void moveTo(num x, num y);

  void putImageData(ImageData imagedata, int dx, int dy,
      [int dirtyX, int dirtyY, int dirtyWidth, int dirtyHeight]);

  void quadraticCurveTo(num cpx, num cpy, num x, num y);

  void rect(num x, num y, num width, num height);

  void removeHitRegion(String id);

  void resetTransform();

  void restore();

  void rotate(num angle);

  void save();

  void scale(num x, num y);

  void setFillColorHsl(int h, num s, num l, [num a = 1]);

  void setFillColorRgb(int r, int g, int b, [num a = 1]);

  void setStrokeColorHsl(int h, num s, num l, [num a = 1]);

  void setStrokeColorRgb(int r, int g, int b, [num a = 1]);

  void setTransform(num a, num b, num c, num d, num e, num f);

  void stroke([Path2D path]);

  void strokeRect(num x, num y, num width, num height);

  void strokeText(String text, num x, num y, [num maxWidth]);

  void transform(num a, num b, num c, num d, num e, num f);

  void translate(num x, num y);
}
