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

typedef RtcPeerConnectionErrorCallback = void Function(DomException exception);

typedef VoidCallback = void Function();

@Native('RTCCertificate')
abstract class RtcCertificate {
  // To suppress missing implicit constructor warnings.
  factory RtcCertificate._() {
    throw UnimplementedError();
  }

  int? get expires;

  List<Map> getFingerprints();
}

@Native('RTCDataChannel,DataChannel')
abstract class RtcDataChannel extends EventTarget {
  // To suppress missing implicit constructor warnings.
  /// Static factory designed to expose `close` events to event
  /// handlers that are not necessarily instances of [RtcDataChannel].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> closeEvent =
      EventStreamProvider<Event>('close');

  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [RtcDataChannel].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  /// Static factory designed to expose `message` events to event
  /// handlers that are not necessarily instances of [RtcDataChannel].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>('message');

  /// Static factory designed to expose `open` events to event
  /// handlers that are not necessarily instances of [RtcDataChannel].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> openEvent =
      EventStreamProvider<Event>('open');

  factory RtcDataChannel._() {
    throw UnimplementedError();
  }

  String? get binaryType;

  set binaryType(String? value);

  int? get bufferedAmount;

  int? get bufferedAmountLowThreshold;

  set bufferedAmountLowThreshold(int? value);

  int? get id;

  String? get label;

  int? get maxRetransmits;

  int? get maxRetransmitTime;

  bool? get negotiated;

  /// Stream of `close` events handled by this [RtcDataChannel].
  Stream<Event> get onClose => closeEvent.forTarget(this);

  /// Stream of `error` events handled by this [RtcDataChannel].
  Stream<Event> get onError => errorEvent.forTarget(this);

  /// Stream of `message` events handled by this [RtcDataChannel].
  Stream<MessageEvent> get onMessage => messageEvent.forTarget(this);

  /// Stream of `open` events handled by this [RtcDataChannel].
  Stream<Event> get onOpen => openEvent.forTarget(this);

  bool? get ordered;

  String? get protocol;

  String? get readyState;

  bool? get reliable;

  void close();

  void send(data);

  @JSName('send')
  void sendBlob(Blob data);

  @JSName('send')
  void sendByteBuffer(ByteBuffer data);

  @JSName('send')
  void sendString(String data);

  @JSName('send')
  void sendTypedData(TypedData data);
}

@Native('RTCDataChannelEvent')
abstract class RtcDataChannelEvent extends Event {
  // To suppress missing implicit constructor warnings.
  factory RtcDataChannelEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  RtcDataChannel? get channel;
}

@Native('RTCDTMFSender')
abstract class RtcDtmfSender extends EventTarget {
  // To suppress missing implicit constructor warnings.
  /// Static factory designed to expose `tonechange` events to event
  /// handlers that are not necessarily instances of [RtcDtmfSender].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<RtcDtmfToneChangeEvent> toneChangeEvent =
      EventStreamProvider<RtcDtmfToneChangeEvent>('tonechange');

  factory RtcDtmfSender._() {
    throw UnimplementedError();
  }

  @JSName('canInsertDTMF')
  bool? get canInsertDtmf;

  int? get duration;

  int? get interToneGap;

  /// Stream of `tonechange` events handled by this [RtcDtmfSender].
  Stream<RtcDtmfToneChangeEvent> get onToneChange =>
      toneChangeEvent.forTarget(this);

  String? get toneBuffer;

  MediaStreamTrack? get track;

  @JSName('insertDTMF')
  void insertDtmf(String tones, [int? duration, int? interToneGap]);
}

@Native('RTCDTMFToneChangeEvent')
abstract class RtcDtmfToneChangeEvent extends Event {
  // To suppress missing implicit constructor warnings.
  factory RtcDtmfToneChangeEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  String? get tone;
}

@SupportedBrowser(SupportedBrowser.CHROME)
@Native('RTCIceCandidate,mozRTCIceCandidate')
abstract class RtcIceCandidate {
  factory RtcIceCandidate(Map dictionary) {
    throw UnimplementedError();
  }

  String? get candidate;

  set candidate(String? value);

  String? get sdpMid;

  set sdpMid(String? value);

