part of universal_html;

class Permissions {
  Permissions._();

  Future query(Map permission) async {
    throw new UnimplementedError();
  }

  Future request(Map permissions) async {
    throw new UnimplementedError();
  }

  Future<PermissionStatus> requestAll(List<Map> permissions) async {
    throw new UnimplementedError();
  }

  Future revoke(Map permission) async {
    throw new UnimplementedError();
  }
}

class PermissionStatus {}
