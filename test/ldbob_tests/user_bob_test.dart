import 'dart:io';

import 'package:basics/ldbob/bob.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../_fake_path_provider.dart';

UserBob _buildUserBob(String id) {
  return UserBob(
    bobID: 0,
    id: id,
    signInMethod: null,
    isSignedUp: null,
    createdAt: null,
    need: null,
    name: 'name-$id',
    trigram: null,
    picPath: null,
    title: null,
    company: null,
    gender: null,
    zone: null,
    language: null,
    location: null,
    contacts: null,
    contactsArePublic: null,
    myBzzIDs: null,
    isAuthor: null,
    emailIsVerified: null,
    isAdmin: null,
    device: null,
    fcmTopics: null,
    savedFlyers: null,
    followedBzz: null,
    lastSeen: null,
    appState: null,
    questionsIDs: null,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Directory tempDir = Directory.systemTemp.createTempSync('user_bob_test_');
  PathProviderPlatform.instance = FakePathProviderPlatform(tempDir.path);

  const String docName = 'users';

  tearDownAll(() async {
    await BobInit.closeTheStore();
    try {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    } on Exception catch (_) {}
  });

  group('UserBobFoundation.deleteByModelsIDs', () {

    test('removes only the targeted IDs, leaving untouched records in place', () async {
      final String keep = 'user_keep_${DateTime.now().microsecondsSinceEpoch}';
      final String drop1 = 'user_drop1_${DateTime.now().microsecondsSinceEpoch}';
      final String drop2 = 'user_drop2_${DateTime.now().microsecondsSinceEpoch}';

      final bool inserted = await UserBobFoundation.insertMany(
        bobs: [_buildUserBob(keep), _buildUserBob(drop1), _buildUserBob(drop2)],
        docName: docName,
      );
      expect(inserted, isTrue);

      final bool deleted = await UserBobFoundation.deleteByModelsIDs(
        modelsIDs: [drop1, drop2],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<UserBob> remaining = await UserBobFoundation.findBobsByModelsIDs(
        modelsIDs: [keep, drop1, drop2],
        docName: docName,
      );
      expect(remaining.length, 1);
      expect(remaining.single.id, keep);
    });

    test('IDs that do not exist are simply a no-op -- returns true, deletes nothing', () async {
      final String existing = 'user_existing_${DateTime.now().microsecondsSinceEpoch}';
      await UserBobFoundation.insertMany(bobs: [_buildUserBob(existing)], docName: docName);

      final bool deleted = await UserBobFoundation.deleteByModelsIDs(
        modelsIDs: ['user_does_not_exist_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<UserBob> stillThere = await UserBobFoundation.findBobsByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere.length, 1);
    });

    test('a null modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await UserBobFoundation.deleteByModelsIDs(
        modelsIDs: null,
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('an empty modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await UserBobFoundation.deleteByModelsIDs(
        modelsIDs: <String>[],
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('deleting a mix of existing and non-existing IDs removes only the existing one', () async {
      final String existing = 'user_mixed_${DateTime.now().microsecondsSinceEpoch}';
      await UserBobFoundation.insertMany(bobs: [_buildUserBob(existing)], docName: docName);

      final bool deleted = await UserBobFoundation.deleteByModelsIDs(
        modelsIDs: [existing, 'user_never_existed_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<UserBob> stillThere = await UserBobFoundation.findBobsByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere, isEmpty);
    });

  });
}
