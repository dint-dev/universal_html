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

class UserAgent {
  final String string;
  final String appName;
  final String appVersion;
  final String product;
  final String productSub;
  final String vendor;
  final String vendorSub;

  const UserAgent(
    this.string, {
    this.appName = "Netscape",
    this.appVersion = "5.0",
    this.product = "Gecko",
    this.productSub = "20030107",
    this.vendor = "-",
    this.vendorSub = "",
  });

  @override
  int get hashCode => string.hashCode;

  @override
  bool operator ==(other) => other is UserAgent && string == other.string;

  @override
  String toString() => string;
}
