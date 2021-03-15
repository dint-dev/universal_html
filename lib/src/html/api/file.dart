// Copyright 2019 terrier989@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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

part of universal_html.internal;

class DirectoryEntry extends Entry {
  factory DirectoryEntry._() {
    throw UnimplementedError();
  }

  @override
  bool get isDirectory => true;

  /// Create a new directory with the specified `path`. If `exclusive` is true,
  /// the returned Future will complete with an error if a directory already
  /// exists with the specified `path`.
  Future<Entry> createDirectory(String path, {bool exclusive = false}) {
    throw UnimplementedError();
  }

  /// Create a new file with the specified `path`. If `exclusive` is true,
  /// the returned Future will complete with an error if a file already
  /// exists at the specified `path`.
  Future<Entry> createFile(String path, {bool exclusive = false}) {
    throw UnimplementedError();
  }

  DirectoryReader createReader() {
    throw UnimplementedError();
  }

  /// Retrieve an already existing directory entry. The returned future will
  /// result in an error if a directory at `path` does not exist or if the item
  /// at `path` is not a directory.
  Future<Entry> getDirectory(String path) {
    throw UnimplementedError();
  }

  /// Retrieve an already existing file entry. The returned future will
  /// result in an error if a file at `path` does not exist or if the item at
  /// `path` is not a file.
  Future<Entry> getFile(String path) {
    throw UnimplementedError();
  }

  Future removeRecursively() {
    throw UnimplementedError();
  }
}

class DirectoryReader {
  factory DirectoryReader._() {
    throw UnimplementedError();
  }

  Future<List<Entry>> readEntries() {
    throw UnimplementedError();
  }
}

abstract class Entry {
  Entry._();

  FileSystem? get filesystem => null;

  String? get fullPath => null;

  bool get isDirectory => false;

  bool get isFile => false;

  String? get name => null;

  Future<Entry> copyTo(DirectoryEntry parent, {String? name}) {
    throw UnimplementedError();
  }

  Future<Metadata> getMetadata() {
    throw UnimplementedError();
  }

  Future<Entry> getParent() {
    throw UnimplementedError();
  }

  Future<Entry> moveTo(DirectoryEntry parent, {String? name}) {
    throw UnimplementedError();
  }

  Future remove() {
    throw UnimplementedError();
  }

  String toUrl() {
    throw UnimplementedError();
  }
}

class File implements Blob {
  factory File(List<Object> fileBits, String fileName, [Map? options]) {
    throw UnimplementedError();
  }

  int get lastModified => throw UnimplementedError();

  DateTime get lastModifiedDate => throw UnimplementedError();

  String get name => throw UnimplementedError();

  String get relativePath => throw UnimplementedError();

  @override
  int get size => throw UnimplementedError();

  @override
  String get type => throw UnimplementedError();

  @override
  Future<List<int>> internalBytes() => throw UnimplementedError();

  @override
  Blob slice([int? start, int? end, String? contentType]) =>
      throw UnimplementedError();
}

class FileEntry extends Entry {
  factory FileEntry._() {
    throw UnimplementedError();
  }

  @override
  bool get isFile => true;

  Future<FileWriter> createWriter() {
    throw UnimplementedError();
  }

  Future<File> file() {
    throw UnimplementedError();
  }

  @override
  Future remove();
}

class FileReader extends EventTarget {
  static const int DONE = 2;
  static const int EMPTY = 0;
  static const int LOADING = 1;

  /// Static factory designed to expose `abort` events to event
  /// handlers that are not necessarily instances of [FileReader].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> abortEvent =
      EventStreamProvider<ProgressEvent>('abort');

  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [FileReader].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> errorEvent =
      EventStreamProvider<ProgressEvent>('error');

  /// Static factory designed to expose `load` events to event
  /// handlers that are not necessarily instances of [FileReader].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> loadEvent =
      EventStreamProvider<ProgressEvent>('load');

  /// Static factory designed to expose `loadend` events to event
  /// handlers that are not necessarily instances of [FileReader].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> loadEndEvent =
      EventStreamProvider<ProgressEvent>('loadend');

  /// Static factory designed to expose `loadstart` events to event
  /// handlers that are not necessarily instances of [FileReader].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> loadStartEvent =
      EventStreamProvider<ProgressEvent>('loadstart');

