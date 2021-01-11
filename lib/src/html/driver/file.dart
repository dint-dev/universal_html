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

part of universal_html.internal;

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
abstract class BlobBase implements Blob {
  @override
  Blob slice([int start, int end, String contentType]) {
    start ??= 0;
    end ??= size;
    if (start < 0 || start > size) {
      throw ArgumentError.value(end, 'start');
    }
    if (end < start || end > size) {
      throw ArgumentError.value(end, 'end');
    }
    return _SlicedBlob(this, start, end);
  }

  Future<Uint8List> toBytesFuture();

  @override
  String toString() => 'Blob(...)';
}

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private
//    fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
abstract class FileBase extends BlobBase implements File {
  FileBase();

  @override
  String toString() => 'File(...)';
}

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private
//    fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
/// Base class for [FileWriter] implementations.
abstract class FileWriterBase extends FileWriter {
  FileWriterBase() : super._();
}

// -----------------------------------------------------------------------------
// This API is:
//  * Part of library '/src/html.dart' so we have access to private
//    fields/methods.
//  * Hidden in library '/html.dart'
//  * Exported by library '/driver.dart'
// -----------------------------------------------------------------------------
class _SlicedBlob extends BlobBase {
  final BlobBase blob;
  final int start;
  final int end;

  _SlicedBlob(this.blob, this.start, this.end);

  @override
  int get size => end - start;

  @override
  String get type => blob.type;

  @override
  Future<Uint8List> toBytesFuture() async {
    final data = await blob.toBytesFuture();
    return Uint8List.view(
      data.buffer,
      start,
      end - start,
    );
  }
}
