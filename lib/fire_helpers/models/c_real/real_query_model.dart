import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:flutter/material.dart';

enum RealOrderType {
  byChild,
  byValue,
  byPriority,
  byKey,
}

enum QueryRange {
  startAfter,
  endAt,
  startAt,
  endBefore,
  equalTo,
}

@immutable
class RealQueryModel{
  // -----------------------------------------------------------------------------
  const RealQueryModel({
    required this.path,
    this.idFieldName,
    this.limit = 5,
    this.readFromBeginningOfOrderedList = true,
    this.orderType,
    this.fieldNameToOrderBy,
    this.queryRange,
  });
  // -----------------------------------------------------------------------------
  final String path;
  final int? limit;
  final String? idFieldName;
  final bool readFromBeginningOfOrderedList;
  final RealOrderType? orderType;
  final String? fieldNameToOrderBy;
  final QueryRange? queryRange;
  // -----------------------------------------------------------------------------

  /// ASCENDING QUERY

  // --------------------
  /// TESTED : WORKS PERFECT
  static RealQueryModel createAscendingQueryModel({
    required String path,
    required String idFieldName,
    String? fieldNameToOrderBy,
    int limit = 5,
  }){
    return RealQueryModel(
      path: path,
      limit: limit,
      idFieldName: idFieldName, /// should be docID : 'id'
      fieldNameToOrderBy: fieldNameToOrderBy,
      orderType: RealOrderType.byChild,
      queryRange: QueryRange.startAfter,
      // readFromBeginningOfOrderedList: true,
    );
  }
  // -----------------------------------------------------------------------------

  /// REAL PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String createRealPath({
    required String coll,
    String? doc,
    String? key, // what is this ? sub node / doc field
  }){

    String _path = coll;

    if (doc != null){

      _path = '$_path/$doc';

      if (key != null){
        _path = '$_path/$key';
      }

    }

    return Pathing.fixPathFormatting(_path)!;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogModel(){
    blog('RealQueryModel ------------------------> START');
    blog('path               : $path');
    blog('keyField           : $idFieldName');
    blog('fieldNameToOrderBy : $fieldNameToOrderBy');
    blog('orderType          : $orderType');
    blog('range              : $queryRange');
    blog('limitToFirst       : $readFromBeginningOfOrderedList');
    blog('limit              : $limit');
    blog('RealQueryModel ------------------------> END');
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkQueriesAreIdentical({
    required RealQueryModel? model1,
    required RealQueryModel? model2,
  }){
  bool _identical = false;

  if (model1 == null && model2 == null){
    _identical = true;
  }

  else if (model1 != null && model2 != null){

    if (
      model1.path == model2.path &&
      model1.limit == model2.limit &&
      model1.idFieldName == model2.idFieldName &&
      model1.readFromBeginningOfOrderedList == model2.readFromBeginningOfOrderedList &&
      model1.orderType == model2.orderType &&
      model1.fieldNameToOrderBy == model2.fieldNameToOrderBy &&
      model1.queryRange == model2.queryRange
    ){
      _identical = true;
    }

  }

  return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is RealQueryModel){
      _areIdentical = checkQueriesAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      path.hashCode^
      idFieldName.hashCode^
      limit.hashCode^
      readFromBeginningOfOrderedList.hashCode^
      orderType.hashCode^
      fieldNameToOrderBy.hashCode^
      queryRange.hashCode;
  // -----------------------------------------------------------------------------

}
