part of universal_html;

class Navigator {
  final Permissions permission = Permissions._();

  /// IMPORTANT: Not part of 'dart:html' API.
  Navigator.internal({this.languages=const ["en-US"], this.userAgent="", this.vendor="", this.vendorSub=""});

  factory Navigator._() => HtmlDriver.current.newNavigator();

  String get appName => "";

  String get appVersion => "";

  int get deviceMemory => null;

  Geolocation get geoLocation => null;

  String get language {
    final languages = this.languages;
    return languages.isEmpty ? null : languages.first;
  }

  final List<String> languages;

  MediaDevices get mediaDevices => MediaDevices._();

  bool get onLine => false;

  final String userAgent;

  final String vendor;

  final String vendorSub;

  void cancelKeyboardLock() {}

  Future<RelatedApplication> getInstalledRelatedApps() {
    return Future.error(UnimplementedError());
  }

  Future<MediaStream> getUserMedia(
      {dynamic audio = false, dynamic video = false}) {
    return Future.error(UnimplementedError());
  }

  void registerProtocolHandler(String scheme, String url, String title) {}

  Future requestKeyboardLock([List<String> keyCodes]) {
    return Future.error(UnimplementedError());
  }

  Future requestMediaKeySystemAccess(
      String keySystem, List<Map> supportedConfigurations) {
    return Future.error(UnimplementedError());
  }

  bool sendBeacon(String url, Object data) {
    return false;
  }
}

class RelatedApplication {
  final String id;
  final String platform;
  final String url;

  RelatedApplication._({this.id, this.platform, this.url});
}
