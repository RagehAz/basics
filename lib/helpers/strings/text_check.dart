import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

/// => AI TESTED
abstract class TextCheck {
  // -----------------------------------------------------------------------------

  /// REG EXP

  // --------------------
  static const String urlPattern = r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?';
  // -----------------------------------------------------------------------------

  /// BAD WORDS

  // --------------------
  /// AI TESTED
  static bool containsBadWords({
    required String? text,
    required List<String> badWords,
  }){
    bool _userIsSayingSomeNastyShit = false;

    if (TextCheck.isEmpty(text) == false) {

      for (int i = 0; i < badWords.length; i++) {
        final bool _hasBadWord = stringContainsSubString(
          string: text,
          subString: badWords[i],
        );

        if (_hasBadWord == true) {
          _userIsSayingSomeNastyShit = true;
          break;
        }
      }

    }

    return _userIsSayingSomeNastyShit;
  }
  // -----------------------------------------------------------------------------

  /// LANGUAGE CHECK

  // --------------------
  /// AI TESTED
  static bool textIsEnglish(String? val) {

    if (val == null || val.trim().isEmpty == true){
      return true;
    }

    else {
    final RegExp exp = RegExp('[a-zA-Z]', multiLine: true, unicode: true);
    bool textIsEnglish = true;

    /// if you want to check the last character input by user let the [characterNumber = val.length-1;]
    const int characterNumber = 0;

      if (exp.hasMatch(val.substring(characterNumber)) && val.substring(characterNumber) != ' ') {
        textIsEnglish = true;
      }

      else if (!exp.hasMatch(val.substring(characterNumber)) &&
          val.substring(characterNumber) != ' ') {
        textIsEnglish = false;
      }

      return textIsEnglish;
    }
  }
  // --------------------
  /// AI TESTED
  static bool textStartsInArabic(String? val) {

    if (isEmpty(val) == true){
      return false;
    }
    else {

      /// \p{N} will match any unicode numeric digit.
      // String _reg = r"^[\u0621-\u064A\s\p{N}]+$" ;

      /// To match only ASCII digit use:
      // String _reg = r"^[\u0621-\u064A\s0-9]+$" ;

      /// this gets all arabic and english together
      // String _reg = r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$" ;

      /// others
      // String _reg = r"^[\u0621-\u064A\u0660-\u0669 ]+$";
      // "[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]"

      /// This works for Arabic/Persian even numbers.
      const String _reg = r'^[؀-ۿ]+$';

      final RegExp _exp = RegExp(_reg, multiLine: true);
      // bool isArabic;

      final String? _firstCharacter = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(val);

      bool _startInArabic = true;

      if (_firstCharacter == null || _firstCharacter == '') {
        _startInArabic = false;
      } else if (_exp.hasMatch(_firstCharacter) == true) {
        _startInArabic = true;
      } else {
        _startInArabic = false;
      }

      return _startInArabic;
    }
  }
  // --------------------
  /// AI TESTED
  static bool textStartsInEnglish(String? val) {
    const String _reg = r'[a-zA-Z]';
    final RegExp _exp = RegExp(_reg, multiLine: true);
    final String? _firstCharacter = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(val);

    bool _startsInEnglish = true;

    if (_firstCharacter == null || _firstCharacter == '') {
      _startsInEnglish = false;
    }

    else if (_exp.hasMatch(_firstCharacter) == true) {
      _startsInEnglish = true;
    }

    else {
      _startsInEnglish = false;
    }

    return _startsInEnglish;
  }
  // --------------------
  /// AI TESTED
  static bool textIsRTL(String? text){
    if (isEmpty(text) == true){
      return false;
    }
    else {
      return intl.Bidi.detectRtlDirectionality(text!);
    }
  }
  // --------------------
  /// AI TESTED
  static String? concludeEnglishOrArabicLang(String? text) {

    if (textStartsInArabic(text) == true){
      return 'ar';
    }
    else if (textStartsInEnglish(text) == true){
      return 'en';
    }
    else {
      return 'en';
    }

  }
  // -----------------------------------------------------------------------------

  /// CASE CHECK

  // --------------------
  /// AI TESTED
  static bool verseIsUpperCase(String? text){
    bool _isUpperCase = false;

    if (TextCheck.isEmpty(text) == false){
      if (text!.toUpperCase() == text){
        _isUpperCase = true;
      }
    }

    return _isUpperCase;
  }
  // -----------------------------------------------------------------------------

  /// TEXT CONTROLLER CHECKERS

