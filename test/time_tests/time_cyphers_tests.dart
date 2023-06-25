// ignore_for_file: avoid_redundant_argument_values, avoid_init_to_null, prefer_const_declarations, avoid_print, prefer_const_constructors
// ignore_for_file: prefer_final_locals
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
// ---------------------------------------------------------------------------

void main() {

  group('Timers.cipherTime', () {
    test('returns the same DateTime object if toJSON is false', () {
      final DateTime dateTime = DateTime.now();
      // print('dateTime    : $dateTime');
      final dynamic ciphered = Timers.cipherTime(time: dateTime, toJSON: true);
      // print('ciphered : $ciphered');
      final DateTime? deciphered = Timers.decipherTime(time: ciphered, fromJSON: true);
      // print('deciphered  : $deciphered');
      expect(deciphered == dateTime, true);
    });

    test('returns a String if toJSON is true', () {
      final DateTime dateTime = DateTime.now();
      final result = Timers.cipherTime(time: dateTime, toJSON: true);
      expect(result, isA<String>());
    });

    test('returns a valid ISO 8601 string if toJSON is true', () {
      final DateTime dateTime = DateTime.now();
      final result = Timers.cipherTime(time: dateTime, toJSON: true);
      expect(() => DateTime.parse(result), returnsNormally);
    });

    test('returns the same DateTime object if toJSON is false', () {
      final DateTime dateTime = DateTime.now();
      expect(Timers.cipherTime(time: dateTime, toJSON: false), equals(dateTime.toUtc()));
    });

    test('returns a String if toJSON is true', () {
      final DateTime dateTime = DateTime.now();
      final result = Timers.cipherTime(time: dateTime, toJSON: true);
      expect(result, isA<String>());
    });

    test('returns a valid ISO 8601 string if toJSON is true', () {
      final DateTime dateTime = DateTime.now();
      final result = Timers.cipherTime(time: dateTime, toJSON: true);
      expect(() => DateTime.parse(result), returnsNormally);
    });

    test('returns null if the time parameter is null', () {
      final result = Timers.cipherTime(time: null, toJSON: true);
      expect(result, isNull);
    });

        test('cipherTime should return UTC DateTime when toJSON is false', () {
      // Arrange
      final time = DateTime(2023, 3, 27, 10, 30, 0);
      final expected = time.toUtc();

      // Act
      final result = Timers.cipherTime(time: time, toJSON: false);

      // Assert
      expect(result, expected);
    });

    test('cipherTime should return ciphered DateTime in ISO 8601 format when toJSON is true', () {
      // Arrange
      final time = DateTime(2023, 3, 27, 10, 30, 0);
      final expected = Timers.cipherDateTimeIso8601(
        time: time,
      );

      // Act
      final result = Timers.cipherTime(time: time, toJSON: true);

      // Assert
      expect(result, expected);
    });

    test('cipherTime should return null when time is null', () {
      // Arrange
      final expected = null;

      // Act
      final result = Timers.cipherTime(time: null, toJSON: true);

      // Assert
      expect(result, expected);
    });

    test('cipherTime should return UTC DateTime when toJSON is false', () {
      // Arrange
      final time = DateTime(2023, 3, 27, 10, 30, 0);
      final expected = time.toUtc();

      // Act
      final result = Timers.cipherTime(time: time, toJSON: false);

      // Assert
      expect(result, expected);
    });

    test('cipherTime should return ciphered DateTime in ISO 8601 format when toJSON is true', () {
      // Arrange
      final time = DateTime(2023, 3, 27, 10, 30, 0);
      final expected = Timers.cipherDateTimeIso8601(
        time: time,
      );

      // Act
      final result = Timers.cipherTime(time: time, toJSON: true);

      // Assert
      expect(result, expected);
    });

    test('cipherTime should return null when time is null', () {
      // Arrange
      final expected = null;

      // Act
      final result = Timers.cipherTime(time: null, toJSON: true);

      // Assert
      expect(result, expected);
    });

    test(
        'cipherTime should return ciphered DateTime in '
        'ISO 8601 format with non-zero milliseconds when '
        'toJSON is true', () {
      // Arrange
      final time = DateTime(2023, 3, 27, 10, 30, 3, 456);
      final expected = Timers.cipherDateTimeIso8601(
        time: time,
      );

      // Act
      final result = Timers.cipherTime(time: time, toJSON: true);
      print('result is : $result');

      // Assert
      expect(result, expected);
      expect(result.contains('.456'), true);
    });

    test('cipherTime should return UTC DateTime with non-zero microseconds when toJSON is false',
        () {
      // Arrange
      final time = DateTime(2023, 3, 27, 10, 30, 0, 123, 456);
      final expected = time.toUtc();

      // Act
      final DateTime result = Timers.cipherTime(time: time, toJSON: false);

      // Assert
      expect(result, expected);
      print('result.microsecond : ${result.microsecond} : ${result.millisecond}');
      expect(expected.microsecond, expected.microsecond);
      expect(result.millisecond, 123);
      expect(result.microsecond, 456);

      final time2 = DateTime(2023, 3, 27, 10, 30, 0, 1234, 456);
      expect(time2.second, 1);
      expect(time2.millisecond, 234);

      final time3 = DateTime(2023, 3, 27, 10, 30, 0, 0, 999);
      expect(time3.millisecond, 0);
      expect(time3.microsecond, 999);

      final time4 = DateTime(2023, 3, 27, 10, 30, 0, 0, 1000);
      expect(time4.millisecond, 1);
      expect(time4.microsecond, 0);
    });

    test(
        'cipherTime should return ciphered DateTime with timezone offset when time is in a non-UTC timezone and toJSON is true',
        () {
      // Arrange
      final time = DateTime.parse('2023-03-27 10:30:00-05:00');
      final expected = Timers.cipherDateTimeIso8601(
        time: time,
      );

      // Act
      final result = Timers.cipherTime(time: time, toJSON: true);

      // Assert
      expect(result, expected);
    });

    test(
        'cipherTime should return UTC DateTime when time is in a non-UTC timezone and toJSON is false',
        () {
      // Arrange
      final time = DateTime.parse('2023-03-27 10:30:00-05:00');
      final expected = time.toUtc();

      // Act
      final result = Timers.cipherTime(time: time, toJSON: false);

      // Assert
      expect(result, expected);
      expect(result.timeZoneName, 'UTC');
    });

  });

  group('Timers.decipherTime', () {

    test('decipherTime with null value', () {
      final result = Timers.decipherTime(time: null, fromJSON: false);
      expect(result, null);
    });

    test('decipherTime with JSON value', () {
      final result = Timers.decipherTime(time: '2022-03-28T10:30:00Z', fromJSON: true);
      expect(result, isA<DateTime>());
    });

    test('decipherTime with Timestamp value', () {
      final Timestamp timestamp = Timestamp.fromDate(DateTime(2022, 3, 28));
      final result = Timers.decipherTime(time: timestamp, fromJSON: false);
      expect(result, isA<DateTime>());
    });

    test('decipherTime with DateTime value', () {
      final DateTime dateTime = DateTime(2022, 3, 28);
      final result = Timers.decipherTime(time: dateTime, fromJSON: false);
      expect(result, isA<DateTime>());
    });

    test('decipherTime with null value', () {
      final result = Timers.decipherTime(time: null, fromJSON: false);
      expect(result, null);
    });

    test('decipherTime with JSON value', () {
    final result = Timers.decipherTime(time: '2022-03-28T10:30:00Z', fromJSON: true);
    expect(result, isA<DateTime>());
  });

  test('decipherTime with Timestamp value', () {
    final Timestamp timestamp = Timestamp.fromDate(DateTime(2022, 3, 28));
    final result = Timers.decipherTime(time: timestamp, fromJSON: false);
    expect(result, isA<DateTime>());
  });

  test('decipherTime with DateTime value', () {
    final DateTime dateTime = DateTime(2022, 3, 28);
    final result = Timers.decipherTime(time: dateTime, fromJSON: false);
    expect(result, isA<DateTime>());
  });


  });

  group('Timers.cipherTimes', () {

    test('cipherTimes with valid input', () {
      final List<DateTime> times = [
        DateTime(2022, 3, 28),
        DateTime(2022, 3, 29),
        DateTime(2022, 3, 30)
      ];
      final result = Timers.cipherTimes(times: times, toJSON: true);
      expect(result, isA<List<dynamic>>());
      expect(result.length, times.length);
    });

    test('cipherTimes with empty list', () {
      final List<DateTime> times = [];
      final result = Timers.cipherTimes(times: times, toJSON: true);
      expect(result, isA<List<dynamic>>());
      expect(result.length, times.length);
    });

    // test('cipherTimes with invalid input', () {
    //   final List<DateTime> times = [DateTime(2022, 3, 28), null, DateTime(2022, 3, 30)];
    //   final List<dynamic> deciphered = Timers.cipherTimes(times: times, toJSON: true);
    //   final List<DateTime> timesAgain = Timers.decipherTimes(times: deciphered, fromJSON: true);
    //
    //   for (int i = 0; i < times.length; i++) {
    //     expect(timesAgain[i], times[i]);
    //   }
    // });

    test('cipherTimes with valid input and fromJSON=true', () {
      final List<DateTime> times = [
        DateTime(2022, 3, 28),
        DateTime(2022, 3, 29),
        DateTime(2022, 3, 30)
      ];
      final result = Timers.cipherTimes(times: times, toJSON: true);
      expect(result, isA<List<dynamic>>());
      expect(result.length, times.length);
      expect(result[0], isA<String>());
      expect(result[1], isA<String>());
      expect(result[2], isA<String>());
    });

    test('cipherTimes with empty list and fromJSON=true', () {
      final List<DateTime> times = [];
      final result = Timers.cipherTimes(times: times, toJSON: true);
      expect(result, isA<List<dynamic>>());
      expect(result.length, times.length);
    });

    test('cipherTimes with empty list and fromJSON=false', () {
      final List<dynamic> times = [];
      final result = Timers.cipherTimes(times: times.cast<DateTime>(), toJSON: false);
      expect(result, isA<List<dynamic>>());
      expect(result.length, times.length);
    });

  });

  group('Timers.decipherTimes', () {

    test('decipherTimes with valid input and fromJSON=true', () {
      final List<dynamic> times = <String>[
        '2022-03-28T00:00:00Z',
        '2022-03-29T00:00:00Z',
        '2022-03-30T00:00:00Z'
      ];
      final List<DateTime?> result = Timers.decipherTimes(times: times, fromJSON: true)!;
      expect(true, times is List<String>);
      expect(result.length, times.length);
      expect(result[0], isA<DateTime>());
      expect(result[1], isA<DateTime>());
      expect(result[2], isA<DateTime>());
    });

    test('decipherTimes with valid input and fromJSON=false', () {
      final List<DateTime> times = [
        DateTime(2022, 3, 28),
        DateTime(2022, 3, 29),
        DateTime(2022, 3, 30)
      ];
      final result = Timers.decipherTimes(times: times.cast<dynamic>(), fromJSON: false)!;
      // expect(result, isA<List<DateTime>>());
      expect(result.length, times.length);
      expect(result[0], isA<DateTime>());
      expect(result[1], isA<DateTime>());
      expect(result[2], isA<DateTime>());
    });

    test('decipherTimes with empty list and fromJSON=true', () {
      final List<dynamic> times = [];
      final result = Timers.decipherTimes(times: times, fromJSON: true);
      // expect(result, isA<List<DateTime>>());
      expect(result?.length, times.length);
    });

    test('decipherTimes with empty list and fromJSON=false', () {
      final List<DateTime> times = [];
      final result = Timers.decipherTimes(times: times.cast<dynamic>(), fromJSON: false);
      // expect(result is List<DateTime?>?, true);
      expect(result?.length, times.length);
    });

    test('decipherTimes with null input and fromJSON=true', () {
      final List<dynamic>? times = null;
      final result = Timers.decipherTimes(times: times, fromJSON: true);
      expect(result, []);
    });


    test('decipherTimes with mixed input and fromJSON=true', () {
      final List<DateTime?> times = [
        null,
        DateTime(2022, 3, 30),
      ];

      final List<dynamic> ciphered = Timers.cipherTimes(
          times: times,
          toJSON: true,
      );

      final List<DateTime?> deciphered = Timers.decipherTimes(
          times: ciphered,
          fromJSON: true,
      )!;

      expect(deciphered[0], null);
      expect(deciphered[1], times[1]);

    });
  });

  group('Timers.cipherDateTimeIso8601', () {

    test('cipherDateTimeIso8601 with null input', () {
      final result = Timers.cipherDateTimeIso8601(time: null);
      expect(result, isNull);
    });

    test('cipherDateTimeIso8601 with valid input and toUTC=false', () {
      final result = Timers.cipherDateTimeIso8601(time: DateTime(2022, 3, 28, 10, 30, 0), toUTC: false);
      expect(result, equals('2022-03-28T10:30:00.000'));
    });

    test('cipherDateTimeIso8601 with valid input and toUTC=true', () {
      final result = Timers.cipherDateTimeIso8601(time: DateTime(2022, 3, 28, 10, 30, 0), toUTC: true);
      // note that this test is written in egypt which is +2Hr
      expect(result, equals('2022-03-28T08:30:00.000Z'));
    });

    test('cipherDateTimeIso8601 with valid input and toUTC=null', () {
      final result = Timers.cipherDateTimeIso8601(time: DateTime(2022, 3, 28, 10, 30, 0), toUTC: false);
      expect(result, equals('2022-03-28T10:30:00.000'));
    });

    test('cipherDateTimeIso8601 with valid input and toUTC=true and non-zero offset', () {
      final result = Timers.cipherDateTimeIso8601(
          time: DateTime(2022, 3, 28, 10, 30, 0, 0).add(Duration(hours: 3)),
          toUTC: true
      );
      expect(result, equals('2022-03-28T11:30:00.000Z'));
    });



  });

  group('Timers.decipherDateTimeIso8601', () {

    test('decipherDateTimeIso8601 with null input', () {
      final result = Timers.decipherDateTimeIso8601(timeString: null);
      expect(result, isNull);
    });

    test('decipherDateTimeIso8601 with valid input and toLocal=true', () {
      final result =
          Timers.decipherDateTimeIso8601(timeString: '2022-03-28T10:30:00.000Z', toLocal: true);
      expect(result, equals(DateTime.utc(2022, 3, 28, 10, 30, 0).toLocal()));
    });

    test('decipherDateTimeIso8601 with valid input and toLocal=false', () {
      final result = Timers.decipherDateTimeIso8601(timeString: '2022-03-28T10:30:00.000Z', toLocal: false);
      expect(result, equals(DateTime.utc(2022, 3, 28, 10, 30, 0)));
    });

    test('decipherDateTimeIso8601 with invalid input', () {
      final result = Timers.decipherDateTimeIso8601(timeString: 'invalid');
      expect(result, isNull);
    });

    test('decipherDateTimeIso8601 1', () {
      final DateTime? result = Timers.decipherDateTimeIso8601(
          timeString: '2022-03-28T10:30:00.000+00:00',
          toLocal: true,
      );
      final DateTime expected = DateTime(2022, 3, 28, 12, 30, 0);
      expect(result, expected);
    });

    test('decipherDateTimeIso8601 2', () {
      final DateTime? result = Timers.decipherDateTimeIso8601(
          timeString: '2022-03-28T10:30:00.000+01:00',
          toLocal: true,
      );
      print('result : $result');
      final DateTime expected = DateTime(2022, 3, 28, 11, 30, 0);
      print('expected : $expected');
      expect(result, expected);
    });

    test('decipherDateTimeIso8601 3', () {
      final DateTime? result = Timers.decipherDateTimeIso8601(
          timeString: '2022-03-28T10:30:00.000+02:00',
          toLocal: true,
      );
      print('result : $result');
      final DateTime expected = DateTime(2022, 3, 28, 10, 30, 0);
      print('expected : $expected');
      expect(result, expected);
    });

    test('decipherDateTimeIso8601 4', () {
      final DateTime? result = Timers.decipherDateTimeIso8601(
          timeString: '2022-03-28T10:30:00.000+02:00',
          toLocal: false,
      );
      print('result : $result');
      final DateTime expected = DateTime(2022, 3, 28, 10, 30, 0).toUtc();
      print('expected : $expected');
      expect(result, expected);
    });

    test('decipherDateTimeIso8601 with valid input and toLocal=false and zero offset', () {
      final result = Timers.decipherDateTimeIso8601(
          timeString: '2022-03-28T10:30:00.000Z',
          toLocal: false,
      );
      expect(result, equals(DateTime.utc(2022, 3, 28, 10, 30, 0)));
    });

  });

  group('decipherDateTimeIso8601ToTimeStamp', () {

    test('decipherDateTimeIso8601ToTimeStamp with null input', () {
      final Timestamp? result = Timers.decipherDateTimeIso8601ToTimeStamp(
        timeString: null,
        toLocal: true,
      );
      expect(result, null);
    });

    test('decipherDateTimeIso8601ToTimeStamp with invalid input', () {
      final Timestamp? result = Timers.decipherDateTimeIso8601ToTimeStamp(
        timeString: 'invalid date',
        toLocal: true,
      );
      expect(result, null);
    });

    test('decipherDateTimeIso8601ToTimeStamp with UTC', () {
      final Timestamp? result = Timers.decipherDateTimeIso8601ToTimeStamp(
        timeString: '2022-03-28T10:30:00.000Z',
        toLocal: false,
      );
      final Timestamp expected = Timestamp.fromDate(DateTime.utc(2022, 3, 28, 10, 30));
      expect(result, expected);
    });

    test('decipherDateTimeIso8601ToTimeStamp with local', () {
      final Timestamp? result = Timers.decipherDateTimeIso8601ToTimeStamp(
        timeString: '2022-03-28T10:30:00.000+01:00',
        toLocal: true,
      );
      final Timestamp expected = Timestamp.fromDate(DateTime(2022, 3, 28, 11, 30, 0));
      expect(result, expected);
    });

    test('decipherDateTimeIso8601ToTimeStamp with null', () {
      final Timestamp? result = Timers.decipherDateTimeIso8601ToTimeStamp(
        timeString: null,
        toLocal: true,
      );
      final Timestamp? expected = null;
      expect(result, expected);
    });

  });

}
