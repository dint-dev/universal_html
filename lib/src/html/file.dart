/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

part of universal_html;

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