  /// Static factory designed to expose `progress` events to event
  /// handlers that are not necessarily instances of [FileReader].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> progressEvent =
      EventStreamProvider<ProgressEvent>('progress');

  factory FileReader() = FileReader._;

  FileReader._() : super.internal();

  Error get error => throw UnimplementedError();

  /// Stream of `abort` events handled by this [FileReader].
  Stream<ProgressEvent> get onAbort => abortEvent.forTarget(this);

  /// Stream of `error` events handled by this [FileReader].
  Stream<ProgressEvent> get onError => errorEvent.forTarget(this);

  /// Stream of `load` events handled by this [FileReader].
  Stream<ProgressEvent> get onLoad => loadEvent.forTarget(this);

  /// Stream of `loadend` events handled by this [FileReader].
  Stream<ProgressEvent> get onLoadEnd => loadEndEvent.forTarget(this);

  /// Stream of `loadstart` events handled by this [FileReader].
  Stream<ProgressEvent> get onLoadStart => loadStartEvent.forTarget(this);

  /// Stream of `progress` events handled by this [FileReader].
  Stream<ProgressEvent> get onProgress => progressEvent.forTarget(this);

  int get readyState => throw UnimplementedError();

  Object get result => throw UnimplementedError();

  void abort() {
    throw UnimplementedError();
  }

  void readAsArrayBuffer(Blob blob) {
    throw UnimplementedError();
  }

  void readAsDataUrl(Blob blob) {
    throw UnimplementedError();
  }

  void readAsText(Blob blob, [String? label]) {
    throw UnimplementedError();
  }
}

class FileSystem {
  static bool get supported => false;

  factory FileSystem._() {
    throw UnimplementedError();
  }

  String? get name => null;

  DirectoryEntry? get root => null;
}

abstract class FileWriter extends EventTarget {
  /// Static factory designed to expose `abort` events to event
  /// handlers that are not necessarily instances of [FileWriter].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> abortEvent =
      EventStreamProvider<ProgressEvent>('abort');

  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [FileWriter].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  /// Static factory designed to expose `progress` events to event
  /// handlers that are not necessarily instances of [FileWriter].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> progressEvent =
      EventStreamProvider<ProgressEvent>('progress');

  /// Static factory designed to expose `write` events to event
  /// handlers that are not necessarily instances of [FileWriter].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> writeEvent =
      EventStreamProvider<ProgressEvent>('write');

  /// Static factory designed to expose `writeend` events to event
  /// handlers that are not necessarily instances of [FileWriter].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> writeEndEvent =
      EventStreamProvider<ProgressEvent>('writeend');

  /// Static factory designed to expose `writestart` events to event
  /// handlers that are not necessarily instances of [FileWriter].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<ProgressEvent> writeStartEvent =
      EventStreamProvider<ProgressEvent>('writestart');

  static const int DONE = 2;

  static const int INIT = 0;

  static const int WRITING = 1;

  FileWriter._() : super.internal();

  Error get error;

  int get length;

  /// Stream of `abort` events handled by this [FileWriter].
  Stream<ProgressEvent> get onAbort => abortEvent.forTarget(this);

  /// Stream of `error` events handled by this [FileWriter].
  Stream<Event> get onError => errorEvent.forTarget(this);

  /// Stream of `progress` events handled by this [FileWriter].
  Stream<ProgressEvent> get onProgress => progressEvent.forTarget(this);

  /// Stream of `write` events handled by this [FileWriter].
  Stream<ProgressEvent> get onWrite => writeEvent.forTarget(this);

  /// Stream of `writeend` events handled by this [FileWriter].
  Stream<ProgressEvent> get onWriteEnd => writeEndEvent.forTarget(this);

  /// Stream of `writestart` events handled by this [FileWriter].
  Stream<ProgressEvent> get onWriteStart => writeStartEvent.forTarget(this);

  int get position => throw UnimplementedError();

  int get readyState => throw UnimplementedError();

  void abort();

  void seek(int position);

  void truncate(int size);

  void write(Blob data);
}

class Metadata {
  factory Metadata._() {
    throw UnimplementedError();
  }

  DateTime get modificationTime => throw UnimplementedError();

  int get size => throw UnimplementedError();
}