  int? get sdpMLineIndex;

  set sdpMLineIndex(int? value);
}

@Native('RTCLegacyStatsReport')
abstract class RtcLegacyStatsReport {
  // To suppress missing implicit constructor warnings.
  factory RtcLegacyStatsReport._() {
    throw UnimplementedError();
  }

  String? get id;

  DateTime get timestamp;

  String? get type;

  List<String> names();

  String stat(String name);
}

@SupportedBrowser(SupportedBrowser.CHROME)
@Native('RTCPeerConnection,webkitRTCPeerConnection,mozRTCPeerConnection')
abstract class RtcPeerConnection extends EventTarget {
  /// Static factory designed to expose `addstream` events to event
  /// handlers that are not necessarily instances of [RtcPeerConnection].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MediaStreamEvent> addStreamEvent =
      EventStreamProvider<MediaStreamEvent>('addstream');

  /// Static factory designed to expose `datachannel` events to event
  /// handlers that are not necessarily instances of [RtcPeerConnection].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<RtcDataChannelEvent> dataChannelEvent =
      EventStreamProvider<RtcDataChannelEvent>('datachannel');

  /// Static factory designed to expose `icecandidate` events to event
  /// handlers that are not necessarily instances of [RtcPeerConnection].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<RtcPeerConnectionIceEvent>
      iceCandidateEvent =
      EventStreamProvider<RtcPeerConnectionIceEvent>('icecandidate');

  /// Static factory designed to expose `iceconnectionstatechange` events to event
  /// handlers that are not necessarily instances of [RtcPeerConnection].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> iceConnectionStateChangeEvent =
      EventStreamProvider<Event>('iceconnectionstatechange');

  // To suppress missing implicit constructor warnings.
  /// Static factory designed to expose `negotiationneeded` events to event
  /// handlers that are not necessarily instances of [RtcPeerConnection].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> negotiationNeededEvent =
      EventStreamProvider<Event>('negotiationneeded');

  /// Static factory designed to expose `removestream` events to event
  /// handlers that are not necessarily instances of [RtcPeerConnection].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<MediaStreamEvent> removeStreamEvent =
      EventStreamProvider<MediaStreamEvent>('removestream');

  /// Static factory designed to expose `signalingstatechange` events to event
  /// handlers that are not necessarily instances of [RtcPeerConnection].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> signalingStateChangeEvent =
      EventStreamProvider<Event>('signalingstatechange');

  /// Static factory designed to expose `track` events to event
  /// handlers that are not necessarily instances of [RtcPeerConnection].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<RtcTrackEvent> trackEvent =
      EventStreamProvider<RtcTrackEvent>('track');

  /// Checks if Real Time Communication (RTC) APIs are supported and enabled on
  /// the current platform.
  static bool get supported => false;

  factory RtcPeerConnection(Map rtcIceServers, [Map? mediaConstraints]) {
    throw UnimplementedError();
  }

  String? get iceConnectionState;

  String? get iceGatheringState;

  RtcSessionDescription? get localDescription;

  /// Stream of `addstream` events handled by this [RtcPeerConnection].
  Stream<MediaStreamEvent> get onAddStream => addStreamEvent.forTarget(this);

  /// Stream of `datachannel` events handled by this [RtcPeerConnection].
  Stream<RtcDataChannelEvent> get onDataChannel =>
      dataChannelEvent.forTarget(this);

  /// Stream of `icecandidate` events handled by this [RtcPeerConnection].
  Stream<RtcPeerConnectionIceEvent> get onIceCandidate =>
      iceCandidateEvent.forTarget(this);

  /// Stream of `iceconnectionstatechange` events handled by this [RtcPeerConnection].
  Stream<Event> get onIceConnectionStateChange =>
      iceConnectionStateChangeEvent.forTarget(this);

  /// Stream of `negotiationneeded` events handled by this [RtcPeerConnection].
  Stream<Event> get onNegotiationNeeded =>
      negotiationNeededEvent.forTarget(this);

  /// Stream of `removestream` events handled by this [RtcPeerConnection].
  Stream<MediaStreamEvent> get onRemoveStream =>
      removeStreamEvent.forTarget(this);

