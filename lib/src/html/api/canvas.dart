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
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

part of universal_html.internal;

abstract class CanvasGradient {
  CanvasGradient._();
  void addColorStop(num offset, String color);
}

abstract class CanvasImageSource {
  CanvasImageSource._();
}

abstract class CanvasPattern {
  CanvasPattern._();
}

abstract class CanvasRenderingContext {
  CanvasRenderingContext._();
  CanvasElement get canvas;
}

abstract class CanvasRenderingContext2D extends _CanvasRenderingContext2DBase {
  @override
  final CanvasElement canvas;

  CanvasRenderingContext2D._(this.canvas);
}

class ImageData {
  final Uint8ClampedList? data;

  final int height;
  final int width;

  factory ImageData(data_OR_sw, int sh_OR_sw, [int? sh]) {
    if (data_OR_sw is int) {
      final width = data_OR_sw;
      final height = sh_OR_sw;
      final data = Uint8ClampedList(4 * width * height);
      return ImageData._(data, width, height);
    } else if (data_OR_sw is List<int>) {
      final data = Uint8ClampedList.fromList(data_OR_sw);
      final width = sh_OR_sw;
      final height = sh ?? data.lengthInBytes ~/ (width * 4);
      return ImageData._(data, width, height);
    } else {
      throw ArgumentError.value(data_OR_sw);
    }
  }
  ImageData._(this.data, this.width, this.height);
}

abstract class OffscreenCanvas extends EventTarget {
  int height;
  int width;

  OffscreenCanvas(this.width, this.height) : super.internal();

  Future convertToBlob([Map options]);

  Object getContext(String contextType, [Map attributes]);

  ImageBitmap transferToImageBitmap();
}

abstract class OffscreenCanvasRenderingContext2D {
  String? direction;
  Object? fillStyle;
  String? filter;
  String? font;
  num? globalAlpha;
  String? globalCompositeOperation;
  bool? imageSmoothingEnabled;
  String? imageSmoothingQuality;
  String? lineCap;
  num? lineDashOffset;
  String? lineJoin;
  num? lineWidth;
  num? miterLimit;
  num? shadowBlur;
  String? shadowColor;
  num? shadowOffsetX;
  num? shadowOffsetY;
  Object? strokeStyle;
  String? textAlign;
  String? textBaseline;
  OffscreenCanvasRenderingContext2D._();

  void arc(num x, num y, num radius, num startAngle, num endAngle,
      [bool anticlockwise = false]);

  void arcTo(num x1, num y1, num x2, num y2, num radius);

  void beginPath();

  void bezierCurveTo(num cp1x, num cp1y, num cp2x, num cp2y, num x, num y);

  void clearRect(num x, num y, num width, num height);

  void clip([dynamic path_OR_winding, String winding]);

  void closePath();

  ImageData createImageData(dynamic data_OR_imagedata_OR_sw,
      [int sh_OR_sw,
      dynamic imageDataColorSettings_OR_sh,
      Map imageDataColorSettings]);

  CanvasGradient createLinearGradient(num x0, num y0, num x1, num y1);

  CanvasPattern createPattern(Object image, String repetitionType);

  CanvasGradient createRadialGradient(
      num x0, num y0, num r0, num x1, num y1, num r1);

  void drawImage(CanvasImageSource source, num destX, num destY);

  void ellipse(num x, num y, num radiusX, num radiusY, num rotation,
      num startAngle, num endAngle, bool anticlockwise);

  void fill([dynamic path_OR_winding, String winding]);

  void fillRect(num x, num y, num width, num height);

  void fillText(String text, num x, num y, [num maxWidth]);

  ImageData getImageData(int sx, int sy, int sw, int sh);

  List<num> getLineDash();

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

  void resetTransform();

  void restore();

  void rotate(num angle);

  void save();

  void scale(num x, num y);

  void setTransform(num a, num b, num c, num d, num e, num f);

  void stroke([Path2D path]);

  void strokeRect(num x, num y, num width, num height);

  void strokeText(String text, num x, num y, [num maxWidth]);

  void transform(num a, num b, num c, num d, num e, num f);

  void translate(num x, num y);
}

abstract class Path2D {
  Path2D([dynamic path_OR_text]);

  void addPath(Path2D path, [DomMatrix transform]);

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

abstract class TextMetrics {
  factory TextMetrics._() {
    throw UnimplementedError();
  }

  num? get actualBoundingBoxAscent;

  num? get actualBoundingBoxDescent;

  num? get actualBoundingBoxLeft;

  num? get actualBoundingBoxRight;

  num? get alphabeticBaseline;

  num? get emHeightAscent;

  num? get emHeightDescent;

  num? get fontBoundingBoxAscent;

  num? get fontBoundingBoxDescent;

  num? get hangingBaseline;

  num? get ideographicBaseline;

  num? get width;
}

abstract class _CanvasRenderingContext2DBase implements CanvasRenderingContext {
  String? direction;
  Object? fillStyle;
  String? filter;
  String? font;
  num? globalAlpha;
  String? globalCompositeOperation;
  bool? imageSmoothingEnabled;
  String? imageSmoothingQuality;
  String? lineCap;
  num? lineDashOffset;
  String? lineJoin;
  num? lineWidth;
  num? miterLimit;
  num? shadowBlur;
  String? shadowColor;
  num? shadowOffsetX;
  num? shadowOffsetY;
  Object? strokeStyle;
  String? textAlign;
  String? textBaseline;

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
