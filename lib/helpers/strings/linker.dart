import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
/// => TAMAM
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
  static String? extractWebsiteDomain({
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
      if (TextCheck.stringStartsExactlyWith(text: url, startsWith: 'www.') == true){
        return TextMod.removeNumberOfCharactersFromBeginningOfAString(string: url, numberOfCharacters: 4);
      }
      else {
        return url;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> extractWebsitesDomains({
    required List<String> links,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(links) == true){

      for (final String link in links){

        final String? _domain = extractWebsiteDomain(link: link);
        if (_domain != null){
          _output = Stringer.addStringToListIfDoesNotContainIt(
              strings: _output,
              stringToAdd: _domain,
          );
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// WEB LINK

  // --------------------
  static const String httpsCode = 'https://';
  // --------------------
  /// AI TESTED
  static String? initializeWebLink({
    required String? url,
  }){
    String? _initialText;

    /// NO URL GIVEN
    if (TextCheck.isEmpty(url) == true){
      _initialText = httpsCode;
    }

    /// URL IS GIVEN
    else {
      _initialText = url;
    }

    return _initialText;
  }
  // --------------------
  /// AI TESTED
  static String? nullifyUrlLinkIfOnlyHTTPS({
    required String? url,
  }){
    String? _output;

    /// URL IS DEFINED
    if (TextCheck.isEmpty(url) == false){

      if (httpsCode != url){
        _output = TextMod.removeSpacesFromAString(url);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
