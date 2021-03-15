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

part of main_test;

void _testHistory() {
  group('History:', () {
    Future<void> delay() => Future.delayed(Duration(milliseconds: 10));

    // Always restore old location
    setUp(() {
      final oldHref = window.location.href;
      addTearDown(() {
        // For loop so to avoid accidental infinite loops
        for (var i = 0; i < 100; i++) {
          window.history.back();
          if (window.location.href == oldHref) {
            // Found original location.
            return;
          }
        }
      });
    });

    test('initial state is correct', () {
      window.location.href = 'http://localhost/';
      final history = window.history;
      final location = window.location;

      // Initial state
      expect(history.state, isNull);
      expect(location.protocol, 'http:');
      expect(location.hostname, 'localhost');
      expect(location.port, matches(r'^[0-9]+$'));
      expect(location.pathname, isNotNull);
      expect(location.hash, isNotNull);
      expect(location.host, '${location.hostname}:${location.port}');
      var expectedHost = '${location.hostname}:${location.port}';
      if (location.port == '80') {
        expectedHost = location.hostname!;
      }
      expect(location.origin, 'http://$expectedHost');
      expect(location.href, matches('^http://$expectedHost/.*\$'));
    }, testOn: '!browser');

    test('push', () async {
      final history = window.history;
      final location = window.location;
      final oldState = history.state;

      // Initial state
      expect(history.state, isNull);

      // Push state
      final state0 = {
        'x': 1,
      };
      final title0 = 'title0';
      final url0 = '/path/to/somewhere#fragment';
      history.pushState(state0, title0, url0);

      // Wait a bit
      await Future.delayed(const Duration(microseconds: 1));

      // Check state
      expect(history.state, equals(state0));

      expect(location.protocol, 'http:');
      expect(location.origin, 'http://localhost');
      expect(location.host, 'localhost:80');
      expect(location.hostname, 'localhost');
      expect(location.port, '80');
      expect(location.pathname, '/path/to/somewhere');
      expect(location.href, 'http://localhost/path/to/somewhere#fragment');

      // Add listener
      PopStateEvent? previousEvent;
      final streamSubscription = window.onPopState.listen(expectAsync1((event) {
        previousEvent = event;
      }, count: 4));
      addTearDown(() async {
        await streamSubscription.cancel();
      });

      // Push second state
      final state1 = {
        'x': 2,
      };
      final title1 = 'title1';
      final url1 = 'somewhere_else';
      history.pushState(state1, title1, url1);

      // Wait a bit
      await delay();

      // Check state
      expect(previousEvent, isNotNull);
      expect(previousEvent!.state, state1);
      expect(history.state, state1);
      expect(location.href, 'http://localhost/path/to/somewhere_else');
      expect(location.pathname, '/path/to/somewhere_else');

      // Go back
      history.back();
      expect(history.state, state1);
      await delay();
      expect(history.state, state0);

      // Replace
      history.replaceState(state1, title1, url1);

      // Wait a bit
      await delay();

      // Check state
      expect(previousEvent, isNotNull);
      expect(previousEvent!.state, state1);
      expect(history.state, state1);

      // Go back
      history.back();
      await delay();
      expect(history.state, oldState);
    }, testOn: '!browser'); // <-- OTHERWISE WILL HALT

    test('History.supportsState', () async {
      expect(History.supportsState, isTrue);
    });

    test('backward(), forward(), pushState()', () async {
      final location = window.location;
      final history = window.history;
      final oldHref = location.href;
      final oldState = history.state;

      history.pushState({'s': 'state0'}, 'title0', '/path0');
      history.pushState({'s': 'state1'}, 'title1', '/path1');
      history.pushState({'s': 'state2'}, 'title2', '/path2');
      history.pushState({'s': 'state3'}, 'title3', '/path3');
      history.pushState({'s': 'state4'}, 'title4', '/path4');

      history.back();

      // Nothing happens yet.
      expect(location.pathname, '/path4');
      expect(history.state, {'s': 'state4'});

      // Wait a bit
      await delay();

      history.back();
      await delay();
      expect(location.pathname, '/path2');
      expect(history.state, {'s': 'state2'});

      history.forward();
      await delay();
      expect(location.pathname, '/path3');
      expect(history.state, {'s': 'state3'});

      history.forward();
      await delay();
      expect(location.pathname, '/path4');
      expect(history.state, {'s': 'state4'});

      history.go(-2);
      await delay();
      expect(history.state, {'s': 'state2'});
      expect(location.pathname, '/path2');

      history.pushState({'s': 'stateNew'}, 'titleNew', '/pathNew');
      expect(location.pathname, '/pathNew');
      expect(history.state, {'s': 'stateNew'});

      history.forward();
      expect(location.pathname, '/pathNew');
      expect(history.state, {'s': 'stateNew'});

      history.back();
      history.back();
      history.back();
      history.back();
      expect(location.pathname, '/pathNew');
      expect(history.state, {'s': 'stateNew'});
      await delay();
      expect(location.href, oldHref);
      expect(history.state, oldState);
    });
  });
}
