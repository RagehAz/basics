import 'package:basics/av/src/e_av_playing/super_video_player/super_video_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('SuperVideoScale.getHeightOnScreen / getWidthOnScreen / getDimsOnScreen', () {

    test('getHeightOnScreen matches getDimsOnScreen.height for a landscape video', () {
      final dims = SuperVideoScale.getDimsOnScreen(
        videoWidth: 1920,
        videoHeight: 1080,
        canvasWidth: 400,
        canvasHeight: 400,
      );
      final height = SuperVideoScale.getHeightOnScreen(
        videoWidth: 1920,
        videoHeight: 1080,
        canvasWidth: 400,
        canvasHeight: 400,
      );
      expect(height, dims.height ?? 0);
    });

    test('getWidthOnScreen matches getDimsOnScreen.width for a landscape video', () {
      final dims = SuperVideoScale.getDimsOnScreen(
        videoWidth: 1920,
        videoHeight: 1080,
        canvasWidth: 400,
        canvasHeight: 400,
      );
      final width = SuperVideoScale.getWidthOnScreen(
        videoWidth: 1920,
        videoHeight: 1080,
        canvasWidth: 400,
        canvasHeight: 400,
      );
      expect(width, dims.width ?? 0);
    });

    test('getHeightOnScreen/getWidthOnScreen stay consistent for a portrait video', () {
      final dims = SuperVideoScale.getDimsOnScreen(
        videoWidth: 1080,
        videoHeight: 1920,
        canvasWidth: 400,
        canvasHeight: 400,
      );
      expect(SuperVideoScale.getHeightOnScreen(videoWidth: 1080, videoHeight: 1920, canvasWidth: 400, canvasHeight: 400), dims.height ?? 0);
      expect(SuperVideoScale.getWidthOnScreen(videoWidth: 1080, videoHeight: 1920, canvasWidth: 400, canvasHeight: 400), dims.width ?? 0);
    });

    test('getHeightOnScreen/getWidthOnScreen stay consistent for a square video', () {
      final dims = SuperVideoScale.getDimsOnScreen(
        videoWidth: 500,
        videoHeight: 500,
        canvasWidth: 300,
        canvasHeight: 200,
      );
      expect(SuperVideoScale.getHeightOnScreen(videoWidth: 500, videoHeight: 500, canvasWidth: 300, canvasHeight: 200), dims.height ?? 0);
      expect(SuperVideoScale.getWidthOnScreen(videoWidth: 500, videoHeight: 500, canvasWidth: 300, canvasHeight: 200), dims.width ?? 0);
    });

    test('Fitted dimensions never exceed the canvas size (contain fit)', () {
      final dims = SuperVideoScale.getDimsOnScreen(
        videoWidth: 1920,
        videoHeight: 1080,
        canvasWidth: 200,
        canvasHeight: 200,
      );
      expect((dims.width ?? 0) <= 200, isTrue);
      expect((dims.height ?? 0) <= 200, isTrue);
    });

    test('A landscape video fitted in a square canvas is width-constrained', () {
      final dims = SuperVideoScale.getDimsOnScreen(
        videoWidth: 1920,
        videoHeight: 1080,
        canvasWidth: 200,
        canvasHeight: 200,
      );
      expect(dims.width, 200);
    });

    test('A square video fitted in its own exact size stays unchanged', () {
      final dims = SuperVideoScale.getDimsOnScreen(
        videoWidth: 100,
        videoHeight: 100,
        canvasWidth: 100,
        canvasHeight: 100,
      );
      expect(dims.width, 100);
      expect(dims.height, 100);
    });

  });

}
