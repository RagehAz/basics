import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

/// => TAMAM
class PaginationController {
  /// -----------------------------------------------------------------------------
  PaginationController({
    required this.paginatorMaps,
    required this.replaceMap,
    required this.addMap,
    required this.deleteMap,
    required this.startAfter,
    required this.addExtraMapsAtEnd,
    required this.idFieldName,
    required this.onDataChanged,
    required this.scrollController,
    required this.isPaginating,
    required this.canKeepReading,
    required this.mounted,
  });
  /// -----------------------------------------------------------------------------
  final ValueNotifier<List<Map<String, dynamic>>> paginatorMaps;
  final ValueNotifier<Map<String, dynamic>?> replaceMap;
  final ValueNotifier<Map<String, dynamic>?> addMap;
  final ValueNotifier<Map<String, dynamic>?> deleteMap;
  final ValueNotifier<dynamic> startAfter;
  bool addExtraMapsAtEnd;
  final String idFieldName;
  final ValueChanged<List<Map<String, dynamic>>>? onDataChanged;
  final ScrollController scrollController;
  final ValueNotifier<bool> isPaginating;
  final ValueNotifier<bool> canKeepReading;
  final bool mounted;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PaginationController copyWith({
    ValueNotifier<List<Map<String, dynamic>>>? paginatorMaps,
    ValueNotifier<Map<String, dynamic>?>? replaceMap,
    ValueNotifier<Map<String, dynamic>?>? addMap,
    ValueNotifier<Map<String, dynamic>?>? deleteMap,
    ValueNotifier<dynamic>? startAfter,
    bool? addExtraMapsAtEnd,
    String? idFieldName,
    ValueChanged<List<Map<String, dynamic>>>? onDataChanged,
    ScrollController? scrollController,
    ValueNotifier<bool>? isPaginating,
    ValueNotifier<bool>? canKeepReading,
    bool? mounted,
  }) {
    return PaginationController(
      paginatorMaps: paginatorMaps ?? this.paginatorMaps,
      replaceMap: replaceMap ?? this.replaceMap,
      addMap: addMap ?? this.addMap,
      deleteMap: deleteMap ?? this.deleteMap,
      startAfter: startAfter ?? this.startAfter,
      addExtraMapsAtEnd: addExtraMapsAtEnd ?? this.addExtraMapsAtEnd,
      idFieldName: idFieldName ?? this.idFieldName,
      onDataChanged: onDataChanged ?? this.onDataChanged,
      scrollController: scrollController ?? this.scrollController,
      isPaginating: isPaginating ?? this.isPaginating,
      canKeepReading: canKeepReading ?? this.canKeepReading,
      mounted: mounted ?? this.mounted,
    );
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static PaginationController initialize({
    required bool addExtraMapsAtEnd,
    required bool mounted,
    ValueChanged<List<Map<String, dynamic>>>? onDataChanged,
    String idFieldName = 'id',
  }){

    final PaginationController _controller = PaginationController(
      paginatorMaps: ValueNotifier(<Map<String, dynamic>>[]),
      replaceMap: ValueNotifier<Map<String, dynamic>?>(null),
      addMap: ValueNotifier<Map<String, dynamic>?>(null),
      deleteMap: ValueNotifier<Map<String, dynamic>?>(null),
      startAfter: ValueNotifier<dynamic>(null),
      addExtraMapsAtEnd: addExtraMapsAtEnd,
      idFieldName: idFieldName,
      onDataChanged: onDataChanged,
      scrollController: ScrollController(),
      canKeepReading: ValueNotifier(true),
      mounted: mounted,
      isPaginating: ValueNotifier(false),
    );

    _controller.activateListeners();

    return _controller;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clear({
    bool? isMounted,
  }){
    setNotifier(mounted: isMounted ?? mounted, notifier: paginatorMaps, value: <Map<String, dynamic>>[]);
    setNotifier(mounted: isMounted ?? mounted, notifier: replaceMap, value: null);
    setNotifier(mounted: isMounted ?? mounted, notifier: addMap, value: null);
    setNotifier(mounted: isMounted ?? mounted, notifier: deleteMap, value: null);
    setNotifier(mounted: isMounted ?? mounted, notifier: startAfter, value: null);
    setNotifier(mounted: isMounted ?? mounted, notifier: isPaginating, value: false);
    setNotifier(mounted: isMounted ?? mounted, notifier: canKeepReading, value: true);
  }
  // --------------------
  /*
  void removeListeners(){
    paginatorMaps.removeListener(() { });
    replaceMap.removeListener(() { });
    addMap.removeListener(() { });
    deleteMap.removeListener(() { });
    startAfter.removeListener(() { });
  }
   */
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    _removePaginatorMapsListener();
    _removeAddMapListener();
    _removeReplaceMapListener();
    _removeDeleteMapListener();
    paginatorMaps.dispose();
    replaceMap.dispose();
    addMap.dispose();
    deleteMap.dispose();
    startAfter.dispose();
    // blog('disposing scrollController');
    scrollController.dispose();
    canKeepReading.dispose();
    isPaginating.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LISTENING

  // --------------------
  /// TESTED : WORKS PERFECT
  void activateListeners(){

    _listenToPaginatorMapsChanges();

    _listenToAddMap();

    _listenToReplaceMap();

    _listenToDeleteMap();

  }
  // --------------------

  /// MAP CHANGES LISTENER

  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToPaginatorMapsChanges(){

    if (onDataChanged != null){
      /// REMOVED
      paginatorMaps.addListener(_paginatorMapsListener);
    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _removePaginatorMapsListener(){
    if (onDataChanged != null){
      paginatorMaps.removeListener(_paginatorMapsListener);
    }
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _paginatorMapsListener() {
    // if (paginatorMaps.value != null){
    onDataChanged!(paginatorMaps.value);
    // }
  }
  // --------------------------------

  /// ADD MAP LISTENER

  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToAddMap(){
    // if (addMap != null){
      /// REMOVED
      addMap.addListener(_addMapListener);
    // }
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _removeAddMapListener(){
    // if (addMap != null){
      addMap.removeListener(_addMapListener);
    // }
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _addMapListener() {
    List<Map<String, dynamic>> _combinedMaps = [...paginatorMaps.value];

    // blog('_addMapToPaginatorMaps STARTS WITH : ${paginatorMaps.value.length} maps');

    if (addMap.value != null){

      final bool _idExists = Mapper.checkMapsContainMapWithID(
        maps: _combinedMaps,
        map: addMap.value,
        idFieldName: idFieldName,
      );

      blog('_addMapToPaginatorMaps _idExists : $_idExists');

      /// SHOULD REPLACE
      if (_idExists == true){
        _combinedMaps = Mapper.replaceMapInMapsWithSameIDField(
          baseMaps: paginatorMaps.value,
          mapToReplace: addMap.value,
          idFieldName: idFieldName,
        )!;
      }

      /// SHOULD ADD
      else {

        if (addExtraMapsAtEnd == true){
          _combinedMaps = [...paginatorMaps.value, addMap.value!];
        }
        else {
          _combinedMaps = [addMap.value!, ...paginatorMaps.value,];
        }

      }

      setNotifier(
        notifier: paginatorMaps,
        mounted: mounted,
        value: _combinedMaps,
      );

      // setNotifier(
      //     notifier: addMap,
      //     mounted: mounted,
      //     value: null,
      // );

      _setStartAfter(
        startAfter: startAfter,
        paginatorMaps: _combinedMaps,
        mounted: mounted,
      );

    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  void addMapToPaginator({
    required Map<String, dynamic> map,
    required bool mounted,
    bool? addExtraMapsAtEnd,
  }){

    final bool _was = this.addExtraMapsAtEnd;

    if (addExtraMapsAtEnd != null){
      this.addExtraMapsAtEnd = addExtraMapsAtEnd;
    }

    setNotifier(
        notifier: addMap,
        mounted: mounted,
        value: map,
    );

    if (addExtraMapsAtEnd != null){
      this.addExtraMapsAtEnd = _was;
    }

  }
  // --------------------------------

  /// REPLACE MAP

  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToReplaceMap(){
    /// REMOVED
    replaceMap.addListener(_replaceMapListener);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _removeReplaceMapListener(){
    replaceMap.removeListener(_replaceMapListener);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _replaceMapListener() {

    _replaceExistingMap(
      mounted: mounted,
      controller: this,
    );

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static void _replaceExistingMap({
    required bool mounted,
    required PaginationController controller,
  }){

    if (controller.replaceMap.value != null){

      final List<Map<String, dynamic>>? _updatedMaps = Mapper.replaceMapInMapsWithSameIDField(
        baseMaps: controller.paginatorMaps.value,
        mapToReplace: controller.replaceMap.value,
        idFieldName: controller.idFieldName,
      );

      setNotifier(
        notifier: controller.paginatorMaps,
        mounted: mounted,
        value: _updatedMaps,
      );

      setNotifier(
        notifier: controller.replaceMap,
        mounted: mounted,
        value: null,
      );

      _setStartAfter(
        startAfter: controller.startAfter,
        paginatorMaps: controller.paginatorMaps.value,
        mounted: mounted,
      );

    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  void replaceMapByID({
    required Map<String, dynamic> map,
    required bool mounted,
  }){

    setNotifier(
        notifier: replaceMap,
        mounted: mounted,
        value: map,
    );

  }
  // --------------------------------

  /// DELETE MAP

  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToDeleteMap(){
    /// REMOVED
    deleteMap.addListener(_deleteMapListener);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _removeDeleteMapListener(){
    deleteMap.removeListener(_deleteMapListener);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _deleteMapListener() {
    if (deleteMap.value != null){

      final List<Map<String, dynamic>> _updatedMaps = Mapper.removeMapFromMapsByIdField(
        baseMaps: paginatorMaps.value,
        mapIDToRemove: deleteMap.value![idFieldName],
        idFieldName: idFieldName,
      );

      setNotifier(
        notifier: paginatorMaps,
        mounted: mounted,
        value: _updatedMaps,
      );

      setNotifier(
        notifier: deleteMap,
        mounted: mounted,
        value: null,
      );

      _setStartAfter(
        startAfter: startAfter,
        paginatorMaps: paginatorMaps.value,
        mounted: mounted,
      );

    }
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void deleteMapByID({
    required String? id,
    String idFieldName = 'id',
  }){

    if (id != null){

      setNotifier(
          notifier: deleteMap,
          mounted: mounted,
          value: Mapper.getMapFromMapsByID(
            maps: paginatorMaps.value,
            id: id,
            idFieldName: idFieldName,
          ),
      );

    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  void removeMapsByIDs({
    required List<String> ids,
    String idFieldName = 'id',
  }){

    if (Lister.checkCanLoop(ids) == true){

      if (paginatorMaps.value.isNotEmpty == true){

        /// counts how many occurrences of each id to remove, matching the
        /// old per-id loop (which called removeMapFromMapsByIdField once
        /// per id, each removing only the first remaining match) -- a
        /// single O(n) pass replaces what used to be an O(ids * n) scan.
        final Map<String, int> _remainingRemovals = <String, int>{};
        for (final String id in ids){
          _remainingRemovals[id] = (_remainingRemovals[id] ?? 0) + 1;
        }

        final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
        for (final Map<String, dynamic> map in paginatorMaps.value){
          final dynamic _id = map[idFieldName];
          final int _remaining = _remainingRemovals[_id] ?? 0;
          if (_remaining > 0){
            _remainingRemovals[_id] = _remaining - 1;
          }
          else {
            _maps.add(map);
          }
        }

       setNotifier(
           notifier: paginatorMaps,
           mounted: mounted,
           value: _maps,
       );


      }

    }

  }
  // --------------------------------

  /// START AFTER

  // ---------
  /// TESTED : WORKS PERFECT
  static void _setStartAfter({
    required ValueNotifier<dynamic> startAfter,
    required List<Map<String, dynamic>>? paginatorMaps,
    required bool mounted,
  }){

    if (Lister.checkCanLoop(paginatorMaps) == true){

      setNotifier(
          notifier: startAfter,
          mounted: mounted,
          value: paginatorMaps?.last['docSnapshot'] ?? paginatorMaps?.last
      );

    }

    else {
      setNotifier(
          notifier: startAfter,
          mounted: mounted,
          value: null,
      );
    }

  }
  // --------------------------------

  /// INSERTION

  // ---------
  /// TESTED : WORKS PERFECT
  static void insertMapsToPaginator({
    required PaginationController? controller,
    required List<Map<String, dynamic>?>? mapsToAdd,
    required bool mounted,
  }){

    final List<Map<String, dynamic>> _combinedMaps = [...?controller?.paginatorMaps.value];

    if (Lister.checkCanLoop(mapsToAdd) == true && controller != null){

      final String _idField = controller.idFieldName;

      /// one O(n) pass to index existing maps by id, instead of running an
      /// O(n) checkMapsContainMapWithID scan + O(n)
      /// replaceMapInMapsWithSameIDField scan PER incoming map (this used
      /// to be O(M*N) for M incoming maps against N already-loaded ones,
      /// and N only grows as the user scrolls further).
      final Map<dynamic, int> _idToIndex = <dynamic, int>{};
      bool _hasNullID = false;
      for (int i = 0; i < _combinedMaps.length; i++){
        final dynamic _id = _combinedMaps[i][_idField];
        if (_id == null){
          _hasNullID = true;
        }
        else {
          /// first-occurrence wins, matching indexWhere's behavior in the
          /// old checkMapsContainMapWithID/replaceMapInMapsWithSameIDField
          /// (relevant only if _combinedMaps ever ends up with duplicate
          /// ids, which this function is otherwise trying to prevent).
          _idToIndex.putIfAbsent(_id, () => i);
        }
      }

      /// new maps are buffered here instead of individually inserted at
      /// the front (which would shift every existing index on every
      /// single insert) -- applied to _combinedMaps in one shot below.
      final List<Map<String, dynamic>> _newMaps = <Map<String, dynamic>>[];
      final Map<dynamic, int> _pendingIndex = <dynamic, int>{};

      for (final Map<String, dynamic>? mapToInsert in mapsToAdd!) {

        final dynamic _insertID = mapToInsert?[_idField];
        final bool _matchesPending = _insertID != null && _pendingIndex.containsKey(_insertID);
        final bool _matchesExisting = _insertID != null && _idToIndex.containsKey(_insertID);

        /// mirrors the old checkMapsContainMapWithID's `==` semantics
        /// (null == null counts as "contains") combined with
        /// replaceMapInMapsWithSameIDField's null-guarded replace (a null
        /// id is never actually found/replaced) -- so once any null-id
        /// map exists, a later null-id mapToInsert is silently a no-op,
        /// exactly like the old per-item loop.
        final bool _contains = _insertID != null
            ? (_matchesPending || _matchesExisting)
            : _hasNullID;

        /// SHOULD REPLACE EXISTING/PENDING MAP
        if (_contains == true) {
          if (_matchesPending){
            _newMaps[_pendingIndex[_insertID]!] = mapToInsert!;
          }
          else if (_matchesExisting){
            _combinedMaps[_idToIndex[_insertID]!] = mapToInsert!;
          }
          /// else: null id "contains" but never actually replaced -- no-op.
        }

        /// SHOULD ADD NEW MAP
        else {
          _pendingIndex[_insertID] = _newMaps.length;
          _newMaps.add(mapToInsert!);
          if (_insertID == null){
            _hasNullID = true;
          }
        }
      }

      if (_newMaps.isNotEmpty){
        if (controller.addExtraMapsAtEnd == true) {
          _combinedMaps.addAll(_newMaps);
        } else {
          /// matches the old per-item `[mapToInsert!, ...?_combinedMaps]`
          /// loop, which ends up with the LAST-processed new item first.
          _combinedMaps.insertAll(0, _newMaps.reversed);
        }
      }

      _setPaginatorMaps(
        controller: controller,
        mounted: mounted,
        maps: _combinedMaps,
      );
    }


  }
  // ---------
  /// TESTED : WORKS PERFECT
  static void _setPaginatorMaps({
    required PaginationController controller,
    required List<Map<String, dynamic>>? maps,
    required bool mounted,
  }){

    setNotifier(
      notifier: controller.paginatorMaps,
      mounted: mounted,
      value: maps,
    );

    _setStartAfter(
      startAfter: controller.startAfter,
      paginatorMaps: maps,
      mounted: mounted,
    );

  }
  // -----------------------------------------------------------------------------

  /// LISTENING

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getVerticalPaginationTileHeight({
    required BuildContext context,
    required int numberOfTilesOnScreen,
    required double totalPaddings,
  }){
    final double _screenHeight = Scale.screenHeight(context);
    return (_screenHeight - totalPaddings) / numberOfTilesOnScreen;
  }
  // -----------------------------------------------------------------------------
}
