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

abstract class GlobalEventHandlers implements EventTarget {
  static const EventStreamProvider<Event> abortEvent =
      EventStreamProvider<Event>('abort');

  static const EventStreamProvider<Event> blurEvent =
      EventStreamProvider<Event>('blur');

  static const EventStreamProvider<Event> canPlayEvent =
      EventStreamProvider<Event>('canplay');

  static const EventStreamProvider<Event> canPlayThroughEvent =
      EventStreamProvider<Event>('canplaythrough');

  static const EventStreamProvider<Event> changeEvent =
      EventStreamProvider<Event>('change');

  static const EventStreamProvider<MouseEvent> clickEvent =
      EventStreamProvider<MouseEvent>('click');

  static const EventStreamProvider<MouseEvent> contextMenuEvent =
      EventStreamProvider<MouseEvent>('contextmenu');

  @DomName('GlobalEventHandlers.dblclickEvent')
  static const EventStreamProvider<Event> doubleClickEvent =
      EventStreamProvider<Event>('dblclick');

  static const EventStreamProvider<MouseEvent> dragEvent =
      EventStreamProvider<MouseEvent>('drag');

  static const EventStreamProvider<MouseEvent> dragEndEvent =
      EventStreamProvider<MouseEvent>('dragend');

  static const EventStreamProvider<MouseEvent> dragEnterEvent =
      EventStreamProvider<MouseEvent>('dragenter');

  static const EventStreamProvider<MouseEvent> dragLeaveEvent =
      EventStreamProvider<MouseEvent>('dragleave');

  static const EventStreamProvider<MouseEvent> dragOverEvent =
      EventStreamProvider<MouseEvent>('dragover');

  static const EventStreamProvider<MouseEvent> dragStartEvent =
      EventStreamProvider<MouseEvent>('dragstart');

  static const EventStreamProvider<MouseEvent> dropEvent =
      EventStreamProvider<MouseEvent>('drop');

  static const EventStreamProvider<Event> durationChangeEvent =
      EventStreamProvider<Event>('durationchange');

  static const EventStreamProvider<Event> emptiedEvent =
      EventStreamProvider<Event>('emptied');

  static const EventStreamProvider<Event> endedEvent =
      EventStreamProvider<Event>('ended');

  static const EventStreamProvider<Event> errorEvent =
      EventStreamProvider<Event>('error');

  static const EventStreamProvider<Event> focusEvent =
      EventStreamProvider<Event>('focus');

  static const EventStreamProvider<Event> inputEvent =
      EventStreamProvider<Event>('input');

  static const EventStreamProvider<Event> invalidEvent =
      EventStreamProvider<Event>('invalid');

  static const EventStreamProvider<KeyboardEvent> keyDownEvent =
      EventStreamProvider<KeyboardEvent>('keydown');

  static const EventStreamProvider<KeyboardEvent> keyPressEvent =
      EventStreamProvider<KeyboardEvent>('keypress');

  static const EventStreamProvider<KeyboardEvent> keyUpEvent =
      EventStreamProvider<KeyboardEvent>('keyup');

  static const EventStreamProvider<Event> loadEvent =
      EventStreamProvider<Event>('load');

  static const EventStreamProvider<Event> loadedDataEvent =
      EventStreamProvider<Event>('loadeddata');

  static const EventStreamProvider<Event> loadedMetadataEvent =
      EventStreamProvider<Event>('loadedmetadata');

  static const EventStreamProvider<MouseEvent> mouseDownEvent =
      EventStreamProvider<MouseEvent>('mousedown');

  static const EventStreamProvider<MouseEvent> mouseEnterEvent =
      EventStreamProvider<MouseEvent>('mouseenter');

  static const EventStreamProvider<MouseEvent> mouseLeaveEvent =
      EventStreamProvider<MouseEvent>('mouseleave');

  static const EventStreamProvider<MouseEvent> mouseMoveEvent =
      EventStreamProvider<MouseEvent>('mousemove');

