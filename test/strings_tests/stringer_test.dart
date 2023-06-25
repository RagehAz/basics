import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:flutter_test/flutter_test.dart';

// write a flutter test group that includes several tests for following function
void main(){
  // -----------------------------------------------------------------------------

  /// checkStringsContainString

  // --------------------
  group('checkStringsContainString',(){

    test('Test that the function returns true when the input strings list contains the input string', () {
      const List<String> strings = ['hello', 'world', 'foo', 'bar'];
      const String string = 'foo';
      expect(Stringer.checkStringsContainString(strings: strings, string: string), equals(true));
    });

    test('Test that the function returns false when the input strings list does not contain the input string', () {
      const List<String> strings = ['hello', 'world', 'foo', 'bar'];
      const String string = 'baz';
      expect(Stringer.checkStringsContainString(strings: strings, string: string), equals(false));
    });

    test('Test that the function returns false when the input strings list is null', () {
      const List<String>? strings = null;
      const String string = 'hello';
      expect(Stringer.checkStringsContainString(strings: strings, string: string), equals(false));
    });

    test('Test that the function returns false when the input string is null', () {
      const List<String> strings = ['hello', 'world', 'foo', 'bar'];
      const String? string = null;
      expect(Stringer.checkStringsContainString(strings: strings, string: string), equals(false));
    });

    test('Test that the function returns false when both the input strings list and the input string are null', () {
      const List<String>? strings = null;
      const String? string = null;
      expect(Stringer.checkStringsContainString(strings: strings, string: string), equals(false));
    });

  });
  // -----------------------------------------------------------------------------

  /// addStringToListIfDoesNotContainIt

  // --------------------
  group('addStringToListIfDoesNotContainIt', () {

    test('Test that the function adds the input stringToAdd to the '
            'input strings list if it does not already contain it', () {
      const List<String> strings = ['hello', 'world', 'foo'];
      const String stringToAdd = 'bar';
      expect(Stringer.addStringToListIfDoesNotContainIt(
          strings: strings,
          stringToAdd: stringToAdd
      ),
          equals(['hello', 'world', 'foo', 'bar']));
    });

    test(
        'Test that the function does not add the input stringToAdd to the input strings list if it already contains it',
        () {
      const List<String> strings = ['hello', 'world', 'foo'];
      const String stringToAdd = 'foo';
      expect(Stringer.addStringToListIfDoesNotContainIt(strings: strings, stringToAdd: stringToAdd),
          equals(['hello', 'world', 'foo']));
    });

    test('Test that the function returns an empty list when '
        'the input strings list is null', () {
      const List<String>? strings = null;
      const String stringToAdd = 'bar';
      expect(Stringer.addStringToListIfDoesNotContainIt(
          strings: strings,
          stringToAdd: stringToAdd),
          equals(['bar']));
    });

    test('Test that the function returns an empty list when '
        'the input stringToAdd is null', () {
      const List<String> strings = ['hello', 'world', 'foo'];
      const String? stringToAdd = null;
      expect(Stringer.addStringToListIfDoesNotContainIt(strings: strings, stringToAdd: stringToAdd),
          equals(['hello', 'world', 'foo']));
    });

    test('Test that the function returns an empty list when '
        'both the input strings list and the input stringToAdd are null',
        () {
      const List<String>? strings = null;
      const String? stringToAdd = null;
      expect(Stringer.addStringToListIfDoesNotContainIt(strings: strings, stringToAdd: stringToAdd),
          equals([]));
    });

  });
  // -----------------------------------------------------------------------------

  /// addStringsToStringsIfDoNotContainThem

  // --------------------
  group('addStringsToStringsIfDoNotContainThem', () {

    test('should add strings to list if they do not contain them', () {
      final listToTake = ['a', 'b', 'c'];
      final listToAdd = ['d', 'e', 'f'];

      final result = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: listToTake, listToAdd: listToAdd);

      expect(result, ['a', 'b', 'c', 'd', 'e', 'f']);
    });

    test('should not add strings that already exist in the list', () {
      final listToTake = ['a', 'b', 'c'];
      final listToAdd = ['b', 'c', 'd'];

      final result = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: listToTake,
          listToAdd: listToAdd
      );

      expect(result, ['a', 'b', 'c', 'd']);
    });

    test('should return original list if listToAdd is empty', () {
      final listToTake = ['a', 'b', 'c'];
      final listToAdd = <String>[];

      final result = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: listToTake,
          listToAdd: listToAdd
      );

      expect(result, ['a', 'b', 'c']);
    });

    test('should return empty list if both listToTake and listToAdd are empty', () {
      final listToTake = <String>[];
      final listToAdd = <String>[];

      final result = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: listToTake,
          listToAdd: listToAdd
      );

      expect(result, <String>[]);
    });

    test('should return empty list if listToTake is null', () {
      final listToAdd = ['a', 'b', 'c'];

      final result = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: null,
          listToAdd: listToAdd,
      );

      expect(result, <String>['a', 'b', 'c']);
    });

    test('should add strings to list if they do not contain them', () {
      final listToTake = ['a', 'b', 'c'];
      final listToAdd = ['d', 'e', 'f'];

      final result = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: listToTake, listToAdd: listToAdd);

      expect(result, ['a', 'b', 'c', 'd', 'e', 'f']);
    });

    test('should return original list if listToAdd is empty', () {
      final listToTake = ['a', 'b', 'c'];
      final listToAdd = <String>[];

      final result = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: listToTake,
          listToAdd: listToAdd
      );

      expect(result, ['a', 'b', 'c']);
    });

    test('should return empty list if both listToTake and listToAdd are empty', () {
      final listToTake = <String>[];
      final listToAdd = <String>[];

      final result = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: listToTake,
          listToAdd: listToAdd,
      );

      expect(result, <String>[]);
    });

    test('should return empty list if listToAdd is null', () {
      final listToTake = ['a', 'b', 'c'];

      final result =
          Stringer.addStringsToStringsIfDoNotContainThem(listToTake: listToTake, listToAdd: null);

      expect(result, ['a', 'b', 'c']);
    });

    test('should return listToTake if listToAdd is null and listToTake is null', () {
      final result =
          Stringer.addStringsToStringsIfDoNotContainThem(listToTake: null, listToAdd: null);

      expect(result, []);
    });

  });
  // -----------------------------------------------------------------------------

  /// addOrRemoveStringToStrings

  // --------------------
  group('addOrRemoveStringToStrings', () {

    test('adds a string when it is not present in the list', () {
      final strings = ['foo', 'bar'];
      const string = 'baz';
      final output = Stringer.addOrRemoveStringToStrings(strings: strings, string: string);
      expect(output, equals(['foo', 'bar', 'baz']));
    });

    test('removes a string when it is present in the list', () {
      final strings = ['foo', 'bar', 'baz'];
      const string = 'bar';
      final output = Stringer.addOrRemoveStringToStrings(strings: strings, string: string);
      expect(output, equals(['foo', 'baz']));
    });

    test('null input strings return empty list', () {
      const strings = null;
      const string = 'baz';
      final output = Stringer.addOrRemoveStringToStrings(strings: strings, string: string);
      expect(output, equals(['baz']));
    });

    test('null input string return original list', () {
      final strings = ['foo', 'bar'];
      const string = null;
      final output = Stringer.addOrRemoveStringToStrings(
          strings: strings,
          string: string,
      );
      expect(output, equals(strings));
    });

    test('adds an empty string', () {
      final strings = ['foo', 'bar'];
      const string = '';
      final output = Stringer.addOrRemoveStringToStrings(strings: strings, string: string);
      expect(output, equals(['foo', 'bar', '']));
    });

    test('removes an empty string', () {
      final strings = ['foo', 'bar', ''];
      const string = '';
      final output = Stringer.addOrRemoveStringToStrings(strings: strings, string: string);
      expect(output, equals(['foo', 'bar']));
    });

    test('handles whitespace strings', () {
      final strings = ['foo', 'bar'];
      const string = ' ';
      final output = Stringer.addOrRemoveStringToStrings(strings: strings, string: string);
      expect(output, equals(['foo', 'bar', ' ']));
    });

    test('handles leading and trailing whitespaces', () {
      final strings = ['foo', 'bar'];
      const string = '   baz   ';
      final output = Stringer.addOrRemoveStringToStrings(strings: strings, string: string);
      expect(output, equals(['foo', 'bar', '   baz   ']));
    });

    test('handles multiple occurrences of the same string', () {
      final strings = ['foo', 'bar', 'baz', 'baz'];
      const string = 'baz';

      final output = Stringer.addOrRemoveStringToStrings(
          strings: strings,
          string: string
      );

      expect(output, equals(['foo', 'bar']));
    });

  });
  // -----------------------------------------------------------------------------

  /// removeStringsFromStrings

  // --------------------
  group('removeStringsFromStrings tests', () {

    test('removes strings from list', () {
      final List<String> removeFrom = ['a', 'b', 'c', 'd'];
      final List<String> removeThis = ['a', 'c'];
      final List<String> expectedOutput = ['b', 'd'];

      expect(Stringer.removeStringsFromStrings(
          removeFrom: removeFrom,
          removeThis: removeThis),
          expectedOutput);

    });

    test('does not remove any strings when list is empty', () {
      final List<String> removeFrom = [];
      final List<String> removeThis = ['a', 'c'];
      final List<String> expectedOutput = [];

      expect(Stringer.removeStringsFromStrings(removeFrom: removeFrom, removeThis: removeThis),
          expectedOutput);
    });

    test('does not remove any strings when removeThis list is empty', () {
      final List<String> removeFrom = ['a', 'b', 'c', 'd'];
      final List<String> removeThis = [];
      final List<String> expectedOutput = ['a', 'b', 'c', 'd'];

      expect(Stringer.removeStringsFromStrings(removeFrom: removeFrom, removeThis: removeThis),
          expectedOutput);
    });

    test('throws error when removeFrom list is null', () {
      const List<String>? removeFrom = null;
      final List<String> removeThis = ['a', 'c'];

      expect(Stringer.removeStringsFromStrings(
              removeFrom: removeFrom,
              removeThis: removeThis),
          []);
    });

    test('throws error when removeThis list is null', () {

      final List<String> removeFrom = ['a', 'b', 'c', 'd'];
      const List<String>? removeThis = null;

      expect(Stringer.removeStringsFromStrings(
          removeFrom: removeFrom,
          removeThis: removeThis),
          ['a', 'b', 'c', 'd']);
    });

  });
  // -----------------------------------------------------------------------------

  /// putStringInStringsIfAbsent

  // --------------------
  group('putStringInStringsIfAbsent tests', () {

    test('a', () {
      final List<String> strings = ['a', 'b', 'c'];
      const String string = 'd';
      final List<String> expectedOutput = ['a', 'b', 'c', 'd'];

      expect(Stringer.putStringInStringsIfAbsent(strings: strings, string: string), expectedOutput);
    });

    test('b', () {
      final List<String> strings = ['a', 'b', 'c'];
      const String string = 'c';
      final List<String> expectedOutput = ['a', 'b', 'c'];

      expect(Stringer.putStringInStringsIfAbsent(strings: strings, string: string), expectedOutput);
    });

    test('c', () {
      final List<String> strings = [];
      const String string = 'c';
      final List<String> expectedOutput = ['c'];

      expect(Stringer.putStringInStringsIfAbsent(
          strings: strings,
          string: string),
          expectedOutput);
    });

    test('d', () {
      const List<String>? strings = null;
      const String string = 'c';

      expect(Stringer.putStringInStringsIfAbsent(
          strings: strings,
          string: string),
          ['c']);
    });

    test('e', () {
      final List<String> strings = ['a', 'b', 'c'];
      const String? string = null;

      expect(Stringer.putStringInStringsIfAbsent(
          strings: strings,
          string: string),
          ['a', 'b', 'c']);
    });

  });
  // -----------------------------------------------------------------------------

  /// cleanDuplicateStrings

  // --------------------
  group('cleanDuplicateStrings tests', () {

    test('removes duplicate strings from list', () {
      final List<String> strings = ['a', 'b', 'c', 'a', 'b'];
      final List<String> expectedOutput = ['a', 'b', 'c'];

      expect(Stringer.cleanDuplicateStrings(strings: strings), expectedOutput);
    });

    test('returns same list when no duplicates', () {
      final List<String> strings = ['a', 'b', 'c'];
      final List<String> expectedOutput = ['a', 'b', 'c'];

      expect(Stringer.cleanDuplicateStrings(strings: strings), expectedOutput);
    });

    test('returns empty list when input is empty', () {
      final List<String> strings = [];
      final List<String> expectedOutput = [];
      expect(Stringer.cleanDuplicateStrings(strings: strings), expectedOutput);
    });

    test('throws error when strings list is null', () {
      const List<String>? strings = null;
      expect(Stringer.cleanDuplicateStrings(strings: strings), []);
    });

  });
  // -----------------------------------------------------------------------------

  /// cleanListNullItems

  // --------------------
  group('cleanListNullItems', () {

    test('removes null items from list', () {
      final input = ['a', 'b', null, 'c', 'null', null];
      final expectedOutput = ['a', 'b', 'c'];
      final output = Stringer.cleanListNullItems(input);
      expect(output, expectedOutput);
    });

    test('removes "null" string items from list', () {
      final input = ['a', 'b', 'null', 'c', 'null', 'd'];
      final expectedOutput = ['a', 'b', 'c', 'd'];
      final output = Stringer.cleanListNullItems(input);
      expect(output, expectedOutput);
    });

    test('returns empty list if input is null', () {
      const input = null;
      final expectedOutput = <String>[];
      final output = Stringer.cleanListNullItems(input);
      expect(output, expectedOutput);
    });

    test('returns original list if no null items present', () {
      final input = ['a', 'b', 'c'];
      final expectedOutput = ['a', 'b', 'c'];
      final output = Stringer.cleanListNullItems(input);
      expect(output, expectedOutput);
    });

  });
  // -----------------------------------------------------------------------------

  /// nullifyNullString

  // --------------------
  group('nullifyNullString', () {

    test('returns null for null input', () {
      const input = null;
      const expectedOutput = null;
      final output = Stringer.nullifyNullString(input);
      expect(output, expectedOutput);
    });

    test('returns null for string "null" input', () {
      const input = 'null';
      const expectedOutput = null;
      final output = Stringer.nullifyNullString(input);
      expect(output, expectedOutput);
    });

    test('returns null for list ["null"] input', () {
      final input = ['null'];
      const expectedOutput = null;
      final output = Stringer.nullifyNullString(input);
      expect(output, expectedOutput);
    });

    test('returns original input for non-null input', () {
      const input = 'hello';
      const expectedOutput = 'hello';
      final output = Stringer.nullifyNullString(input);
      expect(output, expectedOutput);
    });

    test('returns original input for non-null list', () {
      final input = ['hello', 'world'];
      // final expectedOutput = ['hello', 'world'];
      final dynamic output = Stringer.nullifyNullString(input);
      expect(output, ['hello', 'world']);
    });

  });
  // -----------------------------------------------------------------------------

  /// sortAlphabetically

  // --------------------
  group('sortAlphabetically', () {

    test('sorts a list of strings alphabetically', () {
      final input = ['c', 'b', 'a', 'd'];
      final expectedOutput = ['a', 'b', 'c', 'd'];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('returns empty list if input is null', () {
      const input = null;
      final expectedOutput = <String>[];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('returns original list if input is already sorted', () {
      final input = ['a', 'b', 'c'];
      final expectedOutput = ['a', 'b', 'c'];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('returns original list if input contains only one item', () {
      final input = ['a'];
      final expectedOutput = ['a'];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('sorts a list of strings alphabetically', () {
      final input = ['c', 'b', 'a', 'd'];
      final expectedOutput = ['a', 'b', 'c', 'd'];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('returns empty list if input is null', () {
      const input = null;
      final expectedOutput = <String>[];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('returns empty list if input is empty', () {
      final input = <String>[];
      final expectedOutput = <String>[];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('returns original list if input is already sorted', () {
      final input = ['a', 'b', 'c'];
      final expectedOutput = ['a', 'b', 'c'];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('returns original list if input contains only one item', () {
      final input = ['a'];
      final expectedOutput = ['a'];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('sorts a list of strings containing special characters and numbers', () {
      final input = ['#', r'$', '3', '2', '1'];
      final expectedOutput = ['#', r'$', '1', '2', '3'];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('sorts a list of mixed case strings alphabetically', () {
      final input = ['Apple', 'banana', 'Carrot', 'Dates', null];
      final expectedOutput = ['Apple', 'banana', 'Carrot', 'Dates', null];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

    test('sorts a list of mixed case strings alphabetically2', () {
      final input = ['Apple', null, 'banana', 'Carrot', 'Dates',];
      final expectedOutput = ['Apple', 'banana', 'Carrot', 'Dates', null];
      final output = Stringer.sortAlphabetically(input);
      expect(output, expectedOutput);
    });

  });
  // -----------------------------------------------------------------------------

  /// getStringsFromDynamics

  // --------------------
  group('getStringsFromDynamics', () {

    test('should return list of strings from list of dynamics', () {
      final dynamics = [1, 'hello', true, 2.5];
      final expected = ['1', 'hello', 'true', '2.5'];
      final result = Stringer.getStringsFromDynamics(dynamics: dynamics);
      expect(result, expected);
    });

    test('should return empty list if input list is null', () {
      const dynamics = null;
      final expected = <String>[];
      final result = Stringer.getStringsFromDynamics(dynamics: dynamics);
      expect(result, expected);
    });

    test('should return list of strings even if some elements are already strings', () {
      final dynamics = [1, 'hello', true, 'world', 2.5];
      final expected = ['1', 'hello', 'true', 'world', '2.5'];
      final result = Stringer.getStringsFromDynamics(dynamics: dynamics);
      expect(result, expected);
    });

    test('should return list of strings from list of dynamics', () {
      final dynamics = [1, 'hello', true, 2.5];
      final expected = ['1', 'hello', 'true', '2.5'];
      final result = Stringer.getStringsFromDynamics(dynamics: dynamics);
      expect(result, expected);
    });

    test('should return empty list if input list is null', () {
      const dynamics = null;
      final expected = <String>[];
      final result = Stringer.getStringsFromDynamics(dynamics: dynamics);
      expect(result, expected);
    });

    test('should return list of strings even if some elements are already strings', () {
      final dynamics = [1, 'hello', true, 'world', 2.5];
      final expected = ['1', 'hello', 'true', 'world', '2.5'];
      final result = Stringer.getStringsFromDynamics(dynamics: dynamics);
      expect(result, expected);
    });

    test('should return empty list if input list is empty', () {
      final dynamics = [];
      final expected = <String>[];
      final result = Stringer.getStringsFromDynamics(dynamics: dynamics);
      expect(result, expected);
    });

    test('should return list of strings from list of nested dynamics', () {
      final dynamics = [
        1,
        ['hello', true],
        2.5,
        {'name': 'John'}
      ];
      final expected = ['1', 'hello', 'true', '2.5', '{name: John}'];
      final result = Stringer.getStringsFromDynamics(dynamics: dynamics);
      expect(result, expected);
    });

  });
  // -----------------------------------------------------------------------------

  /// createTrigram

  // --------------------
  group('createTrigram', () {

    test('returns empty list when input is null', () {
      final result = Stringer.createTrigram(input: null);
      expect(result, isEmpty);
    });

    test('removes spaces when removeSpaces is true', () {
      final result = Stringer.createTrigram(input: 'Hello World', removeSpaces: true);
      expect(result.every((e) => !e.contains(' ')), isTrue);
    });

    test('does not remove spaces when removeSpaces is false', () {
      final result = Stringer.createTrigram(input: 'Hello World');
      expect(result.any((e) => e.contains(' ')), isTrue);
    });

    test('returns trigrams in lowercase', () {
      final result = Stringer.createTrigram(input: 'Hello World');
      expect(result.every((e) => e == e.toLowerCase()), isTrue);
    });

    test('returns unique trigrams', () {
      final result = Stringer.createTrigram(input: 'Hello World');
      final Set<String> unique = Set.from(result);
      expect(result.length, unique.length);
    });
  });
  // -----------------------------------------------------------------------------

  /// generateStringFromStrings

  // --------------------
  group('generateStringFromStrings', () {

    test('generates a single string from a list of strings', () {
      const List<String> strings = ['hello', 'world', 'how', 'are', 'you'];
      // const String separator = ', ';
      const String expectedOutput = 'hello, world, how, are, you';

      expect(Stringer.generateStringFromStrings(strings: strings),
          expectedOutput);
    });

    test('handles empty list input', () {
      const List<String> strings = [];
      // const String separator = ', ';

      expect(
          Stringer.generateStringFromStrings(strings: strings), null);
    });

    test('handles null input', () {
      const List<String>? strings = null;
      // const String separator = ', ';

      expect(
          Stringer.generateStringFromStrings(strings: strings), null);
    });

    test('handles custom separator', () {
      const List<String> strings = ['hello', 'world'];
      const String separator = '-';
      const String expectedOutput = 'hello-world';

      expect(Stringer.generateStringFromStrings(strings: strings, stringsSeparator: separator),
          expectedOutput);
    });

  });
  // -----------------------------------------------------------------------------

  /// getAddedStrings

  // --------------------
  group('getAddedStrings', () {

    test('returns new strings that were added to the list', () {
      final List<String> oldStrings = ['hello', 'world'];
      final List<String> newStrings = ['hello', 'world', 'how', 'are', 'you'];
      final List<String> expectedOutput = ['how', 'are', 'you'];

      expect(
          Stringer.getAddedStrings(oldStrings: oldStrings, newStrings: newStrings), expectedOutput);
    });

    test('handles empty input', () {
      final List<String> oldStrings = [];
      final List<String> newStrings = ['hello', 'world'];

      expect(Stringer.getAddedStrings(oldStrings: oldStrings, newStrings: newStrings), newStrings);
    });

    test('handles null input', () {
      const List<String>? oldStrings = null;
      final List<String> newStrings = ['hello', 'world'];

      expect(Stringer.getAddedStrings(oldStrings: oldStrings, newStrings: newStrings), newStrings);
    });

    test('handles no new strings added', () {
      final List<String> oldStrings = ['hello', 'world'];
      final List<String> newStrings = ['hello', 'world'];

      expect(Stringer.getAddedStrings(oldStrings: oldStrings, newStrings: newStrings), []);
    });

  });
  // -----------------------------------------------------------------------------

  /// getRemovedStrings

  // --------------------
  group('Stringer.getRemovedStrings', () {
    test('Returns an empty list when both oldStrings and newStrings are null', () {
      final List<String?> result = Stringer.getRemovedStrings(
        oldStrings: null,
        newStrings: null,
      );
      expect(result, isEmpty);
    });

    test('Returns an empty list when oldStrings is null and newStrings is empty', () {
      final List<String?> result = Stringer.getRemovedStrings(
        oldStrings: null,
        newStrings: [],
      );
      expect(result, isEmpty);
    });

    test('Returns an empty list when oldStrings is empty and newStrings is null', () {
      final List<String?> result = Stringer.getRemovedStrings(
        oldStrings: [],
        newStrings: null,
      );
      expect(result, isEmpty);
    });

    test('Returns an empty list when oldStrings and newStrings are empty', () {
      final List<String?> result = Stringer.getRemovedStrings(
        oldStrings: [],
        newStrings: [],
      );
      expect(result, isEmpty);
    });

    test('Returns an empty list when oldStrings and newStrings have the same elements', () {
      final List<String?> result = Stringer.getRemovedStrings(
        oldStrings: ['A', 'B', 'C'],
        newStrings: ['A', 'B', 'C'],
      );
      expect(result, isEmpty);
    });

    test('Returns a list with elements that are present in oldStrings but not in newStrings', () {
      final List<String?> result = Stringer.getRemovedStrings(
        oldStrings: ['A', 'B', 'C', 'D'],
        newStrings: ['A', 'C'],
      );
      expect(result, equals(['B', 'D']));
    });

    test('Returns an empty list when oldStrings contains null values', () {
      final List<String?> result = Stringer.getRemovedStrings(
        oldStrings: ['A', null, 'C', 'D'],
        newStrings: ['A', 'C'],
      );
      expect(result, equals([null, 'D']));
    });
  });
  // -----------------------------------------------------------------------------

  /// findHashtags

  // --------------------
  group('Stringer.findHashtags', () {

    test('Returns an empty list when text is null', () {
      final List<String> result = Stringer.findHashtags(
        text: null,
      );
      expect(result, []);
    });

    test('Returns an empty list when text is an empty string', () {
      final List<String> result = Stringer.findHashtags(
        text: '',
      );
      expect(result, isEmpty);
    });

    test('Returns an empty list when no hashtags are present', () {
      final List<String> result = Stringer.findHashtags(
        text: 'This is a sample text without hashtags.',
      );
      expect(result, []);
    });

    test('Returns a list with hashtags when considerDash is true and removeHash is false', () {
      final List<String> result = Stringer.findHashtags(
        text: 'This is a sample text with #hashtags and #multiple-dash-tags.',
        // considerDash: true, // default
        // removeHash: false, // default
      );
      expect(result, equals(['#hashtags', '#multiple-dash-tags']));
    });

    test('test', () {
      final List<String> result = Stringer.findHashtags(
        text: 'This is a sample text with #hashtags and #multiple-dash-tags.',
        considerDash: false,
        // removeHash: false, // default
      );
      expect(result, equals(['#hashtags', '#multiple']));
    });

    test('Returns a list without the hash symbol when considerDash is true and removeHash is true', () {
      final List<String> result = Stringer.findHashtags(
        text: 'This is a sample text with #hashtags and #multiple-dash-tags.',
        // considerDash: true, // default
        removeHash: true,
      );
      expect(result, equals(['hashtags', 'multiple-dash-tags']));
    });

    test('Returns a list with hashtags when considerDash is false and removeHash is true', () {
      final List<String> result = Stringer.findHashtags(
        text: 'This is a sample text with #hashtags and #multiple-dash-tags.',
        considerDash: false,
        removeHash: true,
      );
      expect(result, equals(['hashtags', 'multiple']));
    });
  }); // -----------------------------------------------------------------------------

  // -----------------------------------------------------------------------------

  /// MANUAL OLD TESTS : STRINGS ADDED AND REMOVED

  // --------------------
  group('Stringer', () {
    // --------------------
    const List<String> _oldList = <String>['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'];
    const List<String> _newWithAdded = <String>[
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k'
    ];
    const List<String> _newWithRemoved = <String>['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'];
    // --------------------
    test('getAddedStrings', () {
      final List<String> _added = Stringer.getAddedStrings(
        oldStrings: _oldList,
        newStrings: _newWithAdded,
      );
      expect(_added, ['k']);
    });
    // --------------------
    test('getRemovedStrings', () {
      final List<String?> _removed = Stringer.getRemovedStrings(
        oldStrings: _oldList,
        newStrings: _newWithRemoved,
      );
      expect(_removed, ['j']);

      final List<String?> _removed2 = Stringer.getRemovedStrings(
        oldStrings: [],
        newStrings: _newWithRemoved,
      );
      expect(_removed2, []);

      final List<String?> _removed3 = Stringer.getRemovedStrings(
        oldStrings: null,
        newStrings: _newWithRemoved,
      );
      expect(_removed3, []);

      final List<String?>? _removed4 = Stringer.getRemovedStrings(
        oldStrings: [null],
        newStrings: ['a', 'b', 'c', 'd'],
      );
      expect(_removed4, [null]); // indeed it should remove the null
    });
    // -----------------------------------------------------------------------------
    test('removeStringsFromStrings', () async {
      const List<String> _source = <String>['wa7ed', 'etneen', 'talata', 'arba3a'];

      const List<String> _toRemove = <String>['wa7ed', 'etneen'];

      final List<String> _modified = Stringer.removeStringsFromStrings(
        removeFrom: _source,
        removeThis: _toRemove,
      );

      expect(_modified, <String>['talata', 'arba3a']);
    });
    // -----------------------------------------------------------------------------
  });
  // -----------------------------------------------------------------------------
}
