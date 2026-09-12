import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:basics/filing/filing.dart';
import 'package:flutter_test/flutter_test.dart';

Future<Uint8List> _makePngBytes() async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder);
  canvas.drawRect(
    const ui.Rect.fromLTWH(0, 0, 10, 10),
    ui.Paint()..color = const ui.Color(0xFF0000FF),
  );
  final ui.Picture picture = recorder.endRecording();
  final ui.Image image = await picture.toImage(10, 10);
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  group('Decoding.checkImageIsDecodable', () {

    test('Returns true for a real PNG', () async {
      final bytes = await _makePngBytes();
      expect(Decoding.checkImageIsDecodable(bytes: bytes), isTrue);
    });

    test('Returns true (pre-existing quirk) when findDecoderForData throws instead of returning null', () {
      /// _output defaults to true and the catch clause silently swallows
      /// any thrown error without resetting it -- confirmed via probe that
      /// this is the exact same behavior as the original async-wrapped
      /// version (img.findDecoderForData throws a RangeError on bytes too
      /// short to sniff a format from, rather than returning null), so this
      /// isn't something introduced by the sync/async refactor.
      final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      expect(Decoding.checkImageIsDecodable(bytes: bytes), isTrue);
    });

    test('Returns true (the documented default) for null bytes', () {
      expect(Decoding.checkImageIsDecodable(bytes: null), isTrue);
    });

  });

  group('Decoding.getImageDecoderFromBytes', () {

    test('Returns a non-null decoder for a real PNG', () async {
      final bytes = await _makePngBytes();
      expect(Decoding.getImageDecoderFromBytes(bytes: bytes), isNotNull);
    });

    test('Returns null for garbage bytes', () {
      final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      expect(Decoding.getImageDecoderFromBytes(bytes: bytes), isNull);
    });

    test('Returns null for null bytes', () {
      expect(Decoding.getImageDecoderFromBytes(bytes: null), isNull);
    });

  });

}
