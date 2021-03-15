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

void _testContentTypeSniffer() {
  group('ContentTypeSniffer', () {
    const sniffer = ContentTypeSniffer();
    const html = 'text/html';
    const xml = 'text/xml';

    test('Comments and whitespace are skipped', () {
      expect(sniffer.sniffMime('<!----><xml></xml>'), xml);
      expect(sniffer.sniffMime('<!-- --><xml></xml>'), xml);
      expect(sniffer.sniffMime(' <!----> <xml></xml>'), xml);
      expect(sniffer.sniffMime(' <!-- --> <xml></xml>'), xml);
      expect(sniffer.sniffMime('\n<!--\n-->\n<xml></xml>'), xml);
    });
    test('Prefix <!DOCTYPE html', () {
      expect(sniffer.sniffMime('<!DOCTYPE html>'), html);
      expect(sniffer.sniffMime('<!DOCTYPE html >'), html);
    });
    test('Prefix <html>', () {
      expect(sniffer.sniffMime('<html>abc'), html);
      expect(sniffer.sniffMime('<html lang="en">'), html);
    });
    test('Prefix <xml>', () {
      expect(sniffer.sniffMime('<xml>abc'), xml);
      expect(sniffer.sniffMime('<xml version="1.0">abc'), xml);
    });
  });
}
