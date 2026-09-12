import 'package:basics/av/av.dart';
import 'package:flutter_test/flutter_test.dart';

AvModel _model({required String id, required String uploadPath}) {
  return AvModel(id: id, uploadPath: uploadPath, bobDocName: 'testDoc');
}

void main() {

  group('AvModel.getAvsUploadPaths', () {

    test('Extracts upload paths from a list of models', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/a/one'),
        _model(id: '2', uploadPath: 'storage/b/two'),
      ];
      expect(AvModel.getAvsUploadPaths(avModels: models), ['storage/a/one', 'storage/b/two']);
    });

    test('Deduplicates repeated upload paths, keeping first-occurrence order', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/a/one'),
        _model(id: '2', uploadPath: 'storage/b/two'),
        _model(id: '3', uploadPath: 'storage/a/one'),
      ];
      expect(AvModel.getAvsUploadPaths(avModels: models), ['storage/a/one', 'storage/b/two']);
    });

    test('Returns an empty list for an empty models list', () {
      expect(AvModel.getAvsUploadPaths(avModels: []), <String>[]);
    });

    test('Returns a single-element list for one model', () {
      final models = [_model(id: '1', uploadPath: 'storage/a/one')];
      expect(AvModel.getAvsUploadPaths(avModels: models), ['storage/a/one']);
    });

    test('Preserves order across a longer list with scattered duplicates', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/c/three'),
        _model(id: '2', uploadPath: 'storage/a/one'),
        _model(id: '3', uploadPath: 'storage/b/two'),
        _model(id: '4', uploadPath: 'storage/a/one'),
        _model(id: '5', uploadPath: 'storage/c/three'),
      ];
      expect(AvModel.getAvsUploadPaths(avModels: models), ['storage/c/three', 'storage/a/one', 'storage/b/two']);
    });

    test('Does not deduplicate distinct paths that merely share a prefix', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/a/one'),
        _model(id: '2', uploadPath: 'storage/a/one_two'),
      ];
      expect(AvModel.getAvsUploadPaths(avModels: models), ['storage/a/one', 'storage/a/one_two']);
    });

    test('Handles a single model list without deduplication needed', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/x/1'),
        _model(id: '2', uploadPath: 'storage/x/2'),
        _model(id: '3', uploadPath: 'storage/x/3'),
      ];
      expect(AvModel.getAvsUploadPaths(avModels: models), ['storage/x/1', 'storage/x/2', 'storage/x/3']);
    });

  });

  group('AvModel.getAvsParentUploadPaths', () {

    test('Extracts parent folders from upload paths', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/a/one'),
        _model(id: '2', uploadPath: 'storage/b/two'),
      ];
      expect(AvModel.getAvsParentUploadPaths(avModels: models), ['storage/a/', 'storage/b/']);
    });

    test('Deduplicates repeated parent folders, keeping first-occurrence order', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/a/one'),
        _model(id: '2', uploadPath: 'storage/a/two'),
      ];
      expect(AvModel.getAvsParentUploadPaths(avModels: models), ['storage/a/']);
    });

    test('Returns an empty list for an empty models list', () {
      expect(AvModel.getAvsParentUploadPaths(avModels: []), <String>[]);
    });

    test('Returns a single-element list for one model', () {
      final models = [_model(id: '1', uploadPath: 'storage/a/one')];
      expect(AvModel.getAvsParentUploadPaths(avModels: models), ['storage/a/']);
    });

    test('Preserves order across a longer list with scattered duplicates', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/c/three'),
        _model(id: '2', uploadPath: 'storage/a/one'),
        _model(id: '3', uploadPath: 'storage/c/other'),
      ];
      expect(AvModel.getAvsParentUploadPaths(avModels: models), ['storage/c/', 'storage/a/']);
    });

    test('Distinguishes parent folders at different nesting depths', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/a/b/one'),
        _model(id: '2', uploadPath: 'storage/a/two'),
      ];
      expect(AvModel.getAvsParentUploadPaths(avModels: models), ['storage/a/b/', 'storage/a/']);
    });

    test('Handles many models sharing the same parent folder', () {
      final models = [
        _model(id: '1', uploadPath: 'storage/x/1'),
        _model(id: '2', uploadPath: 'storage/x/2'),
        _model(id: '3', uploadPath: 'storage/x/3'),
      ];
      expect(AvModel.getAvsParentUploadPaths(avModels: models), ['storage/x/']);
    });

  });

}
