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

part of driver_test;

void _testBrowserImplementationUtils() {
  test('FileBase', () {
    expect(_ExampleFile(), isNotNull);
  });

  test('FileWriterBase', () {
    expect(_ExampleFileWriter(), isNotNull);
  });

  group('BrowserImplementationUtils', () {
    test('getBlobData', () async {
      final actual = Blob([
        'ab',
        [1, 2],
        Uint8List.fromList([3, 4])
      ]);
      expect(actual.size, 7);

      final data = await BrowserImplementationUtils.getBlobData(actual);
      expect(data, [
        // String
        'a'.codeUnitAt(0),
        'b'.codeUnitAt(0),
        0,

        // List<int>
        1,
        2,

        // Uint8List
        3,
        4,
      ]);
    });

    test('newComment', () {
      final actual = BrowserImplementationUtils.newComment(null, 'value');
      expect(actual, isA<Comment>());
      expect(actual.nodeValue, 'value');
    });

    test('newCoordinates', () {
      final actual = BrowserImplementationUtils.newCoordinates(
          latitude: 2.0, longitude: 3.0);
      expect(actual.latitude, 2.0);
      expect(actual.longitude, 3.0);
    });

    test('newGeoposition', () {
      final coords = BrowserImplementationUtils.newCoordinates();
      final actual = BrowserImplementationUtils.newGeoposition(coords: coords);
      expect(actual.coords, same(coords));
    });

    test('newText', () {
      final node = BrowserImplementationUtils.newText(null, 'value');
      expect(node, isA<Text>());
      expect(node.nodeValue, 'value');
    });
  });
}

class _ExampleFile extends FileBase {
  @override
  int get lastModified => throw UnimplementedError();

  @override
  DateTime get lastModifiedDate => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  String get relativePath => throw UnimplementedError();

  @override
  int get size => throw UnimplementedError();

  @override
  String get type => throw UnimplementedError();

  @override
  Future<Uint8List> toBytesFuture() {
    throw UnimplementedError();
  }
}

class _ExampleFileWriter extends FileWriterBase {
  @override
  Error get error => null;

  @override
  int get length => 0;

  @override
  int get position => throw UnimplementedError();

  @override
  int get readyState => throw UnimplementedError();

  @override
  void abort() {}

  @override
  void seek(int position) {}

  @override
  void truncate(int size) {}

  @override
  void write(Blob data) {}
}
