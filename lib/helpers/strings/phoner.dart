

import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';

class Phoner {
  // -----------------------------------------------------------------------------

  const Phoner();

  // -----------------------------------------------------------------------------

  /// CLEAN

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cleanNumber({
    required String? phone,
  }){
    String? value;

    if (TextCheck.isEmpty(phone) == false){

      value = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: TextMod.removeSpacesFromAString(phone),
        specialCharacter: ':',
      )?.toLowerCase();

      value = TextMod.replaceAllCharacters(characterToReplace: '(', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: ')', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: ' ', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: '-', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: '_', replacement: '', input: value);
      if (TextCheck.stringStartsExactlyWith(text: value, startsWith: '00') == true){
        final String _n = TextMod.removeNumberOfCharactersFromBeginningOfAString(string: value, numberOfCharacters: 2)!;
        value = '+$_n';
      }

    }

    return value;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> cleanNumbers({
    required List<String>? phones,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(phones) == true){

      for (final String phone in phones!){

        final String? _cleaned = cleanNumber(phone: phone);

        if (_cleaned != null){
          _output.add(_cleaned);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
