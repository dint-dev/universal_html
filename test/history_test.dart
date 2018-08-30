import 'dart:async';

import 'package:test/test.dart';
import 'package:universal_html/html.dart' as html;

void main() {
  group("History:", () {
    test("initial state is correct", () {
      final history = html.window.history;
      final location = html.window.location;

      // Initial state
      expect(history.state, isNull);
      expect(location.protocol, equals("http:"));
      expect(location.hostname, equals("localhost"));
      expect(location.hash, "");
    }, onPlatform: {
      "browser": Skip(),
    });
    test("push", () async {
      final history = html.window.history;
      final location = html.window.location;

      // Initial state
      expect(history.state, isNull);

      // Push state
      final state0 = {
        "x": 1,
      };
      final title0 = "title0";
      final url0 = "http://localhost:1234/path/to/somewhere#fragment";
      history.pushState(state0, title0, url0);

      // Wait a bit
      await Future.delayed(const Duration(microseconds: 1));

      // Check state
      expect(history.state, equals(state0));
      expect(location.href,
          equals("http://localhost:1234/path/to/somewhere#fragment"));
      expect(location.origin, equals("http://localhost:1234"));
      expect(location.protocol, equals("http:"));
      expect(location.host, equals("localhost:1234"));
      expect(location.hostname, equals("localhost"));
      expect(location.port, equals("1234"));
      expect(location.pathname, equals("/path/to/somewhere"));

      // Add listener
      html.PopStateEvent previousEvent;
      html.window.onPopState.listen((event) {
        previousEvent = event;
      });

      // Push second state
      final state1 = {
        "x": 2,
      };
      final title1 = "title1";
      final url1 = "somewhere_else";
      history.pushState(state1, title1, url1);

      // Wait a bit
      await Future.delayed(const Duration(microseconds: 1));

      // Check state
      expect(previousEvent, isNotNull);
      expect(previousEvent.state, equals(state1));
      expect(history.state, equals(state1));
      expect(location.href,
          equals("http://localhost:1234/path/to/somewhere_else"));
      expect(location.pathname, equals("/path/to/somewhere_else"));

      // Go back
      history.back();
      expect(history.state, equals(state0));

      // Replace
      history.replaceState(state1, title1, url1);

      // Wait a bit
      await Future.delayed(const Duration(microseconds: 1));

      // Check state
      expect(previousEvent, isNotNull);
      expect(previousEvent.state, equals(state1));
      expect(history.state, equals(state1));

      // Go back
      history.back();
      expect(history.state, isNull);
    }, onPlatform: {
      "browser": Skip(),
    });
  });
}
