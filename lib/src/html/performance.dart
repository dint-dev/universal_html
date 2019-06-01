part of universal_html;

class Performance extends EventTarget {
  Performance._();

  static bool get supported => false;

  final num timeOrigin = DateTime.now().microsecondsSinceEpoch / 10e6;

  void clearMarks(String markName) {
    throw UnimplementedError();
  }

  void clearMeasures(String measureName) {
    throw UnimplementedError();
  }

  void clearResourceTimings() {
    throw UnimplementedError();
  }

  void mark(String markName) {
    throw UnimplementedError();
  }

  void measure(String measureName, String startMark, String endMark) {
    throw UnimplementedError();
  }

  double now() {
    return DateTime.now().microsecondsSinceEpoch / 10e6;
  }

  void setResourceTimingBufferSize(int maxSize) {
    throw UnimplementedError();
  }
}
