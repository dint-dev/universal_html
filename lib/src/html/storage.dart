part of universal_html;

class Storage {
  factory Storage._() => HtmlDriver.current.newStorage();

  Storage.internal();

  final Map<String, String> _map = <String, String>{};

  void addAll(Map<String, String> other) {
    _map.addAll(other);
  }

  String remove(Object key) {
    return _map.remove(key);
  }

  String putIfAbsent(String key, String ifAbsent()) {
    return _map.putIfAbsent(key, ifAbsent);
  }

  void forEach(void f(String key, String value)) {
    _map.forEach(f);
  }

  bool containsValue(Object value) {
    return _map.containsValue(value);
  }

  bool containsKey(Object key) {
    return _map.containsKey(key);
  }

  void clear() {
    _map.clear();
  }
}

class StorageEvent extends Event {
  final String key;
  final String newValue;
  final String oldValue;
  final Storage storageArea;
  final String url;

  StorageEvent(String type,
      {this.key, this.newValue, this.oldValue, this.storageArea, this.url})
      : super.internalConstructor(type);
}
