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

library universal_html.internal;

import 'dart:async';
import 'dart:collection';
import 'dart:convert' show json, utf8;
import 'dart:math' show Rectangle;
import 'dart:math' show Random;
import 'dart:math' show Point, min, max;
import 'dart:typed_data';

import 'package:async/async.dart' show collectBytes;
import 'package:charcode/ascii.dart' as charcode;
import 'package:collection/collection.dart';
import 'package:csslib/parser.dart' as css;
import 'package:csslib/visitor.dart' as css;
import 'package:meta/meta.dart';
import 'package:universal_html/driver.dart';
import 'package:universal_html/src/indexed_db.dart';
import 'package:universal_html/src/svg.dart' as svg;
import 'package:universal_io/io.dart' as io;

import 'html/html_common/metadata.dart';
import 'internal/event_stream_decoder.dart';
import 'web_gl.dart' as gl;

export 'dart:math' show Point, Rectangle;

export 'package:universal_io/io.dart' show HttpStatus;

part 'html/accessible_node.dart';
part 'html/animation.dart';
part 'html/application_cache.dart';
part 'html/blob.dart';
part 'html/canvas.dart';
part 'html/console.dart';
part 'html/crypto.dart';
part 'html/css.dart';
part 'html/css_class_set.dart';
part 'html/css_computed_style.dart';
part 'html/css_rect.dart';
part 'html/css_selectors.dart';
part 'html/css_style_declaration.dart';
part 'html/css_style_declaration_base.dart';
part 'html/css_style_declaration_set.dart';
part 'html/data_transfer.dart';
part 'html/device.dart';
part 'html/document.dart';
part 'html/document_fragment.dart';
part 'html/dom_exception.dart';
part 'html/dom_matrix.dart';
part 'html/dom_parser.dart';
part 'html/element.dart';
part 'html/element_classes.dart';
part 'html/element_classes_input.dart';
part 'html/element_list.dart';
part 'html/element_misc.dart';
part 'html/event.dart';
part 'html/event_classes.dart';
part 'html/event_handlers.dart';
part 'html/event_source.dart';
part 'html/event_stream.dart';
part 'html/event_target.dart';
part 'html/file.dart';
part 'html/geolocation.dart';
part 'html/hidden_exports.dart';
part 'html/history.dart';
part 'html/html_node_validator.dart';
part 'html/http_request.dart';
part 'html/keycode.dart';
part 'html/media.dart';
part 'html/navigator.dart';
part 'html/navigator_misc.dart';
part 'html/node.dart';
part 'html/node_child_node_list.dart';
part 'html/node_printing.dart';
part 'html/node_validator_builder.dart';
part 'html/notification.dart';
part 'html/payment.dart';
part 'html/performance.dart';
part 'html/permissions.dart';
part 'html/rtc.dart';
part 'html/scroll.dart';
part 'html/service_worker.dart';
part 'html/storage.dart';
part 'html/speech_synthesis.dart';
part 'html/validators.dart';
part 'html/web_socket.dart';
part 'html/window.dart';
part 'html/window_misc.dart';
part 'html/xml.dart';
