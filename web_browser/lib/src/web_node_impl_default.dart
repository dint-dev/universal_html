// Copyright 2020 Gohilla Ltd.
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

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_browser/html.dart' as html;
import 'package:web_browser/web_browser.dart';

class WebNodeState extends State<WebNode> {
  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final htmlSource = serializeNode(
      context,
      node,
      backgroundColor: widget.backgroundColor,
    );
    return WebBrowser(
      initialUrl: Uri.dataFromString(
        htmlSource,
        mimeType: 'text/html',
      ).toString(),
      interactionSettings: null,
    );
  }
}

String serializeNode(
  BuildContext context,
  html.Node node, {
  Color backgroundColor,
}) {
  if (node is html.Document) {
    return node.documentElement.outerHtml;
  } else {
    html.HtmlHtmlElement htmlElement;
    if (node is html.HtmlHtmlElement) {
      htmlElement = node;
    } else {
      htmlElement = html.HtmlHtmlElement();
      final bodyElement = html.BodyElement();
      htmlElement.append(bodyElement);
      bodyElement.append(node);

      // Get CSS style
      final cssStyle = bodyElement.style;

      // Set CSS background color from widget
      if (backgroundColor != null) {
        cssStyle.backgroundColor = _cssFromColor(backgroundColor);
      }

      // Set CSS properties based on DefaultTextStyle
      final defaultTextStyle =
          context.dependOnInheritedWidgetOfExactType<DefaultTextStyle>();
      if (defaultTextStyle != null) {
        final flutterStyle = defaultTextStyle.style;
        if (cssStyle.fontFamily == '') {
          cssStyle.fontFamily = flutterStyle.fontFamily;
        }
        if (cssStyle.fontSize == '') {
          cssStyle.fontSize = _cssFromFontSize(flutterStyle.fontSize);
        }
        if (cssStyle.color == '') {
          cssStyle.color = _cssFromColor(flutterStyle.color);
        }
      }

      // Set CSS properties based on scaffold
      final scaffoldState = Scaffold.of(context, nullOk: true);
      if (scaffoldState != null) {
        if (cssStyle.backgroundColor == '') {
          cssStyle.backgroundColor = _cssFromColor(
            scaffoldState.widget.backgroundColor,
          );
        }
      }

      final cupertinoTheme = CupertinoTheme.of(context);
      if (cupertinoTheme != null) {
        final textStyle = cupertinoTheme.textTheme?.textStyle;
        if (textStyle != null) {
          if (cssStyle.fontFamily == '') {
            cssStyle.fontFamily = textStyle.fontFamily;
          }
          if (cssStyle.fontSize == '') {
            cssStyle.fontSize = _cssFromFontSize(textStyle.fontSize);
          }
          if (cssStyle.color == '') {
            cssStyle.color = _cssFromColor(textStyle.color);
          }
        }
        if (cssStyle.backgroundColor == '') {
          cssStyle.backgroundColor = _cssFromColor(
            cupertinoTheme.scaffoldBackgroundColor,
          );
        }
      }

      // Set CSS properties based on theme
      final theme = Theme.of(context);
      if (theme != null) {
        final bodyText = theme.textTheme?.bodyText2;
        if (bodyText != null) {
          if (cssStyle.fontFamily == '') {
            cssStyle.fontFamily = bodyText.fontFamily;
          }
          if (cssStyle.fontSize == '') {
            cssStyle.fontSize = _cssFromFontSize(bodyText.fontSize);
          }
          if (cssStyle.color == '') {
            cssStyle.color = _cssFromColor(bodyText.color);
          }
        }
        if (cssStyle.backgroundColor == '') {
          cssStyle.backgroundColor = _cssFromColor(
            theme.scaffoldBackgroundColor,
          );
        }
      }
    }
    return htmlElement.outerHtml;
  }
}

String _cssFromFontSize(double fontSize) {
  if (fontSize == null) {
    return null;
  }

  // TODO: Behavior based better research
  if (Platform.isIOS) {
    fontSize *= 2;
  }

  return '${fontSize.round()}pt';
}

String _cssFromColor(Color color) {
  if (color == null) {
    return null;
  }
  final red = color.red.toRadixString(16).padLeft(2, '0');
  final green = color.green.toRadixString(16).padLeft(2, '0');
  final blue = color.blue.toRadixString(16).padLeft(2, '0');
  return '#$red$green$blue';
}
