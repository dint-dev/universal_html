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

part of universal_html;

abstract class AbstractWorker implements EventTarget {
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  factory AbstractWorker._() {
    throw UnimplementedError();
  }

  /// Stream of `error` events handled by this [AbstractWorker].
  Stream<Event> get onError => errorEvent.forTarget(this);
}

class Client {
  final String frameType;

  final String id;

  final String type;

  final String url;

  factory Client._() {
    throw UnimplementedError();
  }

  void postMessage(Object message, [List<Object> transfer]) {
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

  Future<List<Client>> matchAll([Map options]) {
    throw UnimplementedError();
  }

  Future<WindowClient> openWindow(String url) {
    throw UnimplementedError();
  }
}

class ForeignFetchEvent extends ExtendableEvent {
  // To suppress missing implicit constructor warnings.
  final String origin;

  factory ForeignFetchEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  factory ForeignFetchEvent._() {
    throw UnimplementedError();
  }

  // final _Request request;

  void respondWith(Future r) {
    throw UnimplementedError();
  }
}

abstract class PushManager {
  static final List<String> supportedContentEncodings = <String>[];

  factory PushManager._() {
    throw UnimplementedError();
  }

  Future<PushSubscription> getSubscription() {
    throw UnimplementedError();
  }

  Future permissionState([Map options]) {
    throw UnimplementedError();
  }

  Future<PushSubscription> subscribe([Map options]) {
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

class PushSubscription {
  final String endpoint;

  final int expirationTime;

  final PushSubscriptionOptions options;

  factory PushSubscription._() {
    throw UnimplementedError();
  }

  ByteBuffer getKey(String name) {
    throw UnimplementedError();
  }

  Future<bool> unsubscribe() {
    throw UnimplementedError();
  }
}

class PushSubscriptionOptions {
  final ByteBuffer applicationServerKey;

  final bool userVisibleOnly;

  factory PushSubscriptionOptions._() {
    throw UnimplementedError();
  }
}

class ServiceWorker extends EventTarget implements AbstractWorker {
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  final String scriptUrl;

  final String state;

  factory ServiceWorker._() {
    throw UnsupportedError("Not supported");
  }

  Stream<Event> get onError => errorEvent.forTarget(this);

  void postMessage(/*any*/ message, [List<Object> transfer]) {
    throw UnimplementedError();
  }
}

class ServiceWorkerContainer extends EventTarget {
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  final ServiceWorker controller;

  factory ServiceWorkerContainer._() {
    throw UnsupportedError("Not supported");
  }

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Future<ServiceWorkerRegistration> get ready {
    throw UnimplementedError();
  }

  Future<ServiceWorkerRegistration> getRegistration([String documentURL]) {
    throw UnimplementedError();
  }

  Future<List<ServiceWorkerRegistration>> getRegistrations() {
    throw UnimplementedError();
  }

  Future<ServiceWorkerRegistration> register(String url, [Map options]) {
    throw UnimplementedError();
  }
}

class ServiceWorkerGlobalScope extends WorkerGlobalScope {
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

  final Clients clients;

  final ServiceWorkerRegistration registration;

  factory ServiceWorkerGlobalScope._() {
    throw UnimplementedError();
  }

  Stream<Event> get onActivate => activateEvent.forTarget(this);

  Stream<Event> get onFetch => fetchEvent.forTarget(this);

  Stream<ForeignFetchEvent> get onForeignfetch =>
      foreignfetchEvent.forTarget(this);

  Stream<Event> get onInstall => installEvent.forTarget(this);

  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  Future skipWaiting() {
    throw UnimplementedError();
  }
}

class ServiceWorkerRegistration extends EventTarget {
  // To suppress missing implicit constructor warnings.
  final ServiceWorker active;

  final ServiceWorker installing;

  // final BackgroundFetchManager backgroundFetch;

  final PushManager pushManager;

  // final NavigationPreloadManager navigationPreload;

  // final PaymentManager paymentManager;

  final String scope;

  final ServiceWorker waiting;

  // final SyncManager sync;

  factory ServiceWorkerRegistration._() {
    throw UnsupportedError("Not supported");
  }

  Future<List<Notification>> getNotifications([Map filter]) {
    throw UnimplementedError();
  }

  Future showNotification(String title, [Map options]) {
    throw UnimplementedError();
  }

  Future<bool> unregister() {
    throw UnimplementedError();
  }

  Future update() {
    throw UnimplementedError();
  }
}

class WindowClient extends Client {
  final bool focused;

  final String visibilityState;

  factory WindowClient._() {
    throw UnimplementedError();
  }

  Future<WindowClient> focus() {
    throw UnimplementedError();
  }

  Future<WindowClient> navigate(String url) {
    throw UnimplementedError();
  }
}

class WorkerGlobalScope extends EventTarget {
  // To suppress missing implicit constructor warnings.
  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [WorkerGlobalScope].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  static WorkerGlobalScope get instance {
    throw UnimplementedError();
  }

  final String addressSpace;

  // final CacheStorage caches;

  // final Crypto crypto;

  final IdbFactory indexedDB;

  final bool isSecureContext;

  // final _WorkerLocation location;

  // final _WorkerNavigator navigator;

  final String origin;

  // final WorkerPerformance performance;

  final WorkerGlobalScope self;

  factory WorkerGlobalScope._() {
    throw UnsupportedError("Not supported");
  }

  /// Stream of `error` events handled by this [WorkerGlobalScope].
  Stream<Event> get onError => errorEvent.forTarget(this);

  String atob(String atob) {
    throw UnimplementedError();
  }

  String btoa(String btoa) {
    throw UnimplementedError();
  }

  Future fetch(/*RequestInfo*/ input, [Map init]) {
    throw UnimplementedError();
  }

  void importScripts(String urls) {
    throw UnimplementedError();
  }
}
