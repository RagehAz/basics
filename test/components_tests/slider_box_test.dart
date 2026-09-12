import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/super_slider/super_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// finds the dot Containers rendered by the private _SliderBox (reached
/// through the public SuperSlider(snap: true) widget) -- one per
/// List.generate(values.last+1, ...) iteration in slider_box.dart.
List<Color?> _dotColors(WidgetTester tester) {
  final containers = tester.widgetList<Container>(find.byWidgetPredicate((widget) {
    if (widget is! Container) {
      return false;
    }
    final decoration = widget.decoration;
    return decoration is BoxDecoration && decoration.shape == BoxShape.circle;
  }));
  return containers.map((c) => (c.decoration as BoxDecoration).color).toList();
}

void main() {
  // -----------------------------------------------------------------------------

  /// _SliderBox dot rendering (Set-based membership check)

  // --------------------
  group('SuperSlider snap dots', () {

    testWidgets('Lights up exactly the dots present in divisions, leaving gaps off', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SuperSlider(
            width: 300,
            height: 20,
            snap: true,
            divisions: const [0, 2, 4],
            draggerColor: Colors.red,
            onChanged: (_) {},
          ),
        ),
      ));

      final colors = _dotColors(tester);

      /// values.last (4) + 1 = 5 dots generated for indices 0..4
      expect(colors.length, 5);
      expect(colors, [Colorz.white20, Colorz.nothing, Colorz.white20, Colorz.nothing, Colorz.white20]);
    });

    testWidgets('Lights up every dot when divisions has no gaps', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SuperSlider(
            width: 300,
            height: 20,
            snap: true,
            divisions: const [0, 1, 2],
            draggerColor: Colors.red,
            onChanged: (_) {},
          ),
        ),
      ));

      final colors = _dotColors(tester);
      expect(colors, [Colorz.white20, Colorz.white20, Colorz.white20]);
    });

  });
}
