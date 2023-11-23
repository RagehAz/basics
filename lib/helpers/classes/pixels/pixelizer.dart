import 'dart:typed_data';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

class Pixelizer {
  // --------------------------------------------------------------------------

  const Pixelizer();

  // --------------------------------------------------------------------------

  /// SNAPSHOTTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> snapshotWidget({
    required GlobalKey? key,
  }) async {
    Uint8List? _output;

    if (key != null){
      final RenderRepaintBoundary? boxPaint = key.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final ui.Image? capture = await boxPaint?.toImage();
      _output = await Floaters.getBytesFromUiImage(capture);
      capture?.dispose();
    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static img.Pixel? getPixelFromGlobalPosition({
    required GlobalKey? key,
    required img.Image? image,
    required Offset? globalPosition,
    bool scaleToImage = false,
  }){
    img.Pixel? _output;

    if (image != null && key != null && globalPosition != null){

      final RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
      final Offset localPosition = box.globalToLocal(globalPosition);

      double? px = localPosition.dx;
      double? py = localPosition.dy;

      if (scaleToImage == true) {
        final double widgetScale = box.size.width / image.width;
        px = px / widgetScale;
        py = py / widgetScale;
      }

      _output = image.getPixelSafe(px.toInt(), py.toInt());

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color? getPixelColor({
    required img.Pixel? pixel,
  }) {

    if (pixel == null) {
      return null;
    }

    else {
      return Color.fromARGB(
        pixel.a.toInt(),
        pixel.r.toInt(),
        pixel.g.toInt(),
        pixel.b.toInt(),
      );
    }

  }
  // --------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPixel(img.Pixel? pixel) {

    if (pixel == null) {
      blog('The pixel is null');
    }

    else {
      blog('------> PIXEL BLOG START <------');
      blog('pixel.toString() : $pixel');
      blog('pixel.x : ${pixel.x}');
      blog('pixel.y : ${pixel.y}');
      blog('pixel.height : ${pixel.height}');
      blog('pixel.width : ${pixel.width}');
      blog('pixel.length : ${pixel.length}');
      blog('pixel.isValid : ${pixel.isValid}');
      blog('pixel.xNormalized : ${pixel.xNormalized}');
      blog('pixel.yNormalized : ${pixel.yNormalized}');
      blog('pixel.hasPalette : ${pixel.hasPalette}');
      blog('pixel.isHdrFormat : ${pixel.isHdrFormat}');
      blog('pixel.isLdrFormat : ${pixel.isLdrFormat}');
      blog('pixel.luminance : ${pixel.luminance}');
      blog('pixel.luminanceNormalized : ${pixel.luminanceNormalized}');
      blog('pixel.format : ${pixel.format}');
      blog('pixel.palette?.format.index : ${pixel.palette?.format.index}');
      blog('pixel.palette?.format.name : ${pixel.palette?.format.name}');
      blog('pixel.palette?.numColors : ${pixel.palette?.numColors}');
      blog('pixel.image : ${pixel.image}');
      blog('------> PIXEL BLOG END <------');
    }

  }
  // --------------------------------------------------------------------------
}
