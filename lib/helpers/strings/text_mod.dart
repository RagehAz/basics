// ignore_for_file: always_put_control_body_on_new_line
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_clip_board.dart';
import 'package:flutter/material.dart';

class TextMod {
  // -----------------------------------------------------------------------------

  const TextMod();

  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// AI TESTED
  static String? replaceAllCharacters({
    required String? characterToReplace,
    required String? replacement,
    required String? input,
  }) {
    if (
    characterToReplace != null &&
    replacement != null &&
    input != null
    ){
      return input.replaceAll(characterToReplace, replacement);
    }
    else {
      return input;
    }

  }
  // --------------------
  /// AI TESTED
  static String? obscureText({
    required String? text,
    String obscurityCharacter = '*',
  }){
    String? _output;

    if (TextCheck.isEmpty(text) == false){
      _output = '';
      for (int i = 0; i < text!.length; i++){
        _output = '$_output$obscurityCharacter';
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? idifyString(String? text){
    String? _output;

    if (TextCheck.isEmpty(text) == false){

      _output = text;

      _output = fixCountryName(
        input: _output,
        addTheseChars: {
          'and'               : {'char': '&'    ,'replacement': '_'},
          'space'             : {'char': ' '    ,'replacement': '_'},
        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CASING

  // --------------------
  ///
  static List<String> stringsToLowerCase({
    required List<String>? strings,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(strings) == true){

      for (final String text in strings!){

        final String _lowered = text.toLowerCase();
        _output.add(_lowered);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  /// TEXT TAGS MODIFIER

  // --------------------
  /// TEXT VARIABLE TAGS
  static const String userNameVarTag1 = '<USERNAME1>';
  static const String userNameVarTag2 = '<USERNAME2>';
  static const String bzNameVarTag1 = '<BZNAME1>';
  static const String bzNameVarTag2 = '<BZNAME2>';
  static const String authorNameVarTag1 = '<AUTHORNAME1>';
  static const String authorNameVarTag2 = '<AUTHORNAME2>';
  static const String numberVarTag1 = '<NUMBER1>';
  static const String numberVarTag2 = '<NUMBER2>';
  // --------------------
  static const List<String> varTags = <String>[
    userNameVarTag1,
    userNameVarTag2,
    bzNameVarTag1,
    bzNameVarTag2,
    authorNameVarTag1,
    authorNameVarTag2,
    numberVarTag1,
    numberVarTag2,
  ];
  // --------------------
  static String? replaceVarTag({
    required String? input,
    String? userName1,
    String? userName2,
    String? bzName1,
    String? bzName2,
    String? authorName1,
    String? authorName2,
    String? number1,
    String? number2,
    String? customTag,
    String? customValue,
  }){
    String? _output = input;

    Map<String, dynamic> _varTagsMap = {};

    /// USER NAME 1
    if (userName1 != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: userNameVarTag1,
        value: userName1,
        overrideExisting: true,
      );
    }
    /// USER NAME 2
    if (userName2 != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: userNameVarTag2,
        value: userName2,
        overrideExisting: true,
      );
    }
    /// BZ NAME 1
    if (bzName1 != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: bzNameVarTag1,
        value: bzName1,
        overrideExisting: true,
      );
    }
    /// BZ NAME 2
    if (bzName2 != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: bzNameVarTag2,
        value: bzName2,
        overrideExisting: true,
      );
    }
    /// AUTHOR NAME 1
    if (authorName1 != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: authorNameVarTag1,
        value: authorName1,
        overrideExisting: true,
      );
    }
    /// AUTHOR NAME 2
    if (authorName2 != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: authorNameVarTag2,
        value: authorName2,
        overrideExisting: true,
      );
    }
    /// NUMBER 1
    if (number1 != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: numberVarTag1,
        value: number1,
        overrideExisting: true,
      );
    }
    /// NUMBER 2
    if (number2 != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: numberVarTag2,
        value: number2,
        overrideExisting: true,
      );
    }
    /// CUSTOM
    if (customTag != null){
      _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: customTag,
        value: customValue,
        overrideExisting: true,
      );
    }


    final List<String> _keys = _varTagsMap.keys.toList();

    if (Lister.checkCanLoop(_keys) == true){

      for (final String key in _keys){

        _output = replaceAllCharacters(
          input: _output,
          characterToReplace: key,
          replacement: _varTagsMap[key],
        );

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CUTTERS

  // --------------------
  /// AI TESTED
  static String? cutFirstCharacterAfterRemovingSpacesFromAString(String? string) {

    if (TextCheck.isEmpty(string) == true){
      return null;
    }

    else {
      final String? _stringWithoutSpaces = removeSpacesFromAString(string?.trim());
      final String? _firstCharacter = cutNumberOfCharactersOfAStringBeginning(
          string: _stringWithoutSpaces,
          number: 1,
      );

      if (_stringWithoutSpaces == null ||
          _stringWithoutSpaces == '' ||
          _stringWithoutSpaces == ' ') {
        return null;
      }

      else if (_firstCharacter == '') {
        return null;
      }

      else {
        return _firstCharacter;
      }

    }

  }
  // --------------------
  /// AI TESTED
  static String? cutNumberOfCharactersOfAStringBeginning({
    required String? string,
    required int? number
  }) {

    if (string == null || string.isEmpty == true || string.trim() == ''){
      return string;
    }
    else if (number == null){
      return string;
    }
    else if (string.length < number){
      return string.substring(0, string.length);
    }

    else {
      return string.substring(0, number);

    }

  }
  // --------------------
  /// AI TESTED
  static String? cutLastTwoCharactersFromAString(String? string) {

    if (TextCheck.isEmpty(string) == true){
      return null;
    }

    else {
      final List<String> _stringSplit = string!.split('');
      final int _listLength = _stringSplit.length;

      if (_listLength == 0){
        return null;
      }

      else if (_listLength < 2){
        return string[_listLength-1];
      }

      else {
        final int _lastIndex = _listLength - 1;
        final int _beforeLastIndex = _listLength - 2;
        return '${_stringSplit[_beforeLastIndex]}${_stringSplit[_lastIndex]}';
      }
    }


  }
  // -----------------------------------------------------------------------------

  /// REMOVERS

  // --------------------
  /// AI TESTED
  static String? removeFirstCharacterFromAString(String? string) {

    if (TextCheck.isEmpty(string) == true){
      return null;
    }
    else {
      return string?.substring(1);
    }

  }
  // --------------------
  /// AI TESTED
  static String? removeNumberOfCharactersFromBeginningOfAString({
    required String? string,
    required int? numberOfCharacters,
  }) {

    if (TextCheck.isEmpty(string) == true){
      return null;
    }

    else {

      final int _numberOfCharacters = numberOfCharacters ?? 0;

      if (_numberOfCharacters > 0) {

        String? _stringTrimmed;

        if (_numberOfCharacters > string!.length) {
          // blog('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
          final Error _error = ArgumentError(
              'can not remove ($numberOfCharacters) from the given string because',
              'removeNumberOfCharactersFromBeginningOfAString');
          throw _error;
        }

        else {
          _stringTrimmed = string.isNotEmpty ? string.substring(_numberOfCharacters) : null;
        }

        return _stringTrimmed;
      }

      else {
        return string;
      }

    }
  }
  // --------------------
  /// AI TESTED
  static String? removeNumberOfCharactersFromEndOfAString({
    required String? string,
    required int numberOfCharacters,
  }) {

    // if (numberOfCharacters > string.length){
    //   blog('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
    //   throw('can not remove ($numberOfCharacters) from the given string because');
    // } else {}
    // blog('string length ${string.trim().length} and : numberOfCharacters : $numberOfCharacters');

    if (string != null && string.trim().isNotEmpty == true) {

      if (string.trim().length == numberOfCharacters) {
        return '';
      }

      else if (string.trim().length > numberOfCharacters) {
        return string.substring(0, string.trim().length - numberOfCharacters);
      }

      else {
        return '';
      }

    }

    else {
      return null;
    }

  }
  // --------------------
  /// TASK : TEST_ME
  static String? removeTextAfterNumberOfCharacters({
    required String? string,
    required int? numberOfCharacters,
  }) {

    if (string == null || string.isEmpty) {
      return null; // If the string is null or empty, return null
    }

    else {

      final int _numberOfCharacters = numberOfCharacters ?? 0;

      if (string.length <= _numberOfCharacters) {
        return string;
      }
      else {
        return string.substring(0, _numberOfCharacters);
      }

    }

  }
  // --------------------
  /// AI TESTED
  static String? removeSpacesFromAString(String? string) {
    String? _output;

    if (string != null) {
      /// solution 1,, won't work, not tested
      // string.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      /// solution 2
      // string.replaceAll(new RegExp(r"\s+"), "");
      /// solution 3
      // string.replaceAll(' ', '');
      /// solution 4
      // string.split(" ").join("");
      /// solution 5
      _output = string.replaceAll(' ', '');

      /// solution 6
      /// String replaceWhitespacesUsingRegex(String s, String replace) {
      ///   if (s == null) {
      ///     return null;
      ///   }
      ///
      ///   // This pattern means "at least one space, or more"
      ///   // \\s : space
      ///   // +   : one or more
      ///   final pattern = RegExp('\\s+');
      ///   return s.replaceAll(pattern, replace);
      ///
      /// ---> I'm just going to shortcut the above method here below
      // string?.replaceAll(new RegExp('\\s+'),'');
      _output = _output.replaceAll('‎', '');
      _output = _output.replaceAll('‏', '');
      _output = _output.replaceAll('‎ ', '');
      _output = _output.replaceAll(' ‏', '');
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? removeTextAfterFirstSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result = text;

    if (TextCheck.isEmpty(text) == false){

      final bool _textContainsChar = TextCheck.stringContainsSubString(
        string: text,
        subString: specialCharacter,
      );

      if (_textContainsChar == true) {
        _result = text?.substring(0, text.indexOf(specialCharacter));
      }

    }

    return _result;
  }
  // --------------------
  /// AI TESTED
  static String? removeTextBeforeFirstSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result;

    if (TextCheck.isEmpty(text) == false){

      _result = text;

      final bool _textContainsChar = TextCheck.stringContainsSubString(
        string: _result,
        subString: specialCharacter,
      );

      if (_textContainsChar == true) {
        final int _position = _result!.indexOf(specialCharacter);
        _result =
        (_position != -1) ? _result.substring(_position + 1, _result.length)
            :
        _result;
      }

    }

    return _result;
  }
  // --------------------
  /// AI TESTED
  static String? removeTextAfterLastSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result;

    if (TextCheck.isEmpty(text) == false){

      _result = text;

      final bool _textContainsChar = TextCheck.stringContainsSubString(
        string: text,
        subString: specialCharacter,
      );

      if (_textContainsChar == true) {
        _result = text?.substring(0, text.lastIndexOf(specialCharacter));
      }

    }
    else {
      _result = text;
    }

    return _result;
  }
  // --------------------
  /// AI TESTED
  static String? removeTextBeforeLastSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result = text;

    if (TextCheck.isEmpty(text) == false){

      final bool _textContainsChar = TextCheck.stringContainsSubString(
        string: text,
        subString: specialCharacter,
      );

      if (_textContainsChar == true) {

        final int _position = _result!.lastIndexOf(specialCharacter);

        _result = text == null ? null
            :
        (_position != -1) ? text.substring(_position + 1, text.length)
            :
        text;
      }

    }

    return _result;
  }
  // --------------------
  /// AI TESTED
  static String? removeAllCharactersAfterNumberOfCharacters({
    required String? text,
    required int? numberOfChars,
  }) {
    String? _output = text;

    if (text != null &&
        numberOfChars != null &&
        text.isNotEmpty &&
        text.length > numberOfChars
    ) {
      _output = text.substring(0, numberOfChars);
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Future<Map<String, dynamic>> getKeywordsMap(List<String>? keywordsIDs) async {
    /// converts list of strings to map of keywords with true map value

    /// example
    ///
    /// List<String> listExample = <String>['construction', 'architecture', 'decor'];
    /// will result a map like this :-
    /// {
    ///   construction : true,
    ///   architecture : true,
    ///   decor        : true,
    /// }
    ///
    /// UPDATE
    ///
    /// MAP SHOULD LOOK LIKE THIS
    /// {
    ///   construction : 0 ,
    ///   architecture : 1 ,
    ///   decor : 2 ,
    /// }

    // old solution
    // Map<String, dynamic> _result = { for (var keyword in list) keyword : true };

    // new solution won't work as key value should be string on firestore
    // Map<int, String> _result = list.asMap();

    // mirroring the map
    final Map<String, dynamic> _stringIndexMap = <String, dynamic>{};

    if (Lister.checkCanLoop(keywordsIDs) == true) {

      int _index = 0;

      await Future.forEach(keywordsIDs!, (String keywordID) {
        _stringIndexMap.addAll(<String, dynamic>{
          keywordID: _index,
        });
        _index++;
      });

    }

    return _stringIndexMap;
  }
  // --------------------
  /// AI TESTED
  static Map<String, dynamic>? getValueAndTrueMap(List<String>? list) {

    if (Lister.checkCanLoop(list) == true){
      final Map<String, dynamic> _result = <String, dynamic>{
        for (final String string in list!) string: true
      };
      return _result;
    }
    else {
      return null;
    }


  }
  // -----------------------------------------------------------------------------

  /// FIXERS

  // --------------------
  /// TASK : LATER
  static String? fixArabicText(String? input) {
    /// TASK : alef hamza issue
    /// TASK : ya2 w alef maksoura issue
    /// TASK : ha2 w ta2 marbouta issue

    return 'Bokra isa';
  }
  // --------------------
  /// AI TESTED
  static String? fixCountryName({
    required String? input,
    Map<String, dynamic>? addTheseChars,
  }) {
    /// only user with country names, city names, districts names
    String? _output;

    if (input != null) {

      _output = input.toLowerCase().trim();

      Map<String, dynamic> _charsToMove = {
        'space'             : {'char': ' '    ,'replacement': '_'},
        'double space'      : {'char': '  '   ,'replacement': '_'},
        'dash'              : {'char': '-'    ,'replacement': '_'},
        'plus'              : {'char': '+'    ,'replacement': '_'},
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
        'forward_slash'     : {'char': '/'    ,'replacement': '_'},
        'back_slash'        : {'char': r'\'    ,'replacement': '_'},
        'line'              : {'char': r'|'    ,'replacement': '_'},
        'semi_colon'        : {'char': ';'    ,'replacement': '_'},
        'colon'             : {'char': ':'    ,'replacement': '_'},
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
        'double underscore' : {'char': '__'   ,'replacement': '_'},
        'double underscore2': {'char': '__'   ,'replacement': '_'},
        'double underscore3': {'char': '__'   ,'replacement': '_'},
        'double underscore4': {'char': '__'   ,'replacement': '_'},
        'double underscore5': {'char': '__'   ,'replacement': '_'},
        // Add more character replacements as needed
      };
      _charsToMove = Mapper.insertMapInMap(
        baseMap: _charsToMove,
        insert: addTheseChars,
        // replaceDuplicateKeys: true,
      );


      final List<String> _keys = _charsToMove.keys.toList();

      for (final String key in _keys){
        _output = replaceAllCharacters(
          input: _output,
          characterToReplace: _charsToMove[key]['char'],
          replacement: _charsToMove[key]['replacement'],
        );
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? fixSearchText(String? input){
    String? _output;

    if (input != null && input != ''){

      _output = input.trim().toLowerCase();
      _output = removeSpacesFromAString(_output);
      // _output = fixArabicText(_output);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TEXT CONTROLLERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> controllerPaste(TextEditingController? controller) async {
    final String? _pasted = await TextClipBoard.paste();
    controller?.text = _pasted ?? '';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void setControllerSelectionAtEnd(TextEditingController? controller){
    if (controller != null){
      controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    }
  }
  // -----------------------------------------------------------------------------

  /// CURSOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextSelection setCursorAtTheEnd({
    required TextEditingController? controller,
  }){

    int _position = 0;

    if (controller != null){
      _position =  controller.text.length;
    }

    return TextSelection.fromPosition(TextPosition(
      offset: _position,
      // affinity:
    ));

  }
  // -----------------------------------------------------------------------------
}

/*

ENCODE AND DECODE STRINGS for encryption

https://stackoverflow.com/questions/56201074/how-to-encode-and-decode-base64-and-base64url-in-flutter-dart

String credentials = "username:password";
Codec<String, String> stringToBase64 = utf8.fuse(base64);
String encoded = stringToBase64.encode(credentials);      // dXNlcm5hbWU6cGFzc3dvcmQ=
String decoded = stringToBase64.decode(encoded);          // username:password

 */
