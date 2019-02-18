part of universal_html;

class Notification extends EventTarget {
  static int get maxActions => 0;

  static String get permission => "denied";

  static bool get supported => false;
  final String body;
  final String dir;
  final String icon;
  final String lang;
  final Stream<Event> onClick = Stream<Event>.empty();
  final Stream<Event> onClose = Stream<Event>.empty();
  final Stream<Event> onError = Stream<Event>.empty();
  final Stream<Event> onShow = Stream<Event>.empty();
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
