import 'dart:async';

import 'package:basics/helpers/streamers/streamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Streamer connectionIsLoading', () {
    test('Returns true while the connection is waiting', () {
      const snapshot = AsyncSnapshot<dynamic>.waiting();
      final result = Streamer.connectionIsLoading(snapshot);
      expect(result, true);
    });

    test('Returns false once data has arrived', () {
      const snapshot = AsyncSnapshot<dynamic>.withData(ConnectionState.active, 'value');
      final result = Streamer.connectionIsLoading(snapshot);
      expect(result, false);
    });

    test('Returns false once the connection is done', () {
      const snapshot = AsyncSnapshot<dynamic>.withData(ConnectionState.done, 'value');
      final result = Streamer.connectionIsLoading(snapshot);
      expect(result, false);
    });

    test('Returns false when nothing (none) is connected', () {
      const snapshot = AsyncSnapshot<dynamic>.nothing();
      final result = Streamer.connectionIsLoading(snapshot);
      expect(result, false);
    });
  });

  group('Streamer disposeStreamSubscriptions', () {
    test('Completes without error for a null list', () async {
      await Streamer.disposeStreamSubscriptions(null);
    });

    test('Completes without error for an empty list', () async {
      await Streamer.disposeStreamSubscriptions(<StreamSubscription<dynamic>>[]);
    });

    test('Cancels every subscription passed to it', () async {
      final controllerA = StreamController<int>.broadcast();
      final controllerB = StreamController<int>.broadcast();

      var receivedA = 0;
      var receivedB = 0;

      // ignore: cancel_subscriptions
      final subA = controllerA.stream.listen((_) => receivedA++);
      // ignore: cancel_subscriptions
      final subB = controllerB.stream.listen((_) => receivedB++);

      controllerA.add(1);
      controllerB.add(1);
      await Future<void>.delayed(Duration.zero);
      expect(receivedA, 1);
      expect(receivedB, 1);

      await Streamer.disposeStreamSubscriptions([subA, subB]);

      /// events fired after cancellation must not reach the listeners
      controllerA.add(2);
      controllerB.add(2);
      await Future<void>.delayed(Duration.zero);
      expect(receivedA, 1);
      expect(receivedB, 1);

      await controllerA.close();
      await controllerB.close();
    });
  });
}