  static const EventStreamProvider<MouseEvent> mouseOutEvent =
      EventStreamProvider<MouseEvent>('mouseout');

  static const EventStreamProvider<MouseEvent> mouseOverEvent =
      EventStreamProvider<MouseEvent>('mouseover');

  static const EventStreamProvider<MouseEvent> mouseUpEvent =
      EventStreamProvider<MouseEvent>('mouseup');

  static const EventStreamProvider<WheelEvent> mouseWheelEvent =
      EventStreamProvider<WheelEvent>('mousewheel');

  static const EventStreamProvider<Event> pauseEvent =
      EventStreamProvider<Event>('pause');

  static const EventStreamProvider<Event> playEvent =
      EventStreamProvider<Event>('play');

  static const EventStreamProvider<Event> playingEvent =
      EventStreamProvider<Event>('playing');

  static const EventStreamProvider<Event> rateChangeEvent =
      EventStreamProvider<Event>('ratechange');

  static const EventStreamProvider<Event> resetEvent =
      EventStreamProvider<Event>('reset');

  static const EventStreamProvider<Event> resizeEvent =
      EventStreamProvider<Event>('resize');

  static const EventStreamProvider<Event> scrollEvent =
      EventStreamProvider<Event>('scroll');

  static const EventStreamProvider<Event> seekedEvent =
      EventStreamProvider<Event>('seeked');

  static const EventStreamProvider<Event> seekingEvent =
      EventStreamProvider<Event>('seeking');

  static const EventStreamProvider<Event> selectEvent =
      EventStreamProvider<Event>('select');

  static const EventStreamProvider<Event> stalledEvent =
      EventStreamProvider<Event>('stalled');

  static const EventStreamProvider<Event> submitEvent =
      EventStreamProvider<Event>('submit');

  static const EventStreamProvider<Event> suspendEvent =
      EventStreamProvider<Event>('suspend');

  static const EventStreamProvider<Event> timeUpdateEvent =
      EventStreamProvider<Event>('timeupdate');

  static const EventStreamProvider<TouchEvent> touchCancelEvent =
      EventStreamProvider<TouchEvent>('touchcancel');

  static const EventStreamProvider<TouchEvent> touchEndEvent =
      EventStreamProvider<TouchEvent>('touchend');

  static const EventStreamProvider<TouchEvent> touchMoveEvent =
      EventStreamProvider<TouchEvent>('touchmove');

  static const EventStreamProvider<TouchEvent> touchStartEvent =
      EventStreamProvider<TouchEvent>('touchstart');

  static const EventStreamProvider<Event> volumeChangeEvent =
      EventStreamProvider<Event>('volumechange');

  static const EventStreamProvider<Event> waitingEvent =
      EventStreamProvider<Event>('waiting');

  static const EventStreamProvider<WheelEvent> wheelEvent =
      EventStreamProvider<WheelEvent>('wheel');

  factory GlobalEventHandlers._() {
    throw UnsupportedError('Not supported');
  }

  @override
  Events get on;

  Stream<Event> get onAbort => abortEvent.forTarget(this);

  Stream<Event> get onBlur => blurEvent.forTarget(this);

  Stream<Event> get onCanPlay => canPlayEvent.forTarget(this);

  Stream<Event> get onCanPlayThrough => canPlayThroughEvent.forTarget(this);

  Stream<Event> get onChange => changeEvent.forTarget(this);

  Stream<MouseEvent> get onClick => clickEvent.forTarget(this);

  Stream<MouseEvent> get onContextMenu => contextMenuEvent.forTarget(this);

  @DomName('GlobalEventHandlers.ondblclick')
  Stream<Event> get onDoubleClick => doubleClickEvent.forTarget(this);

  Stream<MouseEvent> get onDrag => dragEvent.forTarget(this);

  Stream<MouseEvent> get onDragEnd => dragEndEvent.forTarget(this);

  Stream<MouseEvent> get onDragEnter => dragEnterEvent.forTarget(this);

  Stream<MouseEvent> get onDragLeave => dragLeaveEvent.forTarget(this);

