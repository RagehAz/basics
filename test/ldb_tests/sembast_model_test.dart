import 'package:basics/ldb/ldb.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  group('DBModel.checkModelsAreIdentical', () {

    test('returns true for two models built from the same docName/doc/database', () async {
      final Database db = await databaseFactoryMemory.openDatabase('one.db');
      final StoreRef<int, Map<String, dynamic>> store = intMapStoreFactory.store('flyers');

      final DBModel model1 = DBModel(docName: 'flyers', doc: store, database: db);
      final DBModel model2 = DBModel(docName: 'flyers', doc: store, database: db);

      expect(DBModel.checkModelsAreIdentical(model1: model1, model2: model2), isTrue);
      expect(model1 == model2, isTrue);
      expect(model1.hashCode == model2.hashCode, isTrue);
    });

    test('returns false when docName differs, even with the same database/store', () async {
      final Database db = await databaseFactoryMemory.openDatabase('two.db');
      final StoreRef<int, Map<String, dynamic>> store = intMapStoreFactory.store('flyers');

      final DBModel model1 = DBModel(docName: 'flyers', doc: store, database: db);
      final DBModel model2 = DBModel(docName: 'users', doc: store, database: db);

      expect(DBModel.checkModelsAreIdentical(model1: model1, model2: model2), isFalse);
      expect(model1 == model2, isFalse);
    });

    test('returns false when the two models point at different underlying databases', () async {
      final Database db1 = await databaseFactoryMemory.openDatabase('three_a.db');
      final Database db2 = await databaseFactoryMemory.openDatabase('three_b.db');
      final StoreRef<int, Map<String, dynamic>> store = intMapStoreFactory.store('flyers');

      final DBModel model1 = DBModel(docName: 'flyers', doc: store, database: db1);
      final DBModel model2 = DBModel(docName: 'flyers', doc: store, database: db2);

      expect(DBModel.checkModelsAreIdentical(model1: model1, model2: model2), isFalse);
    });

    test('handles null model arguments the same way == would (null == null is true, one-sided null is false)', () async {
      final Database db = await databaseFactoryMemory.openDatabase('four.db');
      final StoreRef<int, Map<String, dynamic>> store = intMapStoreFactory.store('flyers');
      final DBModel model = DBModel(docName: 'flyers', doc: store, database: db);

      expect(DBModel.checkModelsAreIdentical(model1: null, model2: null), isTrue);
      expect(DBModel.checkModelsAreIdentical(model1: model, model2: null), isFalse);
      expect(DBModel.checkModelsAreIdentical(model1: null, model2: model), isFalse);
    });

    test('a model is identical to itself (identical() short-circuit) and to a different StoreRef instance with the same store name', () async {
      final Database db = await databaseFactoryMemory.openDatabase('five.db');
      final StoreRef<int, Map<String, dynamic>> store = intMapStoreFactory.store('flyers');
      final DBModel model = DBModel(docName: 'flyers', doc: store, database: db);

      expect(DBModel.checkModelsAreIdentical(model1: model, model2: model), isTrue);

      /// a fresh StoreRef built from the SAME store name is `==` in sembast
      /// (StoreRef equality is name-based, not identity-based), so a model
      /// built from it should still compare identical.
      final StoreRef<int, Map<String, dynamic>> sameNameStore = intMapStoreFactory.store('flyers');
      final DBModel model2 = DBModel(docName: 'flyers', doc: sameNameStore, database: db);
      expect(DBModel.checkModelsAreIdentical(model1: model, model2: model2), isTrue);
    });

  });
}
