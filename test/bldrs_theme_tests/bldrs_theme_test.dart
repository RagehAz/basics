import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
// -----------------------------------------------------------------------------
  test('checkAssetExists', () async {

    const String icon = Iconz.bz;

    final bool exists = await Iconz.checkAssetExists(icon);
    expect(exists, false);

    /// this method will fail to be used here
    /// as it uses the below path, which only works when used in other
    /// projects depending on bldrs_theme package
    /// final String _path = 'packages/basics/bldrs_theme/$bldrsThemeAsset';
    /// so in order to check the method [Iconz.checkAssetExists]
    /// an altered path is used here
    ///
    /// AND I GUESS rootBundle will not work as well because assets are not bundled here
    /// and are not mentioned in pubspec.yaml

    Future<bool> checkAssetExistsWithAlteredPathForTesting(String? bldrsThemeAsset) async {
      bool _exists = false;

      if (bldrsThemeAsset != null) {
        await rootBundle.load(bldrsThemeAsset).then((_) {
          _exists = true;
        }).catchError((error) {
          _exists = false;
        });
      }

      return _exists;
    }

    final bool existsWithAlteredPath = await checkAssetExistsWithAlteredPathForTesting(icon);
    expect(existsWithAlteredPath, false);

    const String icon2 = 'lib/assets/icons/gi_play.svg';
    final bool exists2 = await checkAssetExistsWithAlteredPathForTesting(icon2);
    expect(exists2, false);

    const String icon3 = 'lib/assets/icons/gi_bzzzzzz.jpg';
    final bool exists3 = await checkAssetExistsWithAlteredPathForTesting(icon3);
    expect(exists3, false);

    /// so to properly test this method, bldrs_theme package should be imported
    /// in another project
    /// then
    /// tested there, just copy the below method and test in another project

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
