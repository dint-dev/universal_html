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

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

/// A web browser address bar.
class WebBrowserAddressBar extends StatefulWidget {
  /// Buttons on the right-side.
  final List<Widget> buttons;

  /// Handler for search queries. Default is [defaultOnSearch].
  ///
  /// If the value is null, search queries are not recognized.
  final FutureOr<void> Function(WebBrowserController controller, String query)
      onSearch;

  const WebBrowserAddressBar({
    Key key,
    this.onSearch = defaultOnSearch,
    this.buttons = const <Widget>[
      WebBrowserShareButton(),
    ],
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebBrowserAddressBarState();
  }

  /// Uses Google for searching.
  static void defaultOnSearch(WebBrowserController controller, String query) {
    query = query.trim();
    if (query.isEmpty) {
      controller.loadUrl('https://www.google.com/');
    } else {
      final q =
          query.split(' ').map((e) => Uri.encodeQueryComponent(e)).join('+');
      final url = 'https://www.google.com/search?q=$q';
      controller.loadUrl(url);
    }
  }
}

class _WebBrowserAddressBarState extends State<WebBrowserAddressBar> {
  final _textEditingController = TextEditingController();
  StreamSubscription<WebBrowserNavigationEvent> _subscription;

  FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    final controller = WebBrowserController.of(context);
    controller.currentUrl().then((value) {
      _textEditingController.text = _visibleUrl(value);
    });
    _subscription?.cancel();
    _subscription = controller.onNavigation.listen((event) {
      final url = _visibleUrl(event.url);
      _textEditingController.text = url;
      _textEditingController.selection = TextSelection.collapsed(offset: 0);
    });
    assert(controller != null);
    _textEditingController.text = 'address';
    _textEditingController.value = TextEditingValue(text: 'value');
    final onSearch = widget.onSearch;

    final textField = CupertinoTextField(
      decoration: BoxDecoration(
        border: Border.all(
          color: CupertinoColors.systemGrey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.all(10.0),
      controller: _textEditingController,
      maxLines: 1,
      focusNode: _focusNode,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.go,
      onEditingComplete: () {
        // Unfocus the text field
        final focusScope = FocusScope.of(context);
        focusScope.unfocus();

        // Get URL
        var value = _textEditingController.text;

        // Is it a search query?
        if (onSearch != null) {
          final isNotGoodURL = value.contains(' ') ||
              !(value.contains('.') || value.contains('://'));
          if (isNotGoodURL) {
            // A search query
            onSearch(controller, value);
            return;
          }
        }

        // If user gives URL without scheme
        if (!value.contains('://')) {
          // Prepend "https://
          value = 'https://$value';
        }

        controller.loadUrl(value);
      },
    );
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Material(
        child: Stack(
          children: [
            textField,
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.buttons,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      _textEditingController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _textEditingController.text.length,
        affinity: TextAffinity.upstream,
      );
    });
    super.initState();
  }

  static String _visibleUrl(String value) {
    value ??= '';
    const ignoredPrefix = 'https://';
    if (value.startsWith(ignoredPrefix)) {
      return value.substring(ignoredPrefix.length);
    }
    return value;
  }
}
