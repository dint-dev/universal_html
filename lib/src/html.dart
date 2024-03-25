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

// The library name is needed for generating differences between our library
// and dart:html.
library universal_html.internal;

import 'dart:async';
import 'dart:collection';
import 'dart:convert' show json, utf8;
import 'dart:io' as io;
import 'dart:math' show Rectangle;
import 'dart:math' show Random;
import 'dart:math' show Point, min, max;
import 'dart:typed_data';

import 'package:charcode/ascii.dart' as charcode;
import 'package:collection/collection.dart';
import 'package:csslib/parser.dart' as css;
import 'package:csslib/visitor.dart' as css;
import 'package:meta/meta.dart';
import 'package:typed_data/typed_buffers.dart';
import 'package:universal_html/html.dart' as universal_html_in_browser_or_vm;

import '../controller.dart';
import 'html.dart' as universal_html;
import 'html/_dom_parser_driver.dart' show DomParserDriver;
import 'html/dom/shared_with_dart2js/metadata.dart';
import 'indexed_db.dart';
import 'internal/event_stream_decoder.dart';
import 'internal/multipart_form_writer.dart';
import 'svg.dart' as svg;
import 'web_audio.dart';
import 'web_gl.dart' as gl;

export 'dart:math' show Point, Rectangle;

export 'package:universal_io/io.dart' show HttpStatus;

export 'html_top_level_functions.dart';
export 'js_util.dart' show promiseToFuture;

part 'html/api/accessible_node.dart';
part 'html/api/animation.dart';
part 'html/api/application_cache.dart';
part 'html/api/blob.dart';
part 'html/api/canvas.dart';
part 'html/api/console.dart';
part 'html/api/crypto.dart';
part 'html/api/data_transfer.dart';
part 'html/api/device.dart';
part 'html/api/dom_matrix.dart';
part 'html/api/event.dart';
part 'html/api/event_handlers.dart';
part 'html/api/event_source.dart';
part 'html/api/event_stream.dart';
part 'html/api/event_subclasses.dart';
part 'html/api/event_target.dart';
part 'html/api/file.dart';
part 'html/api/geolocation.dart';
part 'html/api/history.dart';
part 'html/api/http_request.dart';
part 'html/api/keycode.dart';
part 'html/api/media.dart';
part 'html/api/navigator.dart';
part 'html/api/navigator_misc.dart';
part 'html/api/notification.dart';
part 'html/api/payment.dart';
part 'html/api/performance.dart';
part 'html/api/permissions.dart';
part 'html/api/scroll.dart';
part 'html/api/speech_synthesis.dart';
part 'html/api/storage.dart';
part 'html/api/web_rtc.dart';
part 'html/api/web_socket.dart';
part 'html/api/window.dart';
part 'html/api/window_misc.dart';
part 'html/api/workers.dart';
part 'html/api/broadcast_channel.dart';
part 'html/dom/css.dart';
part 'html/dom/css_computed_style.dart';
part 'html/dom/css_rect.dart';
part 'html/dom/css_selectors.dart';
part 'html/dom/css_style_declaration.dart';
part 'html/dom/css_style_declaration_base.dart';
part 'html/dom/css_style_declaration_set.dart';
part 'html/dom/document.dart';
part 'html/dom/document_fragment.dart';
part 'html/dom/dom_exception.dart';
part 'html/dom/element.dart';
part 'html/dom/element_attributes.dart';
part 'html/dom/element_list.dart';
part 'html/dom/element_misc.dart';
part 'html/dom/element_subclasses.dart';
part 'html/dom/element_subclasses_for_inputs.dart';
part 'html/dom/html_document.dart';
part 'html/dom/html_node_validator.dart';
part 'html/dom/node.dart';
part 'html/dom/node_child_node_list.dart';
part 'html/dom/node_printing.dart';
part 'html/dom/node_validator_builder.dart';
part 'html/dom/parser.dart';
part 'html/dom/shared_with_dart2js/css_class_set.dart';
part 'html/dom/validators.dart';
part 'html/dom/xml_document.dart';
