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
  'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
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

abstract class AbstractWorker implements EventTarget {
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  factory AbstractWorker._() {
    throw UnimplementedError();
  }

  /// Stream of `error` events handled by this [AbstractWorker].
  Stream<Event> get onError => errorEvent.forTarget(this);
}

class BackgroundFetchManager {
  factory BackgroundFetchManager._() {
    throw UnimplementedError();
  }

  Future<BackgroundFetchRegistration> fetch(String id, Object requests,
      [Map? options]) {
    throw UnimplementedError();
  }

  Future<BackgroundFetchRegistration> get(String id) =>
      throw UnimplementedError();

  Future<List<String>> getIds() => throw UnimplementedError();
}

abstract class BackgroundFetchRegistration extends EventTarget {
  factory BackgroundFetchRegistration._() {
    throw UnimplementedError();
  }

  int get downloaded;

  int get downloadTotal;

  String get id;

  String get title;

  int get totalDownloadSize;

  int get uploaded;

  int get uploadTotal;

  Future<bool> abort() => throw UnimplementedError();
}

abstract class Body {
  factory Body._() {
    throw UnimplementedError();
  }

  bool? get bodyUsed;

  Future arrayBuffer();

  Future<Blob> blob();

  Future<FormData> formData();

  Future json();

  Future<String> text();
}

abstract class Client {
  factory Client._() {
    throw UnimplementedError();
  }

  String? get frameType;

  String? get id;

  String? get type;

  String? get url;

  void postMessage(Object message, [List<Object>? transfer]) {
    throw UnimplementedError();
  }
}

class Clients {
  factory Clients._() {
    throw UnimplementedError();
  }

  Future claim() {
    throw UnimplementedError();
  }

  Future get(String id) {
    throw UnimplementedError();
  }

  Future<List<Client>> matchAll([Map? options]) {
    throw UnimplementedError();
  }

  Future<WindowClient> openWindow(String url) {
    throw UnimplementedError();
  }
}

abstract class ForeignFetchEvent extends ExtendableEvent {
  factory ForeignFetchEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  String? get origin;

  // final _Request request;

  void respondWith(Future r) {
    throw UnimplementedError();
  }
}

class FormData {
  /// Checks if this type is supported on the current platform.
  static bool get supported => false;

  factory FormData([FormElement? form]) {
    throw UnimplementedError();
  }

  void append(String name, String value) => throw UnimplementedError();

  void appendBlob(String name, Blob value, [String? filename]) =>
      throw UnimplementedError();

  void delete(String name) => throw UnimplementedError();

  Object get(String name) => throw UnimplementedError();

  List<Object> getAll(String name) => throw UnimplementedError();

  bool has(String name) => throw UnimplementedError();

  void set(String name, value, [String? filename]) =>
      throw UnimplementedError();
}

class Headers {
  factory Headers([Object? init]) {
    throw UnimplementedError();
  }
}

class NavigationPreloadManager {
  factory NavigationPreloadManager._() {
    throw UnimplementedError();
  }

  Future disable() => throw UnimplementedError();

  Future enable() => throw UnimplementedError();

  Future<Map<String, dynamic>> getState() => throw UnimplementedError();
}

abstract class PushManager {
  static final List<String> supportedContentEncodings = <String>[];

  factory PushManager._() {
    throw UnimplementedError();
  }

  Future<PushSubscription> getSubscription() {
    throw UnimplementedError();
  }

  Future permissionState([Map? options]) {
    throw UnimplementedError();
  }

  Future<PushSubscription> subscribe([Map? options]) {
    throw UnimplementedError();
  }
}

class PushMessageData {
  factory PushMessageData._() {
    throw UnimplementedError();
  }

  ByteBuffer arrayBuffer() {
    throw UnimplementedError();
  }

  Blob blob() {
    throw UnimplementedError();
  }

  Object json() {
    throw UnimplementedError();
  }

  String text() {
    throw UnimplementedError();
  }
}

abstract class PushSubscription {
  factory PushSubscription._() {
    throw UnimplementedError();
  }

  String get endpoint;

  int get expirationTime;

  PushSubscriptionOptions get options;

  ByteBuffer getKey(String name) {
    throw UnimplementedError();
  }

  Future<bool> unsubscribe() {
    throw UnimplementedError();
  }
}

abstract class PushSubscriptionOptions {
  factory PushSubscriptionOptions._() {
    throw UnimplementedError();
  }

  ByteBuffer get applicationServerKey;

  bool get userVisibleOnly;
}

abstract class ServiceWorker extends EventTarget implements AbstractWorker {
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  factory ServiceWorker._() {
    throw UnsupportedError('Not supported');
  }

