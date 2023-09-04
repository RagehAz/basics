// ignore_for_file: avoid_redundant_argument_values

import 'package:basics/helpers/classes/time/timers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Sorting DateTimes after Ciphering', () {

    test('Sort DateTimes after ciphering to int', () {
      final dateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 0, 500000), // Microsecond level
        DateTime.utc(2023, 9, 4, 15, 30, 0, 250000), // Microsecond level
        DateTime.utc(2023, 9, 6, 8, 45, 0, 750000), // Microsecond level
      ];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      cipheredIntList.sort();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      final expectedDateTimeList = [
        DateTime.utc(2023, 9, 4, 15, 30, 0, 250000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 500000), // Microsecond level
        DateTime.utc(2023, 9, 6, 8, 45, 0, 750000), // Microsecond level
      ];

      final actualDateTimeList = sortedDateTimeList.map((dt) => dt?.toUtc()).toList();

      expect(actualDateTimeList, expectedDateTimeList);
    });

    test('Sort DateTimes after ciphering to int', () {
      final dateTimeList = [
        DateTime(2023, 9, 5, 10, 0),
        DateTime(2023, 9, 4, 15, 30),
        DateTime(2023, 9, 6, 8, 45),
      ];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      cipheredIntList.sort();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      expect(sortedDateTimeList, [
        DateTime(2023, 9, 4, 15, 30),
        DateTime(2023, 9, 5, 10, 0),
        DateTime(2023, 9, 6, 8, 45),
      ]);
    });

    test('Sort DateTimes after ciphering to int (Single DateTime)', () {
      final dateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0),
      ];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      final expectedDateTime = DateTime.utc(2023, 9, 5, 10, 0); // Expected DateTime in UTC

      // Convert actual DateTime to UTC
      final actualDateTime = sortedDateTimeList[0]?.toUtc();

      expect(actualDateTime, expectedDateTime);
    });

    test('Sort DateTimes after ciphering to int (Duplicate DateTimes)', () {
      final dateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0),
        DateTime.utc(2023, 9, 5, 10, 0),
        DateTime.utc(2023, 9, 5, 10, 0),
      ];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      // Sort the ciphered integers to ensure consistency
      cipheredIntList.sort();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      final expectedDateTime = DateTime.utc(2023, 9, 5, 10, 0); // Expected DateTime in UTC

      // Convert actual DateTimes to UTC for comparison
      final actualDateTimeList = sortedDateTimeList.map((dt) => dt?.toUtc()).toList();

      expect(actualDateTimeList, [
        expectedDateTime,
        expectedDateTime,
        expectedDateTime,
      ]);
    });

    test('Sort DateTimes to the Second', () {
      final dateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 30), // Second level
        DateTime.utc(2023, 9, 5, 10, 0, 15), // Second level
        DateTime.utc(2023, 9, 5, 10, 0, 45), // Second level
      ];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      cipheredIntList.sort();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      final expectedDateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 15), // Second level
        DateTime.utc(2023, 9, 5, 10, 0, 30), // Second level
        DateTime.utc(2023, 9, 5, 10, 0, 45), // Second level
      ];

      final actualDateTimeList = sortedDateTimeList.map((dt) => dt?.toUtc()).toList();

      expect(actualDateTimeList, expectedDateTimeList);
    });

    test('Sort DateTimes after ciphering to int (Empty List)', () {
      final dateTimeList = <DateTime>[];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      cipheredIntList.sort();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      expect(sortedDateTimeList, []);
    });

    test('Sort DateTimes to the Microsecond', () {
      final dateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 0, 500000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 250000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 750000), // Microsecond level
      ];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      cipheredIntList.sort();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      final expectedDateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 0, 250000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 500000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 750000), // Microsecond level
      ];

      final actualDateTimeList = sortedDateTimeList.map((dt) => dt?.toUtc()).toList();

      expect(actualDateTimeList, expectedDateTimeList);
    });

    test('Sort DateTimes to the Nanosecond', () {
      final dateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 0, 0, 500000), // Nanosecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 0, 250000), // Nanosecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 0, 750000), // Nanosecond level
      ];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      cipheredIntList.sort();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      final expectedDateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 0, 0, 250000), // Nanosecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 0, 500000), // Nanosecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 0, 750000), // Nanosecond level
      ];

      final actualDateTimeList = sortedDateTimeList.map((dt) => dt?.toUtc()).toList();

      expect(actualDateTimeList, expectedDateTimeList);
    });

    test('Sort DateTimes with Unified Integers', () {
      final dateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 0, 260000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 250000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 290000), // Microsecond level
      ];

      final cipheredIntList =
          dateTimeList.map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime)).toList();

      cipheredIntList.sort();

      final sortedDateTimeList = cipheredIntList
          .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
          .toList();

      final expectedDateTimeList = [
        DateTime.utc(2023, 9, 5, 10, 0, 0, 250000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 260000), // Microsecond level
        DateTime.utc(2023, 9, 5, 10, 0, 0, 290000), // Microsecond level
      ];

      final actualDateTimeList = sortedDateTimeList.map((dt) => dt?.toUtc()).toList();

      expect(actualDateTimeList, expectedDateTimeList);
    });

    test('Sort DateTimes with Duplicates and UTC Handling', () {
  final dateTimeList = [
    DateTime.utc(2023, 9, 5, 10, 0, 0, 500000), // Microsecond level
    DateTime.utc(2023, 9, 5, 10, 0, 0, 250000), // Microsecond level
    DateTime.utc(2023, 9, 5, 10, 0, 0, 750000), // Microsecond level
    DateTime.utc(2023, 9, 5, 10, 0, 0, 500000), // Microsecond level (duplicate)
  ];

  final cipheredIntList = dateTimeList
      .map((dateTime) => Timers.cipherDateTimeToInt(time: dateTime))
      .toList();

  cipheredIntList.sort();

  final sortedDateTimeList = cipheredIntList
      .map((cipheredInt) => Timers.decipherIntToDateTime(integer: cipheredInt))
      .toList();

  final expectedDateTimeList = [
    DateTime.utc(2023, 9, 5, 10, 0, 0, 250000), // Microsecond level
    DateTime.utc(2023, 9, 5, 10, 0, 0, 500000), // Microsecond level
    DateTime.utc(2023, 9, 5, 10, 0, 0, 500000), // Microsecond level (duplicate)
    DateTime.utc(2023, 9, 5, 10, 0, 0, 750000), // Microsecond level
  ];

  final actualDateTimeList = sortedDateTimeList.map((dt) => dt?.toUtc()).toList();

  expect(actualDateTimeList, expectedDateTimeList);
});

  });

}
