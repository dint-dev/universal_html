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

void _testNavigator() {
  group("Navigator", () {
    Navigator navigator;
    setUp(() {
      navigator = window.navigator;
    });
    test("appName", () {
      expect(navigator.appName, "Netscape");
    });
    test("appVersion", () {
      expect(navigator.appVersion, anyOf("5.0", matches(r"5.0 \(.*")));
    });
    test("product", () {
      expect(navigator.product, "Gecko");
    });
    test("productSub", () {
      expect(navigator.productSub, "20030107");
    });
    test("userAgent", () {
      expect(navigator.userAgent, isNotEmpty);
    });
    test("vendor", () {
      expect(navigator.vendor, anyOf(["-", "Google Inc."]));
    });
    test("vendorSub", () {
      expect(navigator.vendorSub, "");
    });
  });
}
