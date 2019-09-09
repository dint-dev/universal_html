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

// Local TCP port that has a HTTP server
int httpServerPort = 0;

// Local TCP port hat DOES NOT have HTTP server
const httpServerWrongPort = 314;

void _testNetworking() {
  group("HttpRequest", () {
    StreamChannel streamChannel;
    setUpAll(() async {
      if (httpServerPort == 0) {
        final streamChannel = spawnHybridUri(
          Uri.parse("/test/src/html/api/networking_server.dart"),
        );
        final streamQueue = StreamQueue(streamChannel.stream);
        httpServerPort = ((await streamQueue.next) as num).toInt();
      }
    });

    tearDownAll(() {
      if (streamChannel != null) {
        streamChannel.sink.close();
      }
    });

    _testHttpRequest();
    _testEventSource();
  });
}