  // --------------------
  /// AI TESTED
  static bool textControllerIsEmpty(TextEditingController? controller) {

    if (
        controller == null ||
        controller.text == '' ||
        controller.text.isEmpty ||
        TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(controller.text) == '' ||
        TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(controller.text) == null
    ) {
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// AI TESTED
  static bool textControllersAreIdentical({
    required TextEditingController? controller1,
    required TextEditingController? controller2,
  }){

    if (controller1 == null && controller2 == null){
      return true;
    }

    else if (controller1 != null && controller2 != null){

      if (
          controller1.text == controller2.text &&
          controller1.hashCode == controller2.hashCode
      ){
        return true;
      }

      else {
        return false;
      }

    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// TEXT CONTROLLER DISPOSERS

  // --------------------
  /// TAMAM
  static void disposeAllTextControllers(List<TextEditingController>? controllers) {
    if (Lister.checkCanLoop(controllers) == true) {
      for (final TextEditingController controller in controllers!) {
        controller.dispose();
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// TEXT CONTROLLER CREATORS

  // --------------------
  /// AI TESTED
  static List<TextEditingController> createEmptyTextControllers(int? length) {
    final List<TextEditingController> _controllers = <TextEditingController>[];

    if (length != null && length != 0){
      for (int i = 0; i < length; i++) {
        _controllers.add(TextEditingController());
    }
    }

    return _controllers;
  }
  // -----------------------------------------------------------------------------

  /// CONTAINS

  // --------------------
  /// AI TESTED
  static bool isEmpty(String? string) {

    if (string == null || string == '' || string.isEmpty == true

    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

    ) {
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// AI TESTED
  static bool stringContainsSubString({
    required String? string,
    required String? subString,
  }) {
    bool _itContainsIt = false;

    if (string != null && subString != null) {
      if (string.toLowerCase().contains(subString.toLowerCase()) == true) {
        _itContainsIt = true;
      }
    }

    return _itContainsIt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkStringContainAnyOfSubStrings({
    required String? string,
    required List<String>? subStrings,
  }){
    bool _output = false;

    if (Lister.checkCanLoop(subStrings) == true && string != null){

      for (final String subString in subStrings!){

        final bool _contains = TextCheck.stringContainsSubString(
            string: string,
            subString: subString
        );


        if (_contains == true){
          _output = true;
          break;
        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static bool stringContainsSubStringRegExp({
    required String? string,
    required String? subString,
    bool caseSensitive = false,
    // bool multiLine = false
  }) {
    bool _itContainsIt = false;

    if (string != null && subString != null) {

      final RegExp pattern = RegExp(subString,
        caseSensitive: caseSensitive,
        // multiLine: multiLine // mesh shaghal w mesh wa2to
      );
      final Iterable matches = pattern.allMatches(string);

      if (matches.isNotEmpty) {
        _itContainsIt = true;
      }

    }

    return _itContainsIt;
  }
  // --------------------
  /// AI TESTED
  static bool stringStartsExactlyWith({
    required String? text,
    required String? startsWith, // http
  }){
    bool _output = false;

    if (TextCheck.isEmpty(text) == false && TextCheck.isEmpty(startsWith) == false){

      final String? _cutText = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: text,
        numberOfChars: startsWith!.length,
      );

      if (_cutText == startsWith){
        _output = true;
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static bool stringStartsWithAny({
    required String? text,
    required List<String>? listThatMightIncludeText, // http
  }){
    bool _output = false;

    if (TextCheck.isEmpty(text) == false && Lister.checkCanLoop(listThatMightIncludeText) == true){

      for (final String startWith in listThatMightIncludeText!){

        final String _cutText = TextMod.removeAllCharactersAfterNumberOfCharacters(
          text: text,
          numberOfChars: startWith.length,
        )!;

        if (_cutText == startWith){
          _output = true;
          break;
        }

      }


    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<String>? getStringsStartingExactlyWith({
    required String? startWith,
    required List<String>? strings,
  }){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(strings) == true && TextCheck.isEmpty(startWith) == false){

      for (final String string in strings!){

        final bool _startsIndeed = stringStartsExactlyWith(
            text: string,
            startsWith: startWith,
        );

        if (_startsIndeed == true){
          _output.add(string);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getStringsContainingThis({
    required List<String> strings,
    required String? subString,
  }){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(strings) == true && TextCheck.isEmpty(subString) == false){

      for (final String text in strings){

        final bool _contains = TextCheck.stringContainsSubString(
          string: text,
          subString: subString,
        );

        if (_contains == true){
          _output.add(text);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// LENGTH

  // --------------------
  /// AI TESTED
  static bool isShorterThanOrEqualTo({
    required String? text,
    required int? length,
  }){
    bool _isShorter = false;

    if (TextCheck.isEmpty(text) == true || length == null){
      _isShorter = true;
    }
    else {
      _isShorter = text!.length <= length;
    }

    return _isShorter;
  }
  // --------------------
  /// AI TESTED
  static bool isShorterThan({
    required String? text,
    required int? length,
  }){
    bool _isShorter = false;

    if (TextCheck.isEmpty(text) == true || length == null){
      _isShorter = true;
    }
    else {
      _isShorter = text!.length < length;
    }

    return _isShorter;
  }
  // -----------------------------------------------------------------------------
}
