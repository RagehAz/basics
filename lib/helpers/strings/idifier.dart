import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';

/// => AI TESTED
abstract class Idifier {
  // -----------------------------------------------------------------------------

  /// CREATE ID

  // --------------------
  /// AI TESTED
  static int createUniqueIDInteger({
    int maxDigitsCount = 16, // 8'640'000'000'000'000'000
  }) {
    assert(maxDigitsCount > 0 && maxDigitsCount <= 16, 'Take care : 0 < maxDigitsCount <= 16',);

    /// some smart ass stunt online said : DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String _string = DateTime.now().microsecondsSinceEpoch.toString();

    final String? _trimmed = TextMod.removeNumberOfCharactersFromBeginningOfAString(
      string: _string,
      numberOfCharacters: _string.length - maxDigitsCount,
    );

    return Numeric.transformStringToInt(_trimmed)!;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String createUniqueIDString({
    int maxDigitsCount = 16, // 8'640'000'000'000'000'000
  }){
    return createUniqueIDInteger(maxDigitsCount: maxDigitsCount).toString();
  }
  // --------------------------------------------------------------------------

  /// IDIFY STRING

  // --------------------
  /// AI TESTED
  static String? idifyString(String? text){
    String? _output;

    if (TextCheck.isEmpty(text) == false){

      _output = text;

      _output = TextMod.fixCountryName(
        input: _output,
        addTheseChars: {
          'and'               : {'char': '&'    ,'replacement': '_'},
          'space'             : {'char': ' '    ,'replacement': '_'},
        },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------
}
