import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:basics/filing/filing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

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

  group('Imager.resizeImgImage', () {

    test('Resizes an image to the requested width and height', () async {
      final bytes = await _makePngBytes(width: 40, height: 20);
      final imgImage = await Imager.getImgImageFromUint8List(bytes);

      final resized = await Imager.resizeImgImage(imgImage: imgImage, width: 10, height: 5);

      expect(resized?.width, 10);
      expect(resized?.height, 5);
    });

    test('Works when upscaling', () async {
      final bytes = await _makePngBytes(width: 10, height: 10);
      final imgImage = await Imager.getImgImageFromUint8List(bytes);

      final resized = await Imager.resizeImgImage(imgImage: imgImage, width: 50, height: 50);

      expect(resized?.width, 50);
      expect(resized?.height, 50);
    });

    test('Returns null when imgImage is null', () async {
      final resized = await Imager.resizeImgImage(imgImage: null, width: 10, height: 10);
      expect(resized, isNull);
    });

    test('Preserves image content (not blank) after resize', () async {
      final bytes = await _makePngBytes(width: 20, height: 20);
      final imgImage = await Imager.getImgImageFromUint8List(bytes);

      final resized = await Imager.resizeImgImage(imgImage: imgImage, width: 5, height: 5);

      final img.Pixel centerPixel = resized!.getPixel(2, 2);
      expect(centerPixel.r, greaterThan(0));
    });

  });

}
