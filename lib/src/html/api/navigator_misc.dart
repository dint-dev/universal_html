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

class BudgetService {
  factory BudgetService._() {
    throw UnimplementedError();
  }

  Future<BudgetState> getBudget() => throw UnimplementedError();

  Future<double> getCost(String operation) => throw UnimplementedError();

  Future<bool> reserve(String operation) => throw UnimplementedError();
}

@Native('BudgetState')
class BudgetState {
  factory BudgetState._() {
    throw UnimplementedError();
  }

  num? get budgetAt => throw UnimplementedError();

  int? get time => throw UnimplementedError();
}

abstract class Clipboard implements EventTarget {
  Clipboard._();

  Future<DataTransfer> read() => throw UnimplementedError();

  Future<String> readText() => throw UnimplementedError();

  Future write(DataTransfer data) => throw UnimplementedError();

  Future writeText(String data) => throw UnimplementedError();
}

abstract class Credential {
  Credential._();

  String get id;

  String get type;
}

abstract class CredentialsContainer {
  CredentialsContainer._();

  Future create([Map? options]);

  Future get([Map? options]);

  Future preventSilentAccess();

  Future requireUserMediation();

  Future store(Credential credential);
}

@deprecated
abstract class DeprecatedStorageQuota {
  DeprecatedStorageQuota._();

  void queryUsageAndQuota(StorageUsageCallback usageCallback,
      [StorageErrorCallback? errorCallback]);

  void requestQuota(int newQuotaInBytes,
      [StorageQuotaCallback? quotaCallback,
      StorageErrorCallback? errorCallback]);
}

abstract class Gamepad {
  Gamepad._();

  List<num>? get axes;

  List<GamepadButton>? get buttons;

  bool? get connected;

  int? get displayId;

  String? get hand;

  String? get id;

  int? get index;

  String? get mapping;

  GamepadPose? get pose;

  int? get timestamp;
}

abstract class GamepadButton {
  GamepadButton._();

  bool? get pressed;

  bool? get touched;

  num? get value;
}

abstract class GamepadPose {
  GamepadPose._();

  Float32List? get angularAcceleration;

  Float32List? get angularVelocity;

  bool? get hasOrientation;

  bool? get hasPosition;

  Float32List? get linearAcceleration;

  Float32List? get linearVelocity;

  Float32List? get orientation;

  Float32List? get position;
}

abstract class MediaCapabilities {
  MediaCapabilities._();

  Future<MediaCapabilitiesInfo> decodingInfo(Map configuration);

  Future<MediaCapabilitiesInfo> encodingInfo(Map configuration);
}

abstract class MediaCapabilitiesInfo {
  MediaCapabilitiesInfo._();

  bool get powerEfficient;

  bool get smooth;

  bool get supported;
}

abstract class MediaMetadata {
  String? album;

  String? artist;

  List? artwork;

  String? title;

  factory MediaMetadata([Map? metadata]) {
    throw UnimplementedError();
  }
}

abstract class MimeType {
  MimeType._();

  String? get description;

  Plugin? get enabledPlugin;

  String? get suffixes;

  String? get type;
}

abstract class NavigatorAutomationInformation {
  NavigatorAutomationInformation._();

  bool? get webdriver;
}

abstract class NavigatorConcurrentHardware {
  NavigatorConcurrentHardware._();

  int? get hardwareConcurrency => 1;
}

abstract class NavigatorCookies {
  NavigatorCookies._();

  bool? get cookieEnabled;
}

abstract class NavigatorID {
  NavigatorID._();

  String get appCodeName;

  String get appName;

  String get appVersion;

  bool? get dartEnabled;

  String? get platform;

  String get product;

  String get userAgent;
}

abstract class NavigatorLanguage {
  NavigatorLanguage._();

  String? get language;

  List<String>? get languages;
}

abstract class NavigatorOnLine {
  NavigatorOnLine._();

  bool? get onLine;
}

abstract class NetworkInformation implements EventTarget {
  static const EventStreamProvider<Event> changeEvent =
      EventStreamProvider<Event>('change');

  NetworkInformation._();

  num? get downlink;

  num? get downlinkMax;

  String? get effectiveType;

  Stream<Event> get onChange => changeEvent.forTarget(this);

  int? get rtt;

  String? get type;
}

@Native('NFC')
abstract class NFC {
  factory NFC._() {
    throw UnimplementedError();
  }
}

abstract class Plugin {
  Plugin._();

  String? get description;

  String? get filename;

  int? get length;

  String? get name;

  MimeType item(int index);

  MimeType namedItem(String name);
}

abstract class Presentation {
  PresentationRequest? defaultRequest;

  Presentation._();

  PresentationReceiver? get receiver;
}

abstract class PresentationAvailability implements EventTarget {
  static const EventStreamProvider<Event> changeEvent =
      EventStreamProvider<Event>('change');

  PresentationAvailability._();

  Stream<Event> get onChange;

  bool? get value;
}

abstract class PresentationConnection extends EventTarget {
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  String? binaryType;

  factory PresentationConnection._() {
    throw UnimplementedError();
  }

  String? get id;

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  String? get state;

  String? get url;

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

abstract class PresentationConnectionAvailableEvent extends Event {
  factory PresentationConnectionAvailableEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  PresentationConnection get connection;
}

abstract class PresentationConnectionCloseEvent extends Event {
  factory PresentationConnectionCloseEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  String? get message;

  String? get reason;
}

abstract class PresentationConnectionList extends EventTarget {
  factory PresentationConnectionList._() {
    throw UnimplementedError();
  }

  List<PresentationConnection> get connections;
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

abstract class RelatedApplication {
  RelatedApplication._();
  String? get id;
  String? get platform;

  String? get url;
}

abstract class StorageManager {
  StorageManager._();

  Future<Map<String, dynamic>> estimate();

  Future<bool> persist();

  Future<bool> persisted();
}

abstract class VR implements EventTarget {
  VR._();

  Future getDevices();
}
