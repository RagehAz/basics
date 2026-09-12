import 'package:basics/fire_helpers/pagination_controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

PaginationController _buildController({
  List<Map<String, dynamic>> initialMaps = const [],
  bool addExtraMapsAtEnd = true,
  String idFieldName = 'id',
}) {
  return PaginationController(
    paginatorMaps: ValueNotifier<List<Map<String, dynamic>>>([...initialMaps]),
    replaceMap: ValueNotifier<Map<String, dynamic>?>(null),
    addMap: ValueNotifier<Map<String, dynamic>?>(null),
    deleteMap: ValueNotifier<Map<String, dynamic>?>(null),
    startAfter: ValueNotifier<dynamic>(null),
    addExtraMapsAtEnd: addExtraMapsAtEnd,
    idFieldName: idFieldName,
    onDataChanged: null,
    scrollController: ScrollController(),
    isPaginating: ValueNotifier<bool>(false),
    canKeepReading: ValueNotifier<bool>(true),
    mounted: true,
  );
}

void main() {
  // -----------------------------------------------------------------------------

  /// insertMapsToPaginator

  // --------------------
  group('PaginationController.insertMapsToPaginator', () {

    test('Appends new maps at the end when addExtraMapsAtEnd is true', () {
      final controller = _buildController(
        initialMaps: [{'id': '1'}, {'id': '2'}],
      );

      PaginationController.insertMapsToPaginator(
        controller: controller,
        mapsToAdd: [{'id': '3'}],
        mounted: true,
      );

      expect(controller.paginatorMaps.value.map((m) => m['id']).toList(), ['1', '2', '3']);
    });

    test('Prepends new maps (last-processed first) when addExtraMapsAtEnd is false', () {
      final controller = _buildController(
        initialMaps: [{'id': '1'}],
        addExtraMapsAtEnd: false,
      );

      PaginationController.insertMapsToPaginator(
        controller: controller,
        mapsToAdd: [{'id': '2'}, {'id': '3'}],
        mounted: true,
      );

      /// matches the pre-existing per-item prepend loop's behavior: each
      /// new item is prepended in turn, so the last one processed ends up
      /// first.
      expect(controller.paginatorMaps.value.map((m) => m['id']).toList(), ['3', '2', '1']);
    });

    test('Replaces an existing map in place (same position) when the id already exists', () {
      final controller = _buildController(
        initialMaps: [{'id': '1', 'v': 'old'}, {'id': '2', 'v': 'x'}],
      );

      PaginationController.insertMapsToPaginator(
        controller: controller,
        mapsToAdd: [{'id': '1', 'v': 'new'}],
        mounted: true,
      );

      expect(controller.paginatorMaps.value.length, 2);
      expect(controller.paginatorMaps.value[0], {'id': '1', 'v': 'new'});
      expect(controller.paginatorMaps.value[1], {'id': '2', 'v': 'x'});
    });

    test('A later duplicate id within the same incoming batch overwrites the earlier one', () {
      final controller = _buildController(initialMaps: []);

      PaginationController.insertMapsToPaginator(
        controller: controller,
        mapsToAdd: [{'id': '1', 'v': 'first'}, {'id': '1', 'v': 'second'}],
        mounted: true,
      );

      expect(controller.paginatorMaps.value.length, 1);
      expect(controller.paginatorMaps.value.first, {'id': '1', 'v': 'second'});
    });

    test('Does nothing when mapsToAdd is empty', () {
      final controller = _buildController(initialMaps: [{'id': '1'}]);

      PaginationController.insertMapsToPaginator(
        controller: controller,
        mapsToAdd: [],
        mounted: true,
      );

      expect(controller.paginatorMaps.value.map((m) => m['id']).toList(), ['1']);
    });

    test('Respects a custom idFieldName', () {
      final controller = _buildController(
        initialMaps: [{'flyerID': 'a', 'v': 'old'}],
        idFieldName: 'flyerID',
      );

      PaginationController.insertMapsToPaginator(
        controller: controller,
        mapsToAdd: [{'flyerID': 'a', 'v': 'new'}, {'flyerID': 'b', 'v': 'y'}],
        mounted: true,
      );

      expect(controller.paginatorMaps.value.length, 2);
      expect(controller.paginatorMaps.value[0], {'flyerID': 'a', 'v': 'new'});
      expect(controller.paginatorMaps.value[1], {'flyerID': 'b', 'v': 'y'});
    });

  });
  // -----------------------------------------------------------------------------

  /// removeMapsByIDs

  // --------------------
  group('PaginationController.removeMapsByIDs', () {

    test('Removes maps whose id is in the given list', () {
      final controller = _buildController(
        initialMaps: [{'id': '1'}, {'id': '2'}, {'id': '3'}],
      );

      controller.removeMapsByIDs(ids: ['2']);

      expect(controller.paginatorMaps.value.map((m) => m['id']).toList(), ['1', '3']);
    });

    test('Removes only the first N occurrences of a repeated id, matching the id count in ids', () {
      final controller = _buildController(
        initialMaps: [{'id': 'a'}, {'id': 'a'}, {'id': 'a'}],
      );

      controller.removeMapsByIDs(ids: ['a', 'a']);

      expect(controller.paginatorMaps.value.length, 1);
    });

    test('Does nothing when ids is empty', () {
      final controller = _buildController(initialMaps: [{'id': '1'}]);
      controller.removeMapsByIDs(ids: []);
      expect(controller.paginatorMaps.value.map((m) => m['id']).toList(), ['1']);
    });

    test('Does nothing when the paginator is already empty', () {
      final controller = _buildController(initialMaps: []);
      controller.removeMapsByIDs(ids: ['1']);
      expect(controller.paginatorMaps.value, <Map<String, dynamic>>[]);
    });

    test('Ignores ids that are not present', () {
      final controller = _buildController(initialMaps: [{'id': '1'}]);
      controller.removeMapsByIDs(ids: ['not-there']);
      expect(controller.paginatorMaps.value.map((m) => m['id']).toList(), ['1']);
    });

  });
}
