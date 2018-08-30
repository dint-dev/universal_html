library universal_html;

import 'dart:async';
import 'dart:collection' show LinkedHashMap;
import 'dart:collection';
import 'dart:math' show Rectangle;
import 'dart:typed_data';

import 'package:charcode/ascii.dart' as charcode;
import 'package:csslib/parser.dart' as css;
import 'package:csslib/visitor.dart' as css;
import 'package:html/dom.dart' as html_parsing;
import 'package:html/parser.dart' as html_parsing;
import 'package:meta/meta.dart';
import 'dart:math' show Random;

import 'svg.dart' as svg;
import 'svg.dart' show Matrix, SvgElement;

export 'dart:math' show Point, Rectangle;

export 'svg.dart' show Matrix;

part 'html/animation.dart';
part 'html/application_cache.dart';
part 'html/canvas.dart';
part 'html/console.dart';
part 'html/css.dart';
part 'html/css_computed_style.dart';
part 'html/data_transfer.dart';
part 'html/document.dart';
part 'html/dom_exception.dart';
part 'html/element.dart';
part 'html/elements.dart';
part 'html/event.dart';
part 'html/event_source.dart';
part 'html/events.dart';
part 'html/file.dart';
part 'html/geo_location.dart';
part 'html/history.dart';
part 'html/html5_node_validator.dart';
part 'html/html_driver.dart';
part 'html/keycode.dart';
part 'html/media.dart';
part 'html/navigator.dart';
part 'html/node.dart';
part 'html/node_child_node_list.dart';
part 'html/node_parsing.dart';
part 'html/node_printing.dart';
part 'html/node_validator_builder.dart';
part 'html/notification.dart';
part 'html/permissions.dart';
part 'html/rtc.dart';
part 'html/storage.dart';
part 'html/validators.dart';
part 'html/window.dart';
