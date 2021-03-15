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

// Local TCP port that has a HTTP server.
late int _httpServerPort;

// Local TCP port hat DOES NOT have HTTP server.
// Used for testing connection failures.
const _httpServerWrongPort = 314;

void _testNetworking() {
  group(
    'Networking:',
    () {
      _testHttpRequest();
      _testEventSource();
    },
    tags: 'networking',
    timeout: Timeout(const Duration(seconds: 30)),
  );
}
