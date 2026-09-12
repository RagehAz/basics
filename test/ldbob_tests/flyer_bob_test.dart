import 'dart:io';

import 'package:basics/ldbob/bob.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../_fake_path_provider.dart';

FlyerBob _buildFlyerBob(String id) {
  return FlyerBob(
    bobID: 0,
    id: id,
    headline: 'headline-$id',
    trigram: null,
    description: null,
    flyerType: null,
    publishState: null,
    phids: null,
    zone: null,
    authorID: null,
    bzID: null,
    position: null,
    slides: null,
    times: null,
    hasPriceTag: null,
    isAmazonFlyer: null,
    hasPDF: null,
    showsAuthor: null,
    score: null,
    pdfPath: null,
    shareLink: null,
    price: null,
    bzIsActive: null,
    affiliateLink: null,
    gtaLink: null,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Directory tempDir = Directory.systemTemp.createTempSync('flyer_bob_test_');
  PathProviderPlatform.instance = FakePathProviderPlatform(tempDir.path);

  const String docName = 'flyers';

  tearDownAll(() async {
    await BobInit.closeTheStore();
    try {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    } on Exception catch (_) {}
  });

  group('FlyerBobFoundation.deleteByModelsIDs', () {

    test('removes only the targeted IDs, leaving untouched records in place', () async {
      final String keep = 'flyer_keep_${DateTime.now().microsecondsSinceEpoch}';
      final String drop1 = 'flyer_drop1_${DateTime.now().microsecondsSinceEpoch}';
      final String drop2 = 'flyer_drop2_${DateTime.now().microsecondsSinceEpoch}';

      final bool inserted = await FlyerBobFoundation.insertMany(
        bobs: [_buildFlyerBob(keep), _buildFlyerBob(drop1), _buildFlyerBob(drop2)],
        docName: docName,
      );
      expect(inserted, isTrue);

      final bool deleted = await FlyerBobFoundation.deleteByModelsIDs(
        modelsIDs: [drop1, drop2],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<FlyerBob> remaining = await FlyerBobFoundation.findBobsByModelsIDs(
        modelsIDs: [keep, drop1, drop2],
        docName: docName,
      );
      expect(remaining.length, 1);
      expect(remaining.single.id, keep);
    });

    test('IDs that do not exist are simply a no-op -- returns true, deletes nothing', () async {
      final String existing = 'flyer_existing_${DateTime.now().microsecondsSinceEpoch}';
      await FlyerBobFoundation.insertMany(bobs: [_buildFlyerBob(existing)], docName: docName);

      final bool deleted = await FlyerBobFoundation.deleteByModelsIDs(
        modelsIDs: ['flyer_does_not_exist_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<FlyerBob> stillThere = await FlyerBobFoundation.findBobsByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere.length, 1);
    });

    test('a null modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await FlyerBobFoundation.deleteByModelsIDs(
        modelsIDs: null,
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('an empty modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await FlyerBobFoundation.deleteByModelsIDs(
        modelsIDs: <String>[],
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('deleting a mix of existing and non-existing IDs removes only the existing one', () async {
      final String existing = 'flyer_mixed_${DateTime.now().microsecondsSinceEpoch}';
      await FlyerBobFoundation.insertMany(bobs: [_buildFlyerBob(existing)], docName: docName);

      final bool deleted = await FlyerBobFoundation.deleteByModelsIDs(
        modelsIDs: [existing, 'flyer_never_existed_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<FlyerBob> stillThere = await FlyerBobFoundation.findBobsByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere, isEmpty);
    });

  });
}
