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

void _testContentSecurityPolicy() {
  group('ContentSecurityPolicy', () {
    test('tryParse: default-src *', () {
      final csp = Csp.tryParse('default-src *');
      expect(
        csp.isAllowed(
          'image-src',
          Uri.parse('http://example.com/'),
        ),
        isTrue,
        reason: 'CSP is: \'$csp\'',
      );
    });

    test("tryParse: script-src 'self'", () {
      final csp = Csp.tryParse("script-src 'self'");
      expect(
        csp.isAllowed(
          'image-src',
          Uri.parse('http://example.com/'),
        ),
        isFalse,
        reason: "CSP is: '$csp'",
      );
      expect(
        csp.isAllowed(
          'script-src',
          Uri.parse('http://example.com/'),
          isSameOrigin: true,
        ),
        isTrue,
        reason: "CSP is: '$csp'",
      );
    });

    test('toString(), empty', () {
      final csp = Csp.tryParse('');
      expect(csp, isNotNull);
      expect(csp.toString(), '');
    });

    test('toString(), one item', () {
      final b = CspBuilder();
      b.addRule('script-src', ["'self'"]);
      b.addRule('default-src', ["'none'"]);
      expect(b.build().toString(), "default-src 'none'; script-src 'self'");
    });

    test('toString(), two items', () {
      final b = CspBuilder();
      b.addRule('default-src', ['a.com', 'b.com']);
      expect(b.build().toString(), 'default-src a.com b.com');
    });
  });
}
