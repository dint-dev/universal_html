class UserAgent {
  final String string;
  final String appName;
  final String appVersion;
  final String product;
  final String productSub;
  final String vendor;
  final String vendorSub;

  const UserAgent(
    this.string, {
    this.appName = "Netscape",
    this.appVersion = "5.0",
    this.product = "Gecko",
    this.productSub = "20030107",
    this.vendor = "-",
    this.vendorSub = "",
  });

  @override
  int get hashCode => string.hashCode;

  @override
  bool operator ==(other) => other is UserAgent && string == other.string;

  @override
  String toString() => string;
}
