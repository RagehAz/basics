import 'package:basics/helpers/strings/text_mod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('modifyAllCharactersWith', () {
    test('Replaces all occurrences of characterToReplace with replacement in input', () {
      final result = TextMod.modifyAllCharactersWith(
        characterToReplace: 'a',
        replacement: 'b',
        input: 'apple',
      );
      expect(result, equals('bpple'));
    });

    test('Returns input unchanged when characterToReplace is null', () {
      final result = TextMod.modifyAllCharactersWith(
        characterToReplace: null,
        replacement: 'b',
        input: 'apple',
      );
      expect(result, equals('apple'));
    });

    test('Returns input unchanged when replacement is null', () {
      final result = TextMod.modifyAllCharactersWith(
        characterToReplace: 'a',
        replacement: null,
        input: 'apple',
      );
      expect(result, equals('apple'));
    });

    test('Returns input unchanged when input is null', () {
      final result = TextMod.modifyAllCharactersWith(
        characterToReplace: 'a',
        replacement: 'b',
        input: null,
      );
      expect(result, equals(null));
    });

    test('Returns input unchanged when characterToReplace is empty', () {
      final result = TextMod.modifyAllCharactersWith(
        characterToReplace: '',
        replacement: 'x',
        input: 'apple',
      );
      expect(result, equals('xaxpxpxlxex'));
    });

    test('Returns input unchanged when replacement is empty', () {
      final result = TextMod.modifyAllCharactersWith(
        characterToReplace: 'a',
        replacement: '',
        input: 'apple',
      );
      expect(result, equals('pple'));
    });

    test('Returns input unchanged when input is empty', () {
      final result = TextMod.modifyAllCharactersWith(
        characterToReplace: 'a',
        replacement: 'b',
        input: '',
      );
      expect(result, equals(''));
    });

    test('test', () {
      final result = TextMod.modifyAllCharactersWith(
        characterToReplace: ' ',
        replacement: '_',
        input: 'fuck you',
      );
      expect(result, equals('fuck_you'));
    });
  });

  group('obscureText', () {
    test('Returns obscured text with default obscurityCharacter', () {
      final result = TextMod.obscureText(text: 'password');
      expect(result, equals('********'));
    });

    test('Returns empty string when text is null', () {
      final result = TextMod.obscureText(text: null);
      expect(result, null);
    });

    test('Returns empty string when text is empty', () {
      final result = TextMod.obscureText(text: '');
      expect(result, null);
    });

    test('Returns obscured text with custom obscurityCharacter', () {
      final result = TextMod.obscureText(text: 'password', obscurityCharacter: 'X');
      expect(result, equals('XXXXXXXX'));
    });

    test('Returns empty string when text is null and obscurityCharacter is not empty', () {
      final result = TextMod.obscureText(
          text: null,
          // obscurityCharacter: '*', // default
      );
      expect(result, null);
    });

    test('Returns empty string when text is empty and obscurityCharacter is not empty', () {
      final result = TextMod.obscureText(
          text: '',
          // obscurityCharacter: '*', // default
      );
      expect(result, null);
    });
  });

  group('idifyString', () {
    test('Returns idified string with spaces replaced by underscores and lowercase', () {
      final result = TextMod.idifyString('Hello World');
      expect(result, equals('hello_world'));
    });

    test('Returns null when input text is null', () {
      final result = TextMod.idifyString(null);
      expect(result, equals(null));
    });

    test('Returns empty string when input text is empty', () {
      final result = TextMod.idifyString('');
      expect(result, null);
    });

    test('Returns idified string with spaces and semicolons replaced', () {
      final result = TextMod.idifyString('Hello;World');
      expect(result, equals('hello_world'));
    });

    test('Returns idified string with fixed country name', () {
      final result = TextMod.idifyString('united states');
      expect(result, equals('united_states'));
    });

    test('Returns idified string with all modifications applied', () {
      final result = TextMod.idifyString('   Hello; World ');
      expect(result, equals('hello_world'));
    });

    test('Returns idified string with special characters', () {
      final result = TextMod.idifyString('Hello!@ #World');
      expect(result, equals('hello_world'));
    });
  });

  group('cutFirstCharacterAfterRemovingSpacesFromAString', () {
    test('Returns first character after removing spaces from the string', () {
      final result = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString('  Hello World ');
      expect(result, equals('H'));
    });

    test('Returns null when string is null', () {
      final result = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(null);
      expect(result, equals(null));
    });

    test('Returns null when string is empty', () {
      final result = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString('');
      expect(result, equals(null));
    });

    test('Returns null when string is whitespace', () {
      final result = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString('   ');
      expect(result, equals(null));
    });

    test('Returns null when string without spaces is whitespace', () {
      final result = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString('   ');
      expect(result, equals(null));
    });

    test('Returns null when first character is empty after removing spaces', () {
      final result = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString('z');
      expect(result, equals('z'));
    });
  });

  group('cutNumberOfCharactersOfAStringBeginning', () {
    test('Returns the specified number of characters from the beginning of the string', () {
      final result = TextMod.cutNumberOfCharactersOfAStringBeginning(
        string: 'Hello World',
        number: 5,
      );
      expect(result, equals('Hello'));
    });

    test('Returns null when string is null', () {
      final result = TextMod.cutNumberOfCharactersOfAStringBeginning(
        string: null,
        number: 5,
      );
      expect(result, equals(null));
    });

    test('Returns null when string is empty', () {
      final result = TextMod.cutNumberOfCharactersOfAStringBeginning(
        string: '',
        number: 5,
      );
      expect(result, equals(''));
    });

    test('Returns null when string is whitespace', () {
      final result = TextMod.cutNumberOfCharactersOfAStringBeginning(
        string: '   ',
        number: 5,
      );
      expect(result, equals('   '));
    });

    test('Returns null when number is null', () {
      final result = TextMod.cutNumberOfCharactersOfAStringBeginning(
        string: 'Hello World',
        number: null,
      );
      expect(result, equals('Hello World'));
    });

    test('Returns null when number is greater than the string length', () {
      final result = TextMod.cutNumberOfCharactersOfAStringBeginning(
        string: 'Hello World',
        number: 20,
      );
      expect(result, equals('Hello World'));
    });

    test('Returns an empty string when number is 0', () {
      final result = TextMod.cutNumberOfCharactersOfAStringBeginning(
        string: 'Hello World',
        number: 0,
      );
      expect(result, equals(''));
    });

    test('Returns the whole string when number is equal to the string length', () {
      final result = TextMod.cutNumberOfCharactersOfAStringBeginning(
        string: 'Hello World',
        number: 11,
      );
      expect(result, equals('Hello World'));
    });
  });

  group('cutLastTwoCharactersFromAString', () {
    test('Returns the last two characters from the string', () {
      final result = TextMod.cutLastTwoCharactersFromAString('Hello World');
      expect(result, equals('ld'));
    });

    test('Returns null when string is null', () {
      final result = TextMod.cutLastTwoCharactersFromAString(null);
      expect(result, equals(null));
    });

    test('Returns null when string is empty', () {
      final result = TextMod.cutLastTwoCharactersFromAString('');
      expect(result, equals(null));
    });

    test('Returns null when string is whitespace', () {
      final result = TextMod.cutLastTwoCharactersFromAString('   ');
      expect(result, equals('  '));
    });

    test('Returns null when string has only one character', () {
      final result = TextMod.cutLastTwoCharactersFromAString('H');
      expect(result, equals('H'));
    });

    test('Returns the whole string when string has two characters', () {
      final result = TextMod.cutLastTwoCharactersFromAString('He');
      expect(result, equals('He'));
    });

    test('Returns the last two characters when string has more than two characters', () {
      final result = TextMod.cutLastTwoCharactersFromAString('Hello');
      expect(result, equals('lo'));
    });

    test('Returns the last two characters when string has special characters', () {
      final result = TextMod.cutLastTwoCharactersFromAString('Hello@#');
      expect(result, equals('@#'));
    });
  });

  group('removeFirstCharacterFromAString', () {
    test('Removes the first character from the string', () {
      final result = TextMod.removeFirstCharacterFromAString('Hello World');
      expect(result, equals('ello World'));
    });

    test('Returns null when string is null', () {
      final result = TextMod.removeFirstCharacterFromAString(null);
      expect(result, equals(null));
    });

    test('Returns null when string is empty', () {
      final result = TextMod.removeFirstCharacterFromAString('');
      expect(result, equals(null));
    });

    test('Returns null when string is whitespace', () {
      final result = TextMod.removeFirstCharacterFromAString('   ');
      expect(result, equals('  '));
    });

    test('Returns an empty string when string has only one character', () {
      final result = TextMod.removeFirstCharacterFromAString('H');
      expect(result, equals(''));
    });

    test('Returns the whole string except the first character', () {
      final result = TextMod.removeFirstCharacterFromAString('Hello');
      expect(result, equals('ello'));
    });

    test('Returns the whole string except the first character when string has special characters',
        () {
      final result = TextMod.removeFirstCharacterFromAString('@Hello');
      expect(result, equals('Hello'));
    });

    test('Returns the whole string except the first character when string starts with whitespace',
        () {
      final result = TextMod.removeFirstCharacterFromAString(' Hello');
      expect(result, equals('Hello'));
    });
  });

  group('removeNumberOfCharactersFromBeginningOfAString', () {
    test('Removes the specified number of characters from the beginning of the string', () {
      final result = TextMod.removeNumberOfCharactersFromBeginningOfAString(
          string: 'Hello World', numberOfCharacters: 6);
      expect(result, equals('World'));
    });

    test('Returns null when string is null', () {
      final result = TextMod.removeNumberOfCharactersFromBeginningOfAString(
          string: null, numberOfCharacters: 5);
      expect(result, equals(null));
    });

    test('Returns null when string is empty', () {
      final result =
          TextMod.removeNumberOfCharactersFromBeginningOfAString(string: '', numberOfCharacters: 3);
      expect(result, equals(null));
    });

    test('Returns null when string is whitespace', () {
      final result = TextMod.removeNumberOfCharactersFromBeginningOfAString(
          string: '   ', numberOfCharacters: 2);
      expect(result, equals(' '));
    });

    test('Returns the whole string when numberOfCharacters is 0', () {
      final result = TextMod.removeNumberOfCharactersFromBeginningOfAString(
          string: 'Hello', numberOfCharacters: 0);
      expect(result, equals('Hello'));
    });

    test('Returns null when numberOfCharacters is greater than the string length', () {
      expect(
        () => TextMod.removeNumberOfCharactersFromBeginningOfAString(
            string: 'Hello', numberOfCharacters: 10),
        throwsArgumentError,
      );
    });

    test('Removes all characters when numberOfCharacters is equal to the string length', () {
      final result = TextMod.removeNumberOfCharactersFromBeginningOfAString(
          string: 'Hello', numberOfCharacters: 5);
      expect(result, equals(''));
    });

    test('Returns the whole string when numberOfCharacters is negative', () {
      final result = TextMod.removeNumberOfCharactersFromBeginningOfAString(
          string: 'Hello', numberOfCharacters: -3);
      expect(result, equals('Hello'));
    });
  });

  group('removeNumberOfCharactersFromEndOfAString', () {
    test('Removes the specified number of characters from the end of the string', () {
      final result = TextMod.removeNumberOfCharactersFromEndOfAString(
          string: 'Hello World', numberOfCharacters: 5);
      expect(result, equals('Hello '));
    });

    test('Returns null when string is null', () {
      final result = TextMod.removeNumberOfCharactersFromEndOfAString(
        string: null,
        numberOfCharacters: 3,
      );
      expect(result, equals(null));
    });

    test('Returns null when string is empty', () {
      final result =
          TextMod.removeNumberOfCharactersFromEndOfAString(string: '', numberOfCharacters: 2);
      expect(result, equals(null));
    });

    test('Returns null when string is whitespace', () {
      final result =
          TextMod.removeNumberOfCharactersFromEndOfAString(string: '   ', numberOfCharacters: 4);
      expect(result, equals(null));
    });

    test('Returns an empty string when numberOfCharacters is 0', () {
      final result =
          TextMod.removeNumberOfCharactersFromEndOfAString(string: 'Hello', numberOfCharacters: 0);
      expect(result, equals('Hello'));
    });

    test('Removes all characters when numberOfCharacters is equal to the string length', () {
      final result = TextMod.removeNumberOfCharactersFromEndOfAString(
        string: 'Hello',
        numberOfCharacters: 5,
      );
      expect(result, equals(''));
    });

    test('Returns the whole string when numberOfCharacters is greater than the string length', () {
      final result = TextMod.removeNumberOfCharactersFromEndOfAString(
        string: 'Hello',
        numberOfCharacters: 10,
      );
      expect(result, equals(''));
    });
  });

  group('removeSpacesFromAString', () {
    test('Removes spaces from the string', () {
      final result = TextMod.removeSpacesFromAString('Hello World');
      expect(result, equals('HelloWorld'));
    });

    test('Returns null when string is null', () {
      final result = TextMod.removeSpacesFromAString(null);
      expect(result, equals(null));
    });

    test('Returns an empty string when string is empty', () {
      final result = TextMod.removeSpacesFromAString('');
      expect(result, equals(''));
    });

    test('Returns null when string is whitespace', () {
      final result = TextMod.removeSpacesFromAString('   ');
      expect(result, equals(''));
    });

    test('Removes multiple consecutive spaces from the string', () {
      final result = TextMod.removeSpacesFromAString('Hello   World');
      expect(result, equals('HelloWorld'));
    });

    test('Removes invisible spaces (U+200E and U+200F) from the string', () {
      final result = TextMod.removeSpacesFromAString('Hello‎ ‎World‏');
      expect(result, equals('HelloWorld'));
    });

    test('Removes both visible and invisible spaces from the string', () {
      final result = TextMod.removeSpacesFromAString('Hello ‎ ‎World‏');
      expect(result, equals('HelloWorld'));
    });

    test('Does not modify the string when there are no spaces', () {
      final result = TextMod.removeSpacesFromAString('HelloWorld');
      expect(result, equals('HelloWorld'));
    });
  });

  group('removeTextAfterFirstSpecialCharacter', () {
    test('Removes text after the first occurrence of special character', () {
      final result = TextMod.removeTextAfterFirstSpecialCharacter(
        text: 'Hello World!',
        specialCharacter: ' ',
      );
      expect(result, equals('Hello'));
    });

    test('Returns null when text is null', () {
      final result = TextMod.removeTextAfterFirstSpecialCharacter(
        text: null,
        specialCharacter: ' ',
      );
      expect(result, equals(null));
    });

    test('Returns empty string when text is empty', () {
      final result = TextMod.removeTextAfterFirstSpecialCharacter(
        text: '',
        specialCharacter: ' ',
      );
      expect(result, equals(''));
    });

    test('Returns the same text when special character is not found', () {
      final result = TextMod.removeTextAfterFirstSpecialCharacter(
        text: 'HelloWorld',
        specialCharacter: ' ',
      );
      expect(result, equals('HelloWorld'));
    });

    test('Handles special characters with multiple occurrences', () {
      final result = TextMod.removeTextAfterFirstSpecialCharacter(
        text: 'Hello World!',
        specialCharacter: 'o',
      );
      expect(result, equals('Hell'));
    });

    test('Removes text after the first occurrence of special character', () {
      final result = TextMod.removeTextAfterFirstSpecialCharacter(
        text: 'Hello, World!',
        specialCharacter: ',',
      );
      expect(result, equals('Hello'));
    });

    test('Handles special characters with no preceding text', () {
      final result = TextMod.removeTextAfterFirstSpecialCharacter(
        text: ', World!',
        specialCharacter: ',',
      );
      expect(result, equals(''));
    });
  });

  group('removeTextBeforeFirstSpecialCharacter', () {
    test('Removes text before the first occurrence of special character', () {
      final result = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: 'Hello World!',
        specialCharacter: ' ',
      );
      expect(result, equals('World!'));
    });

    test('Returns null when text is null', () {
      final result = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: null,
        specialCharacter: ' ',
      );
      expect(result, equals(null));
    });

    test('Returns empty string when text is empty', () {
      final result = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: '',
        specialCharacter: ' ',
      );
      expect(result, equals(null));
    });

    test('Returns the same text when special character is not found', () {
      final result = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: 'HelloWorld',
        specialCharacter: ' ',
      );
      expect(result, equals('HelloWorld'));
    });

    test('Handles special characters with multiple occurrences', () {
      final result = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: 'Hello World!',
        specialCharacter: 'o',
      );
      expect(result, equals(' World!'));
    });

    test('Removes text before the first occurrence of special character', () {
      final result = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: 'Hello, World!',
        specialCharacter: ',',
      );
      expect(result, equals(' World!'));
    });

    test('Handles special characters with no succeeding text', () {
      final result = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: 'Hello,',
        specialCharacter: ',',
      );
      expect(result, equals(''));
    });
  });

  group('removeTextAfterLastSpecialCharacter', () {
    test('Removes text after the last occurrence of special character', () {
      final result = TextMod.removeTextAfterLastSpecialCharacter(
        text: 'Hello, World!',
        specialCharacter: ',',
      );
      expect(result, equals('Hello'));
    });

    test('Returns null when text is null', () {
      final result = TextMod.removeTextAfterLastSpecialCharacter(
        text: null,
        specialCharacter: ',',
      );
      expect(result, equals(null));
    });

    test('Returns empty string when text is empty', () {
      final result = TextMod.removeTextAfterLastSpecialCharacter(
        text: '',
        specialCharacter: ',',
      );
      expect(result, '');
    });

    test('Returns the same text when special character is not found', () {
      final result = TextMod.removeTextAfterLastSpecialCharacter(
        text: 'HelloWorld',
        specialCharacter: ',',
      );
      expect(result, equals('HelloWorld'));
    });

    test('Handles special characters with multiple occurrences', () {
      final result = TextMod.removeTextAfterLastSpecialCharacter(
        text: 'Hello, World, Again!',
        specialCharacter: ',',
      );
      expect(result, equals('Hello, World'));
    });

    test('Handles special characters at the beginning of the text', () {
      final result = TextMod.removeTextAfterLastSpecialCharacter(
        text: ',Hello, World!',
        specialCharacter: ',Hello',
      );
      expect(result, equals(''));
    });

    test('Handles special characters with no preceding text', () {
      final result = TextMod.removeTextAfterLastSpecialCharacter(
        text: ',',
        specialCharacter: ',',
      );
      expect(result, equals(''));
    });
  });

  group('removeTextBeforeLastSpecialCharacter', () {
    test('Removes text before the last occurrence of special character', () {
      final result = TextMod.removeTextBeforeLastSpecialCharacter(
        text: 'Hello, World!',
        specialCharacter: ',',
      );
      expect(result, equals(' World!'));
    });

    test('Returns null when text is null', () {
      final result = TextMod.removeTextBeforeLastSpecialCharacter(
        text: null,
        specialCharacter: ',',
      );
      expect(result, equals(null));
    });

    test('Returns empty string when text is empty', () {
      final result = TextMod.removeTextBeforeLastSpecialCharacter(
        text: '',
        specialCharacter: ',',
      );
      expect(result, equals(''));
    });

    test('Returns the same text when special character is not found', () {
      final result = TextMod.removeTextBeforeLastSpecialCharacter(
        text: 'HelloWorld',
        specialCharacter: ',',
      );
      expect(result, equals('HelloWorld'));
    });

    test('Handles special characters with multiple occurrences', () {
      final result = TextMod.removeTextBeforeLastSpecialCharacter(
        text: 'Hello, World, Again!',
        specialCharacter: ',',
      );
      expect(result, equals(' Again!'));
    });

    test('Handles special characters at the end of the text', () {
      final result = TextMod.removeTextBeforeLastSpecialCharacter(
        text: 'Hello, World!',
        specialCharacter: ',',
      );
      expect(result, equals(' World!'));
    });

    test('Handles special characters with no succeeding text', () {
      final result = TextMod.removeTextBeforeLastSpecialCharacter(
        text: ',',
        specialCharacter: ',',
      );
      expect(result, equals(''));
    });
  });

  group('removeAllCharactersAfterNumberOfCharacters', () {
    test('Removes all characters after the specified number of characters', () {
      final result = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: 'Hello, World!',
        numberOfChars: 5,
      );
      expect(result, equals('Hello'));
    });

    test('Returns null when text is null', () {
      final result = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: null,
        numberOfChars: 5,
      );
      expect(result, equals(null));
    });

    test('Returns empty string when text is empty', () {
      final result = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: '',
        numberOfChars: 5,
      );
      expect(result, equals(''));
    });

    test(
        'Returns the same text when the number of characters is greater than or equal to the text length',
        () {
      final result = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: 'Hello, World!',
        numberOfChars: 20,
      );
      expect(result, equals('Hello, World!'));
    });

    test('Handles zero number of characters', () {
      final result = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: 'Hello, World!',
        numberOfChars: 0,
      );
      expect(result, equals(''));
    });

    test('Handles special characters and symbols', () {
      final result = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: 'Hello! How are you?',
        numberOfChars: 7,
      );
      expect(result, equals('Hello! '));
    });
  });

  group('getFileNameFromAsset', () {
    test('getFileNameFromAsset returns null when asset is null', () {
      expect(TextMod.getFileNameFromAsset(null), isNull);
    });

    test('getFileNameFromAsset returns null when asset is empty', () {
      expect(TextMod.getFileNameFromAsset(''), isNull);
    });

    test('getFileNameFromAsset returns the correct file name', () {
      expect(
        TextMod.getFileNameFromAsset('assets/xx/pp_sodic/builds_1.jpg'),
        equals('builds_1.jpg'),
      );
    });

    test('getFileNameFromAsset returns the correct file name with multiple slashes', () {
      expect(
        TextMod.getFileNameFromAsset('assets/xx/pp_sodic/images/builds_1.jpg'),
        equals('builds_1.jpg'),
      );
    });

    test('getFileNameFromAsset returns the correct file name when asset has no path', () {
      expect(
        TextMod.getFileNameFromAsset('builds_1.jpg'),
        equals('builds_1.jpg'),
      );
    });

    test('getFileNameFromAsset returns null when asset has no file name', () {
      expect(
        TextMod.getFileNameFromAsset('assets/xx/pp_sodic/'),
        '',
      );
    });

    test('getFileNameFromAsset returns null when asset ends with a slash', () {
      expect(
        TextMod.getFileNameFromAsset('assets/xx/pp_sodic/'),
        '',
      );
    });
  });

  group('getKeywordsMap', () {
    test('getKeywordsMap returns an empty map when keywordsIDs is null', () async {
      final result = await TextMod.getKeywordsMap(null);
      expect(result, isEmpty);
    });

    test('getKeywordsMap returns an empty map when keywordsIDs is an empty list', () async {
      final result = await TextMod.getKeywordsMap([]);
      expect(result, isEmpty);
    });

    test('getKeywordsMap returns the correct map with keyword IDs', () async {
      final keywordsIDs = ['construction', 'architecture', 'decor'];
      final expectedMap = {
        'construction': 0,
        'architecture': 1,
        'decor': 2,
      };
      final result = await TextMod.getKeywordsMap(keywordsIDs);
      expect(result, equals(expectedMap));
    });

    test('getKeywordsMap returns the correct map with keyword IDs when there are duplicate IDs',
        () async {
      final keywordsIDs = ['construction', 'architecture', 'decor'];
      final expectedMap = {
        'construction': 0,
        'architecture': 1,
        'decor': 2,
      };
      final result = await TextMod.getKeywordsMap(keywordsIDs);
      expect(result, equals(expectedMap));
    });

    test('getKeywordsMap returns the correct map with keyword IDs when keywordsIDs contain numbers',
        () async {
      final keywordsIDs = ['1construction', '2architecture', '3decor'];
      final expectedMap = {
        '1construction': 0,
        '2architecture': 1,
        '3decor': 2,
      };
      final result = await TextMod.getKeywordsMap(keywordsIDs);
      expect(result, equals(expectedMap));
    });
  });

  group('getValueAndTrueMap', () {
    test('getValueAndTrueMap returns null when list is null', () {
      final result = TextMod.getValueAndTrueMap(null);
      expect(result, isNull);
    });

    test('getValueAndTrueMap returns null when list is an empty list', () {
      final result = TextMod.getValueAndTrueMap([]);
      expect(result, isNull);
    });

    test('getValueAndTrueMap returns the correct map with values and true', () {
      final list = ['value1', 'value2', 'value3'];
      final expectedMap = {
        'value1': true,
        'value2': true,
        'value3': true,
      };
      final result = TextMod.getValueAndTrueMap(list);
      expect(result, equals(expectedMap));
    });

    test(
        'getValueAndTrueMap returns the correct map with values and true when there are duplicate values',
        () {
      final list = ['value1', 'value2', 'value3', 'value1'];
      final expectedMap = {
        'value1': true,
        'value2': true,
        'value3': true,
      };
      final result = TextMod.getValueAndTrueMap(list);
      expect(result, equals(expectedMap));
    });

    test(
        'getValueAndTrueMap returns the correct map with values and true when values contain special characters',
        () {
      final list = ['va@lue1', 'v!alue2', 'va#lue3'];
      final expectedMap = {
        'va@lue1': true,
        'v!alue2': true,
        'va#lue3': true,
      };
      final result = TextMod.getValueAndTrueMap(list);
      expect(result, equals(expectedMap));
    });

    test(
        'getValueAndTrueMap returns the correct map with values and true when values contain numbers',
        () {
      final list = ['1value', '2value', '3value'];
      final expectedMap = {
        '1value': true,
        '2value': true,
        '3value': true,
      };
      final result = TextMod.getValueAndTrueMap(list);
      expect(result, equals(expectedMap));
    });
  });

  group('fixCountryName', () {
    test('fixCountryName returns null when input is null', () {
      final result = TextMod.fixCountryName(input: null);
      expect(result, isNull);
    });

    test('fixCountryName returns null when input is an empty string', () {
      final result = TextMod.fixCountryName(input: '');
      expect(result, '');
    });

    test('fixCountryName returns the correct fixed country name', () {
      const input = 'United States';
      const expectedOutput = 'united_states';
      final result = TextMod.fixCountryName(input: input);
      expect(result, equals(expectedOutput));
    });

    test(
        'fixCountryName returns the correct fixed country name when input contains special characters',
        () {
      const input = 'Côte d’Ivoire';
      const expectedOutput = 'cote_divoire';
      final result = TextMod.fixCountryName(input: input);
      expect(result, equals(expectedOutput));
    });

    test('fixCountryName returns the correct fixed country name when input contains numbers', () {
      const input = 'South Korea 123';
      const expectedOutput = 'south_korea_123';
      final result = TextMod.fixCountryName(input: input);
      expect(result, equals(expectedOutput));
    });
  });

  group('fixSearchText', () {
    test('fixSearchText returns null when input is null', () {
      final result = TextMod.fixSearchText(null);
      expect(result, isNull);
    });

    test('fixSearchText returns null when input is an empty string', () {
      final result = TextMod.fixSearchText('');
      expect(result, isNull);
    });

    test('fixSearchText returns the correct fixed search text', () {
      const input = '  This is a test  ';
      const expectedOutput = 'thisisatest';
      final result = TextMod.fixSearchText(input);
      expect(result, equals(expectedOutput));
    });

    test('fixSearchText returns the correct fixed search text with lowercase', () {
      const input = 'ThIS iS a TeSt';
      const expectedOutput = 'thisisatest';
      final result = TextMod.fixSearchText(input);
      expect(result, equals(expectedOutput));
    });

    test('fixSearchText returns the correct fixed search text with removed spaces', () {
      const input = '   remove  spaces   from  string  ';
      const expectedOutput = 'removespacesfromstring';
      final result = TextMod.fixSearchText(input);
      expect(result, equals(expectedOutput));
    });

    test('fixSearchText returns the correct fixed search text when input contains numbers', () {
      const input = 'This is a test with numbers 12345';
      const expectedOutput = 'thisisatestwithnumbers12345';
      final result = TextMod.fixSearchText(input);
      expect(result, equals(expectedOutput));
    });
  });

  group('initializePhoneNumber', () {
    test('initializePhoneNumber returns null when number and countryPhoneCode are null', () {
      final result = TextMod.initializePhoneNumber(number: null, countryPhoneCode: null);
      expect(result, isNull);
    });

    test('initializePhoneNumber returns countryPhoneCode when number is null', () {
      const countryPhoneCode = '123';
      final result =
          TextMod.initializePhoneNumber(number: null, countryPhoneCode: countryPhoneCode);
      expect(result, equals(countryPhoneCode));
    });

    test('initializePhoneNumber returns number when both number and countryPhoneCode are not null',
        () {
      const number = '456';
      const countryPhoneCode = '123';
      final result =
          TextMod.initializePhoneNumber(number: number, countryPhoneCode: countryPhoneCode);
      expect(result, equals(number));
    });

    test(
        'initializePhoneNumber returns number when number is not null and countryPhoneCode is null',
        () {
      const number = '456';
      final result = TextMod.initializePhoneNumber(number: number, countryPhoneCode: null);
      expect(result, equals(number));
    });

    test(
        'initializePhoneNumber returns null when number is an empty string and countryPhoneCode is null',
        () {
      final result = TextMod.initializePhoneNumber(number: '', countryPhoneCode: null);
      expect(result, isNull);
    });

    test('initializePhoneNumber returns countryPhoneCode when number is an empty string', () {
      const countryPhoneCode = '123';
      final result = TextMod.initializePhoneNumber(number: '', countryPhoneCode: countryPhoneCode);
      expect(result, equals(countryPhoneCode));
    });

    test(
        'initializePhoneNumber returns null when both number and countryPhoneCode are empty strings',
        () {
      final result = TextMod.initializePhoneNumber(number: '', countryPhoneCode: '');
      expect(result, isNull);
    });
  });

  group('nullifyNumberIfOnlyCountryCode', () {
    test('nullifyNumberIfOnlyCountryCode returns null when number and countryPhoneCode are null', () {
      final result = TextMod.nullifyNumberIfOnlyCountryCode(number: null, countryPhoneCode: null);
      expect(result, isNull);
    });

    test('nullifyNumberIfOnlyCountryCode returns null when number is null and countryPhoneCode is not null', () {
      const countryPhoneCode = '123';
      final result = TextMod.nullifyNumberIfOnlyCountryCode(number: null, countryPhoneCode: countryPhoneCode);
      expect(result, isNull);
    });

    test('nullifyNumberIfOnlyCountryCode returns null when number is not null and countryPhoneCode is null', () {
      const number = '456';
      final result = TextMod.nullifyNumberIfOnlyCountryCode(number: number, countryPhoneCode: null);
      expect(result, isNull);
    });

    test('nullifyNumberIfOnlyCountryCode returns null when number is equal to countryPhoneCode', () {
      const number = '123';
      const countryPhoneCode = '123';
      final result = TextMod.nullifyNumberIfOnlyCountryCode(number: number, countryPhoneCode: countryPhoneCode);
      expect(result, isNull);
    });

    test('nullifyNumberIfOnlyCountryCode returns the number without spaces when number is not equal to countryPhoneCode', () {
      const number = '  456  ';
      const countryPhoneCode = '123';
      const expectedOutput = '456';
      final result = TextMod.nullifyNumberIfOnlyCountryCode(number: number, countryPhoneCode: countryPhoneCode);
      expect(result, equals(expectedOutput));
    });

    test('nullifyNumberIfOnlyCountryCode returns the number without spaces when number has additional spaces', () {
      const number = '  456  ';
      const countryPhoneCode = '123';
      const expectedOutput = '456';
      final result = TextMod.nullifyNumberIfOnlyCountryCode(number: number, countryPhoneCode: countryPhoneCode);
      expect(result, equals(expectedOutput));
    });

    test('nullifyNumberIfOnlyCountryCode returns the number without spaces when number has leading and trailing spaces', () {
      const number = '  456';
      const countryPhoneCode = '123';
      const expectedOutput = '456';
      final result = TextMod.nullifyNumberIfOnlyCountryCode(number: number, countryPhoneCode: countryPhoneCode);
      expect(result, equals(expectedOutput));
    });
  });

  group('initializeWebLink', () {
    test('initializeWebLink returns the default https code when url is null', () {
      final result = TextMod.initializeWebLink(url: null);
      expect(result, equals('https://'));
    });

    test('initializeWebLink returns the default https code when url is an empty string', () {
      final result = TextMod.initializeWebLink(url: '');
      expect(result, equals('https://'));
    });

    test('initializeWebLink returns the given url when url is not null or empty', () {
      const url = 'example.com';
      final result = TextMod.initializeWebLink(url: url);
      expect(result, equals(url));
    });


    test('initializeWebLink returns the given url when url starts with https://', () {
      const url = 'https://example.com';
      final result = TextMod.initializeWebLink(url: url);
      expect(result, equals(url));
    });

    test('initializeWebLink returns the given url when url starts with https:// and has additional characters', () {
      const url = 'https://example.com/path?param=value';
      final result = TextMod.initializeWebLink(url: url);
      expect(result, equals(url));
    });


  });

  group('nullifyUrlLinkIfOnlyHTTPS', () {
    test('nullifyUrlLinkIfOnlyHTTPS returns null when url is null', () {
      final result = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: null);
      expect(result, isNull);
    });

    test('nullifyUrlLinkIfOnlyHTTPS returns null when url is an empty string', () {
      final result = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: '');
      expect(result, isNull);
    });

    test('nullifyUrlLinkIfOnlyHTTPS returns null when url is equal to the httpsCode', () {
      const url = 'https://';
      final result = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: url);
      expect(result, isNull);
    });

    test('nullifyUrlLinkIfOnlyHTTPS returns the url without spaces when url is not equal to the httpsCode', () {
      const url = ' example.com ';
      const expectedOutput = 'example.com';
      final result = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: url);
      expect(result, equals(expectedOutput));
    });

    test('nullifyUrlLinkIfOnlyHTTPS returns the url without spaces when url has additional spaces', () {
      const url = ' example.com ';
      const expectedOutput = 'example.com';
      final result = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: url);
      expect(result, equals(expectedOutput));
    });

    test('nullifyUrlLinkIfOnlyHTTPS returns the url without spaces when url has leading and trailing spaces', () {
      const url = ' example.com';
      const expectedOutput = 'example.com';
      final result = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: url);
      expect(result, equals(expectedOutput));
    });

    test('nullifyUrlLinkIfOnlyHTTPS returns the url without spaces when url has leading and trailing spaces and additional spaces in between', () {
      const url = ' example  . com ';
      const expectedOutput = 'example.com';
      final result = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: url);
      expect(result, equals(expectedOutput));
    });
  });
}
