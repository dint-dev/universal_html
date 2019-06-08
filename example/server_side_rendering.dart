import 'dart:async';

import 'package:universal_html/driver.dart';
import 'package:universal_html/html.dart';

Future main() async {
  // Create renderer
  final renderer = ServerSideRenderer(webApp);

  // Listen at an automatically chosen port.
  await renderer.bind("localhost", 0, onReady: (server) {
    print("Listening at: http://${server.address.host}:${server.port}");
  });
}

void webApp() {
  switch (window.location.pathname) {
    case "/":
      document.body.append(
        HeadingElement.h1()..appendText("Choose an animal"),
      );
      final list = UListElement();
      document.body.append(
        AnchorElement()
          ..href = "/cat"
          ..appendText("Cat"),
      );
      document.body.appendText(" | ");
      document.body.append(
        AnchorElement()
          ..href = "/dog"
          ..appendText("Dog"),
      );
      document.body.append(list);
      break;

    case "/dog":
      document.body.append(HeadingElement.h1()..appendText("Dog!"));
      document.body.append(AnchorElement()
        ..href = "/"
        ..appendText("Choose again"));
      break;

    case "/cat":
      document.body.append(HeadingElement.h1()..appendText("Cat!"));
      document.body.append(AnchorElement()
        ..href = "/"
        ..appendText("Choose again"));
      break;

    default:
      document.body.append(HeadingElement.h1()..appendText("404 :("));
  }
}
