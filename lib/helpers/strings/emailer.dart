import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:email_validator/email_validator.dart';

class Emailer {
  // -----------------------------------------------------------------------------

  const Emailer();

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
    String? _output;

    if (TextCheck.isEmpty(email) == false){

      _output = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: TextMod.removeSpacesFromAString(email),
        specialCharacter: ':',
      )?.toLowerCase();

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
