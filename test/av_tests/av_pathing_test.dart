import 'package:basics/av/av.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('AvPathing.createAmazonPaths', () {

    test('Strips the storage/ prefix from upload-style paths', () {
      final result = AvPathing.createAmazonPaths(paths: ['storage/folder/file']);
      expect(result, ['folder/file']);
    });

    test('Keeps plain paths (containing a slash, no storage/ prefix) unchanged', () {
      final result = AvPathing.createAmazonPaths(paths: ['folder/file']);
      expect(result, ['folder/file']);
    });

    test('Deduplicates repeated resulting paths, keeping first-occurrence order', () {
      final result = AvPathing.createAmazonPaths(paths: ['storage/a/b', 'a/b', 'storage/c/d']);
      expect(result, ['a/b', 'c/d']);
    });

    test('Excludes entries with no slash at all', () {
      final result = AvPathing.createAmazonPaths(paths: ['nopathhere', 'storage/a/b']);
      expect(result, ['a/b']);
    });

    test('Returns an empty list for a null paths list', () {
      expect(AvPathing.createAmazonPaths(paths: null), <String>[]);
    });

    test('Returns an empty list for an empty paths list', () {
      expect(AvPathing.createAmazonPaths(paths: []), <String>[]);
    });

    test('Preserves order across a longer mixed list', () {
      final result = AvPathing.createAmazonPaths(paths: ['storage/x/1', 'y/2', 'storage/x/1', 'z/3']);
      expect(result, ['x/1', 'y/2', 'z/3']);
    });

  });

}
