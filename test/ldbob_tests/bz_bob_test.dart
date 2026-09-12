import 'dart:io';

import 'package:basics/ldbob/bob.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../_fake_path_provider.dart';

BzBob _buildBzBob(String id) {
  return BzBob(
    bobID: 0,
    id: id,
    bzTypes: null,
    bzForm: null,
    createdAt: null,
    power: null,
    name: 'name-$id',
    trigram: null,
    logoPath: null,
    scopes: null,
    zone: null,
    about: null,
    position: null,
    contacts: null,
    authors: null,
    pendings: null,
    showsTeam: null,
    isVerified: null,
    bzState: null,
    publication: null,
    lastStateChanged: null,
    lastPicChanged: null,
    assetsIDs: null,
    questionsIDs: null,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Directory tempDir = Directory.systemTemp.createTempSync('bz_bob_test_');
  PathProviderPlatform.instance = FakePathProviderPlatform(tempDir.path);

  const String docName = 'bzz';

  tearDownAll(() async {
    await BobInit.closeTheStore();
    try {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    } on Exception catch (_) {
      /// best-effort cleanup -- Windows can hold the native store's file
      /// handle open briefly after closeTheStore() returns.
    }
  });

  group('BzBobFoundation.deleteByModelsIDs', () {

    test('removes only the targeted IDs, leaving untouched records in place', () async {
      final String keep = 'bz_keep_${DateTime.now().microsecondsSinceEpoch}';
      final String drop1 = 'bz_drop1_${DateTime.now().microsecondsSinceEpoch}';
      final String drop2 = 'bz_drop2_${DateTime.now().microsecondsSinceEpoch}';

      final bool inserted = await BzBobFoundation.insertMany(
        bobs: [_buildBzBob(keep), _buildBzBob(drop1), _buildBzBob(drop2)],
        docName: docName,
      );
      expect(inserted, isTrue);

      final bool deleted = await BzBobFoundation.deleteByModelsIDs(
        modelsIDs: [drop1, drop2],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<BzBob> remaining = await BzBobFoundation.findBobsByModelsIDs(
        modelsIDs: [keep, drop1, drop2],
        docName: docName,
      );
      expect(remaining.length, 1);
      expect(remaining.single.id, keep);
    });

    test('IDs that do not exist are simply a no-op -- returns true, deletes nothing', () async {
      final String existing = 'bz_existing_${DateTime.now().microsecondsSinceEpoch}';
      await BzBobFoundation.insertMany(bobs: [_buildBzBob(existing)], docName: docName);

      final bool deleted = await BzBobFoundation.deleteByModelsIDs(
        modelsIDs: ['bz_does_not_exist_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<BzBob> stillThere = await BzBobFoundation.findBobsByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere.length, 1);
    });

    test('a null modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await BzBobFoundation.deleteByModelsIDs(
        modelsIDs: null,
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('an empty modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await BzBobFoundation.deleteByModelsIDs(
        modelsIDs: <String>[],
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('deleting a mix of existing and non-existing IDs removes only the existing one', () async {
      final String existing = 'bz_mixed_${DateTime.now().microsecondsSinceEpoch}';
      await BzBobFoundation.insertMany(bobs: [_buildBzBob(existing)], docName: docName);

      final bool deleted = await BzBobFoundation.deleteByModelsIDs(
        modelsIDs: [existing, 'bz_never_existed_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<BzBob> stillThere = await BzBobFoundation.findBobsByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere, isEmpty);
    });

  });
}
