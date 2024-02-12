import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';

class Linker {
  // -----------------------------------------------------------------------------

  const Linker();

  // -----------------------------------------------------------------------------

  /// EMAIL EXTRACTORS

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

  /// EXTRACTORS

  // --------------------
  /// AI TESTED
  static String? extractDomainFromWebLink({
    required String? link,
  }){

    if (TextCheck.isEmpty(link) == true){
      return null;
    }

    else {

      // Remove any leading and trailing spaces
      String url = link!.trim();

      // Check if the URL starts with a protocol (e.g., http:// or https://)
      if (url.startsWith('http://')) {
        url = url.substring(7); // Remove 'http://'
      } else if (url.startsWith('https://')) {
        url = url.substring(8); // Remove 'https://'
      }

      // Find the index of the first slash after the protocol (if any)
      final int slashIndex = url.indexOf('/');
      if (slashIndex != -1) {
        // If there's a slash, extract the substring before it
        url = url.substring(0, slashIndex);
      }

      // Find the index of the first colon after the protocol (if any)
      final int colonIndex = url.indexOf(':');
      if (colonIndex != -1) {
        // If there's a colon, extract the substring before it
        url = url.substring(0, colonIndex);
      }

      // The remaining part of the URL is the domain
      return url;

    }

  }
  // -----------------------------------------------------------------------------
}
