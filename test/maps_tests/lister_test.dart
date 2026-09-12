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

    test('Preserves null entries already inside the list unchanged', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, null, 3, null],
        fillValue: 'X',
        index: 6,
      );

      expect(result, [1, null, 3, null, 'X', 'X', 'X']);
    });

    test('Copied entries stay distinguishable from padding when both are null', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [null, 1, null],
        fillValue: null,
        index: 5,
      );

      expect(result, [null, 1, null, null, null, null]);
      expect(result.length, 6);
    });

    test('Handles a deeply negative index by returning the list unchanged (no padding)', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 2, 3],
        fillValue: 'fill',
        index: -100,
      );

      expect(result, [1, 2, 3]);
    });

    test('Handles a large index by padding a single item far out', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1],
        fillValue: 0,
        index: 999,
      );

      expect(result.length, 1000);
      expect(result[0], 1);
      expect(result.sublist(1).every((v) => v == 0), isTrue);
    });

    test('Reuses the exact same fillValue reference (a Map) for every padded slot', () {
      final Map<String, int> sharedFill = {'a': 1};
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [],
        fillValue: sharedFill,
        index: 2,
      );

      expect(result.length, 3);
      expect(result.every((v) => identical(v, sharedFill)), isTrue);
    });

    test('Preserves list-typed and bool-typed elements without altering their identity', () {
      final List<int> nestedList = [9, 9];
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [true, nestedList, false],
        fillValue: 'pad',
        index: 4,
      );

      expect(result, [true, nestedList, false, 'pad', 'pad']);
      expect(identical(result[1], nestedList), isTrue);
    });

    test('Pads exactly one slot when index is exactly the list length', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 2, 3],
        fillValue: 'fill',
        index: 3,
      );

      expect(result, [1, 2, 3, 'fill']);
    });

    test('Does not mutate the original input list', () {
      final original = [1, 2, 3];
      Lister.fillEmptySlotsUntilIndex(
        list: original,
        fillValue: 0,
        index: 6,
      );

      expect(original, [1, 2, 3]);
    });

    test('Copies mixed-type entries in order without dropping or reordering any', () {
      final result = Lister.fillEmptySlotsUntilIndex(
        list: [1, 'two', 3.0, null, true],
        fillValue: 'pad',
        index: 7,
      );

      expect(result, [1, 'two', 3.0, null, true, 'pad', 'pad', 'pad']);
    });
  });

}
