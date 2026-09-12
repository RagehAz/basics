import 'package:basics/helpers/colors/colorizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

int _byte(double component) => (component * 255.0).round();

void main() {

  group('Colorizer cipherColor / decipherColor', () {
    test('Returns null when ciphering a null color', () {
      final result = Colorizer.cipherColor(null);
      expect(result, null);
    });

    test('Ciphers a color into an alpha*red*green*blue string', () {
      const color = Color.fromARGB(255, 10, 20, 30);
      final result = Colorizer.cipherColor(color);
      expect(result, '255*10*20*30');
    });

    test('Returns null when decipherColor is called on null', () {
      final result = Colorizer.decipherColor(null);
      expect(result, null);
    });

    test('Deciphers a ciphered string back into an identical color', () {
      const color = Color.fromARGB(200, 1, 2, 3);
      final ciphered = Colorizer.cipherColor(color);
      final deciphered = Colorizer.decipherColor(ciphered);
      expect(Colorizer.checkColorsAreIdentical(color, deciphered), true);
    });
  });

  group('Colorizer createByInts / createByDoubles', () {
    test('createByInts builds a color from int channels and opacity', () {
      final result = Colorizer.createByInts(
        red: 10,
        green: 20,
        blue: 30,
        opacity: 1,
      );
      expect(_byte(result.r), 10);
      expect(_byte(result.g), 20);
      expect(_byte(result.b), 30);
      expect(_byte(result.a), 255);
    });

    test('createByDoubles truncates channels to ints', () {
      final result = Colorizer.createByDoubles(
        red: 10.9,
        green: 20.1,
        blue: 30.5,
        opacity: 1,
      );
      expect(_byte(result.r), 10);
      expect(_byte(result.g), 20);
      expect(_byte(result.b), 30);
    });
  });

  group('Colorizer createRandomColor / createRandomColorFromColors', () {
    test('createRandomColor produces channels within the 0-255 range', () {
      final result = Colorizer.createRandomColor();
      expect(_byte(result.r), inInclusiveRange(0, 255));
      expect(_byte(result.g), inInclusiveRange(0, 255));
      expect(_byte(result.b), inInclusiveRange(0, 255));
      expect(_byte(result.a), inInclusiveRange(0, 255));
    });

    test('createRandomColorFromColors returns null for a null list', () {
      final result = Colorizer.createRandomColorFromColors(colors: null);
      expect(result, null);
    });

    test('createRandomColorFromColors returns null for an empty list', () {
      final result = Colorizer.createRandomColorFromColors(colors: []);
      expect(result, null);
    });

    test('createRandomColorFromColors picks a color from a single-item list', () {
      const color = Color.fromARGB(255, 5, 6, 7);
      final result = Colorizer.createRandomColorFromColors(colors: [color]);
      expect(Colorizer.checkColorsAreIdentical(result, color), true);
    });
  });

  group('Colorizer withOpacity', () {
    test('Applies opacity while preserving RGB channels', () {
      const color = Color.fromARGB(255, 40, 50, 60);
      final result = Colorizer.withOpacity(color: color, opacity: 0.5);
      expect(_byte(result.r), 40);
      expect(_byte(result.g), 50);
      expect(_byte(result.b), 60);
      expect(result.a, closeTo(0.5, 0.01));
    });
  });

  group('Colorizer checkColorIsBlack', () {
    test('Returns false for a null color', () {
      final result = Colorizer.checkColorIsBlack(null);
      expect(result, false);
    });

    test('Returns true for pure black', () {
      const black = Color.fromARGB(255, 0, 0, 0);
      final result = Colorizer.checkColorIsBlack(black);
      expect(result, true);
    });

    test('Ignores alpha when checking for black', () {
      const almostBlack = Color.fromARGB(0, 0, 0, 0);
      final result = Colorizer.checkColorIsBlack(almostBlack);
      expect(result, true);
    });

    test('Returns false for a non-black color', () {
      const white = Color.fromARGB(255, 255, 255, 255);
      final result = Colorizer.checkColorIsBlack(white);
      expect(result, false);
    });
  });

  group('Colorizer checkColorsAreIdentical', () {
    test('Returns true when both colors are null', () {
      final result = Colorizer.checkColorsAreIdentical(null, null);
      expect(result, true);
    });

    test('Returns false when only one color is null', () {
      const color = Color.fromARGB(255, 1, 1, 1);
      final result = Colorizer.checkColorsAreIdentical(color, null);
      expect(result, false);
    });

    test('Returns true for two colors with identical channels', () {
      const colorA = Color.fromARGB(100, 1, 2, 3);
      const colorB = Color.fromARGB(100, 1, 2, 3);
      final result = Colorizer.checkColorsAreIdentical(colorA, colorB);
      expect(result, true);
    });

    test('Returns false when a single channel differs', () {
      const colorA = Color.fromARGB(100, 1, 2, 3);
      const colorB = Color.fromARGB(100, 1, 2, 4);
      final result = Colorizer.checkColorsAreIdentical(colorA, colorB);
      expect(result, false);
    });
  });

  group('Colorizer convertColorToHex / convertHexToColor', () {
    test('convertColorToHex returns null for a null color', () {
      final result = Colorizer.convertColorToHex(null);
      expect(result, null);
    });

    test('convertColorToHex produces an uppercase hex string', () {
      const color = Color.fromARGB(255, 255, 0, 128);
      final result = Colorizer.convertColorToHex(color);
      expect(result, '#FF0080');
    });

    test('convertHexToColor returns null for a null hex string', () {
      final result = Colorizer.convertHexToColor(null);
      expect(result, null);
    });

    test('convertHexToColor rebuilds the same color from its hex string', () {
      const color = Color.fromARGB(255, 255, 0, 128);
      final hex = Colorizer.convertColorToHex(color);
      final rebuilt = Colorizer.convertHexToColor(hex);
      expect(rebuilt == null ? null : _byte(rebuilt.r), _byte(color.r));
      expect(rebuilt == null ? null : _byte(rebuilt.g), _byte(color.g));
      expect(rebuilt == null ? null : _byte(rebuilt.b), _byte(color.b));
    });
  });
}
