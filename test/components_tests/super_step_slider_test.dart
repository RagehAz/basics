import 'package:basics/components/super_slider/super_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// SuperStepSlider._onChange (drives the Slider's onChanged callback)

  // --------------------
  group('SuperStepSlider', () {

    testWidgets('Reports the closest division index while dragging', (tester) async {
      int? reported;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SuperStepSlider(
            divisions: const [0, 1, 2, 3, 4],
            labels: null,
            draggerColor: Colors.red,
            initialIndex: 0,
            onChanged: (value) => reported = value,
          ),
        ),
      ));

      final slider = tester.widget<Slider>(find.byType(Slider));
      slider.onChanged!(0.5);
      await tester.pump();

      expect(reported, 2); // closest of [0,1,2,3,4] to (4 * 0.5 = 2)
    });

    testWidgets("Updates the Slider's visual value after a change", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SuperStepSlider(
            divisions: const [0, 1, 2, 3, 4],
            labels: null,
            draggerColor: Colors.red,
            initialIndex: 0,
            onChanged: (_) {},
          ),
        ),
      ));

      tester.widget<Slider>(find.byType(Slider)).onChanged!(0.75);
      await tester.pump();

      final updatedSlider = tester.widget<Slider>(find.byType(Slider));
      expect(updatedSlider.value, 0.75);
    });

    testWidgets('onChangeEnd snaps to the closest division value', (tester) async {
      int? endValue;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SuperStepSlider(
            divisions: const [0, 1, 2, 3, 4],
            labels: null,
            draggerColor: Colors.red,
            initialIndex: 0,
            onChanged: (_) {},
            onChangeEnd: (value) => endValue = value,
          ),
        ),
      ));

      tester.widget<Slider>(find.byType(Slider)).onChangeEnd!(0.6);
      await tester.pump();

      expect(endValue, 2); // closest of [0,1,2,3,4] to (4 * 0.6 = 2.4)
    });

    testWidgets('onChangeStart reports the closest division without changing state', (tester) async {
      int? startValue;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SuperStepSlider(
            divisions: const [0, 1, 2, 3, 4],
            labels: null,
            draggerColor: Colors.red,
            initialIndex: 0,
            onChanged: (_) {},
            onChangeStart: (value) => startValue = value,
          ),
        ),
      ));

      tester.widget<Slider>(find.byType(Slider)).onChangeStart!(0.9);
      await tester.pump();

      expect(startValue, 4); // closest of [0,1,2,3,4] to (4 * 0.9 = 3.6)
    });

    testWidgets('Starts at the value implied by initialIndex', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SuperStepSlider(
            divisions: const [0, 1, 2, 3, 4],
            labels: null,
            draggerColor: Colors.red,
            initialIndex: 2,
            onChanged: (_) {},
          ),
        ),
      ));

      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.value, 0.5); // index 2 / values.last(4) = 0.5
    });

  });
}
