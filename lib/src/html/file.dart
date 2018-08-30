part of universal_html;

typedef void BlobCallback(Blob blob);

abstract class Blob {
  factory Blob(List blobParts, [String type, String encoding]) =>
      HtmlDriver.current.newBlob(blobParts, type, encoding);

  int get size;

  String get type;

  Blob slice([int start, int end, String contentType]);
}

abstract class DirectoryEntry extends Entry {
  bool get isDirectory => true;
}

abstract class Entry {
  FileSystem get filesystem;

  String get fullPath;

  bool get isDirectory => false;

  bool get isFile => false;

  String get name;
}

abstract class File implements Blob {
  int get lastModified;

  DateTime get lastModifiedDate;

  String get name;

  String get relativePath;

  int get size;

  String get type;

  Blob slice([int start, int end, String contentType]);
}

abstract class FileEntry extends Entry {
  bool get isFile => true;

  Future<File> file();

  Future remove();
}

abstract class FileReader {
  static const int DONE = 2;
  static const int EMPTY = 0;
  static const int LOADING = 1;

  Error get error;

  Stream<ProgressEvent> get onAbort;

  Stream<ProgressEvent> get onError;

  Stream<ProgressEvent> get onLoad;

  Stream<ProgressEvent> get onLoadEnd;

  Stream<ProgressEvent> get onLoadStart;

  Stream<ProgressEvent> get onProgress;

  int get readyState;

  Object get result;

  void abort();

  void readAsArrayBuffer(Blob blob);

  void readAsDataUrl(Blob blob);

  void readAsText(Blob blob, [String label]);
}

abstract class FileSystem {
  static bool get supported => false;

  String get name;

  DirectoryEntry get root;
}

abstract class FileWriter {
  Error get error;

  int get length;

  Stream<ProgressEvent> get onAbort;

  Stream<ProgressEvent> get onError;

  Stream<ProgressEvent> get onProgress;

  Stream<ProgressEvent> get onWrite;

  Stream<ProgressEvent> get onWriteEnd;

  Stream<ProgressEvent> get onWriteStart;

  void abort();

  void seek(int position);

  void truncate(int size);

  void write(Blob data);
}

abstract class Metadata {
  DateTime get modificationTime;

  int get size;
}
