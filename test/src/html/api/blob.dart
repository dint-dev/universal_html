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

part of main_test;

void _testBlob() {
  test('Blob([\'ab\'])', () {
    final blob = Blob([
      'ab',
    ]);
    expect(blob.size, 2);
    // Data in the blob is tested in BrowserImplementationUtils test
  });

  test('Blob([\'ab\', [1,2]])', () {
    final blob = Blob([
      'ab',
      [1, 2]
    ]);
    expect(blob.size, 5);
    // Data in the blob is tested in BrowserImplementationUtils test
  });

  test('Blob(\'ab\', [1,2], Uint8List.fromList([3,4]))', () {
    final blob = Blob([
      'ab',
      [1, 2],
      Uint8List.fromList([3, 4])
    ]);
    expect(blob.size, 7);
    // Data in the blob is tested in BrowserImplementationUtils test
  });
}
