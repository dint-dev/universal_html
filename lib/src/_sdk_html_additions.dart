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

import 'dart:async';
import 'dart:html';
import 'dart:io';

/// Implemented by [EventSource] outside browser.
///
/// ## Example
/// ```dart
/// import 'package:universal_html/html.dart';
/// import 'dart:io' show Cookie;
///
/// Future<void> main() async {
///   final eventSource = EventSource('http://example.com/events');
///   if (eventSource is EventSourceOutsideBrowser) {
///     eventSource.onHttpClientRequest = (eventSource, request) {
///       request.headers.set('Authorization', 'example');
///       request.cookies.add(Cookie('name', 'value'));
///     };
///     eventSource.onHttpClientRequest = (eventSource, request, response) {
///       // ...
///     };
///   }
///   await for (var message in eventSource.onMessage) {
///     print('Event:');
///     print('  type: ${message.type}');
///     print('  data: ${message.data}');
///   }
/// }
/// ```
///
/// Constructs [EventSource] and allows HTTP request modifications if the
/// application is not running in browser.
abstract class EventSourceOutsideBrowser implements EventSource {
  /// A callback called when a [HttpClientRequest] is ready (only outside
  /// browsers).
  ///
  /// You can access [httpClientRequest] if you want to set headers.
  FutureOr<void> Function(
          EventSourceOutsideBrowser eventSource, HttpClientRequest request)?
      onHttpClientRequest;

  /// A callback called when a [HttpClientResponse] arrives (only outside
  /// browsers).
  ///
  /// You can access [httpClientResponse] if you want to access headers.
  FutureOr<void> Function(
      EventSourceOutsideBrowser eventSource,
      HttpClientRequest request,
      HttpClientResponse response)? onHttpClientResponse;

  /// Current timeout.
  Duration retryDuration = Duration(seconds: 3);
}
