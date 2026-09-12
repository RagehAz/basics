import 'package:basics/filing/filing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// FilePathing.checkLocalAssetExists uses rootBundle.load (via
  /// Byter.byteDataFromLocalAsset) under the hood, which needs
  /// ServicesBinding.instance -- a plain test() doesn't initialize any
  /// Flutter binding on its own.
  TestWidgetsFlutterBinding.ensureInitialized();
  // -----------------------------------------------------------------------------

  /// checkLocalAssetExists

  // --------------------
  group('FilePathing.checkLocalAssetExists', () {

    test('Returns true for an asset key resolvable on disk', () async {
      /// resolves directly against this package's own lib/ folder when
      /// tests run from inside the basics package itself.
      const String asset = 'packages/basics/lib/bldrs_theme/assets/icons/gi_bz.svg';
      final bool exists = await FilePathing.checkLocalAssetExists(asset);
      expect(exists, true);
    });

    test('Returns false for a genuinely missing asset', () async {
      final bool exists = await FilePathing.checkLocalAssetExists('lib/assets/icons/gi_bzzzzzz.jpg');
      expect(exists, false);
    });

    test('Returns false when asset is not a String', () async {
      final bool exists = await FilePathing.checkLocalAssetExists(42);
      expect(exists, false);
    });

    test('Returns false when asset is an empty string', () async {
      final bool exists = await FilePathing.checkLocalAssetExists('');
      expect(exists, false);
    });

    test('Returns false when asset is null', () async {
      final bool exists = await FilePathing.checkLocalAssetExists(null);
      expect(exists, false);
    });

  });
}
