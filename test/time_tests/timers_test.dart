import 'package:basics/helpers/time/timers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// cipherDateTimeToInt / decipherIntToDateTime

  // --------------------
  group('Timers.cipherDateTimeToInt / decipherIntToDateTime', () {

    test('Round-trips a UTC DateTime through microsecondsSinceEpoch', () {
      final time = DateTime.utc(2024, 3, 15, 10, 30);
      final ciphered = Timers.cipherDateTimeToInt(time: time);
      final deciphered = Timers.decipherIntToDateTime(integer: ciphered, toLocal: false);
      expect(deciphered!.isAtSameMomentAs(time), true);
    });

    test('Returns null when time is null', () {
      expect(Timers.cipherDateTimeToInt(time: null), isNull);
    });

    test('Returns null when integer is null', () {
      expect(Timers.decipherIntToDateTime(integer: null), isNull);
    });

    test('Preserves chronological ordering (lexicographic sort support)', () {
      final earlier = DateTime.utc(2020);
      final later = DateTime.utc(2025);
      final earlierInt = Timers.cipherDateTimeToInt(time: earlier)!;
      final laterInt = Timers.cipherDateTimeToInt(time: later)!;
      expect(earlierInt < laterInt, true);
    });

  });
  // -----------------------------------------------------------------------------

  /// cipherDateTimeIso8601 / decipherDateTimeIso8601

  // --------------------
  group('Timers.cipherDateTimeIso8601 / decipherDateTimeIso8601', () {

    test('Round-trips a UTC DateTime through an ISO8601 string', () {
      final time = DateTime.utc(2024, 6, 1, 12);
      final ciphered = Timers.cipherDateTimeIso8601(time: time);
      final deciphered = Timers.decipherDateTimeIso8601(timeString: ciphered, toLocal: false);
      expect(deciphered!.isAtSameMomentAs(time), true);
    });

    test('Returns null when time is null', () {
      expect(Timers.cipherDateTimeIso8601(time: null), isNull);
    });

    test('Returns null when timeString is null', () {
      expect(Timers.decipherDateTimeIso8601(timeString: null), isNull);
    });

    test('Returns null for an unparseable string', () {
      expect(Timers.decipherDateTimeIso8601(timeString: 'not a date'), isNull);
    });

  });
  // -----------------------------------------------------------------------------

  /// decipherTime

  // --------------------
  group('Timers.decipherTime', () {

    test('Returns null when time is null', () {
      expect(Timers.decipherTime(time: null, fromJSON: true), isNull);
    });

    test('Deciphers an int (epoch microseconds) when fromJSON is true', () {
      final time = DateTime.utc(2024, 3, 15, 10, 30);
      final asInt = Timers.cipherDateTimeToInt(time: time);
      final result = Timers.decipherTime(time: asInt, fromJSON: true, toLocal: false);
      expect(result!.isAtSameMomentAs(time), true);
    });

    test('Deciphers a Firestore Timestamp', () {
      final time = DateTime.utc(2024, 3, 15, 10, 30);
      final timestamp = Timestamp.fromDate(time);
      final result = Timers.decipherTime(time: timestamp, fromJSON: false, toLocal: false);
      expect(result!.isAtSameMomentAs(time), true);
    });

    test('Passes a DateTime straight through', () {
      final time = DateTime.utc(2024, 3, 15, 10, 30);
      final result = Timers.decipherTime(time: time, fromJSON: false, toLocal: false);
      expect(result!.isAtSameMomentAs(time), true);
    });

    test('Deciphers an ISO8601 string', () {
      final time = DateTime.utc(2024, 3, 15, 10, 30);
      final result = Timers.decipherTime(time: time.toIso8601String(), fromJSON: false, toLocal: false);
      expect(result!.isAtSameMomentAs(time), true);
    });

  });
  // -----------------------------------------------------------------------------

  /// cipherTime

  // --------------------
  group('Timers.cipherTime', () {

    test('Ciphers to an epoch int when toJSON is true', () {
      final time = DateTime.utc(2024, 3, 15, 10, 30);
      final result = Timers.cipherTime(time: time, toJSON: true);
      expect(result, isA<int>());
      expect(Timers.decipherIntToDateTime(integer: result as int, toLocal: false)!.isAtSameMomentAs(time), true);
    });

    test('Returns a UTC DateTime when toJSON is false and toUTC is true', () {
      final time = DateTime.utc(2024, 3, 15, 10, 30);
      final result = Timers.cipherTime(time: time, toJSON: false);
      expect(result, isA<DateTime>());
      expect((result as DateTime).isUtc, true);
    });

    test('Returns null when time is null and toJSON is true', () {
      expect(Timers.cipherTime(time: null, toJSON: true), isNull);
    });

  });
  // -----------------------------------------------------------------------------

  /// createDateTime / createDate / createClock

  // --------------------
  group('Timers.createDateTime / createDate / createClock', () {

    test('createDateTime builds the exact DateTime requested', () {
      final result = Timers.createDateTime(year: 2024, month: 3, day: 15, hour: 10, minute: 30, second: 15);
      expect(result, DateTime(2024, 3, 15, 10, 30, 15));
    });

    test('createDate builds midnight on the given day', () {
      final result = Timers.createDate(year: 2024, month: 3, day: 15);
      expect(result, DateTime(2024, 3, 15));
    });

    test('createClock builds a time-of-day on the epoch date', () {
      final result = Timers.createClock(hour: 10, minute: 30, second: 15);
      expect(result.hour, 10);
      expect(result.minute, 30);
      expect(result.second, 15);
    });

  });
  // -----------------------------------------------------------------------------

  /// simplifyTime

  // --------------------
  group('Timers.simplifyTime', () {

    test('Strips milliseconds/microseconds while keeping date and time', () {
      final time = DateTime(2024, 3, 15, 10, 30, 45, 999, 999);
      final result = Timers.simplifyTime(time);
      expect(result, DateTime(2024, 3, 15, 10, 30, 45));
    });

    test('Returns null when time is null', () {
      expect(Timers.simplifyTime(null), isNull);
    });

  });
}
