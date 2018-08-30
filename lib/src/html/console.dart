part of universal_html;

class Console {
  Console._();

  void assertCondition(bool condition, Object arg) {
    if (!condition) {
      log(arg);
    }
  }

  void clear(Object arg) {}

  void count(Object arg) {}

  void debug(Object arg) {
    log(arg);
  }

  void dir(Object arg) {}

  void dirxml(Object arg) {}

  void error(Object arg) {
    log(arg);
  }

  void group(Object arg) {}

  void groupCollapsed(Object arg) {}

  void groupEnd() {}

  void info(Object arg) {
    log(arg);
  }

  void log(Object arg) {
    print(arg);
  }

  void markTimeline(Object arg) {}

  void profile(String title) {}

  void profileEnd(String title) {}

  void table(Object arg) {}

  void time(String title) {}

  void timeEnd(String title) {}

  void timeStamp(Object arg) {}

  void trace(Object arg) {}

  void warn(Object arg) {
    log(arg);
  }
}
