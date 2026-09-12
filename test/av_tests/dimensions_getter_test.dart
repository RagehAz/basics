import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:basics/av/av.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds a real, valid PNG of the given size by rendering a filled
/// rectangle and encoding it -- avoids hardcoding a base64 blob while still
/// exercising the actual native decode path.
Future<Uint8List> _makePngBytes({required int width, required int height}) async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder);
  canvas.drawRect(
    ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    ui.Paint()..color = const ui.Color(0xFFFF0000),
  );
  final ui.Picture picture = recorder.endRecording();
  final ui.Image image = await picture.toImage(width, height);
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  group('DimensionsGetter.fromBytes', () {

    test('Returns the correct width and height for a non-square image', () async {
      final bytes = await _makePngBytes(width: 40, height: 20);
      final result = await DimensionsGetter.fromBytes(bytes: bytes, isVideo: false, invoker: 'test');

      expect(result?.width, 40);
      expect(result?.height, 20);
    });

    test('Does not swap width and height', () async {
      final bytes = await _makePngBytes(width: 15, height: 60);
      final result = await DimensionsGetter.fromBytes(bytes: bytes, isVideo: false, invoker: 'test');

      expect(result?.width, 15);
      expect(result?.height, 60);
    });

    test('Returns a square image correctly', () async {
      final bytes = await _makePngBytes(width: 32, height: 32);
      final result = await DimensionsGetter.fromBytes(bytes: bytes, isVideo: false, invoker: 'test');

      expect(result?.width, 32);
      expect(result?.height, 32);
    });

    test('Returns null for null bytes', () async {
      final result = await DimensionsGetter.fromBytes(bytes: null, isVideo: false, invoker: 'test');
      expect(result, isNull);
    });

    test('Returns null for undecodable bytes', () async {
      final result = await DimensionsGetter.fromBytes(
        bytes: Uint8List.fromList([1, 2, 3, 4, 5]),
        isVideo: false,
        invoker: 'test',
      );
      expect(result, isNull);
    });

  });

}
