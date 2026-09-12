import 'dart:io';

import 'package:basics/ldb/ldb.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../_fake_path_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Directory tempDir = Directory.systemTemp.createTempSync('sembast_info_test_');
  PathProviderPlatform.instance = FakePathProviderPlatform(tempDir.path);

  tearDownAll(() async {
    await SembastInit.closeDatabase();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('SembastInfo.getStoreItemsCount', () {

    test('returns 0 for a store that has never had anything written to it', () async {
      final int? count = await SembastInfo.getStoreItemsCount('empty_store_${DateTime.now().microsecondsSinceEpoch}');
      expect(count, 0);
    });

    test('returns null when docName is null', () async {
      final int? count = await SembastInfo.getStoreItemsCount(null);
      expect(count, isNull);
    });

    test('reflects the exact number of records inserted into that docName', () async {
      final String docName = 'count_store_a_${DateTime.now().microsecondsSinceEpoch}';
      final DBModel? model = await SembastInit.getDBModel(docName);
      expect(model, isNotNull);

      await model!.doc.add(model.database, {'id': '1', 'name': 'first'});
      await model.doc.add(model.database, {'id': '2', 'name': 'second'});
      await model.doc.add(model.database, {'id': '3', 'name': 'third'});

      final int? count = await SembastInfo.getStoreItemsCount(docName);
      expect(count, 3);
    });

    test('only counts records in the requested store, not other stores in the same database', () async {
      final String docNameA = 'count_store_b_${DateTime.now().microsecondsSinceEpoch}';
      final String docNameB = 'count_store_c_${DateTime.now().microsecondsSinceEpoch}';

      final DBModel? modelA = await SembastInit.getDBModel(docNameA);
      final DBModel? modelB = await SembastInit.getDBModel(docNameB);

      await modelA!.doc.add(modelA.database, {'id': '1'});
      await modelA.doc.add(modelA.database, {'id': '2'});

      await modelB!.doc.add(modelB.database, {'id': '1'});

      expect(await SembastInfo.getStoreItemsCount(docNameA), 2);
      expect(await SembastInfo.getStoreItemsCount(docNameB), 1);
    });

    test('count drops after a record is removed from the store', () async {
      final String docName = 'count_store_d_${DateTime.now().microsecondsSinceEpoch}';
      final DBModel? model = await SembastInit.getDBModel(docName);

      final int key1 = await model!.doc.add(model.database, {'id': '1'});
      await model.doc.add(model.database, {'id': '2'});

      expect(await SembastInfo.getStoreItemsCount(docName), 2);

      await model.doc.record(key1).delete(model.database);

      expect(await SembastInfo.getStoreItemsCount(docName), 1);
    });

  });
}
