import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:flutter/material.dart';

/// AI TESTED
class TextDir {
  // -----------------------------------------------------------------------------

  const TextDir();

  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection getAppLangTextDirection({
    required bool appIsLTR,
  }) {

    if (appIsLTR == true) {
      return TextDirection.ltr;
    }

    else {
      return TextDirection.rtl;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection getAppLangInverseTextDirection({
    required bool appIsLTR,
  }) {

    if (appIsLTR == true) {
      return TextDirection.rtl;
    }

    else {
      return TextDirection.ltr;
    }

  }
  // -----------------------------------------------------------------------------

  /// AUTO SWITCHERS

  // --------------------
  /// AI TESTED
  static TextDirection? autoSwitchTextDirectionByController(TextEditingController? controller) {

    /// if keyboard lang is ltr ? ltr : rtl
    /// On native iOS the current keyboard language can be gotten from
    /// UITextInputMode
    /// and listened to with
    /// UITextInputCurrentInputModeDidChangeNotification.
    /// On native Android you can use
    /// getCurrentInputMethodSubtype
    /// to get the keyboard language, but I'm not seeing a way to listen
    /// to keyboard language changes.

    if (TextCheck.textControllerIsEmpty(controller) == false) {

      /// first character defines the direction
      final String? _trimmedVal = TextMod.removeSpacesFromAString(controller!.text.trim());
      final String? _firstCharacter = TextMod.cutNumberOfCharactersOfAStringBeginning(
          string: _trimmedVal,
          number: 1,
      );

      if (TextCheck.textStartsInEnglish(_firstCharacter) == true) {
        return TextDirection.ltr;
      }

      else if (TextCheck.textStartsInArabic(_firstCharacter) == true) {
        return TextDirection.rtl;
      }

      else {
        return null;
      }

    }

    else {
      return null;
    }

  }
  // --------------------
  /// AI TESTED
  static TextDirection? autoSwitchTextDirection({
    required String? val,
    required bool appIsLTR,
  }) {

    // bool _appIsLeftToRight = appIsLeftToRight(context);
    // TextDirection _defaultByLang = _appIsLeftToRight == true ? TextDirection.ltr : TextDirection.rtl;

    /// when val has a value
    if (TextCheck.isEmpty(val) == false) {

      /// first character defines the direction
      final String? _trimmedVal = TextMod.removeSpacesFromAString(val!.trim());
      final String? _firstCharacter = TextMod.cutNumberOfCharactersOfAStringBeginning(
          string: _trimmedVal,
          number: 1,
      );

      if (TextCheck.textStartsInEnglish(_firstCharacter)) {
        return TextDirection.ltr;
      }

      else if (TextCheck.textStartsInArabic(_firstCharacter)) {
        return TextDirection.rtl;
      }

      else {
        // _textDirection = _defaultByLang; // can not check app is left to right in initState of SuperTextField
        return TextDirection.ltr; // instead of null
      }

    }

    /// when val is empty
    else {
      // _textDirection = _defaultByLang;
      /// can not check app is left to right in initState of SuperTextField
      return getAppLangTextDirection(
        appIsLTR: appIsLTR,
      ); // instead of null
    }

  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// AI TESTED
  static TextDirection concludeTextDirection({
    required TextDirection? definedDirection,
    required TextDirection? detectedDirection,
    required bool appIsLTR,
  }) {

    /// when definedDirection is already defined, it overrides all
    if (definedDirection != null) {
      return definedDirection;
    }

    /// when it is not defined outside, and detectedDirection hadn't changed yet we
    /// use default superTextDirection that detects current app language
    else if (detectedDirection == null) {
      return getAppLangTextDirection(
        appIsLTR: appIsLTR,
      );
    }

    /// so otherwise we use detectedDirection that auto detects current input
    /// language
    else {
      return detectedDirection;
    }

  }
  // -----------------------------------------------------------------------------
}
