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

abstract class FileReader extends EventTarget {
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

  Error get error;

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

  void abort();

  void seek(int position);

  void truncate(int size);

  void write(Blob data);
}

abstract class Metadata {
  DateTime get modificationTime;

  int get size;
}
