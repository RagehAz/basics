import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
// -----------------------------------------------------------------------------
  /// Iconz.checkAssetExists uses rootBundle.load, which needs
  /// ServicesBinding.instance -- a plain test() (unlike testWidgets())
  /// doesn't initialize any Flutter binding on its own.
  TestWidgetsFlutterBinding.ensureInitialized();
  // -----------------------------------------------------------------------------
  test('checkAssetExists', () async {

    const String icon = Iconz.bz;

    /// when tests run from inside the basics package itself, an asset key
    /// prefixed with 'packages/basics/...' resolves directly against this
    /// package's own lib/ folder on disk -- no pubspec.yaml assets: entry
    /// needed. So this genuinely resolves here, unlike a real consuming
    /// app (where basics is an external dependency and this same key
    /// would need to be declared/bundled).
    final bool exists = await Iconz.checkAssetExists(icon);
    expect(exists, true);

    /// local helper mirrors Iconz.checkAssetExists's try/catch shape --
    /// using .then().catchError() here previously hung on this specific
    /// asset-bundle Future rather than completing (verified: it neither
    /// completes on success nor reliably catches the failure case; try/
    /// catch around a plain await does not have this problem).
    Future<bool> checkAssetExistsWithAlteredPathForTesting(String? bldrsThemeAsset) async {
      bool _exists = false;

      if (bldrsThemeAsset != null) {
        try {
          await rootBundle.load(bldrsThemeAsset);
          _exists = true;
        } catch (error) {
          _exists = false;
        }
      }

      return _exists;
    }

    /// same underlying path as `icon` above, so it resolves the same way.
    final bool existsWithAlteredPath = await checkAssetExistsWithAlteredPathForTesting(icon);
    expect(existsWithAlteredPath, true);

    /// missing the 'packages/basics/' prefix -- does not resolve.
    const String icon2 = 'lib/assets/icons/gi_play.svg';
    final bool exists2 = await checkAssetExistsWithAlteredPathForTesting(icon2);
    expect(exists2, false);

    /// intentionally not a real file.
    const String icon3 = 'lib/assets/icons/gi_bzzzzzz.jpg';
    final bool exists3 = await checkAssetExistsWithAlteredPathForTesting(icon3);
    expect(exists3, false);

  });
  // -----------------------------------------------------------------------------
  /// THIS TEST TO BE USED IN ANOTHER PROJECT AFTER IMPORTING bldrs_theme PACKAGE
  /*
  test('check bldrs_theme asset exists', () async {

    /// should insure widgets binding for root bundle to work in tests
    WidgetsFlutterBinding.ensureInitialized();

    const String icon = Iconz.bz;
    final bool exists = await Iconz.checkAssetExists(icon);
    expect(exists, true);

    const String icon2 = 'lib/assets/icons/gi_bzzzzzz.jpg';
    final bool exists2 = await Iconz.checkAssetExists(icon2);
    expect(exists2, false);

  });
   */
  // -----------------------------------------------------------------------------
}
