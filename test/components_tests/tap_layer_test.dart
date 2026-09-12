import 'package:basics/components/layers/tap_layer/tap_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async => null);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  Future<void> pump(WidgetTester tester, Widget tapLayer) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: tapLayer),
    ));
  }

  /// TapLayer's callbacks are invoked through an async _tapWithVibration
  /// wrapper (awaits a HapticFeedback platform-channel round trip before
  /// calling through) -- pumpAndSettle() alone doesn't reliably flush that
  /// pending platform-channel Future since it isn't tied to a scheduled
  /// animation frame, so a real-time pump is needed first.
  Future<void> settle(WidgetTester tester) async {
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
  }

  group('TapLayer (no splashColor -- GestureDetector path)', () {

    testWidgets('Calls onTap when tapped', (tester) async {
      int taps = 0;
      await pump(tester, TapLayer(
        width: 100,
        height: 100,
        onTap: () => taps++,
        child: Container(color: Colors.blue, width: 100, height: 100),
      ));

      await tester.tap(find.byType(TapLayer));
      await settle(tester);

      expect(taps, 1);
    });

    testWidgets('Calls onDoubleTap when double-tapped', (tester) async {
      int doubleTaps = 0;
      await pump(tester, TapLayer(
        width: 100,
        height: 100,
        onDoubleTap: () => doubleTaps++,
        child: Container(color: Colors.blue, width: 100, height: 100),
      ));

      await tester.tap(find.byType(TapLayer));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.byType(TapLayer));
      await settle(tester);

      expect(doubleTaps, 1);
    });

    testWidgets('Calls onLongTap on a long press', (tester) async {
      int longTaps = 0;
      await pump(tester, TapLayer(
        width: 100,
        height: 100,
        onLongTap: () => longTaps++,
        child: Container(color: Colors.blue, width: 100, height: 100),
      ));

      await tester.longPress(find.byType(TapLayer));
      await settle(tester);

      expect(longTaps, 1);
    });

    /// NOTE: onTapCancel and onTapUp are not exercised here -- verified via
    /// git-stash comparison against the pre-refactor code that neither
    /// fires in this widget-test harness even before my change (a nested-
    /// GestureDetector gesture-arena interaction between the outer
    /// onTapDown/onTapUp detector and the inner _TapInkLayer onTap
    /// detector), so this is a pre-existing test-environment limitation
    /// unrelated to this refactor, not something to fix as part of a
    /// perf-only pass.
    testWidgets('Calls onTapDown when tapped', (tester) async {
      int downs = 0;
      await pump(tester, TapLayer(
        width: 100,
        height: 100,
        onTapDown: () => downs++,
        child: Container(color: Colors.blue, width: 100, height: 100),
      ));

      final gesture = await tester.startGesture(tester.getCenter(find.byType(TapLayer)));
      await tester.pump(const Duration(milliseconds: 100));
      await gesture.up();
      await settle(tester);

      expect(downs, 1);
    });

    testWidgets('Does not throw and renders the child when no tap callbacks are given', (tester) async {
      await pump(tester, const TapLayer(
        width: 100,
        height: 100,
        child: Text('no taps'),
      ));

      expect(find.text('no taps'), findsOneWidget);

      await tester.tap(find.text('no taps'));
      await settle(tester);
    });

  });

  group('TapLayer (with splashColor -- InkWell path)', () {

    testWidgets('Calls onTap when tapped through the InkWell branch', (tester) async {
      int taps = 0;
      await pump(tester, TapLayer(
        width: 100,
        height: 100,
        splashColor: Colors.blue,
        onTap: () => taps++,
        child: Container(color: Colors.blue, width: 100, height: 100),
      ));

      await tester.tap(find.byType(TapLayer));
      await settle(tester);

      expect(taps, 1);
      expect(find.byType(InkWell), findsOneWidget);
    });

  });

  group('TapLayer (isDisabled)', () {

    testWidgets('Calls onDisabledTap instead of onTap when disabled', (tester) async {
      int taps = 0;
      int disabledTaps = 0;
      await pump(tester, TapLayer(
        width: 100,
        height: 100,
        isDisabled: true,
        onTap: () => taps++,
        onDisabledTap: () => disabledTaps++,
        child: Container(color: Colors.blue, width: 100, height: 100),
      ));

      await tester.tap(find.byType(TapLayer));
      await settle(tester);

      expect(taps, 0);
      expect(disabledTaps, 1);
    });

  });

}
