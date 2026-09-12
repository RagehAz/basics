import 'package:basics/bldrs_theme/assets/planet/all_flags_list.dart';
import 'package:basics/models/flag_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// searchCountryPhoneCodesEqual

  // --------------------
  group('Flag.searchCountryPhoneCodesEqual', () {

    test('Finds the country whose phone code exactly matches', () {
      final result = Flag.searchCountryPhoneCodesEqual(phoneCode: '+2');
      expect(result, ['egy']);
    });

    test('Returns an empty list when no country matches', () {
      final result = Flag.searchCountryPhoneCodesEqual(phoneCode: '+9999');
      expect(result, <String>[]);
    });

    test('Returns an empty list when phoneCode does not start with +', () {
      final result = Flag.searchCountryPhoneCodesEqual(phoneCode: '2');
      expect(result, <String>[]);
    });

    test('Returns an empty list when phoneCode is null', () {
      final result = Flag.searchCountryPhoneCodesEqual(phoneCode: null);
      expect(result, <String>[]);
    });

  });
  // -----------------------------------------------------------------------------

  /// searchCountryPhoneCodesStartingWith

  // --------------------
  group('Flag.searchCountryPhoneCodesStartingWith', () {

    test('Finds every country whose phone code starts with the given prefix', () {
      final result = Flag.searchCountryPhoneCodesStartingWith(phoneCode: '+2');
      expect(result, contains('egy'));
      expect(result.length, greaterThan(1));
    });

    test('Includes exact-match countries too', () {
      final result = Flag.searchCountryPhoneCodesStartingWith(phoneCode: '+2');
      expect(result, contains('egy'));
    });

    test('Returns an empty list when no country matches', () {
      final result = Flag.searchCountryPhoneCodesStartingWith(phoneCode: '+9999');
      expect(result, <String>[]);
    });

  });
  // -----------------------------------------------------------------------------

  /// searchCountryPhoneCodesContain

  // --------------------
  group('Flag.searchCountryPhoneCodesContain', () {

    test('Finds countries whose phone code contains the given substring', () {
      final result = Flag.searchCountryPhoneCodesContain(phoneCode: '+2');
      expect(result, contains('egy'));
    });

    test('Returns an empty list when phoneCode does not start with +', () {
      final result = Flag.searchCountryPhoneCodesContain(phoneCode: '2');
      expect(result, <String>[]);
    });

    test('Returns an empty list when no country matches', () {
      final result = Flag.searchCountryPhoneCodesContain(phoneCode: '+9999');
      expect(result, <String>[]);
    });

  });
  // -----------------------------------------------------------------------------

  /// search functions stay correct across repeated calls (regression guard
  /// for the now-cached _createCountriesPhonesMap -- the cache must not go
  /// stale or get corrupted across calls)

  // --------------------
  group('Flag phone code search caching', () {

    test('Repeated calls return consistent, independent results', () {
      final first = Flag.searchCountryPhoneCodesEqual(phoneCode: '+2');
      final second = Flag.searchCountryPhoneCodesEqual(phoneCode: '+2');
      expect(first, second);

      final third = Flag.searchCountryPhoneCodesStartingWith(phoneCode: '+1');
      expect(third, contains('usa'));
    });

  });
  // -----------------------------------------------------------------------------

  /// getCountryPhoneCode

  // --------------------
  group('Flag.getCountryPhoneCode', () {

    test('Returns the phone code for a known country id', () {
      expect(Flag.getCountryPhoneCode('egy'), '+2');
    });

    test('Returns null for an unknown country id', () {
      expect(Flag.getCountryPhoneCode('not_a_real_country'), isNull);
    });

    test('Returns null when countryID is null', () {
      expect(Flag.getCountryPhoneCode(null), isNull);
    });

  });
  // -----------------------------------------------------------------------------

  /// getFlagFromFlagsByCountryID / getCountryIDByISO2 / getAllCountriesIDs

  // --------------------
  group('Flag lookups', () {

    test('getFlagFromFlagsByCountryID finds the flag with a matching id', () {
      final flag = Flag.getFlagFromFlagsByCountryID(flags: allFlags, countryID: 'egy');
      expect(flag, isNotNull);
      expect(flag!.id, 'egy');
      expect(flag.iso2, 'EG');
    });

    test('getFlagFromFlagsByCountryID returns null for an unknown id', () {
      final flag = Flag.getFlagFromFlagsByCountryID(flags: allFlags, countryID: 'not_a_real_country');
      expect(flag, isNull);
    });

    test('getCountryIDByISO2 finds the country id for a known ISO2 code', () {
      expect(Flag.getCountryIDByISO2('EG'), 'egy');
    });

    test('getAllCountriesIDs returns a non-empty list containing known ids', () {
      final ids = Flag.getAllCountriesIDs();
      expect(ids, isNotEmpty);
      expect(ids, contains('egy'));
      expect(ids, contains('usa'));
    });

  });
  // -----------------------------------------------------------------------------

  /// checkFlagsAreIdentical

  // --------------------
  group('Flag.checkFlagsAreIdentical', () {

    test('Returns true for the same flag instance', () {
      final flag = Flag.getFlagFromFlagsByCountryID(flags: allFlags, countryID: 'egy');
      expect(Flag.checkFlagsAreIdentical(flag, flag), true);
    });

    test('Returns false for two different flags', () {
      final egy = Flag.getFlagFromFlagsByCountryID(flags: allFlags, countryID: 'egy');
      final usa = Flag.getFlagFromFlagsByCountryID(flags: allFlags, countryID: 'usa');
      expect(Flag.checkFlagsAreIdentical(egy, usa), false);
    });

    test('Returns true when both are null', () {
      expect(Flag.checkFlagsAreIdentical(null, null), true);
    });

  });
}
