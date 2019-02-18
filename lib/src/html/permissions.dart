part of universal_html;

class Permissions {
  Permissions._();

  Future query(Map permission) async {
    throw UnimplementedError();
  }

  Future request(Map permissions) async {
    throw UnimplementedError();
  }

  Future<PermissionStatus> requestAll(List<Map> permissions) async {
    throw UnimplementedError();
  }

  Future revoke(Map permission) async {
    throw UnimplementedError();
  }
}

class PermissionStatus {}
