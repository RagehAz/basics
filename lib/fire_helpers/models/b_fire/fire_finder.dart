import 'package:basics/fire_helpers/models/b_fire/fire_comparison_enum.dart';
import 'package:flutter/material.dart';

@immutable
class FireFinder {
  /// --------------------------------------------------------------------------
  const FireFinder({
    required this.field,
    required this.comparison,
    required this.value,
  });
  /// --------------------------------------------------------------------------
  final String field; /// fire field name
  final FireComparison comparison; /// fire equality comparison type
  final dynamic value; /// search value
  // -----------------------------------------------------------------------------

  /// NATIVE QUERY CREATOR


  // -----------------------------------------------------------------------------

  /// QUERY CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFindersAreIdentical(FireFinder? finder1, FireFinder? finder2){
    bool _identical = false;

    if (finder1 == null && finder2 == null){
      _identical = true;
    }

    else if (finder1 != null && finder2 != null){

      if (
          finder1.field == finder2.field &&
          finder1.comparison == finder2.comparison &&
          finder1.value == finder2.value
      ){
        _identical = true;
      }

    }

    return _identical;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFindersListsAreIdentical(List<FireFinder>? finders1, List<FireFinder>? finders2){
    bool _output = false;

    if (finders1 == null && finders2 == null){
      _output = true;
    }
    else if (finders1 != null && finders1.isEmpty && finders2 != null && finders2.isEmpty){
      _output = true;
    }
    else if (finders1 != null && finders2 != null){

      if (finders1.length != finders2.length){
        _output = false;
      }

      else {

        for (int i = 0; i < finders1.length; i++){

          final bool _areIdentical = checkFindersAreIdentical(
            finders1[i],
            finders2[i],
          );

          if (_areIdentical == false){
            _output = false;
            break;
          }

          else {
            _output = true;
          }

        }

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => 'FireFinder(field: $field, comparison: $comparison, value: $value)';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FireFinder){
      _areIdentical = checkFindersAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      field.hashCode^
      comparison.hashCode^
      value.hashCode;
  // -----------------------------------------------------------------------------
}
