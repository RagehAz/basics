import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:email_validator/email_validator.dart';
/// => TAMAM
abstract class Emailer {
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool validate(String? email){
    if (email == null){
      return false;
    }
    else {
      return EmailValidator.validate(email);
    }
  }
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const List<String> commonDomains = [
    'gmail.com',
    'hotmail.com',
    'outlook.com',
    'yahoo.com',
  ];
  // -----------------------------------------------------------------------------

  /// EXTRACT DOMAIN FROM EMAIL

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? extractEmailDomain({
    required String? email,
  }){
    String? _output;

    if (email != null) {
      final int atIndex = email.indexOf('@');

      if (atIndex != -1) {
        _output = email.substring(atIndex + 1);
      }
    }
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> extractEmailsDomains({
    required List<String> emails,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(emails) == true){

      for (final String email in emails) {

        final String? domain = extractEmailDomain(
          email: email,
        );

        if (domain != null) {
          _output = Stringer.addStringToListIfDoesNotContainIt(
              strings: _output,
              stringToAdd: domain.toLowerCase()
          );
        }
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cleanEmail({
    required String? email,
  }){
    String? _output = email;

    if (TextCheck.isEmpty(_output) == false){

      _output = getEmailFromOutlookPaste(_output);

      _output = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: TextMod.removeSpacesFromAString(_output),
        specialCharacter: ':',
      )?.toLowerCase();

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getEmailFromOutlookPaste(String? text){
    String? _output = text;

    if (TextCheck.isEmpty(text) == false){

      /// LOOKS LIKE THIS
      // info@jddesign.ae <info@jddesign.ae>;

      final List<String> parts = text!.trim().split(' ');

      if (Lister.superLength(parts) == 2){
        final String _first = parts[0];
        final String _second = parts[1];

        if (_second == '<$_first>;'){
          _output = _first;
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
