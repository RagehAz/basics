import 'package:basics/helpers/strings/pathing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Pathing - getParentNode', () {
    test('Returns null for non-existent node in the path', () {
      final result = Pathing.getParentNode(path: '/parent/child', node: 'nonexistent');
      expect(result, isNull);
    });

    test('Returns empty string for the first node in the path', () {
      final result = Pathing.getParentNode(path: '/first/second/third', node: 'first');
      expect(result, '');
    });

    test('Returns the parent node for an intermediate node in the path', () {
      final result = Pathing.getParentNode(path: '/parent/child/grandchild', node: 'child');
      expect(result, 'parent');
    });

    test('Handles paths with repeated nodes correctly', () {
      final result = Pathing.getParentNode(path: '/parent/child/parent/child', node: 'child');
      expect(result, 'parent');
    });

    test('Handles paths with a single node correctly', () {
      final result = Pathing.getParentNode(path: '/single', node: 'single');
      expect(result, '');
    });

    test('Returns empty string for an empty path', () {
      final result = Pathing.getParentNode(path: '', node: 'node');
      expect(result, null);
    });

    test('Handles paths with special characters correctly', () {
      final result = Pathing.getParentNode(path: '/special/chars', node: 'chars');
      expect(result, 'special');
    });

    test('Handles paths with numeric nodes correctly', () {
      final result = Pathing.getParentNode(path: '/123/456', node: '456');
      expect(result, '123');
    });
  });

  group('Pathing - getSonNode', () {

    test('Returns null for empty path', () {
      final result = Pathing.getSonNode(path: '', node: 'node');
      expect(result, isNull);
    });

    test('Returns null for empty node', () {
      final result = Pathing.getSonNode(path: '/parent/child', node: '');
      expect(result, isNull);
    });

    test('Returns null for non-existent node in the path', () {
      final result = Pathing.getSonNode(path: '/parent/child', node: 'nonexistent');
      expect(result, isNull);
    });

    test('Returns empty string for the last node in the path', () {
      final result = Pathing.getSonNode(path: '/first/second/third', node: 'third');
      expect(result, '');
    });

    test('Returns the son node for an intermediate node in the path', () {
      final result = Pathing.getSonNode(path: '/parent/child/grandchild', node: 'child');
      expect(result, 'grandchild');
    });

    test('Handles paths with repeated nodes correctly', () {
      final result = Pathing.getSonNode(path: '/parent/child/parent/child', node: 'parent');
      expect(result, 'child');
    });

    test('Handles paths with a single node correctly', () {
      final result = Pathing.getSonNode(path: '/single', node: 'single');
      expect(result, '');
    });

    test('Handles paths with special characters correctly', () {
      final result = Pathing.getSonNode(path: '/special/chars', node: 'special');
      expect(result, 'chars');
    });

    test('Returns empty string for the last node with no son', () {
      final result = Pathing.getSonNode(path: '/onlyson', node: 'onlyson');
      expect(result, '');
    });

    test('Handles paths with numeric nodes correctly', () {
      final result = Pathing.getSonNode(path: '/123/456', node: '123');
      expect(result, '456');
    });

  });

  group('generatePathAncestry', () {

    test('Generates full ancestry from deepest to shallowest', () {
      final result = Pathing.generatePathAncestry(path: 'grand/parent/son/bobo');
      expect(result, ['grand/parent/son/bobo', 'grand/parent/son/', 'grand/parent/', 'grand/']);
    });

    test('Returns just the path itself for a single-node path', () {
      final result = Pathing.generatePathAncestry(path: 'grand');
      expect(result, ['grand']);
    });

    test('Returns an empty list for a null path', () {
      final result = Pathing.generatePathAncestry(path: null);
      expect(result, <String>[]);
    });

    test('Does not produce duplicate ancestors', () {
      final result = Pathing.generatePathAncestry(path: 'grand/parent/son/bobo');
      expect(result.toSet().length, result.length);
    });

    test('Generates ancestry for a two-node path', () {
      final result = Pathing.generatePathAncestry(path: 'parent/son');
      expect(result, ['parent/son', 'parent/']);
    });

    test('The first entry is always the exact input path', () {
      final result = Pathing.generatePathAncestry(path: 'a/b/c');
      expect(result.first, 'a/b/c');
    });

    test('The last entry is always the shallowest single-node ancestor', () {
      final result = Pathing.generatePathAncestry(path: 'a/b/c/d/e');
      expect(result.last, 'a/');
    });

  });

}
