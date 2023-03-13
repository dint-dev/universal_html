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

void _testController() {
  group('WindowController:', () {
    test('openContent(_), sniffing <!DOCTYPE html>', () async {
      const content =
          '<!DOCTYPE html><html><body><h1>Hello world!</h1></body></html>';
      final windowController = WindowController();
      windowController.openContent(content);
      final document = windowController.window.document as HtmlDocument;
      final body = document.body!;
      expect(body.text, 'Hello world!');
    });

    test('openContent(_, contentType: _)', () async {
      final windowController = WindowController();
      windowController.openContent(
        '<html><body><h1>Hello world!</h1></body></html>',
        contentType: io.ContentType('text', 'html'),
      );
      final document = windowController.window.document as HtmlDocument;
      final body = document.body!;
      expect(body.text, 'Hello world!');
    });

    test('Mock WindowController', () {
      final oldWindowController = WindowController.instance;
      addTearDown(() {
        WindowController.instance = oldWindowController;
      });
      WindowController.instance = WindowControllerMock();
      expect(WindowController.instance, isA<WindowControllerMock>());
    });
  });
}

class WindowControllerMock extends WindowController {}
