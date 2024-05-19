import 'package:basics/helpers/maps/lister.dart';

class TextCasing {
  // -----------------------------------------------------------------------------

  const TextCasing();

  // -----------------------------------------------------------------------------

  /// TITLE

  // --------------------
  ///
  static List<String> upperCaseAll({
    required List<String> strings,
  }) {
    final List<String> _output = [];

    if (Lister.checkCanLoop(strings) == true){

      for (final String string in strings){
        _output.add(string.toUpperCase());
      }

    }

    return _output;
  }
  // --------------------
  ///
  static List<String> lowerCaseAll({
    required List<String> strings,
  }) {
    final List<String> _output = [];

    if (Lister.checkCanLoop(strings) == true){
      for (final String string in strings){
        _output.add(string.toLowerCase());
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CASING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? capitalizeFirstLetter({
    required String? input,
    required bool lowerCaseTheRest,
  }) {

    if (input == null || input.isEmpty == true) {
      return input;
    }

    else {

      String _rest;

      if (lowerCaseTheRest == true){
        _rest = input.substring(1).toLowerCase();
      }

      else {
        _rest = input.substring(1);
      }

      return input[0].toUpperCase() + _rest;
    }

  }
  // -----------------------------------------------------------------------------
  void x(){}
}
