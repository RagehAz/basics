import 'package:basics/helpers/strings/phoner.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
/// => TAMAM
class TextFind {
  // -----------------------------------------------------------------------------

  const TextFind();

  // -----------------------------------------------------------------------------

  /// REG EX

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getStringsByRegEx({
    required String? pattern,
    required String? text,
    bool caseSensitive = true,
    bool multiLine = false,
  }){
    List<String> _output = [];

    if (TextCheck.isEmpty(text) == false && TextCheck.isEmpty(pattern) == false){

      final RegExp regex = RegExp(
        pattern!,
        caseSensitive: caseSensitive,
        multiLine: multiLine,
        // dotAll: ,
        // unicode: ,
      );

      _output = regex.allMatches(text!).map((match){

        final String _grouped = match.group(0)!;

        return _grouped;

      }).toList();

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PHONE NUMBERS

  // --------------------
  /// FAIR ENOUGH
  static List<String> phones({
    required String? text,
  }) {
    List<String> phoneNumbers = [];

    if (TextCheck.isEmpty(text) == false){

      const Map<String, dynamic> _charsToMove = {
        /// LEAVE THIS
        'plus'              : {'char': '+'    ,'replacement': '00'},
        'dash'              : {'char': '-'    ,'replacement': ''},

        /// USED IN DATES & CLOCKS
        'forward_slash'     : {'char': '/'    ,'replacement': 'XXX'},
        'back_slash'        : {'char': r'\'    ,'replacement': 'XXX'},
        'colon'             : {'char': ':'    ,'replacement': 'XXX'},

        /// REPLACE THOSE
        'space'             : {'char': ' '    ,'replacement': '_'},
        'double space'      : {'char': '  '   ,'replacement': '_'},
        'tilde'             : {'char': '~'    ,'replacement': '_'},
        'dollar'            : {'char': r'$'    ,'replacement': '_'},
        'equal'             : {'char': '='    ,'replacement': '_'},
        'comma'             : {'char': ','    ,'replacement': ''},
        'left parenthesis'  : {'char': '('    ,'replacement': ''},
        'right parenthesis' : {'char': ')'    ,'replacement': ''},
        'left sq par'       : {'char': '['    ,'replacement': '_'},
        'right sq par'      : {'char': ']'    ,'replacement': '_'},
        'left x par'        : {'char': '{'    ,'replacement': '_'},
        'right x par'       : {'char': '}'    ,'replacement': '_'},
        'bigger'            : {'char': '>'    ,'replacement': '_'},
        'smaller'           : {'char': '<'    ,'replacement': '_'},
        'apostrophe'        : {'char': '’'    ,'replacement': ''},
        'double_quote'      : {'char': '"'    ,'replacement': ''},
        'single_quote'      : {'char': "'"    ,'replacement': ''},
        'o_circumflex'      : {'char': 'ô'    ,'replacement': 'o'},
        'backtick'          : {'char': '`'    ,'replacement': ''},
        'period'            : {'char': '.'    ,'replacement': '_'},
        'line'              : {'char': r'|'    ,'replacement': '_'},
        'semi_colon'        : {'char': ';'    ,'replacement': '_'},
        'hash'              : {'char': '#'    ,'replacement': ''},
        'at'                : {'char': '@'    ,'replacement': ''},
        'exclamation'       : {'char': '!'    ,'replacement': ''},
        'question'          : {'char': '?'    ,'replacement': ''},
        'percent'           : {'char': '%'    ,'replacement': ''},
        'bo2loz'            : {'char': '^'    ,'replacement': ''},
        'star'              : {'char': '*'    ,'replacement': ''},
        'space1'            : {'char': '‎'  ,'replacement': '_'},
        'space2'            : {'char': '‏'  ,'replacement': '_'},
        'space3'            : {'char': '‎ ' ,'replacement': '_'},
        'space4'            : {'char': ' ‏' ,'replacement': '_'},
        'space5'            : {'char': '​' ,'replacement': '_'},
        'and'               : {'char': '&'    ,'replacement': '_'},
        'double underscore' : {'char': '__'   ,'replacement': '_'},
        'double underscore2': {'char': '__'   ,'replacement': '_'},
        'double underscore3': {'char': '__'   ,'replacement': '_'},
        'double underscore4': {'char': '__'   ,'replacement': '_'},
        'double underscore5': {'char': '__'   ,'replacement': '_'},

        /// COMPACT ALL UNDERSCORES
        'last_underscore': {'char': '_'   ,'replacement': ' '},
      };

      final String? _cleaned = TextMod.fixCountryName(
        input: text,
        addTheseChars: _charsToMove,
      );

      if (TextCheck.isEmpty(text) == false){

        // final List<String> _matches1 = getStringsByRegEx(
        //   text: _cleaned,
        //   pattern: r'\b\d{3}[-.]?\d{3}[-.]?\d{4}\b',
        // );
        //
        // final List<String> _matches2 = getStringsByRegEx(
        //   text: _cleaned,
        //   pattern: r'\b[+]*[(]{0,1}[6-9]{1,4}[)]{0,1}[-\s\.0-9]*\b',
        // );

        final List<String> _moreThan5Numbers = getStringsByRegEx(
          text: _cleaned,
          pattern: r'\b\d{6,}\b',
        );

        phoneNumbers = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: phoneNumbers,
          listToAdd: [
            // ..._matches1,
            // ..._matches2,
            ..._moreThan5Numbers,
          ],
        );

      }

    }

    return Phoner.cleanNumbers(phones: phoneNumbers);
  }
  // -----------------------------------------------------------------------------

  /// URLS

  // --------------------
  /// AI TESTED
  static List<String> urls({
    required String? text,
  }) {
    List<String> _output = [];

    if (TextCheck.isEmpty(text) == false){

      if (TextCheck.isEmpty(text) == false){

        final List<String> _matches = getStringsByRegEx(
          text: text,
          pattern: r'\bhttps?:\/\/[\w\-_]+(\.[\w\-_]+)+[\w\-.,@?^=%&:/~+#]*[\w\-@?^=%&/~+#]',
        );

        _output = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: _output,
          listToAdd: [
            ..._matches,
          ],
        );

      }

    }

    return TextMod.stringsToLowerCase(strings: _output);
  }
  // -----------------------------------------------------------------------------

  /// EMAILS

  // --------------------
  /// AI TESTED
  static List<String> emails({
    required String? text,
  }) {
    List<String> _output = [];

    if (TextCheck.isEmpty(text) == false){

      if (TextCheck.isEmpty(text) == false){

        final List<String> _matches = getStringsByRegEx(
          text: text,
          pattern: r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b',
        );

        _output = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: _output,
          listToAdd: [
            ..._matches,
          ],
        );

      }

    }

    return TextMod.stringsToLowerCase(strings: _output);
  }
  // -----------------------------------------------------------------------------

  /// HASHTAGS

  // --------------------
  /// AI TESTED
  static List<String> hashtags({
    required String? text,
    bool considerDash = true,
    bool removeHash = false,
  }){
    final List<String> _output = <String>[];

    if (text != null && text.isNotEmpty == true){

      String _rawExp;
      /// CONSIDER DASH
      if (considerDash == true){
        _rawExp = r'\B#[\w-]+';
      }
      /// IGNORE DASH
      else {
        _rawExp = r'\B#\w\w+';
      }

      final RegExp exp = RegExp(_rawExp);
      exp.allMatches(text).forEach((match){

        final String? _match = match.group(0);

        if (_match != null) {
          /// REMOVE HASH
          if (removeHash == true) {
            final String _cleaned = TextMod.removeTextBeforeFirstSpecialCharacter(
                text: _match,
                specialCharacter: '#')!;
            _output.add(_cleaned);
          }

          /// KEEP HASH
          else {
            _output.add(_match);
          }
        }
      });

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
