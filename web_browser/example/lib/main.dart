import 'package:flutter/material.dart';
import 'package:web_browser/html.dart' as html;
import 'package:web_browser/web_browser.dart';

// Running this example:
//
//     flutter run
//     flutter run -d chrome
//
//
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Text(
            'WebBrowser:',
            textScaleFactor: 2.0,
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: WebBrowser(
              initialUrl: 'https://dart.dev/',
            ),
          ),
          Text(
            'WebText:',
            textScaleFactor: 2.0,
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: WebText('<h1>Hello world!</h1>'),
          ),
          Text(
            'WebNode:',
            textScaleFactor: 2.0,
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: WebNode(
              html.HeadingElement.h1()..appendText('Hello world!'),
            ),
          ),
        ],
      ),
    ),
  ));
}
