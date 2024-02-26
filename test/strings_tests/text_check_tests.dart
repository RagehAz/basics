import 'package:basics/helpers/strings/searching.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('TextCheck containsBadWords', () {
    test('Returns false for empty text', () {
      final result = TextCheck.containsBadWords(
        text: '',
        badWords: ['bad', 'nasty', 'shit'],
      );
      expect(result, false);
    });

    test('Returns false when no bad words are present', () {
      final result = TextCheck.containsBadWords(
        text: 'This is a clean text.',
        badWords: ['bad', 'nasty', 'shit'],
      );
      expect(result, false);
    });

    test('Returns true when a bad word is present', () {
      final result = TextCheck.containsBadWords(
        text: 'This text contains a bad word.',
        badWords: ['bad', 'nasty', 'shit'],
      );
      expect(result, true);
    });

    test('Returns true when multiple bad words are present', () {
      final result = TextCheck.containsBadWords(
        text: 'This text contains multiple bad words like nasty and shit.',
        badWords: ['bad', 'nasty', 'shit'],
      );
      expect(result, true);
    });

    test('Is case-insensitive for bad words', () {
      final result = TextCheck.containsBadWords(
        text: 'This text contains a NASTY word.',
        badWords: ['bad', 'nasty', 'shit'],
      );
      expect(result, true);
    });

    test('Handles partial matches', () {
      final result = TextCheck.containsBadWords(
        text: 'This text contains shite.',
        badWords: ['bad', 'nasty', 'shit'],
      );
      expect(result, true);
    });

    test('Handles special characters in bad words', () {
      final result = TextCheck.containsBadWords(
        text: 'This text contains a b@d word.',
        badWords: ['b@d', 'nasty', 'shit'],
      );
      expect(result, true);
    });
  });

  group('textIsEnglish', () {
    test('Returns true for null input', () {
      final result = TextCheck.textIsEnglish(null);
      expect(result, true);
    });

    test('Returns true for empty input', () {
      final result = TextCheck.textIsEnglish('');
      expect(result, true);
    });

    test('Returns true for English text', () {
      final result = TextCheck.textIsEnglish('This is an English text.');
      expect(result, true);
    });

    test('Returns false for non-English text', () {
      final result = TextCheck.textIsEnglish('これは日本語のテキストです。');
      expect(result, false);
    });

    test('Returns true for English text with leading spaces', () {
      final result = TextCheck.textIsEnglish('  English text with leading spaces.');
      expect(result, true);
    });

    test('Returns false for non-English text with leading spaces', () {
      final result = TextCheck.textIsEnglish('  日本語のテキストです。');
      expect(result, false);
    });

    test('Is case-insensitive for English text', () {
      final result = TextCheck.textIsEnglish('english TEXT');
      expect(result, true);
    });

    test('Is case-insensitive for non-English text', () {
      final result = TextCheck.textIsEnglish('日本語のテキスト');
      expect(result, false);
    });
  });

  group('textStartsInArabic', () {
    test('Returns false for null input', () {
      final result = TextCheck.textStartsInArabic(null);
      expect(result, false);
    });

    test('Returns false for empty input', () {
      final result = TextCheck.textStartsInArabic('');
      expect(result, false);
    });

    test('Returns true for Arabic text', () {
      final result = TextCheck.textStartsInArabic('مرحبا بك');
      expect(result, true);
    });

    test('Returns false for non-Arabic text', () {
      final result = TextCheck.textStartsInArabic('Hello');
      expect(result, false);
    });

    test('Is case-insensitive', () {
      final result = TextCheck.textStartsInArabic('مرحبا');
      expect(result, true);
    });

    test('Considers leading spaces', () {
      final result = TextCheck.textStartsInArabic('   مرحبا بك');
      expect(result, true);
    });

    test('Returns false if the first character is a number', () {
      final result = TextCheck.textStartsInArabic('1234');
      expect(result, false);
    });

    test('Returns false if the first character is a special character', () {
      final result = TextCheck.textStartsInArabic('#Hello');
      expect(result, false);
    });
  });

  group('textStartsInEnglish', () {
    test('Returns false for null input', () {
      final result = TextCheck.textStartsInEnglish(null);
      expect(result, false);
    });

    test('Returns false for empty input', () {
      final result = TextCheck.textStartsInEnglish('');
      expect(result, false);
    });

    test('Returns true for English text', () {
      final result = TextCheck.textStartsInEnglish('Hello');
      expect(result, true);
    });

    test('Returns false for non-English text', () {
      final result = TextCheck.textStartsInEnglish('مرحبا');
      expect(result, false);
    });

    test('Is case-insensitive', () {
      final result = TextCheck.textStartsInEnglish('hElLo');
      expect(result, true);
    });

    test('Considers leading spaces', () {
      final result = TextCheck.textStartsInEnglish('   Hello');
      expect(result, true);
    });

    test('Returns false if the first character is a number', () {
      final result = TextCheck.textStartsInEnglish('1234');
      expect(result, false);
    });

    test('Returns false if the first character is a special character', () {
      final result = TextCheck.textStartsInEnglish('#Hello');
      expect(result, false);
    });
  });

  group('textIsRTL', () {
    test('Returns false for null input', () {
      final result = TextCheck.textIsRTL(null);
      expect(result, false);
    });

    test('Returns false for empty input', () {
      final result = TextCheck.textIsRTL('');
      expect(result, false);
    });

    test('Returns false for LTR text', () {
      final result = TextCheck.textIsRTL('Hello');
      expect(result, false);
    });

    test('Returns true for RTL text', () {
      final result = TextCheck.textIsRTL('مرحبا');
      expect(result, true);
    });

    test('Is case-insensitive', () {
      final result = TextCheck.textIsRTL('مرحبا World');
      expect(result, true);
    });

    test('Considers leading spaces', () {
      final result = TextCheck.textIsRTL('   مرحبا');
      expect(result, true);
    });

    test('Returns false for mixed LTR and RTL text', () {
      final result = TextCheck.textIsRTL('Hello مرحبا');
      expect(result, true);
    });
  });

  group('concludeEnglishOrArabicLang', () {
    test('Returns "ar" for Arabic text', () {
      final result = TextCheck.concludeEnglishOrArabicLang('مرحبا');
      expect(result, 'ar');
    });

    test('Returns "en" for English text', () {
      final result = TextCheck.concludeEnglishOrArabicLang('Hello');
      expect(result, 'en');
    });

    test('Returns "en" for null input', () {
      final result = TextCheck.concludeEnglishOrArabicLang(null);
      expect(result, 'en');
    });

    test('Returns "en" for empty input', () {
      final result = TextCheck.concludeEnglishOrArabicLang('');
      expect(result, 'en');
    });

    test('Handles mixed LTR and RTL text', () {
      final result = TextCheck.concludeEnglishOrArabicLang('Hello مرحبا');
      expect(result, 'en');
    });
  });

  group('verseIsUpperCase', () {
    test('Returns true for all uppercase text', () {
      final result = TextCheck.verseIsUpperCase('THIS IS UPPER CASE');
      expect(result, true);
    });

    test('Returns false for lowercase text', () {
      final result = TextCheck.verseIsUpperCase('this is lower case');
      expect(result, false);
    });

    test('Returns false for mixed case text', () {
      final result = TextCheck.verseIsUpperCase('ThIs Is MiXeD CaSe');
      expect(result, false);
    });

    test('Returns false for null input', () {
      final result = TextCheck.verseIsUpperCase(null);
      expect(result, false);
    });

    test('Returns false for empty input', () {
      final result = TextCheck.verseIsUpperCase('');
      expect(result, false);
    });
  });

  group('textControllerIsEmpty', () {
    test('Returns true for null controller', () {
      final result = TextCheck.textControllerIsEmpty(null);
      expect(result, true);
    });

    test('Returns true for empty text', () {
      final controller = TextEditingController(text: '');
      final result = TextCheck.textControllerIsEmpty(controller);
      expect(result, true);
    });

    test('Returns true for text with only spaces', () {
      final controller = TextEditingController(text: '    ');
      final result = TextCheck.textControllerIsEmpty(controller);
      expect(result, true);
    });

    test('Returns true for text with spaces after trimming', () {
      final controller = TextEditingController(text: '   Some Text   ');
      final result = TextCheck.textControllerIsEmpty(controller);
      expect(result, false);
    });

    test('Returns false for non-empty text', () {
      final controller = TextEditingController(text: 'Some Text');
      final result = TextCheck.textControllerIsEmpty(controller);
      expect(result, false);
    });
  });

  group('textControllersAreIdentical', () {
    test('Returns true for both null controllers', () {
      final result = TextCheck.textControllersAreIdentical(
        controller1: null,
        controller2: null,
      );
      expect(result, true);
    });

    test('Returns false for one null and one non-null controller', () {
      final controller1 = TextEditingController(text: 'Text');
      final result = TextCheck.textControllersAreIdentical(
        controller1: controller1,
        controller2: null,
      );
      expect(result, false);
    });

    test('Returns true for identical controllers', () {
      final controller1 = TextEditingController(text: 'Text');
      final controller2 = TextEditingController(text: 'Text');
      final result = TextCheck.textControllersAreIdentical(
        controller1: controller1,
        controller2: controller2,
      );
      expect(result, false);
    });

    test('Returns false for different text in controllers', () {
      final controller1 = TextEditingController(text: 'Text1');
      final controller2 = TextEditingController(text: 'Text2');
      final result = TextCheck.textControllersAreIdentical(
        controller1: controller1,
        controller2: controller2,
      );
      expect(result, false);
    });

    test('Returns false for different hash codes of controllers', () {
      final controller1 = TextEditingController(text: 'Text');
      final controller2 = TextEditingController(text: 'Text');
      controller2.text = 'Updated Text';
      final result = TextCheck.textControllersAreIdentical(
        controller1: controller1,
        controller2: controller2,
      );
      expect(result, false);
    });
  });

  group('createEmptyTextControllers', () {
    test('Returns an empty list for length = null', () {
      final result = TextCheck.createEmptyTextControllers(null);
      expect(result, []);
    });

    test('Returns an empty list for length = 0', () {
      final result = TextCheck.createEmptyTextControllers(0);
      expect(result, []);
    });

    test('Returns a list with one empty controller for length = 1', () {
      final result = TextCheck.createEmptyTextControllers(1);
      expect(result.length, 1);
      expect(result[0].text, '');
    });

    test('Returns a list with multiple empty controllers for length > 1', () {
      final result = TextCheck.createEmptyTextControllers(3);
      expect(result.length, 3);
      expect(result[0].text, '');
      expect(result[1].text, '');
      expect(result[2].text, '');
    });
  });

  group('isEmpty', () {
    test('Returns true for null string', () {
      final result = TextCheck.isEmpty(null);
      expect(result, true);
    });

    test('Returns true for empty string', () {
      final result = TextCheck.isEmpty('');
      expect(result, true);
    });

    test('Returns true for string with only whitespace', () {
      final result = TextCheck.isEmpty('     ');
      expect(result, false);
    });

    test('Returns false for non-empty string', () {
      final result = TextCheck.isEmpty('Hello World');
      expect(result, false);
    });
  });

  group('stringContainsSubString', () {
    test('Returns true when string contains the substring (case-insensitive)', () {
      final result = TextCheck.stringContainsSubString(
        string: 'Hello World',
        subString: 'world',
      );
      expect(result, true);
    });

    test('Returns true when string contains the substring (case-sensitive)', () {
      final result = TextCheck.stringContainsSubString(
        string: 'Hello World',
        subString: 'Hello',
      );
      expect(result, true);
    });

    test('Returns false when string does not contain the substring', () {
      final result = TextCheck.stringContainsSubString(
        string: 'Hello World',
        subString: 'foo',
      );
      expect(result, false);
    });

    test('Returns false when either string or substring is null', () {
      final result = TextCheck.stringContainsSubString(
        string: null,
        subString: 'Hello',
      );
      expect(result, false);
    });

    test('Returns false when both string and substring are null', () {
      final result = TextCheck.stringContainsSubString(
        string: null,
        subString: null,
      );
      expect(result, false);
    });

    test('Returns false when both string and substring are empty', () {
      final result = TextCheck.stringContainsSubString(
        string: '',
        subString: '',
      );
      expect(result, true);
    });

    test('/#/', () {
      expect(TextCheck.stringContainsSubString(string: 'theString/#/thing', subString: '/#/'), true);
      expect(TextCheck.stringContainsSubString(string: '/#/thing', subString: '/#/'), true);
      expect(TextCheck.stringContainsSubString(string: '/#/', subString: '/#/'), true);
      expect(TextCheck.stringContainsSubString(string: 'ssss/#', subString: '/#/'), false);
      expect(TextCheck.stringContainsSubString(string: 'ssss/#ss', subString: '/#/'), false);
      expect(TextCheck.stringContainsSubString(string: 'ssss/#/', subString: '/#/'), true);
      expect(TextCheck.stringContainsSubString(string: 'ssss/x/', subString: '/#/'), false);

    });

  });

  group('stringContainsSubStringRegExp', () {
    test('Returns true when string contains the substring (case-insensitive)', () {
      final result = TextCheck.stringContainsSubStringRegExp(
        string: 'Hello World',
        subString: 'world',
      );
      expect(result, true);
    });

    test('Returns true when string contains the substring (case-sensitive)', () {
      final result = TextCheck.stringContainsSubStringRegExp(
        string: 'Hello World',
        subString: 'Hello',
        caseSensitive: true,
      );
      expect(result, true);
    });

    test('Returns false when string does not contain the substring', () {
      final result = TextCheck.stringContainsSubStringRegExp(
        string: 'Hello World',
        subString: 'foo',
      );
      expect(result, false);
    });

    test('Returns false when either string or substring is null', () {
      final result = TextCheck.stringContainsSubStringRegExp(
        string: null,
        subString: 'Hello',
      );
      expect(result, false);
    });

    test('Returns false when both string and substring are null', () {
      final result = TextCheck.stringContainsSubStringRegExp(
        string: null,
        subString: null,
      );
      expect(result, false);
    });

    test('Returns false when both string and substring are empty', () {
      final result = TextCheck.stringContainsSubStringRegExp(
        string: '',
        subString: '',
      );
      expect(result, true);
    });
  });

  group('stringStartsExactlyWith', () {
    test('Returns true when the text starts exactly with the specified string', () {
      final result = TextCheck.stringStartsExactlyWith(
        text: 'http://example.com',
        startsWith: 'http://',
      );
      expect(result, true);
    });

    test('Returns false when the text does not start exactly with the specified string', () {
      final result = TextCheck.stringStartsExactlyWith(
        text: 'https://example.com',
        startsWith: 'http://',
      );
      expect(result, false);
    });

    test('Returns false when either text or startsWith is null', () {
      final result = TextCheck.stringStartsExactlyWith(
        text: null,
        startsWith: 'http://',
      );
      expect(result, false);
    });

    test('Returns false when both text and startsWith are null', () {
      final result = TextCheck.stringStartsExactlyWith(
        text: null,
        startsWith: null,
      );
      expect(result, false);
    });

    test('Returns false when both text and startsWith are empty', () {
      final result = TextCheck.stringStartsExactlyWith(
        text: '',
        startsWith: '',
      );
      expect(result, false);
    });
  });

  group('stringStartsWithAny', () {
    test('Returns true when the text starts with any string in the list', () {
      final result = TextCheck.stringStartsWithAny(
        text: 'http://example.com',
        listThatMightIncludeText: ['http://', 'https://'],
      );
      expect(result, true);
    });

    test('Returns false when the text does not start with any string in the list', () {
      final result = TextCheck.stringStartsWithAny(
        text: 'ftp://example.com',
        listThatMightIncludeText: ['http://', 'https://'],
      );
      expect(result, false);
    });

    test('Returns false when either text or listThatMightIncludeText is null', () {
      final result = TextCheck.stringStartsWithAny(
        text: null,
        listThatMightIncludeText: ['http://', 'https://'],
      );
      expect(result, false);
    });

    test('Returns false when both text and listThatMightIncludeText are null', () {
      final result = TextCheck.stringStartsWithAny(
        text: null,
        listThatMightIncludeText: null,
      );
      expect(result, false);
    });

    test('Returns false when both text and listThatMightIncludeText are empty', () {
      final result = TextCheck.stringStartsWithAny(
        text: '',
        listThatMightIncludeText: [],
      );
      expect(result, false);
    });
  });

  group('getStringsStartingExactlyWith', () {
    test('Returns a list of strings that start exactly with the specified prefix', () {
      final List<String>? result = TextCheck.getStringsStartingExactlyWith(
        startWith: 'hello',
        strings: ['hello world', 'hello there', 'hi', 'hey'],
      );
      expect(result, ['hello world', 'hello there']);
    });

    test('Returns an empty list when no strings start exactly with the specified prefix', () {
      final result = TextCheck.getStringsStartingExactlyWith(
        startWith: 'hello',
        strings: ['hi', 'hey', 'goodbye'],
      );
      expect(result, []);
    });

    test('Returns an empty list when either startWith or strings is null', () {
      final result = TextCheck.getStringsStartingExactlyWith(
        startWith: null,
        strings: ['hello', 'hi', 'hey'],
      );
      expect(result, []);
    });

    test('Returns an empty list when both startWith and strings are null', () {
      final result = TextCheck.getStringsStartingExactlyWith(
        startWith: null,
        strings: null,
      );
      expect(result, []);
    });

    test('Returns an empty list when both startWith and strings are empty', () {
      final result = TextCheck.getStringsStartingExactlyWith(
        startWith: '',
        strings: [],
      );
      expect(result, []);
    });
  });

  group('isShorterThanOrEqualTo', () {
    test('Returns true if the text is empty', () {
      final result = TextCheck.isShorterThanOrEqualTo(
        text: '',
        length: 5,
      );
      expect(result, isTrue);
    });

    test('Returns true if the text length is equal to the specified length', () {
      final result = TextCheck.isShorterThanOrEqualTo(
        text: 'Hello',
        length: 5,
      );
      expect(result, isTrue);
    });

    test('Returns true if the text length is less than the specified length', () {
      final result = TextCheck.isShorterThanOrEqualTo(
        text: 'Hi',
        length: 5,
      );
      expect(result, isTrue);
    });

    test('Returns false if the text length is greater than the specified length', () {
      final result = TextCheck.isShorterThanOrEqualTo(
        text: 'Hello World',
        length: 5,
      );
      expect(result, isFalse);
    });

    test('Returns true if either text or length is null', () {
      final result = TextCheck.isShorterThanOrEqualTo(
        text: 'Hello',
        length: null,
      );
      expect(result, isTrue);
    });
  });

  group('isShorterThan', () {
    test('Returns true if the text is empty', () {
      final result = TextCheck.isShorterThan(
        text: '',
        length: 5,
      );
      expect(result, isTrue);
    });

    test('Returns true if the text length is less than the specified length', () {
      final result = TextCheck.isShorterThan(
        text: 'Hi',
        length: 5,
      );
      expect(result, isTrue);
    });

    test('Returns false if the text length is equal to the specified length', () {
      final result = TextCheck.isShorterThan(
        text: 'Hello',
        length: 5,
      );
      expect(result, isFalse);
    });

    test('Returns false if the text length is greater than the specified length', () {
      final result = TextCheck.isShorterThan(
        text: 'Hello World',
        length: 5,
      );
      expect(result, isFalse);
    });

    test('Returns true if either text or length is null', () {
      final result = TextCheck.isShorterThan(
        text: 'Hello',
        length: null,
      );
      expect(result, isTrue);
    });
  });

  group('triggerIsSearching', () {
    test('Returns false if the text is null', () {
      final result = Searching.triggerIsSearching(text: null);
      expect(result, isFalse);
    });

    test('Returns false if the text length is less than the minimum character limit', () {
      final result = Searching.triggerIsSearching(text: 'Hi', minCharLimit: 5);
      expect(result, isFalse);
    });

    test('Returns true if the text length is equal to the minimum character limit', () {
      final result = Searching.triggerIsSearching(text: 'Hello', minCharLimit: 5);
      expect(result, isTrue);
    });

    test('Returns true if the text length is greater than the minimum character limit', () {
      final result = Searching.triggerIsSearching(text: 'Hello World', minCharLimit: 5);
      expect(result, isTrue);
    });

    test('Returns false if the text is null and the minimum character limit is not reached', () {
      final result = Searching.triggerIsSearching(text: null, minCharLimit: 5);
      expect(result, isFalse);
    });
  });

  group('triggerIsSearchingNotifier', () {
    test(
        'Switches on searching and calls onResume when text length is equal to or greater than minCharLimit',
        () {
      final isSearching = ValueNotifier<bool>(false);
      bool onResumeCalled = false;
      bool onSwitchOffCalled = false;

      Searching.triggerIsSearchingNotifier(
        text: 'Hello',
        isSearching: isSearching,
        mounted: true,
        minCharLimit: 5,
        onResume: () {
          onResumeCalled = true;
        },
        onSwitchOff: () {
          onSwitchOffCalled = true;
        },
      );

      expect(isSearching.value, isTrue);
      expect(onResumeCalled, isTrue);
      expect(onSwitchOffCalled, isFalse);
    });

    test('Switches off searching and calls onSwitchOff when text length is less than minCharLimit',
        () {
      final isSearching = ValueNotifier<bool>(true);
      bool onResumeCalled = false;
      bool onSwitchOffCalled = false;

      Searching.triggerIsSearchingNotifier(
        text: 'Hi',
        isSearching: isSearching,
        mounted: true,
        minCharLimit: 5,
        onResume: () {
          onResumeCalled = true;
        },
        onSwitchOff: () {
          onSwitchOffCalled = true;
        },
      );

      expect(isSearching.value, isFalse);
      expect(onResumeCalled, isFalse);
      expect(onSwitchOffCalled, isTrue);
    });

    test('Does not switch on searching when it is already on', () {
      final isSearching = ValueNotifier<bool>(true);
      bool onResumeCalled = false;
      bool onSwitchOffCalled = false;

      Searching.triggerIsSearchingNotifier(
        text: 'Hello',
        isSearching: isSearching,
        mounted: true,
        minCharLimit: 5,
        onResume: () {
          onResumeCalled = true;
        },
        onSwitchOff: () {
          onSwitchOffCalled = true;
        },
      );

      expect(isSearching.value, isTrue);
      expect(onResumeCalled, isTrue);
      expect(onSwitchOffCalled, isFalse);
    });

    test('Does not switch off searching when it is already off', () {
      final isSearching = ValueNotifier<bool>(false);
      bool onResumeCalled = false;
      bool onSwitchOffCalled = false;

      Searching.triggerIsSearchingNotifier(
        text: 'Hi',
        isSearching: isSearching,
        mounted: true,
        minCharLimit: 5,
        onResume: () {
          onResumeCalled = true;
        },
        onSwitchOff: () {
          onSwitchOffCalled = true;
        },
      );

      expect(isSearching.value, isFalse);
      expect(onResumeCalled, isFalse);
      expect(onSwitchOffCalled, isFalse);
    });

    test('Does not switch on searching when text is null', () {
      final isSearching = ValueNotifier<bool>(false);
      bool onResumeCalled = false;
      bool onSwitchOffCalled = false;

      Searching.triggerIsSearchingNotifier(
        text: null,
        isSearching: isSearching,
        mounted: true,
        minCharLimit: 5,
        onResume: () {
          onResumeCalled = true;
        },
        onSwitchOff: () {
          onSwitchOffCalled = true;
        },
      );

      expect(isSearching.value, isFalse);
      expect(onResumeCalled, isFalse);
      expect(onSwitchOffCalled, isFalse);
    });
  });

}
