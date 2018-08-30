part of universal_html;

class Notification extends EventTarget {
  static int get maxActions => 0;

  static String get permission => "denied";

  static bool get supported => false;
  final String body;
  final String dir;
  final String icon;
  final String lang;
  final Stream<Event> onClick = new Stream<Event>.empty();
  final Stream<Event> onClose = new Stream<Event>.empty();
  final Stream<Event> onError = new Stream<Event>.empty();
  final Stream<Event> onShow = new Stream<Event>.empty();
  final String tag;
  final String title;

  Notification(
    this.title, {
    this.dir,
    this.body,
    this.lang,
    this.tag,
    this.icon,
  });

  static Future<String> requestPermission() async => "denied";
}
