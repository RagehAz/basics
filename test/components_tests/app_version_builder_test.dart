import 'package:basics/components/sensors/app_version_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// appVersionIsValid

  // --------------------
  group('AppVersionBuilder.appVersionIsValid', () {

    test('Returns true for a plain semantic version', () {
      expect(AppVersionBuilder.appVersionIsValid('1.2.3'), true);
    });

    test('Returns true for a version with a build number', () {
      expect(AppVersionBuilder.appVersionIsValid('1.2.3+45'), true);
    });

    test('Returns false for a version missing a segment', () {
      expect(AppVersionBuilder.appVersionIsValid('1.2'), false);
    });

    test('Returns false for a non-numeric version', () {
      expect(AppVersionBuilder.appVersionIsValid('a.b.c'), false);
    });

    test('Returns false when version is null', () {
      expect(AppVersionBuilder.appVersionIsValid(null), false);
    });

    test('Returns false for an empty string', () {
      expect(AppVersionBuilder.appVersionIsValid(''), false);
    });

  });
  // -----------------------------------------------------------------------------

  /// getAppVersionNumbered

  // --------------------
  group('AppVersionBuilder.getAppVersionNumbered', () {

    test('Converts a plain version into a comparable int', () {
      expect(AppVersionBuilder.getAppVersionNumbered('1.2.3'), 123);
    });

    test('Ignores the build number when converting', () {
      expect(AppVersionBuilder.getAppVersionNumbered('1.2.3+45'), 123);
    });

    test('Returns null for an invalid version', () {
      expect(AppVersionBuilder.getAppVersionNumbered('not.a.version'), isNull);
    });

  });
  // -----------------------------------------------------------------------------

  /// versionIsBigger

  // --------------------
  group('AppVersionBuilder.versionIsBigger', () {

    test('Returns true when the first version is bigger', () {
      expect(AppVersionBuilder.versionIsBigger(thisIsBigger: '2.0.0', thanThis: '1.9.9'), true);
    });

    test('Returns false when the first version is smaller', () {
      expect(AppVersionBuilder.versionIsBigger(thisIsBigger: '1.0.0', thanThis: '1.0.1'), false);
    });

    test('Returns false when the versions are equal', () {
      expect(AppVersionBuilder.versionIsBigger(thisIsBigger: '1.2.3', thanThis: '1.2.3'), false);
    });

    test('Returns false when either version is invalid', () {
      expect(AppVersionBuilder.versionIsBigger(thisIsBigger: 'bad', thanThis: '1.0.0'), false);
      expect(AppVersionBuilder.versionIsBigger(thisIsBigger: '1.0.0', thanThis: null), false);
    });

  });
}
