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

abstract class CanvasCaptureMediaStreamTrack implements MediaStreamTrack {
  CanvasCaptureMediaStreamTrack._();

  CanvasElement get canvas;
}

abstract class ImageBitmap {
  ImageBitmap._();
}

abstract class ImageCapture {
  factory ImageCapture(MediaStreamTrack track) {
    throw UnimplementedError();
  }

  Future<PhotoCapabilities> getPhotoCapabilities();

  Future<Map<String, dynamic>> getPhotoSettings();

  Future<ImageBitmap> grabFrame();

  Future setOptions(Map photoSettings);

  Future takePhoto([Map photoSettings]);
}

abstract class MediaDeviceInfo {
  MediaDeviceInfo._();

  String get deviceId;

  String get groupId;

  String get kind;

  String get label;
}

class MediaDevices {
  MediaDevices._();

  Future<List<MediaDeviceInfo>> enumerateDevices() async {
    return const <MediaDeviceInfo>[];
  }
}

class MediaKeys {
  MediaKeys._();
}

abstract class MediaRecorder {
  void pause() {}

  void requestData() {}

  void resume() {}

  void start([int timeslice]) {}

  void stop() {}
}

abstract class MediaSettingsRange {
  MediaSettingsRange._();

  num get max;

  num get min;

  num get step;
}

abstract class MediaSource extends EventTarget {
  static bool get supported => false;

  MediaSource._() : super._created();

  List<SourceBuffer> get activeSourceBuffers;

  num get duration;

  String get readyState;

  List<SourceBuffer> get sourceBuffers;

  static bool isTypeSupported(String type) => false;
}

abstract class MediaStream extends EventTarget {
  MediaStream._() : super._created();
}

class MediaStreamEvent extends Event {
  MediaStreamEvent(String type) : super.internal(type);
}

abstract class MediaStreamTrack extends EventTarget {
  String contentHint;
  bool enabled;

  MediaStreamTrack._() : super._created();

  String get id;

  String get kind;

  String get label;

  bool get muted;

  String get readyState;
}

abstract class MediaStreamTrackEvent extends Event {
  factory MediaStreamTrackEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  MediaStreamTrack get track;
}

abstract class PhotoCapabilities {
  PhotoCapabilities._();

  List get fillLightMode;

  MediaSettingsRange get imageHeight;

  MediaSettingsRange get imageWidth;

  String get redEyeReduction;
}

abstract class SourceBuffer {
  SourceBuffer._();

  void abort();

  void appendBuffer(ByteBuffer data);

  void appendTypedData(TypedData data);

  void remove(num start, num end);
}

class TextTrack {
  TextTrack._();
}

class VideoPlaybackQuality {
  VideoPlaybackQuality._();
}
