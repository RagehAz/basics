// ignore_for_file: avoid_redundant_argument_values
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/trigonometer.dart';
import 'package:basics/helpers/strings/idifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math' as math;
import 'package:basics/helpers/nums/booler.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// formatNumToSeparatedKilos

  // --------------------
  group('formatNumToSeparatedKilos() tests', () {
    test('returns the correct string for int values less than 1000', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 999), '999');
      expect(Numeric.formatNumToSeparatedKilos(number: 123), '123');
    });

    test('returns the correct string for int values greater than 1000', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 123456), "123'456");
      expect(Numeric.formatNumToSeparatedKilos(number: 123456789), "123'456'789");
    });

    test('returns the correct string for double values with 2 decimal places', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 123456.78), "123'456.78");
      expect(Numeric.formatNumToSeparatedKilos(number: 123456.789), "123'456.79");
    });

    test('returns the correct string for negative values', () {
      expect(Numeric.formatNumToSeparatedKilos(number: -123456), "-123'456");
      expect(Numeric.formatNumToSeparatedKilos(number: -123456.78), "-123'456.78");
    });

    test('returns the correct string when separator is set to a custom value', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 123456, separator: ':'), '123:456');
      expect(Numeric.formatNumToSeparatedKilos(number: 123456.78, separator: ':'),
          '123:456.78');
    });

    test('returns the correct string for double values with 4 decimal places', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 123456.789, fractions: 4),
          "123'456.789");
    });

    test('returns the correct string for double values with 0 decimal places', () {
      expect(
          Numeric.formatNumToSeparatedKilos(number: 123456.789, fractions: 0), "123'457");
    });

    test('returns the correct string for negative double values with 2 decimal places', () {
      expect(Numeric.formatNumToSeparatedKilos(number: -123456.789), "-123'456.79");
    });

    test('returns the correct string for positive int values', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 123456), "123'456");
    });

    test('returns the correct string for negative int values', () {
      expect(Numeric.formatNumToSeparatedKilos(number: -123456), "-123'456");
    });

    test('returns the correct string for values close to 0', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 0), '0');
      expect(Numeric.formatNumToSeparatedKilos(number: 0.0001), '0');
      expect(Numeric.formatNumToSeparatedKilos(number: -0.0001), '0');
    });

    test('returns the correct string for values close to 1000', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 1000), "1'000");
      expect(Numeric.formatNumToSeparatedKilos(number: 999.9999), "1'000");
      expect(Numeric.formatNumToSeparatedKilos(number: -999.9999), "-1'000");
    });

    test('null case', () {
      expect(Numeric.formatNumToSeparatedKilos(number: null), '0');
    });

    /// --------------------------------------------------------------------
    /// EXPANDED COVERAGE -- explicit boundary values around every power of
    /// 1000, verified by hand (not by re-running the code under test).
    /// --------------------------------------------------------------------

    test('boundary: exactly at every power-of-1000 threshold (positive)', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 999, fractions: 0), '999');
      expect(Numeric.formatNumToSeparatedKilos(number: 1000, fractions: 0), "1'000");
      expect(Numeric.formatNumToSeparatedKilos(number: 999999, fractions: 0), "999'999");
      expect(Numeric.formatNumToSeparatedKilos(number: 1000000, fractions: 0), "1'000'000");
      expect(Numeric.formatNumToSeparatedKilos(number: 999999999, fractions: 0), "999'999'999");
      expect(Numeric.formatNumToSeparatedKilos(number: 1000000000, fractions: 0),
          "1'000'000'000");
    });

    test('boundary: exactly at every power-of-1000 threshold (negative)', () {
      expect(Numeric.formatNumToSeparatedKilos(number: -999, fractions: 0), '-999');
      expect(Numeric.formatNumToSeparatedKilos(number: -1000, fractions: 0), "-1'000");
      expect(Numeric.formatNumToSeparatedKilos(number: -999999, fractions: 0), "-999'999");
      expect(Numeric.formatNumToSeparatedKilos(number: -1000000, fractions: 0), "-1'000'000");
    });

    test('groups a 1-digit remainder correctly (leading group smaller than 3)', () {
      /// 7 digits: leading group is "1", then two full groups of 3.
      expect(Numeric.formatNumToSeparatedKilos(number: 1234567, fractions: 0), "1'234'567");
    });

    test('groups a 2-digit remainder correctly (leading group smaller than 3)', () {
      /// 8 digits: leading group is "12", then two full groups of 3.
      expect(Numeric.formatNumToSeparatedKilos(number: 12345678, fractions: 0), "12'345'678");
    });

    test('groups an exact multiple of 3 digits correctly (leading group is full)', () {
      /// 9 digits: three full groups of 3, no partial leading group.
      expect(Numeric.formatNumToSeparatedKilos(number: 123456789, fractions: 0), "123'456'789");
    });

    test('works with an empty-string separator (no visual grouping, but no crash)', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 123456789, fractions: 0, separator: ''),
          '123456789');
    });

    test('works with a multi-character separator', () {
      expect(
          Numeric.formatNumToSeparatedKilos(number: 123456789, fractions: 0, separator: ' - '),
          '123 - 456 - 789');
    });

    test('works with a space separator', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 123456789, fractions: 0, separator: ' '),
          '123 456 789');
    });

    test('works with a unicode separator (Arabic thousands separator)', () {
      expect(
          Numeric.formatNumToSeparatedKilos(number: 123456789, fractions: 0, separator: '٬'),
          '123٬456٬789');
    });

    test('does not pad the fraction string when it is naturally shorter than `fractions`', () {
      /// 123456.789 already has 3 significant decimal digits; asking for 4
      /// does not pad it to "7890" -- it stays "789" (documents the
      /// underlying getFractionStringWithoutZero behavior: trims from the
      /// end when longer than requested, never pads when shorter).
      expect(Numeric.formatNumToSeparatedKilos(number: 123456.789, fractions: 4),
          "123'456.789");
    });

    test('drops a trailing zero fraction produced by rounding', () {
      /// 123456.70 rounds cleanly and Dart's double.toString() drops the
      /// trailing zero ("123456.7"), so only one fraction digit shows.
      expect(Numeric.formatNumToSeparatedKilos(number: 123456.70, fractions: 2),
          "123'456.7");
    });

    test('omits the fraction entirely when it rounds to all zeros', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 123456.001, fractions: 2), "123'456");
      expect(Numeric.formatNumToSeparatedKilos(number: 123000.00, fractions: 2), "123'000");
    });

    test('handles a very large number within double-integer precision', () {
      /// 10 digits: four groups (1 + 3 + 3 + 3).
      expect(Numeric.formatNumToSeparatedKilos(number: 1234567890, fractions: 0),
          "1'234'567'890");
    });

    test('handles single- and double-digit numbers (no grouping needed)', () {
      expect(Numeric.formatNumToSeparatedKilos(number: 5, fractions: 0), '5');
      expect(Numeric.formatNumToSeparatedKilos(number: 42, fractions: 0), '42');
      expect(Numeric.formatNumToSeparatedKilos(number: -7, fractions: 0), '-7');
    });

    /// --------------------------------------------------------------------
    /// PROPERTY-BASED CHECK -- verifies the thousands-grouping algorithm's
    /// mathematical invariant directly (separator placement + digit
    /// preservation), independent of the fraction-formatting quirks above,
    /// across many random integers and several separators. This does not
    /// re-implement the function under test -- it checks a property that
    /// must hold for ANY correct grouping, however it's implemented.
    /// --------------------------------------------------------------------

    /// splits a digit string into groups of (at most) 3, counting from the
    /// right -- e.g. "1234567" -> ["1", "234", "567"].
    List<String> expectedGroupsFromRight(String digits) {
      final List<String> groups = [];
      int end = digits.length;
      while (end > 0) {
        final int start = (end - 3) > 0 ? end - 3 : 0;
        groups.insert(0, digits.substring(start, end));
        end = start;
      }
      return groups;
    }

    test('property: separators land every 3 digits from the right, for many random integers', () {
      final random = math.Random(2026);

      for (final separator in ["'", ':', ' ', '_', '-']) {
        for (int i = 0; i < 500; i++) {
          /// stays well within double-integer precision (2^53) so no
          /// floating-point artifacts leak into the comparison.
          final int magnitude = random.nextInt(999999999) + 1;
          final int signedNumber = random.nextBool() ? magnitude : -magnitude;

          final String result = Numeric.formatNumToSeparatedKilos(
            number: signedNumber,
            fractions: 0,
            separator: separator,
          );

          final bool isNegative = signedNumber < 0;
          final String digits = magnitude.toString();
          final String expected =
              (isNegative ? '-' : '') + expectedGroupsFromRight(digits).join(separator);

          expect(result, expected,
              reason: 'formatNumToSeparatedKilos(number: $signedNumber, separator: "$separator")');
        }
      }
    });

    test('property: stripping the separator reproduces the original digits, for many random integers', () {
      final random = math.Random(99);

      for (int i = 0; i < 300; i++) {
        final int magnitude = random.nextInt(999999999) + 1;
        final int signedNumber = random.nextBool() ? magnitude : -magnitude;

        final String result = Numeric.formatNumToSeparatedKilos(
          number: signedNumber,
          fractions: 0,
          separator: "'",
        );

        final String digitsOnly = result.replaceAll("'", '').replaceAll('-', '');
        expect(digitsOnly, magnitude.toString(),
            reason: 'formatNumToSeparatedKilos(number: $signedNumber)');
        expect(result.startsWith('-'), signedNumber < 0,
            reason: 'formatNumToSeparatedKilos(number: $signedNumber)');
      }
    });
  });
  // -----------------------------------------------------------------------------

  /// formatNumToCounterCaliber

  // --------------------
  group('formatNumToCounterCaliber', () {
    test('0 returns 0', () {
      final result = Numeric.formatNumToCounterCaliber(x: 0);
      expect(result, '0');
    });

    test('999 returns 999', () {
      final result = Numeric.formatNumToCounterCaliber(x: 999);
      expect(result, '999');
    });

    test('1000 returns 1 thousand', () {
      final result = Numeric.formatNumToCounterCaliber(x: 1000);
      expect(result, '1 thousand');
    });

    test('1001 returns 1 thousand', () {
      final result = Numeric.formatNumToCounterCaliber(x: 1001);
      expect(result, '1 thousand');
    });

    test('1999 returns 2 thousand', () {
      final result = Numeric.formatNumToCounterCaliber(x: 1999);
      expect(result, '2 thousand');
    });

    test('99999 returns 100 thousand', () {
      final result = Numeric.formatNumToCounterCaliber(x: 99999);
      expect(result, '100 thousand');
    });

    test('100000 returns 100 thousand', () {
      final result = Numeric.formatNumToCounterCaliber(x: 100000);
      expect(result, '100 thousand');
    });

    test('1000000 returns 1 million', () {
      final result = Numeric.formatNumToCounterCaliber(x: 1000000);
      expect(result, '1 million');
    });

    test('10000000 returns 10 million', () {
      final result = Numeric.formatNumToCounterCaliber(x: 10000000);
      expect(result, '10 million');
    });

    test('custom thousands and millions returns custom values', () {
      final result = Numeric.formatNumToCounterCaliber(x: 1000, thousand: 'k', million: 'm');
      expect(result, '1 k');

      final result2 = Numeric.formatNumToCounterCaliber(x: 1000000, thousand: 'k', million: 'm');
      expect(result2, '1 m');
    });

    /// --------------------------------------------------------------------
    /// REGRESSION -- these numbers used to be silently corrupted by an
    /// unescaped '.' in a RegExp (matched ANY character, not just a
    /// literal dot), which deleted the wrong 3 characters whenever the
    /// calibrated value's integer part contained an internal "0<digit>0"
    /// substring not touching the decimal point.
    /// --------------------------------------------------------------------

    test('does not corrupt a million-range value with an internal "0X0" digit pattern', () {
      /// x / 1e6 = 1030.0 -- old buggy regex matched "030" (chars 1-3 of
      /// "1030.0"), turning "1030 million" into "10 million".
      expect(Numeric.formatNumToCounterCaliber(x: 1030000000), '1030 million');
    });

    test('does not corrupt several other "0X0"-pattern billions', () {
      expect(Numeric.formatNumToCounterCaliber(x: 2050000000), '2050 million');
      expect(Numeric.formatNumToCounterCaliber(x: 5060000000), '5060 million');
      expect(Numeric.formatNumToCounterCaliber(x: 1090000000), '1090 million');
      expect(Numeric.formatNumToCounterCaliber(x: 3010000000), '3010 million');
    });

    test('keeps a genuine non-zero fraction on a value with a "0X0" digit pattern', () {
      /// x / 1e6 = 1030.5 -- the fraction is real (not a trailing ".0"),
      /// so it must survive.
      expect(Numeric.formatNumToCounterCaliber(x: 1030500000), '1030.5 million');
    });

    test('boundary: last thousand-branch value vs first "round to thousand" value', () {
      expect(Numeric.formatNumToCounterCaliber(x: 99994), '100 thousand');
      expect(Numeric.formatNumToCounterCaliber(x: 99995), '100 thousand');
    });

    test('boundary: last "round to thousand" value vs first million-branch value', () {
      expect(Numeric.formatNumToCounterCaliber(x: 999444), '999 thousand');
      expect(Numeric.formatNumToCounterCaliber(x: 999445), '1 million');
    });

    /// --------------------------------------------------------------------
    /// PROPERTY-BASED CHECK -- for many random values landing in the
    /// million branch (including ones deliberately constructed to contain
    /// an internal "0<digit>0" pattern), verifies the numeric prefix of
    /// the result, scaled back up by 1e6, reconstructs the original value
    /// within the rounding tolerance the formatter itself uses (1 decimal
    /// place on the millions figure = up to 50,000 either way). This
    /// directly catches any digit-corruption bug, independent of hardcoded
    /// expected strings.
    /// --------------------------------------------------------------------

    test('property: the million-branch numeric prefix always reconstructs the original value', () {
      final random = math.Random(7);

      for (int i = 0; i < 500; i++) {
        /// bias towards constructing "0<digit>0" internal patterns (the
        /// bug trigger) alongside plain random values.
        final int millions = random.nextBool()
            ? (random.nextInt(9) + 1) * 1000 + random.nextInt(10) * 10 // e.g. 1030, 5060, 9090
            : random.nextInt(9000) + 1000; // plain random 4-digit millions
        final int x = millions * 1000000 + 999445; // stays safely in the million branch

        final String result = Numeric.formatNumToCounterCaliber(x: x);
        expect(result.endsWith(' million'), true, reason: 'x=$x result=$result');

        final String numericPart = result.replaceAll(' million', '');
        final double parsedMillions = double.parse(numericPart);

        expect((parsedMillions - x / 1000000).abs(), lessThan(0.06),
            reason: 'x=$x result=$result parsedMillions=$parsedMillions');
      }
    });
  });
  // -----------------------------------------------------------------------------

  /// formatNumToCounterCaliber

  // --------------------
  group('Numeric.formatNumberWithinDigits tests', () {
    test('Case 1: Format 0 within 4 digits', () {
      const int num = 0;
      const int digits = 4;
      const String expectedResult = '0000';

      final String? result = Numeric.formatIntWithinDigits(num: num, digits: digits);

      expect(result, expectedResult);
    });

    test('Case 2: Format 100 within 4 digits', () {
      const int num = 100;
      const int digits = 4;
      const String expectedResult = '0100';

      final String? result = Numeric.formatIntWithinDigits(num: num, digits: digits);

      expect(result, expectedResult);
    });

    test('Case 3: Format 10 within 4 digits', () {
      const int num = 10;
      const int digits = 4;
      const String expectedResult = '0010';

      final String? result = Numeric.formatIntWithinDigits(num: num, digits: digits);

      expect(result, expectedResult);
    });

    test('Case 4: Format 9999 within 4 digits', () {
      const int num = 9999;
      const int digits = 4;
      const String expectedResult = '9999';

      final String? result = Numeric.formatIntWithinDigits(num: num, digits: digits);

      expect(result, expectedResult);
    });

    test('Case 5: Format 10000 within 4 digits', () {
      const int num = 10000;
      const int digits = 4;
      const String expectedResult = 'XXXX';

      final String? result = Numeric.formatIntWithinDigits(num: num, digits: digits);

      expect(result, expectedResult);
    });
  });
  // -----------------------------------------------------------------------------

  /// concludeNumberOfDigits

  // --------------------
  group('concludeNumberOfDigits', () {
    test('returns 0 for negative or null input', () {
      expect(Numeric.concludeNumberOfDigits(-5), 1);
      expect(Numeric.concludeNumberOfDigits(null), 0);
    });

    test('returns 1 for input 1', () {
      expect(Numeric.concludeNumberOfDigits(1), 1);
    });

    test('returns 1 for input 10', () {
      expect(Numeric.concludeNumberOfDigits(10), 2);
    });

    test('returns 2 for input 100', () {
      expect(Numeric.concludeNumberOfDigits(100), 3);
    });

    test('returns the number of digits minus 1', () {
      expect(Numeric.concludeNumberOfDigits(12345), 5);
    });
  });
  // -----------------------------------------------------------------------------

  /// formatIndexDigits

  // --------------------
  group('Numeric.formatIndexDigits', () {
    test('returns correct format for index 0 with list length 1', () {
      expect(Numeric.formatIndexDigits(index: 0, listLength: 1), '0');
    });

    test('returns correct format for index 0 with list length 10', () {
      expect(Numeric.formatIndexDigits(index: 0, listLength: 10), '00');
    });

    test('returns correct format for index 1 with list length 10', () {
      expect(Numeric.formatIndexDigits(index: 1, listLength: 10), '01');
    });

    test('returns correct format for index 11 with list length 100', () {
      expect(Numeric.formatIndexDigits(index: 11, listLength: 100), '011');
    });

    test('returns correct format for index 100 with list length 1000', () {
      expect(Numeric.formatIndexDigits(index: 100, listLength: 1000), '0100');
    });
  });
  // -----------------------------------------------------------------------------

  /// formatIndexDigits

  // --------------------
  group('transformStringToInt', () {
    test('returns null for null input', () {
      expect(Numeric.transformStringToInt(null), null);
    });

    test('returns null for non-integer string input', () {
      expect(Numeric.transformStringToInt('abc'), null);
    });

    test('returns integer value for integer string input', () {
      expect(Numeric.transformStringToInt('123'), 123);
    });

    test('returns integer value for negative integer string input', () {
      expect(Numeric.transformStringToInt('-123'), -123);
    });

    test('returns integer value for negative integer string input', () {
      expect(Numeric.transformStringToInt('-123.25'), -123);
    });

    test('returns integer value for negative integer string input', () {
      expect(Numeric.transformStringToInt('0.0'), 0);
    });

    test('returns integer value for negative integer string input', () {
      expect(Numeric.transformStringToInt('0'), 0);
    });

    test('returns integer value for negative integer string input', () {
      expect(Numeric.transformStringToInt('0.1'), 0);
    });

    test('returns integer value for negative integer string input', () {
      expect(Numeric.transformStringToInt('0.9'), 0);
    });

    test('returns integer value for negative integer string input', () {
      expect(Numeric.transformStringToInt('10.99'), 10);
    });
  });
  // -----------------------------------------------------------------------------

  /// transformStringToDouble

  // --------------------
  group('transformStringToDouble', () {
    test('returns a double when string is valid', () {
      const double expectedValue = 10.5;
      const String string = '10.5';

      final double? result = Numeric.transformStringToDouble(string);

      expect(result, expectedValue);
    });

    test('returns null when string is null', () {
      const String? string = null;

      final double? result = Numeric.transformStringToDouble(string);

      expect(result, null);
    });

    test('returns null when string is an empty string', () {
      const String string = '';

      final double? result = Numeric.transformStringToDouble(string);

      expect(result, null);
    });

    test('returns null when string is not a valid double', () {
      const String string = 'not a valid double';

      final double? result = Numeric.transformStringToDouble(string);

      expect(result, null);
    });

    test('a', () {
      const String string = '-125.25';

      final double? result = Numeric.transformStringToDouble(string);

      expect(result, -125.25);
    });

    test('b', () {
      const String string = '-0.0';

      final double? result = Numeric.transformStringToDouble(string);

      expect(result, 0);
    });
  });
  // -----------------------------------------------------------------------------

  /// createRandomIndex

  // --------------------
  group('createRandomIndex', () {
    test('returns a random index within the default list length of 1001', () {
      final int result = Indexer.createRandomIndex();

      expect(result, lessThan(1001));
    });

    test('returns a random index within the specified list length', () {
      const int listLength = 10;
      final int result = Indexer.createRandomIndex(listLength: listLength);

      expect(result, lessThan(listLength));
    });

    test('WILL NEVER FAIL', () {
      const int listLength = 5;

      for (int i = 0; i<500; i++){

        final int result = Indexer.createRandomIndex(listLength: listLength);
        expect(result, lessThan(listLength));

      }

    });

  });
  // -----------------------------------------------------------------------------

  /// createUniqueIndex

  // --------------------
  group('createUniqueIndex', () {
    test('returns a unique index within the max index of 999999', () {
      final List<int> existingIndexes = [];
      final int result = Indexer.createUniqueIndex(existingIndexes: existingIndexes);

      expect(result, lessThan(1000000));
      expect(existingIndexes.contains(result), isFalse);
    });

    test('returns a unique index within the specified max index', () {
      final List<int> existingIndexes = [];
      const int maxIndex = 10;
      final int result =
      Indexer.createUniqueIndex(existingIndexes: existingIndexes, maxIndex: maxIndex);

      expect(result, lessThan(maxIndex + 1));
      expect(existingIndexes.contains(result), isFalse);
    });

    test('returns a unique index when all possible indexes have been used', () {
      final List<int> existingIndexes = [0, 1, 2, 3, 4];
      const int maxIndex = 5;

      final int result = Indexer.createUniqueIndex(
        existingIndexes: existingIndexes,
        maxIndex: maxIndex,
      );

      expect(result, 5);
      expect(existingIndexes.contains(result), isFalse);
    });
  });
  // -----------------------------------------------------------------------------

  /// createUniqueID

  // --------------------
  group('createUniqueID', () {
    test('returns a unique ID with the default max digits count of 16', () {
      final int result = Idifier.createUniqueIDInteger();

      expect(result, greaterThan(0));
      expect(result
          .toString()
          .length, lessThanOrEqualTo(16));
    });

    test('returns a unique ID with the specified max digits count', () {
      const int maxDigitsCount = 10;
      final int result = Idifier.createUniqueIDInteger(maxDigitsCount: maxDigitsCount);

      expect(result, greaterThan(0));
      expect(result
          .toString()
          .length, lessThanOrEqualTo(maxDigitsCount));
    });
  });
  // -----------------------------------------------------------------------------

  /// createUniqueKeyFrom

  // --------------------
  /*
  group('createUniqueKeyFrom', () {

    test('returns a unique ValueKey with int value not in existing keys', () {
      final List<ValueKey<int>> existingKeys = [const ValueKey(1), const ValueKey(2)];
      final ValueKey<int> result = Numeric.createUniqueKeyFrom(existingKeys: existingKeys);

      expect(existingKeys, isNot(contains(result)));
    });

    test('returns a unique ValueKey with int value not in existing keys', () {
      final List<ValueKey<int>> existingKeys = [const ValueKey(1), const ValueKey(2)];
      final ValueKey<int> result = Numeric.createUniqueKeyFrom(existingKeys: existingKeys);

      expect(existingKeys, isNot(contains(result)));
    });

    test('returns a unique ValueKey even if all existing keys have been used', () {
      /// NOTE : IT THROWS STACK OVER FLOW WHEN LENGTH > 100000
      const int length = 99999;
      final List<ValueKey<int>> existingKeys = [for (int i = 0; i < length; i++) ValueKey(i)];
      final ValueKey<int> result = Numeric.createUniqueKeyFrom(
        existingKeys: existingKeys,
      );

      expect(result, null);
    });

    test('returns a unique ValueKey even if all existing keys have been used', () {
      /// NOTE : IT THROWS STACK OVER FLOW WHEN LENGTH > 100000
      const int length = 1000000;
      final List<ValueKey<int>> existingKeys = [for (int i = 0; i < length; i++) ValueKey(i)];
      final ValueKey<int> result = Numeric.createUniqueKeyFrom(
        existingKeys: existingKeys,
      );

      expect(result, throwsAssertionError);
    });

    test('throws an exception if existing keys list is empty', () {
      final List<ValueKey<int>> existingKeys = [];
      final ValueKey<int> result = Numeric.createUniqueKeyFrom(existingKeys: existingKeys);

      expect(result, isNot(contains(result)));
    });

  });

   */
  // -----------------------------------------------------------------------------

  /// createListWithDummyValue

  // --------------------
  /*
  group("createListWithDummyValue", () {
    test("returns list with given length", () {
      final list = Numeric.createListWithDummyValue(length: 5, value: 0);
      expect(list.length, 5);
    });

    test("returns list filled with given value", () {
      final list = Numeric.createListWithDummyValue(length: 5, value: 0);
      for (int i = 0; i < 5; i++) {
        expect(list[i], 0);
      }
    });

    // test("throws error when length argument is missing", () {
    //   expect(() => Numeric.createListWithDummyValue(value: 0), throwsAssertionError);
    // });
    //
    // test("throws error when value argument is missing", () {
    //   expect(() => Numeric.createListWithDummyValue(length: 5), throwsAssertionError);
    // });
  });
   */
  // -----------------------------------------------------------------------------

  /// createRandomIndexes

  // --------------------
  group('createRandomIndexes', () {
    test('returns list with given numberOfIndexes', () {
      final list = Indexer.createRandomIndexes(numberOfIndexes: 5, maxIndex: 10);
      expect(list.length, 5);
    });

    test('returns list filled with unique indexes', () {
      final list = Indexer.createRandomIndexes(numberOfIndexes: 5, maxIndex: 10);
      expect(Set<int>.from(list).length, 5);
    });

    test('returns list filled with indexes in the inclusive range [0, maxIndex]', () {
      final list = Indexer.createRandomIndexes(numberOfIndexes: 5, maxIndex: 10);
      for (final index in list) {
        expect(index, greaterThanOrEqualTo(0));
        expect(index, lessThanOrEqualTo(10));
      }
    });

    test('returns an empty list when numberOfIndexes is 0', () {
      final list = Indexer.createRandomIndexes(numberOfIndexes: 0, maxIndex: 10);
      expect(list, <int>[]);
    });

    test('returns unique indexes even when numberOfIndexes exhausts the whole range', () {
      /// maxIndex 4 => 5 possible values (0..4 inclusive); requesting all 5
      /// forces every collision-retry path to eventually succeed.
      final list = Indexer.createRandomIndexes(numberOfIndexes: 5, maxIndex: 4);
      expect(list.length, 5);
      expect(Set<int>.from(list).toList()..sort(), [0, 1, 2, 3, 4]);
    });

    test('stays correct across repeated calls (randomized, checked on invariants not values)', () {
      for (int i = 0; i < 20; i++) {
        final list = Indexer.createRandomIndexes(numberOfIndexes: 8, maxIndex: 50);
        expect(list.length, 8);
        expect(Set<int>.from(list).length, 8);
        for (final index in list) {
          expect(index, greaterThanOrEqualTo(0));
          expect(index, lessThanOrEqualTo(50));
        }
      }
    });

  });
  // -----------------------------------------------------------------------------

  /// cipherBool

  // --------------------
  group('cipherBool', () {
    test('returns 1 for true', () {
      final result = Booler.cipherBool(bool: true);
      expect(result, 1);
    });

    test('returns 0 for false', () {
      final result = Booler.cipherBool(bool: false);
      expect(result, 0);
    });

    test('returns 0 for any other value', () {
      final result = Booler.cipherBool(bool: null);
      expect(result, 0);
    });
  });
  // -----------------------------------------------------------------------------

  /// decipherBool

  // --------------------
  group('decipherBool', () {
    test('returns true for 1', () {
      final result = Booler.decipherBool(1);
      expect(result, true);
    });

    test('returns false for 0', () {
      final result = Booler.decipherBool(0);
      expect(result, false);
    });

    test('returns false for any other value', () {
      final result = Booler.decipherBool(2);
      expect(result, false);
    });
  });
  // -----------------------------------------------------------------------------

  /// getFractions

  // --------------------
  group('Numeric.getFractions', () {
    test('should return null when number is null', () {
      final result = Numeric.getFractions(number: null, fractionDigits: 2);
      expect(result, isNull);
    });

    test('should return null when number is NaN', () {
      final result = Numeric.getFractions(number: double.nan, fractionDigits: 2);
      expect(result, isNull);
    });

    test('should return 0.123 when number is 1.123 with 3 fraction digits', () {
      final result = Numeric.getFractions(number: 1.123, fractionDigits: 3);
      expect(result, 0.123);
    });

    test('should return 0.123 when number is 1.123 with null fraction digits', () {
      final result = Numeric.getFractions(number: 1.123, fractionDigits: null);
      expect(result, 0.123);
    });

    test('should return 0 when number is an integer', () {
      final result = Numeric.getFractions(number: 5, fractionDigits: 2);
      expect(result, 0);
    });

    test('should return null when number is zero and fraction digits are provided', () {
      final result = Numeric.getFractions(number: 0, fractionDigits: 2);
      expect(result, 0);
    });

    // Add more test cases as needed
  });
  // -----------------------------------------------------------------------------

  /// removeFractions

  // --------------------
  group('Numeric.removeFractions', () {
    test('should return null when number is null', () {
      final result = Numeric.removeFractions(number: null);
      expect(result, isNull);
    });

    test('should return null when number is NaN', () {
      final result = Numeric.removeFractions(number: double.nan);
      expect(result, isNull);
    });

    test('should return 1 when number is 1.123', () {
      final result = Numeric.removeFractions(number: 1.123);
      expect(result, 1);
    });

    test('should return -2 when number is -2.345', () {
      final result = Numeric.removeFractions(number: -2.345);
      expect(result, -2);
    });

    test('should return 0 when number is 0', () {
      final result = Numeric.removeFractions(number: 0);
      expect(result, 0);
    });

    test('should return null when number is zero and has fractions', () {
      final result = Numeric.removeFractions(number: 0.123);
      expect(result, 0);
    });

    // Add more test cases as needed

  });
  // -----------------------------------------------------------------------------

  /// roundFractions

  // --------------------
  group('Numeric.roundFractions', () {
    test('should return null when value is null', () {
      final result = Numeric.roundFractions(null, 2);
      expect(result, isNull);
    });

    test('should return 1.12 when value is 1.123 and fractions is 2', () {
      final result = Numeric.roundFractions(1.123, 2);
      expect(result, 1.12);
    });

    test('should return -2.35 when value is -2.345 and fractions is 2', () {
      final result = Numeric.roundFractions(-2.345, 2);
      expect(result, -2.35);
    });

    test('should return 0.00 when value is 0 and fractions is 2', () {
      final result = Numeric.roundFractions(0, 2);
      expect(result, 0.00);
    });

    test('should return null when value is null and fractions is provided', () {
      final result = Numeric.roundFractions(null, 2);
      expect(result, isNull);
    });

    // Add more test cases as needed

  });
  // -----------------------------------------------------------------------------

  /// getFractionStringWithoutZero

  // --------------------
  group('Numeric.getFractionStringWithoutZero', () {
    test('should return null when number is null', () {
      final result = Numeric.getFractionStringWithoutZero(number: null, fractionDigits: 2);
      expect(result, isNull);
    });

    test('should return "123" when number is 1.123 and fractionDigits is 3', () {
      final result = Numeric.getFractionStringWithoutZero(number: 1.123, fractionDigits: 3);
      expect(result, '123');
    });

    test('should return "12" when number is 1.123 and fractionDigits is 2', () {
      final result = Numeric.getFractionStringWithoutZero(number: 1.123, fractionDigits: 2);
      expect(result, '12');
    });

    test('should return "1" when number is 1.123 and fractionDigits is 1', () {
      final result = Numeric.getFractionStringWithoutZero(number: 1.123, fractionDigits: 1);
      expect(result, '1');
    });

    test('should return "0" when number is 5 and fractionDigits is 2', () {
      final result = Numeric.getFractionStringWithoutZero(number: 5, fractionDigits: 2);
      expect(result, '0');
    });

    // Add more test cases as needed
  });
  // -----------------------------------------------------------------------------

  /// getNumberOfFractions

  // --------------------
  group('Numeric.getNumberOfFractions', () {
    test('should return null when number is null', () {
      final result = Numeric.getNumberOfFractions(number: null);
      expect(result, isNull);
    });

    test('should return 3 when number is 1.123', () {
      final result = Numeric.getNumberOfFractions(number: 1.123);
      expect(result, 3);
    });

    test('should return 0 when number is an integer', () {
      final result = Numeric.getNumberOfFractions(number: 5);
      expect(result, 0);
    });

    test('should return null when number is zero', () {
      final result = Numeric.getNumberOfFractions(number: 0);
      expect(result, 0);
    });

    test('should return null when number is zero with fractions', () {
      final result = Numeric.getNumberOfFractions(number: -0.123);
      expect(result, 3);
    });

    // Add more test cases as needed
  });
  // -----------------------------------------------------------------------------

  /// checkNumberAsStringHasInvalidDigits

  // --------------------
  group('Numeric.checkNumberAsStringHasInvalidDigits', () {
    test('should return false when numberAsText is null', () {
      final result = Numeric.checkNumberAsStringHasMoreThanMaxDigits(
          numberAsText: null, maxDigits: 2);
      expect(result, isFalse);
    });

    test('should return false when numberAsText is empty', () {
      final result = Numeric.checkNumberAsStringHasMoreThanMaxDigits(
          numberAsText: '', maxDigits: 2);
      expect(result, isFalse);
    });

    test('should return false when numberAsText is "1.23" and maxDigits is 4', () {
      final result = Numeric.checkNumberAsStringHasMoreThanMaxDigits(
          numberAsText: '1.23',
          maxDigits: 4
      );
      expect(result, isFalse);
    });

    test('should return true when numberAsText is "1.234" and maxDigits is 3', () {
      final result = Numeric.checkNumberAsStringHasMoreThanMaxDigits(
        numberAsText: '1.2345',
        maxDigits: 3,
      );
      expect(result, isTrue);
    });

    test('should return false when numberAsText is "5" and maxDigits is 0', () {
      final result = Numeric.checkNumberAsStringHasMoreThanMaxDigits(
          numberAsText: '5',
          maxDigits: 1
      );
      expect(result, isFalse);
    });

    test('should return false when numberAsText is "0.123" and maxDigits is 2', () {
      final result = Numeric.checkNumberAsStringHasMoreThanMaxDigits(
          numberAsText: '0.123',
          maxDigits: 2
      );
      expect(result, true);
    });

    // Add more test cases as needed
  });
  // -----------------------------------------------------------------------------

  /// calculateDiscountPercentage

  // --------------------
  group('Numeric.calculateDiscountPercentage', () {
    test('should return null when oldPrice is null', () {
      final result = Numeric.calculateDiscountPercentage(oldPrice: null, currentPrice: 50);
      expect(result, isNull);
    });

    test('should return null when currentPrice is null', () {
      final result = Numeric.calculateDiscountPercentage(oldPrice: 100, currentPrice: null);
      expect(result, isNull);
    });

    test('should return 0 when oldPrice and currentPrice are equal', () {
      final result = Numeric.calculateDiscountPercentage(oldPrice: 100, currentPrice: 100);
      expect(result, 0);
    });

    test('should return 50 when oldPrice is 100 and currentPrice is 50', () {
      final result = Numeric.calculateDiscountPercentage(oldPrice: 100, currentPrice: 50);
      expect(result, 50);
    });

    test('should return 33 when oldPrice is 150 and currentPrice is 100', () {
      final result = Numeric.calculateDiscountPercentage(oldPrice: 150, currentPrice: 100);
      expect(result, 33);
    });

    test('should return 20 when oldPrice is 80 and currentPrice is 64', () {
      final result = Numeric.calculateDiscountPercentage(oldPrice: 80, currentPrice: 64);
      expect(result, 20);
    });

    // Add more test cases as needed

  });
  // -----------------------------------------------------------------------------

  /// calculateIntegerPower

  // --------------------
  group('Numeric.calculateIntegerPower', () {
    test('should return 1 when both num and power are null', () {
      final result = Numeric.calculateIntegerPower(num: null, power: null);
      expect(result, 1);
    });

    test('should return 1 when num is null and power is 0', () {
      final result = Numeric.calculateIntegerPower(num: null, power: 0);
      expect(result, 1);
    });

    test('should return 0 when num is 0 and power is 0', () {
      final result = Numeric.calculateIntegerPower(num: 0, power: 0);
      expect(result, 1);
    });

    test('should return 1 when num is 2 and power is 0', () {
      final result = Numeric.calculateIntegerPower(num: 2, power: 0);
      expect(result, 1);
    });

    test('should return 10 when num is 10 and power is 1', () {
      final result = Numeric.calculateIntegerPower(num: 10, power: 1);
      expect(result, 10);
    });

    test('should return 100 when num is 10 and power is 2', () {
      final result = Numeric.calculateIntegerPower(num: 10, power: 2);
      expect(result, 100);
    });

    // Add more test cases as needed

  });
  // -----------------------------------------------------------------------------

  /// calculateDoublePower

  // --------------------
  group('Numeric.calculateDoublePower', () {
    test('should return 1.0 when both num and power are null', () {
      final result = Numeric.calculateDoublePower(num: null, power: null);
      expect(result, 1.0);
    });

    test('should return 1.0 when num is null and power is 0', () {
      final result = Numeric.calculateDoublePower(num: null, power: 0);
      expect(result, 1.0);
    });

    test('should return 0.0 when num is 0.0 and power is 1', () {
      final result = Numeric.calculateDoublePower(num: 0, power: 0);
      expect(result, 1);
    });

    test('should return 1.0 when num is 2.0 and power is 0', () {
      final result = Numeric.calculateDoublePower(num: 2, power: 0);
      expect(result, 1.0);
    });

    test('should return 10.0 when num is 10.0 and power is 1', () {
      final result = Numeric.calculateDoublePower(num: 10, power: 1);
      expect(result, 10.0);
    });

    test('should return 100.0 when num is 10.0 and power is 2', () {
      final result = Numeric.calculateDoublePower(num: 10, power: 2);
      expect(result, 100.0);
    });

    // Add more test cases as needed

  });
  // -----------------------------------------------------------------------------

  /// degreeToRadian

  // --------------------
  group('Numeric.degreeToRadian', () {
    test('should return null when degree is null', () {
      final result = Trigonometer.degreeToRadian(null);
      expect(result, isNull);
    });

    test('should return 0.0 when degree is 0.0', () {
      final result = Trigonometer.degreeToRadian(0);
      expect(result, 0.0);
    });

    test('should return pi/2 when degree is 90.0', () {
      final result = Trigonometer.degreeToRadian(90);
      expect(result, math.pi / 2);
    });

    test('should return pi when degree is 180.0', () {
      final result = Trigonometer.degreeToRadian(180);
      expect(result, math.pi);
    });

    test('should return -pi/2 when degree is -90.0', () {
      final result = Trigonometer.degreeToRadian(-90);
      expect(result, -math.pi / 2);
    });

    test('should return -pi when degree is -180.0', () {
      final result = Trigonometer.degreeToRadian(-180);
      expect(result, -math.pi);
    });

    // Add more test cases as needed

  });
  // -----------------------------------------------------------------------------

  /// binarySearch

  // --------------------
  group('Numeric.binarySearch', () {
    test('should return null when list and searchedValue are null', () {
      final result = Numeric.binarySearch(list: null, searchedValue: null);
      expect(result, isNull);
    });

    test('should return null when list is null and searchedValue is not null', () {
      final result = Numeric.binarySearch(list: null, searchedValue: 5);
      expect(result, isNull);
    });

    test('should return null when list is empty and searchedValue is not null', () {
      final result = Numeric.binarySearch(list: [], searchedValue: 5);
      expect(result, isNull);
    });

    test('should return null when searchedValue is null and list is not null', () {
      final result = Numeric.binarySearch(list: [1, 2, 3], searchedValue: null);
      expect(result, isNull);
    });

    test('should return null when searchedValue is not in the list', () {
      final result = Numeric.binarySearch(list: [1, 2, 3, 4, 6, 7], searchedValue: 5);
      expect(result, isNull);
    });

    test('should return the index when searchedValue is found in the list', () {
      final result = Numeric.binarySearch(list: [1, 2, 3, 4, 5, 6, 7], searchedValue: 5);
      expect(result, 4);
    });

    test('should return the index when searchedValue is found in the list', () {
      final result = Numeric.binarySearch(list: [1, 2, 3, 4, 5, 6, 7], searchedValue: 7);
      expect(result, 6);
    });

    test('should return the index when searchedValue is found in the list', () {
      final result = Numeric.binarySearch(list: [1, 2, 3, 4, 5, 6, 7], searchedValue: 500);
      expect(result, isNull);
    });

    // Add more test cases as needed

  });
  // -----------------------------------------------------------------------------

  /// modulus

  // --------------------
  group('Numeric.modulus', () {

    test('Returns null for null input', () {
      final result = Numeric.modulus(null);
      expect(result, isNull);
    });

    test('Returns 0 for input 0', () {
      final result = Numeric.modulus(0);
      expect(result, 0);
    });

    test('Returns positive value for positive input', () {
      final result = Numeric.modulus(5);
      expect(result, greaterThan(0));
    });

    test('Returns positive value for negative input', () {
      final result = Numeric.modulus(-5);
      expect(result, greaterThan(0));
    });

    test('Returns correct value for non-integer input', () {
      final result = Numeric.modulus(3.14);
      expect(result, closeTo(3.14, 0.001));
    });

  });
  // -----------------------------------------------------------------------------

  /// reverseIndex

  // --------------------
  group('Numeric.reverseIndex', () {

    test('Returns null when listLength is null', () {
      final result = Indexer.reverseIndex(listLength: null, index: 5);
      expect(result, isNull);
    });

    test('Returns null when index is null', () {
      final result = Indexer.reverseIndex(listLength: 10, index: null);
      expect(result, isNull);
    });

    test('Returns null when both listLength and index are null', () {
      final result = Indexer.reverseIndex(listLength: null, index: null);
      expect(result, isNull);
    });

    test('Returns null when index is out of bounds', () {
      final result = Indexer.reverseIndex(listLength: 5, index: 10);
      expect(result, isNull);
    });

    test('Returns correct reversed index for valid input', () {
      final result = Indexer.reverseIndex(listLength: 10, index: 3);
      expect(result, 6);
    });

    test('Returns correct reversed index for edge case input', () {
      final result = Indexer.reverseIndex(listLength: 1, index: 0);
      expect(result, 0);
    });

    test('xxxxx', () {
      final a = Indexer.reverseIndex(listLength: 7, index: 0);
      expect(a, 6);
      final b = Indexer.reverseIndex(listLength: 7, index: 1);
      expect(b, 5);
      final c = Indexer.reverseIndex(listLength: 7, index: 2);
      expect(c, 4);
      final d = Indexer.reverseIndex(listLength: 7, index: 3);
      expect(d, 3);
      final e = Indexer.reverseIndex(listLength: 7, index: 4);
      expect(e, 2);
      final f = Indexer.reverseIndex(listLength: 7, index: 5);
      expect(f, 1);
      final g = Indexer.reverseIndex(listLength: 7, index: 6);
      expect(g, 0);
    });

  });
  // -----------------------------------------------------------------------------

  /// pythagorasHypotenuse

  // --------------------
  group('Trigonometer.pythagorasHypotenuse', () {
    test('Returns null when side is null', () {
      final result = Trigonometer.pythagorasHypotenuse(side: null, side2: 4);
      expect(result, isNull);
    });

    test('Returns correct hypotenuse for valid input', () {
      final result = Trigonometer.pythagorasHypotenuse(side: 3, side2: 4);
      expect(result, closeTo(5, 0.001));
    });

    test('Returns correct hypotenuse for side2 equal to side', () {
      final result = Trigonometer.pythagorasHypotenuse(side: 5, side2: 5);
      expect(result, closeTo(7.071, 0.001));
    });

    test('Returns correct hypotenuse for side2 not provided', () {
      final result = Trigonometer.pythagorasHypotenuse(side: 6);
      expect(result, closeTo(8.485, 0.001));
    });

    test('Returns null when side and side2 are both null', () {
      final result = Trigonometer.pythagorasHypotenuse(side: null, side2: null);
      expect(result, isNull);
    });

    test('Returns null when side is null and side2 is provided', () {
      final result = Trigonometer.pythagorasHypotenuse(side: null, side2: 3);
      expect(result, isNull);
    });
  });
  // -----------------------------------------------------------------------------

  /// pythagorasHypotenuse

  // --------------------
  group('Numeric - getClosestInt', () {

    test('Test value less than 0', () {
      const List<int> numbers = [1, 2, 3, 4, 5];
      const double value = -0.5;

      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, numbers.first);
    });

    test('Test value greater than 1', () {
      const List<int> numbers = [1, 2, 3, 4, 5];
      const double value = 1.5;

      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, 1);
    });


    test('Test value greater than 1', () {
      const List<int> numbers = [1, 2, 3, 4, 5];
      const double value = 1.51;

      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, 2);
    });


    test('Test value within range', () {
      const List<int> numbers = [1, 2, 3, 4, 5];
      const double value = 2.7;

      blog('sa');
      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, 3);
    });

    test('Test value within range', () {
      const List<int> numbers = [1, 3, 4, 5];
      const double value = 2;

      blog('sa');
      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, 1);
    });

    test('Test value equal to first element', () {
      const List<int> numbers = [1, 2, 3, 4, 5];
      const double value = 3.51;

      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, 4);
    });

    test('Test value equal to last element', () {
      const List<int> numbers = [1, 2, 3, 4, 5];
      const double value = 5;

      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, numbers.last);
    });

    test('Test empty list', () {
      const List<int> numbers = [];
      const double value = 0.5;

      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, null);
    });

    test('Test single element list', () {
      const List<int> numbers = [1];
      const double value = 0.5;

      final int? result = Numeric.getClosestInt(ints: numbers, value: value);

      expect(result, numbers.first);
    });

  });
  // -----------------------------------------------------------------------------

  /// ROMAN

  // --------------------
  group('Numeric.formatToRomanA', () {
    test('Test zero input', () {
      expect(Numeric.formatToRomanA(0), '');
    });

    test('Test negative input', () {
      expect(Numeric.formatToRomanA(-10), '');
    });

    test('Test single digit input', () {
      expect(Numeric.formatToRomanA(3), 'III');
    });

    test('Test random input 1', () {
      expect(Numeric.formatToRomanA(23), 'XXIII');
    });

    test('Test random input 2', () {
      expect(Numeric.formatToRomanA(49), 'XLIX');
    });

    test('Test random input 3', () {
      expect(Numeric.formatToRomanA(128), 'CXXVIII');
    });

    test('Test maximum input', () {
      expect(Numeric.formatToRomanA(3999), 'MMMCMXCIX');
    });
  });
  // --------------------
  group('Numeric.formatToRomanB', () {
    test('Test zero input', () {
      expect(Numeric.formatToRomanB(0), '');
    });

    test('Test negative input', () {
      expect(Numeric.formatToRomanB(-10), '');
    });

    test('Test single digit input', () {
      expect(Numeric.formatToRomanB(3), 'III');
    });

    test('Test random input 1', () {
      expect(Numeric.formatToRomanB(23), 'XXIII');
    });

    test('Test random input 2', () {
      expect(Numeric.formatToRomanB(49), 'XLIX');
    });

    test('Test random input 3', () {
      expect(Numeric.formatToRomanB(128), 'CXXVIII');
    });

    test('Test maximum input', () {
      expect(Numeric.formatToRomanB(3999), 'MMMCMXCIX');
    });
  });
  // -----------------------------------------------------------------------------

  /// ROMAN

  // --------------------
  group('Trigonometer.move360Degree', () {
    test('Adding positive angle within range', () {
      expect(Trigonometer.move360Degree(source360Degree: 45, moveBy360Degree: 30), 75);
    });
    test('Subtracting positive angle within range', () {
      expect(Trigonometer.move360Degree(source360Degree: 180, moveBy360Degree: -45), 135);
    });
    test('Adding angle that wraps around (>= 360)', () {
      expect(Trigonometer.move360Degree(source360Degree: 320, moveBy360Degree: 60), 20);
    });
    test('Subtracting angle that wraps around (< 0)', () {
      expect(Trigonometer.move360Degree(source360Degree: 20, moveBy360Degree: -30), 350);
    });
    test('Adding negative angle within range', () {
      expect(Trigonometer.move360Degree(source360Degree: 300, moveBy360Degree: -40), 260);
    });
    test('Subtracting negative angle within range', () {
      expect(Trigonometer.move360Degree(source360Degree: 90, moveBy360Degree: -75), 15);
    });
    test('Null inputs should return null', () {
      expect(Trigonometer.move360Degree(source360Degree: null, moveBy360Degree: 90), null);
      expect(Trigonometer.move360Degree(source360Degree: 180, moveBy360Degree: null), null);
      expect(Trigonometer.move360Degree(source360Degree: null, moveBy360Degree: null), null);
    });
  });
  // -----------------------------------------------------------------------------
  group('Numeric getNextIndex tests', () {

    test('Test case 1: Next index when not at the last', () {
      final int? result = Indexer.getNextIndex(listLength: 5, currentIndex: 2, loop: false);
      expect(result, 3);
    });

    test('Test case 2: Next index when at the last with loop enabled', () {
      final int? result = Indexer.getNextIndex(listLength: 4, currentIndex: 3, loop: true);
      expect(result, 0);
    });

    test('Test case 3: Next index when at the last with loop disabled', () {
      final int? result = Indexer.getNextIndex(listLength: 4, currentIndex: 3, loop: false);
      expect(result, 3);
    });

    test('Test case 4: Next index with null list length', () {
      final int? result = Indexer.getNextIndex(listLength: null, currentIndex: 2, loop: false);
      expect(result, null);
    });

    test('Test case 5: Next index with null current index', () {
      final int? result = Indexer.getNextIndex(listLength: 5, currentIndex: null, loop: false);
      expect(result, null);
    });

    test('Test case 6: Next index with null list length and current index', () {
      final int? result = Indexer.getNextIndex(listLength: null, currentIndex: null, loop: false);
      expect(result, null);
    });

    test('Test case 7: Next index with loop disabled at last element', () {
      final int? result = Indexer.getNextIndex(listLength: 3, currentIndex: 2, loop: false);
      expect(result, 2);
    });
  });
  // -----------------------------------------------------------------------------

  /// ROMAN

  // -----------------------------------------------------------------------------
  group('formatDoubleWithinDigits', () {

    test('Format double with 5 digits after decimal point', () {
      expect(Numeric.formatDoubleWithinDigits(value: 1, digits: 5), '+1.00000');
    });

    test('Format double with 4 digits after decimal point', () {
      expect(Numeric.formatDoubleWithinDigits(value: 2.54, digits: 4), '+2.5400');
    });

    test('Format double with 2 digits after decimal point', () {
      expect(Numeric.formatDoubleWithinDigits(value: 3.14159, digits: 2), '+3.14');
    });

    test('Handle null values', () {
      expect(Numeric.formatDoubleWithinDigits(value: null, digits: 3), isNull);
    });

    test('Handle null digits', () {
      expect(Numeric.formatDoubleWithinDigits(value: 5.6789, digits: null), isNull);
    });

    test('Handle value exceeding maximum possible with 3 digits', () {
      expect(Numeric.formatDoubleWithinDigits(value: 1234.5678, digits: 3), '+1234.568');
    });

    test('Handle value exceeding maximum possible with 3 digits 2', () {
      expect(Numeric.formatDoubleWithinDigits(value: 5.1234467, digits: 4), '+5.1234');
    });

    test('Handle value exceeding maximum possible with 3 digits 2', () {
      expect(Numeric.formatDoubleWithinDigits(value: 5.1234567, digits: 4), '+5.1235');
    });

    test('Handle value exceeding maximum possible with 3 digits 2', () {
      expect(Numeric.formatDoubleWithinDigits(value: 5.1234567, digits: 10 ), '+5.1234567000');
    });

  });
  // -----------------------------------------------------------------------------

}
