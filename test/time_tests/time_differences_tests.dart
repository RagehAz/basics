// ignore_for_file: avoid_redundant_argument_values, avoid_init_to_null
// ignore_for_file: prefer_final_locals
import 'package:basics/helpers/time/timers.dart';
import 'package:flutter_test/flutter_test.dart';
// ---------------------------------------------------------------------------

/// CHAT GBT TEST REQUEST

/*

for the following flutter method, write group of test methods in one test group to assure its
perfectly working, Do not write description, just the dart code in one test group, note that the
method is a static method from a class called Timers

 */

// ---------------------------------------------------------------------------

void main() {

  /// ----------------------------------------------------------

  group('custom tests', () {

    test('1', () {
      final DateTime now = DateTime.now();
      final utc = now.toUtc();

      final bool identical = Timers.checkTimesAreIdentical(
        accuracy: TimeAccuracy.second,
        time1: now,
        time2: utc,
      );
      expect(identical, false,);
    });

    test('2', () {
      final DateTime now = DateTime.now();
      final utc = now.toUtc();

      final String _ciphered = Timers.cipherTime(time: utc, toJSON: true);
      final DateTime? _deciphered = Timers.decipherTime(time: _ciphered, fromJSON: true);

      final bool identical2 = Timers.checkTimesAreIdentical(
        accuracy: TimeAccuracy.second,
        time1: now,
        time2: _deciphered,
      );
      expect(identical2, true,);
    });

    test('3', () {
      final DateTime now = DateTime.now();
      final utc = now.toUtc();
      final String _ciphered = Timers.cipherTime(time: utc, toJSON: true);
      final DateTime? _deciphered = Timers.decipherTime(time: _ciphered, fromJSON: true);
      expect(_deciphered, now);
      expect(_deciphered, utc.toLocal());


      final bool identical = Timers.checkTimesAreIdentical(
        accuracy: TimeAccuracy.second,
        time1: now,
        time2: _deciphered?.toLocal(),
      );
      expect(identical, true,);
    });

    test('4', () {
      final DateTime now = DateTime.now();
      final utc = now.toUtc();

      final dynamic _ciphered = Timers.cipherTime(time: utc, toJSON: false);
      final DateTime? _deciphered = Timers.decipherTime(time: _ciphered, fromJSON: false);

      final bool identical2 = Timers.checkTimesAreIdentical(
        accuracy: TimeAccuracy.second,
        time1: now,
        time2: _deciphered?.toLocal(),
      );
      expect(identical2, true,);
    });

    test('5', () {
      final DateTime now = DateTime.now();
      final utc = now.toUtc();

      final dynamic _ciphered = Timers.cipherTime(time: utc, toJSON: false);
      final DateTime? _deciphered = Timers.decipherTime(time: _ciphered, fromJSON: false);

      final bool identical2 = Timers.checkTimesAreIdentical(
        accuracy: TimeAccuracy.second,
        time1: utc,
        time2: _deciphered?.toLocal(),
      );
      expect(identical2, false,);
    });

    test('6', () {
      final DateTime now = DateTime.now();
      final utc = now.toUtc();

      final dynamic _ciphered = Timers.cipherTime(time: utc, toJSON: false);
      final DateTime? _deciphered = Timers.decipherTime(time: _ciphered, fromJSON: false);

      final bool identical2 = Timers.checkTimesAreIdentical(
        accuracy: TimeAccuracy.second,
        time1: now.toLocal().toLocal().toUtc(),
        time2: _deciphered?.toLocal().toLocal().toUtc(),
      );
      expect(identical2, true,);
    });

  });

  /// ----------------------------------------------------------

  group('calculateTimeDifferenceInSeconds', () {
    test('should return 0 when from and to are null', () {
      expect(
        Timers.calculateTimeDifferenceInSeconds(from: null, to: null),
        equals(0),
      );
    });

    test('should return 0 when from is null', () {
      expect(
        Timers.calculateTimeDifferenceInSeconds(
          from: null,
          to: DateTime.now(),
        ),
        equals(0),
      );
    });

    test('should return 0 when to is null', () {
      expect(
        Timers.calculateTimeDifferenceInSeconds(
          from: DateTime.now(),
          to: null,
        ),
        equals(0),
      );
    });

    test('should return the correct time difference in seconds', () {
      final from = DateTime(2023, 3, 24, 12, 0, 2);
      final to = DateTime(2023, 3, 24, 12, 0, 10);
      expect(
        Timers.calculateTimeDifferenceInSeconds(from: from, to: to),
        equals(8),
      );
    });
  });

  group('Timers.calculateTimeDifferenceInMinutes', () {
    test('should return 0 when from and to are null', () {
      expect(
        Timers.calculateTimeDifferenceInMinutes(from: null, to: null),
        equals(0),
      );
    });

    test('should return 0 when from is null', () {
      expect(
        Timers.calculateTimeDifferenceInMinutes(
          from: null,
          to: DateTime.now(),
        ),
        equals(0),
      );
    });

    test('should return 0 when to is null', () {
      expect(
        Timers.calculateTimeDifferenceInMinutes(
          from: DateTime.now(),
          to: null,
        ),
        equals(0),
      );
    });

    test('should return the correct time difference in minutes', () {
      final from = DateTime(2023, 3, 24, 12, 0, 0);
      final to = DateTime(2023, 3, 24, 12, 10, 0);
      expect(
        Timers.calculateTimeDifferenceInMinutes(from: from, to: to),
        equals(10),
      );
    });

    test('time check', () {
      final from = DateTime(2023, 3, 24, 12, 0, 0);
      final to = DateTime(2023, 3, 24, 12, 0, 0);
      expect(Timers.calculateTimeDifferenceInMinutes(from: from, to: to), 0);
    });

    test('time check', () {
      final from = DateTime(2023, 3, 24, 12, 0, 0);
      final to = DateTime(2023, 3, 24, 12, 1, 0);
      expect(Timers.calculateTimeDifferenceInMinutes(from: from, to: to), 1);
    });

    test('time check', () {
      final from = DateTime(2023, 3, 24, 12, 0, 0);
      final to = DateTime(2023, 3, 24, 13, 0, 0);
      expect(Timers.calculateTimeDifferenceInMinutes(from: from, to: to), 60);
    });

    test('time check', () {
      final from = DateTime(2023, 3, 24, 12, 0, 0);
      final to = DateTime(2023, 3, 24, 14, 5, 0);
      expect(Timers.calculateTimeDifferenceInMinutes(from: from, to: to), 125);
    });


  });

  group('Timers.calculateTimeDifferenceInHours', () {
    test('should return 0 when from and to are null', () {
      expect(
        Timers.calculateTimeDifferenceInHours(from: null, to: null),
        equals(0),
      );
    });

    test('should return 0 when from is null', () {
      expect(
        Timers.calculateTimeDifferenceInHours(
          from: null,
          to: DateTime.now(),
        ),
        equals(0),
      );
    });

    test('should return 0 when to is null', () {
      expect(
        Timers.calculateTimeDifferenceInHours(
          from: DateTime.now(),
          to: null,
        ),
        equals(0),
      );
    });

    test('should return the correct time difference in hours', () {
      final from = DateTime(2023, 3, 24, 12, 0, 0);
      final to = DateTime(2023, 3, 24, 22, 0, 0);
      expect(
        Timers.calculateTimeDifferenceInHours(from: from, to: to),
        equals(10),
      );
    });
  });

  group('Timers.calculateTimeDifferenceInDays', () {
    test('should return 0 when from and to are null', () {
      expect(
        Timers.calculateTimeDifferenceInDays(from: null, to: null),
        equals(0),
      );
    });

    test('should return 0 when from is null', () {
      expect(
        Timers.calculateTimeDifferenceInDays(
          from: null,
          to: DateTime.now(),
        ),
        equals(0),
      );
    });

    test('should return 0 when to is null', () {
      expect(
        Timers.calculateTimeDifferenceInDays(
          from: DateTime.now(),
          to: null,
        ),
        equals(0),
      );
    });

    test('should return the correct time difference in days', () {
      final from = DateTime(2023, 3, 20);
      final to = DateTime(2023, 3, 23);
      expect(
        Timers.calculateTimeDifferenceInDays(from: from, to: to),
        equals(3),
      );
    });
  });

  group('Timers.calculateTimeDifferenceInWeeks', () {
    test('should return 0 when from and to are null', () {
      expect(
        Timers.calculateTimeDifferenceInWeeks(from: null, to: null),
        equals(0),
      );
    });

    test('should return 0 when from is null', () {
      expect(
        Timers.calculateTimeDifferenceInWeeks(
          from: null,
          to: DateTime.now(),
        ),
        equals(0),
      );
    });

    test('should return 0 when to is null', () {
      expect(
        Timers.calculateTimeDifferenceInWeeks(
          from: DateTime.now(),
          to: null,
        ),
        equals(0),
      );
    });

    test('should return the correct time difference in weeks', () {
      final from = DateTime(2023, 3, 20);
      final to = DateTime(2023, 4, 1);
      expect(
        Timers.calculateTimeDifferenceInWeeks(from: from, to: to),
        equals(1),
      );
    });

    test('should return 0 when difference is less than a week', () {
      final from = DateTime(2023, 3, 20);
      final to = DateTime(2023, 3, 24);
      expect(
        Timers.calculateTimeDifferenceInWeeks(from: from, to: to),
        equals(0),
      );
    });
  });

  group('Timers.calculateTimeDifferenceInMonths', () {

    test('should return 0 when from and to are null', () {
      expect(
        Timers.calculateTimeDifferenceInMonths(from: null, to: null),
        equals(0),
      );
    });

    test('should return 0 when from is null', () {
      expect(
        Timers.calculateTimeDifferenceInMonths(
          from: null,
          to: DateTime.now(),
        ),
        equals(0),
      );
    });

    test('should return 0 when to is null', () {
      expect(
        Timers.calculateTimeDifferenceInMonths(
          from: DateTime.now(),
          to: null,
        ),
        equals(0),
      );
    });

    test('should return the correct time difference in months', () {
      final from = DateTime(2022, 12, 1);
      final to = DateTime(2023, 3, 31);
      expect(
        Timers.calculateTimeDifferenceInMonths(from: from, to: to),
        equals(3),
      );
    });

    test('should return 0 when difference is less than a month', () {
      final from = DateTime(2023, 3, 20);
      final to = DateTime(2023, 3, 24);
      expect(
        Timers.calculateTimeDifferenceInMonths(from: from, to: to),
        equals(0),
      );
    });

  });

  group('Timers.calculateTimeDifferenceInYears()', () {

    test('Given valid dates, should return the correct difference in years.', () {
      final DateTime from = DateTime(2020, 3, 1);
      final DateTime to = DateTime(2023, 3, 1);
      expect(Timers.calculateTimeDifferenceInYears(from: from, to: to), 3);
    });

    test('some number', () {
      final DateTime from = DateTime(2023, 3, 1);
      final DateTime to = DateTime(2020, 3, 1);
      expect(Timers.calculateTimeDifferenceInYears(from: from, to: to), 3);
    });

    test('Given two identical dates, should return 0.', () {
      final DateTime from = DateTime(2023, 3, 1);
      final DateTime to = DateTime(2023, 3, 1);
      expect(Timers.calculateTimeDifferenceInYears(from: from, to: to), 0);
    });

  });

  group('Timers.calculateRemainingHoursAndMinutes()', () {

    test('Given valid seconds, should return the correct remaining hours and minutes string.', () {
      int secondsUntilNow = 7200;
      expect(Timers.calculateRemainingHoursAndMinutes(secondsUntilNow: secondsUntilNow), '02:00');
    });

    test('Given seconds equal to zero, should return an empty string.', () {
      int secondsUntilNow = 0;
      expect(Timers.calculateRemainingHoursAndMinutes(secondsUntilNow: secondsUntilNow), '00:00');
    });

    test('Given null seconds, should return an empty string.', () {
      expect(Timers.calculateRemainingHoursAndMinutes(secondsUntilNow: null), '');
    });

    test('Given negative seconds, should throw an exception.', () {
      int secondsUntilNow = -7200;
      expect(Timers.calculateRemainingHoursAndMinutes(secondsUntilNow: secondsUntilNow),'');
    });

  });

  group('Timers.checkTimeDifferenceIsBiggerThan()', () {

    test('Given time difference is bigger than maxDifferenceInMinutes, should return true.', () {
      DateTime time1 = DateTime(2023, 3, 26, 10, 30);
      DateTime time2 = DateTime(2023, 3, 26, 11, 45);
      int maxDifferenceInMinutes = 30;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          true);
    });

    test('Given time difference is equal to maxDifferenceInMinutes, should return false.', () {
      DateTime time1 = DateTime(2023, 3, 26, 10, 30);
      DateTime time2 = DateTime(2023, 3, 26, 11, 0);
      int maxDifferenceInMinutes = 30;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          false);
    });

    test('Given time difference is smaller than maxDifferenceInMinutes, should return false.', () {
      DateTime time1 = DateTime(2023, 3, 26, 10, 30);
      DateTime time2 = DateTime(2023, 3, 26, 10, 50);
      int maxDifferenceInMinutes = 30;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          false);
    });

    test('Given null times, should return false.', () {
      DateTime? time1 = null;
      DateTime? time2 = null;
      int maxDifferenceInMinutes = 30;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          false);
    });


    test('Given null maxDifferenceInMinutes, should throw an exception.', () {
      DateTime time1 = DateTime(2023, 3, 26, 10, 30);
      DateTime time2 = DateTime(2023, 3, 26, 10, 32);
      DateTime time3 = DateTime(2023, 3, 26, 10, 31);
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: null),
          true);
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time3, maxDifferenceInMinutes: null),
          false);
    });

    test('Given maxDifferenceInMinutes is zero, should return true.', () {
      DateTime time1 = DateTime(2023, 3, 26, 10, 30);
      DateTime time2 = DateTime(2023, 3, 26, 11, 0);
      int maxDifferenceInMinutes = 0;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          true);
    });

    test('Given maxDifferenceInMinutes is negative, should throw an exception.', () {
      DateTime time1 = DateTime(2023, 3, 26, 10, 30);
      DateTime time2 = DateTime(2023, 3, 26, 11, 45);
      int maxDifferenceInMinutes = -30;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          true);
    });

    test('Given time2 is before time1, should return true.', () {
      DateTime time1 = DateTime(2023, 3, 26, 11, 45);
      DateTime time2 = DateTime(2023, 3, 26, 10, 30);
      int maxDifferenceInMinutes = 30;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          true);
    });

    test('Given time difference is exactly maxDifferenceInMinutes + 1, should return true.', () {
      DateTime time1 = DateTime(2023, 3, 26, 10, 30);
      DateTime time2 = DateTime(2023, 3, 26, 11, 1);
      int maxDifferenceInMinutes = 30;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          true);
    });

    test('Given time difference is much bigger than maxDifferenceInMinutes, should return true.',() {
      DateTime time1 = DateTime(2023, 3, 26, 10, 30);
      DateTime time2 = DateTime(2023, 3, 26, 12, 0);
      int maxDifferenceInMinutes = 30;
      expect(
          Timers.checkTimeDifferenceIsBiggerThan(
              time1: time1, time2: time2, maxDifferenceInMinutes: maxDifferenceInMinutes),
          true);
    });

  });

  /// ----------------------------------------------------------

}