  Stream<MouseEvent> get onDragOver => dragOverEvent.forTarget(this);

  Stream<MouseEvent> get onDragStart => dragStartEvent.forTarget(this);

  Stream<MouseEvent> get onDrop => dropEvent.forTarget(this);

  Stream<Event> get onDurationChange => durationChangeEvent.forTarget(this);

  Stream<Event> get onEmptied => emptiedEvent.forTarget(this);

  Stream<Event> get onEnded => endedEvent.forTarget(this);

  Stream<Event> get onError => errorEvent.forTarget(this);

  Stream<Event> get onFocus => focusEvent.forTarget(this);

  Stream<Event> get onInput => inputEvent.forTarget(this);

  Stream<Event> get onInvalid => invalidEvent.forTarget(this);

  Stream<KeyboardEvent> get onKeyDown => keyDownEvent.forTarget(this);

  Stream<KeyboardEvent> get onKeyPress => keyPressEvent.forTarget(this);

  Stream<KeyboardEvent> get onKeyUp => keyUpEvent.forTarget(this);

  Stream<Event> get onLoad => loadEvent.forTarget(this);

  Stream<Event> get onLoadedData => loadedDataEvent.forTarget(this);

  Stream<Event> get onLoadedMetadata => loadedMetadataEvent.forTarget(this);

  Stream<MouseEvent> get onMouseDown => mouseDownEvent.forTarget(this);

  Stream<MouseEvent> get onMouseEnter => mouseEnterEvent.forTarget(this);

  Stream<MouseEvent> get onMouseLeave => mouseLeaveEvent.forTarget(this);

  Stream<MouseEvent> get onMouseMove => mouseMoveEvent.forTarget(this);

  Stream<MouseEvent> get onMouseOut => mouseOutEvent.forTarget(this);

  Stream<MouseEvent> get onMouseOver => mouseOverEvent.forTarget(this);

  Stream<MouseEvent> get onMouseUp => mouseUpEvent.forTarget(this);

  Stream<WheelEvent> get onMouseWheel => mouseWheelEvent.forTarget(this);

  Stream<Event> get onPause => pauseEvent.forTarget(this);

  Stream<Event> get onPlay => playEvent.forTarget(this);

  Stream<Event> get onPlaying => playingEvent.forTarget(this);

  Stream<Event> get onRateChange => rateChangeEvent.forTarget(this);

  Stream<Event> get onReset => resetEvent.forTarget(this);

  Stream<Event> get onResize => resizeEvent.forTarget(this);

  Stream<Event> get onScroll => scrollEvent.forTarget(this);

  Stream<Event> get onSeeked => seekedEvent.forTarget(this);

  Stream<Event> get onSeeking => seekingEvent.forTarget(this);

  Stream<Event> get onSelect => selectEvent.forTarget(this);

  Stream<Event> get onStalled => stalledEvent.forTarget(this);

  Stream<Event> get onSubmit => submitEvent.forTarget(this);

  Stream<Event> get onSuspend => suspendEvent.forTarget(this);

  Stream<Event> get onTimeUpdate => timeUpdateEvent.forTarget(this);

  Stream<TouchEvent> get onTouchCancel => touchCancelEvent.forTarget(this);

  Stream<TouchEvent> get onTouchEnd => touchEndEvent.forTarget(this);

  Stream<TouchEvent> get onTouchMove => touchMoveEvent.forTarget(this);

  Stream<TouchEvent> get onTouchStart => touchStartEvent.forTarget(this);

  Stream<Event> get onVolumeChange => volumeChangeEvent.forTarget(this);

  Stream<Event> get onWaiting => waitingEvent.forTarget(this);

  Stream<WheelEvent> get onWheel => wheelEvent.forTarget(this);

  @override
  void addEventListener(String type, dynamic Function(Event event) listener,
      [bool? useCapture]);

  @override
  bool dispatchEvent(Event event);

  @override
  void removeEventListener(String type, dynamic Function(Event event) listener,
      [bool? useCapture]);
}
