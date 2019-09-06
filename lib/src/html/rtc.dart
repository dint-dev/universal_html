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

abstract class RtcDataChannel extends EventTarget {
  static const EventStreamProvider<Event> closeEvent =
      EventStreamProvider<Event>("close");

  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>("error");

  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>("message");

  static const EventStreamProvider<Event> openEvent =
      EventStreamProvider<Event>("open");

  RtcDataChannel._() : super._created();

  Stream<Event> get onClose;

  Stream<Event> get onError;

  Stream<MessageEvent> get onMessage;

  Stream<Event> get onOpen;

  String get readyState;

  bool get reliable;

  void close();

  void send(data);

  void sendBlob(Blob data);

  void sendByteBuffer(ByteBuffer data);

  void sendString(String data);

  void sendTypedData(TypedData data);
}

class RtcDataChannelEvent extends Event {
  RtcDataChannelEvent(String type) : super.internal(type);

  RtcDataChannel get channel => null;
}

abstract class RtcDtmfSender {
  RtcDtmfSender._();
}

abstract class RtcPeerConnection extends EventTarget {
  static const EventStreamProvider<MediaStreamEvent> addStreamEvent =
      EventStreamProvider<MediaStreamEvent>("addstream");

  static const EventStreamProvider<RtcDataChannelEvent> dataChannelEvent =
      EventStreamProvider<RtcDataChannelEvent>("datachannel");

  static const EventStreamProvider<RtcPeerConnectionIceEvent>
      iceCandidateEvent =
      EventStreamProvider<RtcPeerConnectionIceEvent>("icecandidate");

  static const EventStreamProvider<Event> iceConnectionStateChangeEvent =
      EventStreamProvider<Event>("iceconnectionstatechange");

  static const EventStreamProvider<MediaStreamEvent> removeStreamEvent =
      EventStreamProvider<MediaStreamEvent>("removestream");

  static const EventStreamProvider<Event> signalingStateChangeEvent =
      EventStreamProvider<Event>("signalignstatechange");

  RtcPeerConnection._() : super._created();

  String get iceConnectionState => null;

  String get iceGatheringState => null;

  RtcSessionDescription get localDescription;

  Stream<MediaStreamEvent> get onAddStream;

  Stream<RtcDataChannelEvent> get onDataChannel;

  Stream<RtcPeerConnectionIceEvent> get onIceCandidate;

  Stream<Event> get onIceConnectionStateChange;

  Stream<MediaStreamEvent> get onRemoveStream;

  Stream<Event> get onSignalingStateChange;

  RtcSessionDescription get remoteDescription;

  Future addIceCandidate(Object candidate,
      [VoidCallback successCallback,
      RtcPeerConnectionErrorCallback failureCallback]);

  void addStream(MediaStream stream, [Map mediaConstraints]);

  RtcRtpSender addTrack(MediaStreamTrack track, MediaStream streams);

  void close();

  Future<RtcSessionDescription> createAnswer([Map mediaConstraints]);

  RtcDataChannel createDataChannel(String label, [Map dataChannelDict]);

  RtcDtmfSender createDtmfSender(MediaStreamTrack track);

  Future<RtcSessionDescription> createOffer([Map mediaConstraints]);

  Future<RtcStatsResponse> getLegacyStats([MediaStreamTrack selector]);

  List<MediaStream> getLocalStreams();

  List<RtcRtpReceiver> getReceivers();

  List<MediaStream> getRemoteStreams();

  List<RtcRtpSender> getSenders();

  Future<RtcStatsReport> getStats();

  void removeStream(MediaStream stream);

  void removeTrack(RtcRtpSender sender);

  void setConfiguration(Map configuration);

  Future setLocalDescription(Map description);

  Future setRemoteDescription(Map description);
}

class RtcPeerConnectionIceEvent extends Event {
  RtcPeerConnectionIceEvent(String type) : super.internal(type);
}

abstract class RtcRtpReceiver {
  RtcRtpReceiver._();
}

abstract class RtcRtpSender {
  RtcRtpSender._();
}

abstract class RtcSessionDescription {}

abstract class RtcStatsReport {
  RtcStatsReport._();
}

abstract class RtcStatsResponse {
  RtcStatsResponse._();
}
