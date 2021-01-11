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

abstract class DomMatrix extends DomMatrixReadOnly {
  @override
  int a = 0;
  @override
  int b = 0;
  @override
  int c = 0;
  @override
  int d = 0;
  @override
  int e = 0;
  @override
  int f = 0;
  @override
  int m11 = 0;
  @override
  int m12 = 0;
  @override
  int m13 = 0;
  @override
  int m14 = 0;
  @override
  int m21 = 0;
  @override
  int m22 = 0;
  @override
  int m23 = 0;
  @override
  int m24 = 0;
  @override
  int m31 = 0;
  @override
  int m32 = 0;
  @override
  int m33 = 0;
  @override
  int m34 = 0;
  @override
  int m41 = 0;
  @override
  int m42 = 0;
  @override
  int m43 = 0;
  @override
  int m44 = 0;

  static DomMatrix fromFloat32Array(Float32List list) {
    throw UnimplementedError();
  }

  static DomMatrix fromFloat64Array(Float64List list) {
    throw UnimplementedError();
  }
}

abstract class DomMatrixReadOnly {
  int get a;
  int get b;
  int get c;
  int get d;
  int get e;
  int get f;
  int get m11;
  int get m12;
  int get m13;
  int get m14;
  int get m21;
  int get m22;
  int get m23;
  int get m24;
  int get m31;
  int get m32;
  int get m33;
  int get m34;
  int get m41;
  int get m42;
  int get m43;
  int get m44;

  DomMatrix flipX();

  DomMatrix flipY();

  DomMatrix inverse();

  DomMatrix multiply(DomMatrix secondDomMatrix);

  DomMatrix rotate(num angle);

  DomMatrix rotateFromVector(num x, num y);

  DomMatrix scale([
    num scaleX,
    num scaleY,
    num scaleZ,
    num originX,
    num originY,
    num originZ,
  ]);

  DomMatrix scale3d([
    num scaleX,
    num scaleY,
    num scaleZ,
    num originX,
    num originY,
    num originZ,
  ]);

  DomMatrix skewX(num angle);

  DomMatrix skewY(num angle);

  DomMatrix translate(num tx, num ty, num tz);

  static DomMatrixReadOnly fromFloat32Array(Float32List list) {
    throw UnimplementedError();
  }

  static DomMatrixReadOnly fromFloat64Array(Float64List list) {
    throw UnimplementedError();
  }
}
