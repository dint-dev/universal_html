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
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
part of universal_html.internal;

typedef MediaSessionActionHandler = void Function();

typedef StorageErrorCallback = void Function(DomError error);

typedef StorageQuotaCallback = void Function(int grantedQuotaInBytes);

typedef StorageUsageCallback = void Function(
    int currentUsageInBytes, int currentQuotaInBytes);

class Credential {
  final String id;

  final String type;

  factory Credential._() {
    throw UnimplementedError();
  }
}

class CredentialsContainer {
  factory CredentialsContainer._() {
    throw UnimplementedError();
  }

  Future create([Map options]) {
    throw UnimplementedError();
  }

  Future get([Map options]) {
    throw UnimplementedError();
  }

  Future preventSilentAccess() => throw UnimplementedError();

  Future requireUserMediation() => throw UnimplementedError();

  Future store(Credential credential) => throw UnimplementedError();
}

@deprecated
class DeprecatedStorageQuota {
  factory DeprecatedStorageQuota._() {
    throw UnimplementedError();
  }

  void queryUsageAndQuota(StorageUsageCallback usageCallback,
          [StorageErrorCallback errorCallback]) =>
      throw UnimplementedError();

  void requestQuota(int newQuotaInBytes,
          [StorageQuotaCallback quotaCallback,
          StorageErrorCallback errorCallback]) =>
      throw UnimplementedError();
}

class Gamepad {
  final List<num> axes;

  final List<GamepadButton> buttons;

  final bool connected;

  final int displayId;

  final String hand;

  final String id;

  final int index;

  final String mapping;

  final GamepadPose pose;

  final int timestamp;

  Gamepad._({
    this.axes,
    this.buttons,
    this.connected,
    this.displayId,
    this.hand,
    this.id,
    this.index,
    this.mapping,
    this.pose,
    this.timestamp,
  });
}

class GamepadButton {
  final bool pressed;

  final bool touched;

  final num value;

  GamepadButton._({
    this.pressed,
    this.touched,
    this.value,
  });
}

class GamepadPose {
  final Float32List angularAcceleration;

  final Float32List angularVelocity;

  final bool hasOrientation;

  final bool hasPosition;

  final Float32List linearAcceleration;

  final Float32List linearVelocity;

  final Float32List orientation;

  final Float32List position;

  GamepadPose._({
    this.angularAcceleration,
    this.angularVelocity,
    this.hasOrientation,
    this.hasPosition,
    this.linearAcceleration,
    this.linearVelocity,
    this.orientation,
    this.position,
  });
}

class MediaCapabilities {
  factory MediaCapabilities._() {
    throw UnimplementedError();
  }

  Future<MediaCapabilitiesInfo> decodingInfo(Map configuration) {
    throw UnimplementedError();
  }

  Future<MediaCapabilitiesInfo> encodingInfo(Map configuration) {
    throw UnimplementedError();
  }
}

class MediaCapabilitiesInfo {
  final bool powerEfficient;

  final bool smooth;

  final bool supported;

  factory MediaCapabilitiesInfo._() {
    throw UnimplementedError();
  }
}

class MediaMetadata {
  String album;

  String artist;

  List artwork;

  String title;

  factory MediaMetadata([Map metadata]) {
    throw UnimplementedError();
  }
}

class MediaSession {
  MediaMetadata metadata;

  String playbackState;

  factory MediaSession._() {
    throw UnimplementedError();
  }

  void setActionHandler(String action, MediaSessionActionHandler handler) {
    throw UnimplementedError();
  }
}

class MimeType {
  final String description;

  final Plugin enabledPlugin;

  final String suffixes;

  final String type;

  factory MimeType._() {
    throw UnimplementedError();
  }
}

class NavigatorAutomationInformation {
  final bool webdriver;

  factory NavigatorAutomationInformation._() {
    throw UnimplementedError();
  }
}

class NavigatorConcurrentHardware {
  NavigatorConcurrentHardware._();

  int get hardwareConcurrency => 1;
}

class NavigatorCookies {
  final bool cookieEnabled;