  @override
  Stream<Event> get onError => errorEvent.forTarget(this);

  String get scriptUrl;

  String get state;

  void postMessage(/*any*/ message, [List<Object>? transfer]) {
    throw UnimplementedError();
  }
}

abstract class ServiceWorkerContainer extends EventTarget {
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  factory ServiceWorkerContainer._() {
    throw UnsupportedError('Not supported');
  }

  ServiceWorker get controller;

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Future<ServiceWorkerRegistration> get ready {
    throw UnimplementedError();
  }

  Future<ServiceWorkerRegistration> getRegistration([String? documentURL]) {
    throw UnimplementedError();
  }

  Future<List<ServiceWorkerRegistration>> getRegistrations() {
    throw UnimplementedError();
  }

  Future<ServiceWorkerRegistration> register(String url, [Map? options]) {
    throw UnimplementedError();
  }
}

abstract class ServiceWorkerGlobalScope extends WorkerGlobalScope {
  static const EventStreamProvider<Event> activateEvent =
      EventStreamProvider<Event>('activate');

  static const EventStreamProvider<Event> fetchEvent =
      EventStreamProvider<Event>('fetch');

  static const EventStreamProvider<ForeignFetchEvent> foreignfetchEvent =
      EventStreamProvider<ForeignFetchEvent>('foreignfetch');

  static const EventStreamProvider<Event> installEvent =
      EventStreamProvider<Event>('install');

  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  static ServiceWorkerGlobalScope get instance {
    throw UnimplementedError();
  }

  factory ServiceWorkerGlobalScope._() {
    throw UnimplementedError();
  }

  ApplicationCache get caches => throw UnimplementedError();

  Clients get clients;

  Crypto get crypto => throw UnimplementedError();

  Location get location => throw UnimplementedError();

  Navigator get navigator => throw UnimplementedError();

  Stream<Event> get onActivate => activateEvent.forTarget(this);

  Stream<Event> get onFetch => fetchEvent.forTarget(this);

  Stream<ForeignFetchEvent> get onForeignfetch =>
      foreignfetchEvent.forTarget(this);

  Stream<Event> get onInstall => installEvent.forTarget(this);

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Performance get performance => throw UnimplementedError();

  ServiceWorkerRegistration get registration;

  Future skipWaiting() {
    throw UnimplementedError();
  }
}

abstract class ServiceWorkerRegistration extends EventTarget {
  factory ServiceWorkerRegistration._() {
    throw UnsupportedError('Not supported');
  }

  ServiceWorker get active;

  BackgroundFetchManager get backgroundFetch;

  ServiceWorker get installing;

  NavigationPreloadManager get navigationPreload;

  PaymentManager get paymentManager;

  PushManager get pushManager;

  String get scope;

  SyncManager get sync;

  ServiceWorker get waiting;

  Future<List<Notification>> getNotifications([Map? filter]) {
    throw UnimplementedError();
  }

  Future showNotification(String title, [Map? options]) {
    throw UnimplementedError();
  }

  Future<bool> unregister() {
    throw UnimplementedError();
  }

  Future update() {
    throw UnimplementedError();
  }
}

abstract class SyncManager {
  factory SyncManager._() {
    throw UnimplementedError();
  }

  Future<List<String>> getTags() => throw UnimplementedError();

  Future register(String tag) => throw UnimplementedError();
}

abstract class WindowClient extends Client {
  factory WindowClient._() {
    throw UnimplementedError();
  }

  bool get focused;

  String get visibilityState;

  Future<WindowClient> focus() {
    throw UnimplementedError();
  }

  Future<WindowClient> navigate(String url) {
    throw UnimplementedError();
  }
}

abstract class WorkerGlobalScope extends EventTarget {
  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [WorkerGlobalScope].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  static WorkerGlobalScope get instance {
    throw UnimplementedError();
  }

  factory WorkerGlobalScope._() {
    throw UnsupportedError('Not supported');
  }

  // final CacheStorage caches;

  // final Crypto crypto;

  String get addressSpace;

  IdbFactory get indexedDB;

  // final _WorkerLocation location;

  // final _WorkerNavigator navigator;

  bool get isSecureContext;

  // final WorkerPerformance performance;

  /// Stream of `error` events handled by this [WorkerGlobalScope].
  Stream<Event> get onError => errorEvent.forTarget(this);

  String get origin;

  WorkerGlobalScope? get self;

  String atob(String atob) {
    throw UnimplementedError();
  }

  String btoa(String btoa) {
    throw UnimplementedError();
  }

  Future fetch(/*RequestInfo*/ input, [Map? init]) {
    throw UnimplementedError();
  }

  void importScripts(String urls) {
    throw UnimplementedError();
  }
}
