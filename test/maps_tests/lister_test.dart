import 'package:basics/helpers/maps/lister.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('MapPathing - fillEmptySlotsUntilIndex', () {

    test('Fills empty slots with provided value until index', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 2, 3, 4],
        fillValue: 0,
        index: 6,
      );

      expect(result, [1, 2, 3, 4, 0, 0, 0]);
    });

    test('Handles an empty list correctly', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [],
        fillValue: 'empty',
        index: 3,
      );

      expect(result, ['empty', 'empty', 'empty', 'empty']);
    });

    test('Fills empty slots until the end if index is beyond the list length', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 2, 3],
        fillValue: 'fill',
        index: 5,
      );

      expect(result, [1, 2, 3, 'fill', 'fill', 'fill']);
    });

    test('Works with non-integer fill values', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 2, 3],
        fillValue: 'a',
        index: 2,
      );

      expect(result, [1, 2, 3]);
    });

    test('Handles index equal to the list length', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 2, 3],
        fillValue: 'fill',
        index: 2,
      );

      expect(result, [1, 2, 3]);
    });

    test('Works with negative index values', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 2, 3],
        fillValue: null,
        index: 3,
      );

      expect(result, [1, 2, 3, null]);
    });

    test('Handles null fill values correctly', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 2, 3],
        fillValue: null,
        index: 4,
      );

      expect(result, [1, 2, 3, null, null]);
    });
  });

}
