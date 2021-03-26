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

abstract class SpeechSynthesis extends EventTarget {
  factory SpeechSynthesis._() {
    throw UnimplementedError();
  }

  bool? get paused;

  bool? get pending;

  bool? get speaking;

  void cancel();

  List<SpeechSynthesisVoice> getVoices();

  void pause();

  void resume();

  void speak(SpeechSynthesisUtterance utterance);
}

abstract class SpeechSynthesisEvent extends Event {
  factory SpeechSynthesisEvent._() {
    throw UnimplementedError();
  }

  int? get charIndex;

  num? get elapsedTime;

  String? get name;

  SpeechSynthesisUtterance? get utterance;
}

abstract class SpeechSynthesisUtterance extends EventTarget {
  /// Static factory designed to expose `boundary` events to event
  /// handlers that are not necessarily instances of [SpeechSynthesisUtterance].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<SpeechSynthesisEvent> boundaryEvent =
      EventStreamProvider<SpeechSynthesisEvent>('boundary');

  /// Static factory designed to expose `end` events to event
  /// handlers that are not necessarily instances of [SpeechSynthesisUtterance].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<SpeechSynthesisEvent> endEvent =
      EventStreamProvider<SpeechSynthesisEvent>('end');

  /// Static factory designed to expose `error` events to event
  /// handlers that are not necessarily instances of [SpeechSynthesisUtterance].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  /// Static factory designed to expose `mark` events to event
  /// handlers that are not necessarily instances of [SpeechSynthesisUtterance].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<SpeechSynthesisEvent> markEvent =
      EventStreamProvider<SpeechSynthesisEvent>('mark');

  /// Static factory designed to expose `pause` events to event
  /// handlers that are not necessarily instances of [SpeechSynthesisUtterance].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> pauseEvent =
      EventStreamProvider<Event>('pause');

  /// Static factory designed to expose `resume` events to event
  /// handlers that are not necessarily instances of [SpeechSynthesisUtterance].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<SpeechSynthesisEvent> resumeEvent =
      EventStreamProvider<SpeechSynthesisEvent>('resume');

  /// Static factory designed to expose `start` events to event
  /// handlers that are not necessarily instances of [SpeechSynthesisUtterance].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<SpeechSynthesisEvent> startEvent =
      EventStreamProvider<SpeechSynthesisEvent>('start');

  factory SpeechSynthesisUtterance([String? text]) {
    throw UnimplementedError();
  }

  String? get lang;

  /// Stream of `boundary` events handled by this [SpeechSynthesisUtterance].
  Stream<SpeechSynthesisEvent> get onBoundary => boundaryEvent.forTarget(this);

  /// Stream of `end` events handled by this [SpeechSynthesisUtterance].
  Stream<SpeechSynthesisEvent> get onEnd => endEvent.forTarget(this);

  /// Stream of `error` events handled by this [SpeechSynthesisUtterance].
  Stream<Event> get onError => errorEvent.forTarget(this);

  /// Stream of `mark` events handled by this [SpeechSynthesisUtterance].
  Stream<SpeechSynthesisEvent> get onMark => markEvent.forTarget(this);

  /// Stream of `pause` events handled by this [SpeechSynthesisUtterance].
  Stream<Event> get onPause => pauseEvent.forTarget(this);

  /// Stream of `resume` events handled by this [SpeechSynthesisUtterance].
  Stream<SpeechSynthesisEvent> get onResume => resumeEvent.forTarget(this);

  /// Stream of `start` events handled by this [SpeechSynthesisUtterance].
  Stream<SpeechSynthesisEvent> get onStart => startEvent.forTarget(this);

  num? get pitch;

  num? get rate;

  String? get text;

  SpeechSynthesisVoice? get voice;

  num? get volume;
}

abstract class SpeechSynthesisVoice {
  factory SpeechSynthesisVoice._() {
    throw UnimplementedError();
  }

  bool? get defaultValue;

  String? get lang;

  bool? get localService;

  String? get name;

  String? get voiceUri;
}
