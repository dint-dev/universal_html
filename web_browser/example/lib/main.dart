import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:web_browser/html.dart' as html;
import 'package:web_browser/web_browser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Widget _body;

  @override
  Widget build(BuildContext context) {
    _body ??= _buildBody(0);
    return MaterialApp(
      title: 'Example',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      home: Scaffold(
        body: SafeArea(child: _body),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.web),
              title: Text('WebBrowser'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.slideshow),
              title: Text('WebNode'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              title: Text('Settings'),
            ),
          ],
          onTap: (i) {
            setState(() {
              _body = _buildBody(i);
            });
          },
        ),
      ),
    );
  }

  Widget _buildBody(int i) {
    return IndexedStack(
      index: i,
      children: [
        WebBrowser(
          key: ValueKey('browser'),
          initialUrl: 'https://dart.dev/',
        ),
        WebNode(
          key: ValueKey('node'),
          node: html.DivElement()
            ..style.textAlign = 'center'
            ..append(
              html.HeadingElement.h1()..appendText('Hello world!'),
            )
            ..append(html.AnchorElement()
              ..href = 'https://dart.dev/'
              ..appendText('A link to dart.dev')),
        ),
        Column(
          children: [
            // TODO: Settings for manual testing
          ],
        ),
      ],
    );
  }
}
