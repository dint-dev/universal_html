part of universal_html;

abstract class CanvasCaptureMediaStreamTrack implements MediaStreamTrack {
  CanvasElement get canvas;
}

abstract class ImageBitmap {}

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

class VideoPlaybackQuality {}

class MediaKeys {}

class TextTrack {}

abstract class MediaRecorder {
  void pause() {}

  void requestData() {}

  void resume() {}

  void start([int timeslice]) {}

  void stop() {}
}

abstract class MediaSettingsRange {
  num get max;

  num get min;

  num get step;
}

abstract class MediaSource extends EventTarget {
  static bool get supported => false;

  static bool isTypeSupported(String type) => false;

  List<SourceBuffer> get activeSourceBuffers;

  num get duration;

  String get readyState;

  List<SourceBuffer> get sourceBuffers;
}

abstract class MediaStream extends EventTarget {}

class MediaStreamEvent extends Event {
  MediaStreamEvent(String type) : super.internalConstructor(type);
}

abstract class MediaStreamTrack extends EventTarget {
  String contentHint;
  bool enabled;
  String id;

  factory MediaStreamTrack() {
    throw UnimplementedError();
  }

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
  List get fillLightMode;

  MediaSettingsRange get imageHeight;

  MediaSettingsRange get imageWidth;

  String get redEyeReduction;
}

abstract class SourceBuffer {
  void abort();

  void appendBuffer(ByteBuffer data);

  void appendTypedData(TypedData data);

  void remove(num start, num end);
}
