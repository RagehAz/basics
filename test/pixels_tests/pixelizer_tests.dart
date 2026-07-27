import 'package:basics/helpers/pixels/pixelizer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

int? _byte(double? component) => component == null ? null : (component * 255.0).round();

img.Pixel _makePixel({
  required int r,
  required int g,
  required int b,
  required int a,
}) {
  final image = img.Image(width: 1, height: 1);
  image.setPixelRgba(0, 0, r, g, b, a);
  return image.getPixel(0, 0);
}

void main() {

  group('Pixelizer getPixelColor', () {
    test('Returns null for a null pixel', () {
      final result = Pixelizer.getPixelColor(pixel: null);
      expect(result, null);
    });

    test('Maps an 8-bit pixel channel-for-channel onto a Color', () {
      final pixel = _makePixel(r: 255, g: 0, b: 128, a: 64);
      final result = Pixelizer.getPixelColor(pixel: pixel);
      expect(_byte(result?.r), 255);
      expect(_byte(result?.g), 0);
      expect(_byte(result?.b), 128);
      expect(_byte(result?.a), 64);
    });

    test('Maps an all-zero pixel to fully transparent black', () {
      final pixel = _makePixel(r: 0, g: 0, b: 0, a: 0);
      final result = Pixelizer.getPixelColor(pixel: pixel);
      expect(_byte(result?.r), 0);
      expect(_byte(result?.g), 0);
      expect(_byte(result?.b), 0);
      expect(_byte(result?.a), 0);
    });
  });
}