  factory NavigatorCookies._() {
    throw UnimplementedError();
  }
}

abstract class NavigatorID {
  final String appCodeName;

  final String appName;

  final String appVersion;

  final bool dartEnabled;

  final String platform;

  final String product;

  final String userAgent;

  factory NavigatorID._() {
    throw UnimplementedError();
  }
}

abstract class NavigatorLanguage {
  final String language;

  final List<String> languages;

  factory NavigatorLanguage._() {
    throw UnimplementedError();
  }
}

abstract class NavigatorOnLine {
  final bool onLine;

  factory NavigatorOnLine._() {
    throw UnimplementedError();
  }
}

class NetworkInformation extends EventTarget {
  static const EventStreamProvider<Event> changeEvent =
      EventStreamProvider<Event>('change');

  final num downlink;

  final num downlinkMax;

  final String effectiveType;

  final int rtt;

  final String type;

  factory NetworkInformation._() {
    throw UnimplementedError();
  }

  Stream<Event> get onChange => changeEvent.forTarget(this);
}

class Plugin {
  final String description;

  final String filename;

  final int length;

  final String name;

  factory Plugin._() {
    throw UnimplementedError();
  }

  MimeType item(int index) {
    throw UnimplementedError();
  }

  MimeType namedItem(String name) {
    throw UnimplementedError();
  }
}

class Presentation {
  PresentationRequest defaultRequest;

  Presentation._();

  PresentationReceiver get receiver => throw UnimplementedError();
}

class PresentationAvailability extends EventTarget {
  static const EventStreamProvider<Event> changeEvent =
      EventStreamProvider<Event>('change');

  final bool value;

  factory PresentationAvailability._() {
    throw UnimplementedError();
  }

  Stream<Event> get onChange => changeEvent.forTarget(this);
}

class PresentationConnection extends EventTarget {
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  String binaryType;

  final String id;

  final String state;

  final String url;

  factory PresentationConnection._() {
    throw UnimplementedError();
  }

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  void close() {
    throw UnimplementedError();
  }

  void send(data_OR_message) {
    throw UnimplementedError();
  }

  void terminate() {
    throw UnimplementedError();
  }
}

class PresentationConnectionAvailableEvent extends Event {
  final PresentationConnection connection;

  factory PresentationConnectionAvailableEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }
}

class PresentationConnectionCloseEvent extends Event {
  final String message;

  final String reason;

  factory PresentationConnectionCloseEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }
}

class PresentationConnectionList extends EventTarget {
  final List<PresentationConnection> connections;

  factory PresentationConnectionList._() {
    throw UnimplementedError();
  }
}

class PresentationReceiver {
  factory PresentationReceiver._() {
    throw UnimplementedError();
  }

  Future<PresentationConnectionList> get connectionList =>
      throw UnimplementedError();
}

class PresentationRequest extends EventTarget {
  factory PresentationRequest(url_OR_urls) {
    throw UnimplementedError();
  }

  Future<PresentationAvailability> getAvailability() =>
      throw UnimplementedError();

  Future<PresentationConnection> reconnect(String id) =>
      throw UnimplementedError();

  Future<PresentationConnection> start() => throw UnimplementedError();
}

class RelatedApplication {
  final String id;
  final String platform;
  final String url;

  RelatedApplication._({this.id, this.platform, this.url});
}

class StorageManager {
  StorageManager._();

  Future<Map<String, dynamic>> estimate() => throw UnimplementedError();

  Future<bool> persist() => throw UnimplementedError();

  Future<bool> persisted() => throw UnimplementedError();
}

class VR extends EventTarget {
  VR._() : super._created();

  Future getDevices() => throw UnimplementedError();
}

class _Clipboard extends EventTarget {
  factory _Clipboard._() {
    throw UnimplementedError();
  }

  Future<DataTransfer> read() => throw UnimplementedError();

  Future<String> readText() => throw UnimplementedError();

  Future write(DataTransfer data) => throw UnimplementedError();

  Future writeText(String data) => throw UnimplementedError();
}
