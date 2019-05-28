/// Q: How to run this on browser without test framework failure?
//@TestOn("vm")
library history_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:universal_html/html.dart' as html;

void main() {
  group("History:", () {
    final isVm = !html.window.location.hash.contains("metadata");

    test("initial state is correct", () {
      final history = html.window.history;
      final location = html.window.location;

      // Initial state
      expect(history.state, isNull);
      expect(location.protocol, "http:");
      expect(location.hostname, "localhost");
      expect(location.port, matches(r"^[0-9]+$"));
      expect(location.pathname, isNotNull);
      expect(location.hash, isNotNull);
      expect(location.host, "${location.hostname}:${location.port}");
      var expectedHost = "${location.hostname}:${location.port}";
      if (location.port == "80") {
        expectedHost = location.hostname;
      }
      expect(location.origin, "http://$expectedHost");
      expect(location.href, matches("^http://$expectedHost/.*\$"));
    });

    test("push", () async {
      if (!isVm) {
        return;
      }
      final history = html.window.history;
      final location = html.window.location;

      // Initial state
      expect(history.state, isNull);

      // Push state
      final state0 = {
        "x": 1,
      };
      final title0 = "title0";
      final url0 = "/path/to/somewhere#fragment";
      history.pushState(state0, title0, url0);

      // Wait a bit
      await Future.delayed(const Duration(microseconds: 1));

      // Check state
      expect(history.state, equals(state0));

      final hostName = location.hostname;
      final port = location.port;
      expect(location.protocol, "http:");
      expect(location.origin, "http://localhost");
      expect(location.host, "localhost:80");
      expect(location.hostname, "localhost");
      expect(location.port, "80");
      expect(location.pathname, "/path/to/somewhere");
      expect(location.href, "http://localhost/path/to/somewhere#fragment");

      // Add listener
      html.PopStateEvent previousEvent;
      html.window.onPopState.listen(expectAsync1((event) {
        previousEvent = event;
      }, count: 4));

      // Push second state
      final state1 = {
        "x": 2,
      };
      final title1 = "title1";
      final url1 = "somewhere_else";
      history.pushState(state1, title1, url1);

      // Wait a bit
      await Future.delayed(const Duration(milliseconds: 10));

      // Check state
      expect(previousEvent, isNotNull);
      expect(previousEvent.state, state1);
      expect(history.state, state1);
      expect(location.href, "http://localhost/path/to/somewhere_else");
      expect(location.pathname, "/path/to/somewhere_else");

      // Go back
      history.back();
      expect(history.state, state0);

      // Replace
      history.replaceState(state1, title1, url1);

      // Wait a bit
      await Future.delayed(const Duration(milliseconds: 10));

      // Check state
      expect(previousEvent, isNotNull);
      expect(previousEvent.state, state1);
      expect(history.state, state1);

      // Go back
      history.back();
      expect(history.state, isNull);
    });
  });
}
