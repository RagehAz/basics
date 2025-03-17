import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';

abstract class TextCasing {
  // -----------------------------------------------------------------------------

  /// TITLE

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
    String? _output;

    if (TextCheck.isEmpty(input) == false){

      String _rest;

      if (lowerCaseTheRest == true){
        _rest = input!.substring(1).toLowerCase();
      }

      else {
        _rest = input!.substring(1);
      }

      _output = input[0].toUpperCase() + _rest;

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? capitalizeFirstLetterOfAllWords({
    required String? input,
    bool lowerCaseTheRest = true,
  }){
    String? _output;

    if (TextCheck.isEmpty(input) == false){

      final List<String> _words = input!.split(' ');

      Stringer.blogStrings(strings: _words, invoker: 'capitalizeFirstLetterOfAllWords');

      if (Lister.checkCanLoop(_words) == true){

        _output = '';

        Lister.loopSync(
            models: _words,
            onLoop: (int index, String? word){

              final String? _cleaned = TextMod.removeSpacesFromAString(word);

              if (TextCheck.isEmpty(_cleaned) == false){

                final String? _capitalized = capitalizeFirstLetter(
                  input: _cleaned,
                  lowerCaseTheRest: lowerCaseTheRest,
                );

                if (TextCheck.isEmpty(_capitalized) == false){

                  if (_output == ''){
                    _output = _capitalized;
                  }
                  else {
                    _output = '$_output $_capitalized';
                  }

                }

              }

            }
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
