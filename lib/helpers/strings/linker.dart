

import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';

class Linker {
  // -----------------------------------------------------------------------------

  const Linker();

  // -----------------------------------------------------------------------------

  /// EXTRACTORS

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
  void x(){}
}
