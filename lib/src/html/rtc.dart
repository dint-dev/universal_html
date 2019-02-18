part of universal_html;

typedef void VoidCallback();

abstract class RtcDataChannel extends EventTarget {
  static const EventStreamProvider<Event> closeEvent =
      EventStreamProvider<Event>("close");

  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>("error");

  static const EventStreamProvider<MessageEvent> messageEvent =
      EventStreamProvider<MessageEvent>("message");

  static const EventStreamProvider<Event> openEvent =
      EventStreamProvider<Event>("open");

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
  RtcDataChannelEvent(String type) : super.constructor(type);

  RtcDataChannel get channel => null;
}

abstract class RtcDtmfSender {}

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

abstract class RtcPeerConnectionErrorCallback {}

class RtcPeerConnectionIceEvent extends Event {
  RtcPeerConnectionIceEvent(String type) : super.constructor(type);
}

abstract class RtcRtpReceiver {}

abstract class RtcRtpSender {}

abstract class RtcSessionDescription {}

abstract class RtcStatsReport {}

abstract class RtcStatsResponse {}
