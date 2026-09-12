import 'dart:ui' as ui;
import 'package:basics/components/super_image/super_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A pre-decoded ui.Image, passed directly as `pic` -- this makes
/// getUiImageFromDynamic's Uint8List branch a no-op (it just returns the
/// image as-is), sidestepping SuperImage's own async bytes-decoding/loading
/// machinery entirely so this test is isolated to the filter-wrapping
/// behavior in _FilteredImage, not image decoding.
Future<ui.Image> _makeUiImage({int width = 20, int height = 20}) async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder);
  canvas.drawRect(
    ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    ui.Paint()..color = const ui.Color(0xFF00FF00),
  );
  final ui.Picture picture = recorder.endRecording();
  return picture.toImage(width, height);
}

void main() {

  group('SuperFilteredImage', () {

    testWidgets('Applies each filter matrix exactly once (no double-filtering) on initial load', (tester) async {
      final image = await _makeUiImage();
      const filter = ImageFilterModel(
        id: 'test-filter',
        matrixes: [
          [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0],
          [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0],
        ],
      );

      await tester.pumpWidget(MaterialApp(
        home: SuperFilteredImage(
          width: 20,
          height: 20,
          pic: image,
          loading: false,
          filterModel: filter,
        ),
      ));

      /// let the didChangeDependencies microtask chain resolve
      await tester.pump();
      await tester.pump();

      expect(find.byType(ColorFiltered), findsNWidgets(filter.matrixes.length));
    });

    testWidgets('Renders without a filter when filterModel is null', (tester) async {
      final image = await _makeUiImage();

      await tester.pumpWidget(MaterialApp(
        home: SuperFilteredImage(
          width: 20,
          height: 20,
          pic: image,
          loading: false,
        ),
      ));

      await tester.pump();
      await tester.pump();

      expect(find.byType(ColorFiltered), findsNothing);
    });

    testWidgets('Re-applies the filter exactly once (still no double-filtering) after an update', (tester) async {
      final image1 = await _makeUiImage();
      final image2 = await _makeUiImage(width: 25, height: 25);
      const filter = ImageFilterModel(
        id: 'test-filter',
        matrixes: [
          [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0],
        ],
      );

      await tester.pumpWidget(MaterialApp(
        home: SuperFilteredImage(
          width: 20,
          height: 20,
          pic: image1,
          loading: false,
          filterModel: filter,
        ),
      ));
      await tester.pump();
      await tester.pump();

      await tester.pumpWidget(MaterialApp(
        home: SuperFilteredImage(
          width: 25,
          height: 25,
          pic: image2,
          loading: false,
          filterModel: filter,
        ),
      ));
      await tester.pump();
      await tester.pump();

      expect(find.byType(ColorFiltered), findsNWidgets(filter.matrixes.length));
    });

  });

}
