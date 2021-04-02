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

void _testWindow() {
  group('Window', () {
    test('console', () {
      final console = window.console;
      expect(console, isNotNull);
      console.info('Hello');
    });

    test('localStorage / sessionStorage', () {
      final storages = [
        window.localStorage,
        window.sessionStorage,
      ];
      for (var storage in storages) {
        expect(storage.length, 0);
        expect(storage['k0'], isNull);

        storage['k0'] = 'v0';
        expect(storage.length, 1);
        expect(storage['k0'], 'v0');

        storage['k1'] = 'v1';
        expect(storage.length, 2);
        expect(storage['k0'], 'v0');
        expect(storage['k1'], 'v1');

        storage['k2'] = 'v2';
        expect(storage.length, 3);
        storage.remove('k2');
        expect(storage.length, 2);
        storage.clear();
        expect(storage.length, 0);
      }
    });

    test('screen', () {
      final screen = window.screen!;
      expect(screen, isNotNull);
      expect(screen.height, greaterThan(0));
      expect(screen.width, greaterThan(0));
    });

    test('scrollX', () {
      expect(window.scrollX, greaterThanOrEqualTo(0));
    });

    test('scrollY', () {
      expect(window.scrollY, greaterThanOrEqualTo(0));
    });
  });
}