  /// Stream of `signalingstatechange` events handled by this [RtcPeerConnection].
  Stream<Event> get onSignalingStateChange =>
      signalingStateChangeEvent.forTarget(this);

  /// Stream of `track` events handled by this [RtcPeerConnection].
  Stream<RtcTrackEvent> get onTrack => trackEvent.forTarget(this);

  RtcSessionDescription? get remoteDescription;

  String? get signalingState;

  Future addIceCandidate(Object candidate,
      [VoidCallback? successCallback,
      RtcPeerConnectionErrorCallback? failureCallback]);

  void addStream(MediaStream? stream, [Map? mediaConstraints]);

  RtcRtpSender addTrack(MediaStreamTrack track, MediaStream streams);

  void close();

  Future<RtcSessionDescription> createAnswer([Map? options]);

  RtcDataChannel createDataChannel(String label, [Map? dataChannelDict]);

  @JSName('createDTMFSender')
  RtcDtmfSender createDtmfSender(MediaStreamTrack track);

  Future<RtcSessionDescription> createOffer([Map? options]) {
    throw UnimplementedError();
  }

  /// Temporarily exposes _getStats and old getStats as getLegacyStats until Chrome fully supports
  /// new getStats API.
  Future<RtcStatsResponse> getLegacyStats([MediaStreamTrack? selector]) {
    throw UnimplementedError();
  }

  List<MediaStream> getLocalStreams();

  List<RtcRtpReceiver> getReceivers();

  List<MediaStream> getRemoteStreams();

  List<RtcRtpSender> getSenders();

  Future<RtcStatsReport> getStats() => throw UnimplementedError();

  void removeStream(MediaStream? stream);

  void removeTrack(RtcRtpSender sender);

  void setConfiguration(Map configuration);

  Future setLocalDescription(Map description);

  Future setRemoteDescription(Map description);

  static Future generateCertificate(/*AlgorithmIdentifier*/ keygenAlgorithm) =>
      throw UnimplementedError();
}
// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Native('RTCPeerConnectionIceEvent')
abstract class RtcPeerConnectionIceEvent extends Event {
  factory RtcPeerConnectionIceEvent(String type, [Map? eventInitDict]) {
    throw UnimplementedError();
  }

  RtcIceCandidate? get candidate;
}
// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Native('RTCRtpContributingSource')
abstract class RtcRtpContributingSource {
  // To suppress missing implicit constructor warnings.
  factory RtcRtpContributingSource._() {
    throw UnimplementedError();
  }

  int? get source;

  num? get timestamp;
}

@Native('RTCRtpReceiver')
abstract class RtcRtpReceiver {
  // To suppress missing implicit constructor warnings.
  factory RtcRtpReceiver._() {
    throw UnimplementedError();
  }

  MediaStreamTrack? get track;

  List<RtcRtpContributingSource> getContributingSources();
}

@Native('RTCRtpSender')
abstract class RtcRtpSender {
  // To suppress missing implicit constructor warnings.
  factory RtcRtpSender._() {
    throw UnimplementedError();
  }

  MediaStreamTrack? get track;
}

@SupportedBrowser(SupportedBrowser.CHROME)
@Native('RTCSessionDescription,mozRTCSessionDescription')
class RtcSessionDescription {
  String? sdp;

  String? type;

  factory RtcSessionDescription(Map dictionary) {
    throw UnimplementedError();
  }
}

@Native('RTCStatsReport')
abstract class RtcStatsReport with MapMixin<String, dynamic> {
  // To suppress missing implicit constructor warnings.
  factory RtcStatsReport._() {
    throw UnimplementedError();
  }
}

@Native('RTCStatsResponse')
abstract class RtcStatsResponse {
  // To suppress missing implicit constructor warnings.
  factory RtcStatsResponse._() {
    throw UnimplementedError();
  }

  RtcLegacyStatsReport namedItem(String? name);

  List<RtcLegacyStatsReport> result();
}
// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class RtcTrackEvent extends Event {
  factory RtcTrackEvent(String type, Map eventInitDict) {
    throw UnimplementedError();
  }

  RtcRtpReceiver? get receiver;

  List<MediaStream>? get streams;

  MediaStreamTrack? get track;
}
