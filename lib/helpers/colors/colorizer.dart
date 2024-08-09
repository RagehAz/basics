// ignore_for_file: non_constant_identifier_names
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/painting.dart';
import 'package:image/image.dart' as img;
import 'package:basics/helpers/checks/tracers.dart';
/// => TAMAM
class Colorizer {
  // -----------------------------------------------------------------------------

  const Colorizer();

  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color? decipherColor(String? colorString) {
    Color? _color;

    if (colorString != null) {
      /// reference ciphered color code
      // String _string = '${_alpha}*${_r}*${_g}*${_b}';

      /// ALPHA
      final String _a = TextMod.removeTextAfterFirstSpecialCharacter(
          text: colorString,
          specialCharacter: '*',
      )!;
      final int _alpha = Numeric.transformStringToInt(_a)!;

      /// RED
      final String _rX_gX_b = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: colorString,
          specialCharacter: '*',
      )!;
      final String _r = TextMod.removeTextAfterFirstSpecialCharacter(
          text: _rX_gX_b,
          specialCharacter: '*',
      )!;
      final int _red = Numeric.transformStringToInt(_r)!;

      /// GREEN
      final String _gX_b = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: _rX_gX_b,
          specialCharacter: '*',
      )!;
      final String _g = TextMod.removeTextAfterFirstSpecialCharacter(
          text: _gX_b,
          specialCharacter: '*',
      )!;
      final int _green = Numeric.transformStringToInt(_g)!;

      /// BLUE
      final String _b = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: _gX_b,
          specialCharacter: '*',
      )!;
      final int _blue = Numeric.transformStringToInt(_b)!;

      _color = Color.fromARGB(_alpha, _red, _green, _blue);
    }

    return _color;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherColor(Color? color) {

    if (color == null){
      return null;
    }

    else {

      final Color _color = color;
      final int _alpha = _color.alpha;
      final int _r = _color.red;
      final int _g = _color.green;
      final int _b = _color.blue;

      /// PLAN : CREATE FUNCTION THAT VALIDATES THIS REGEX PATTERN ON DECIPHER COLOR METHOD
      final String _string = '$_alpha*$_r*$_g*$_b';
      return _string;

    }

  }
  // -----------------------------------------------------------------------------

  /// CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color createRandomColor(){
    final int _red = Numeric.createRandomIndex(listLength: 256);
    final int _green = Numeric.createRandomIndex(listLength: 256);
    final int _blue = Numeric.createRandomIndex(listLength: 256);
    final int _alpha = Numeric.createRandomIndex(listLength: 256);
    final Color _color = Color.fromARGB(_alpha, _red, _green, _blue);
    return _color;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color? createRandomColorFromColors({
    required List<Color>? colors,
  }) {
    if (colors != null && colors.isNotEmpty == true){
    final int _randomIndex = math.Random().nextInt(colors.length);
    return colors[_randomIndex];

    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool checkColorIsBlack(Color? color) {
    bool _isBlack = false;

    const Color _black = Color.fromARGB(255, 0, 0, 0);

    if (color != null &&
        color.red == _black.red &&
        color.green == _black.green &&
        color.blue == _black.blue) {
      _isBlack = true;
    }

    return _isBlack;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkColorsAreIdentical(Color? color1, Color? color2) {
    bool _areIdentical = false;

    if (color1 == null && color2 == null){
      _areIdentical = true;
    }
    else if (color1 != null && color2 != null){

      if (
          color1.alpha == color2.alpha &&
          color1.red == color2.red &&
          color1.green == color2.green &&
          color1.blue == color2.blue
      ) {
        _areIdentical = true;
      }

    }


    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// AVERAGE COLOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Color?> getAverageColor(Uint8List? bytes) async {
    Color? _color;

    if (bytes != null){

      final img.Image? bitmap = await Imager.getImgImageFromUint8List(bytes);

      if (bitmap != null) {
        double redBucket = 0;
        double greenBucket = 0;
        double blueBucket = 0;
        double pixelCount = 0;

        for (int y = 0; y < bitmap.height; y++) {
          for (int x = 0; x < bitmap.width; x++) {
            final img.Pixel pixel = bitmap.getPixel(x, y);

            pixelCount++;
            redBucket += pixel.r;
            greenBucket += pixel.g;
            blueBucket += pixel.b;
          }
        }

        _color = Color.fromRGBO(
            redBucket ~/ pixelCount, greenBucket ~/ pixelCount, blueBucket ~/ pixelCount, 1);
      }
    }

    return _color;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Color?> getAverageColorFromXFile(XFile? file) async {
    Color? _output;

    if (file != null){
      final Uint8List? _bytes = await Byter.fromXFile(file, 'getAverageColorFromXFile');
      _output = await getAverageColor(_bytes);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Color?> getAverageColorFromSuperFile(SuperFile? file) async {
    Color? _output;

    if (file != null){
      final Uint8List? _bytes = await Byter.fromSuperFile(file);
      _output = await getAverageColor(_bytes);
    }

    return _output;
  }
  // ------------------------------------------------------------------------------

  /// BLUR

  // --------------------
  /// TESTED : WORKS PERFECT
  static ui.ImageFilter createBlurFilter({
    required bool isOn,
  }) {
    final double blueValue = isOn == true ? 8 : 0;

    final ui.ImageFilter blur = ui.ImageFilter.blur(
      sigmaX: blueValue,
      sigmaY: blueValue,
    );

    return blur;
  }
  // -----------------------------------------------------------------------------

  /// DESATURATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static ColorFilter desaturationColorFilter({
    required bool isItBlackAndWhite,
    Color geryColor = const Color.fromARGB(255, 200, 200, 200),
  }) {

    /// if i want to black and white a widget, put it as child in here
    /// child: ColorFiltered(
    ///     colorFilter: superDesaturation(blackAndWhite),
    ///     child: ,

    final Color imageSaturationColor = isItBlackAndWhite == true ?
    geryColor
        :
    const Color.fromARGB(0, 255, 255, 255);

    return ColorFilter.mode(imageSaturationColor, BlendMode.saturation);
  }
  // -----------------------------------------------------------------------------

  /// HEX

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? convertColorToHex(Color? color) {
    if (color == null){
      return null;
    }
    else {

      final int red = (color.value >> 16) & 0xFF;
      final int green = (color.value >> 8) & 0xFF;
      final int blue = color.value & 0xFF;

      return '#${red.toRadixString(16).padLeft(2, '0')}'
              '${green.toRadixString(16).padLeft(2, '0')}'
              '${blue.toRadixString(16).padLeft(2, '0')}'.toUpperCase();

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color? convertHexToColor(String? hex) {

    if (hex == null){
      return null;
    }
    else {
      return Color(int.parse(hex.replaceFirst('#', '0x')));
    }

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  ///
  static void blogColor(Color? color){
    blog('Color.r(${color?.red}).g(${color?.green}).b(${color?.blue}).o(${color?.opacity})');
  }
  // -----------------------------------------------------------------------------
}
