import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
/// => TAMAM
abstract class Linker {
  // -----------------------------------------------------------------------------

  /// COMMON DOMAINS

  // --------------------
  static const List<String> commonDomains = [
    'facebook.com',
    'linkedin.com',
    'youtube.com',
    'instagram.com',
    'pinterest.com',
    'pinterest.it',
    'tiktok.com',
    'twitter.com',
    'behance.net',
    'behance.com',
    'vimeo.com',
  ];
  static const List<String> commonLinkersDomains = [
    'linktr.ee',
    'bit.ly',
    'linkin.bio',
    't.me',
    'linkr.bio',
  ];
  // -----------------------------------------------------------------------------

  /// EXTRACT DOMAIN FROM WEBSITE

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

  /// CLEANUPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cleanURL(String? link){
    String? _output;

    if (TextCheck.isEmpty(link) == false) {

      /// LINK SHOULD CONTAIN 'http://' to work
      final bool _containsHttp = TextCheck.stringContainsSubString(
        string: link,
        subString: 'http://',
      );

      final bool _containsHttps = TextCheck.stringContainsSubString(
        string: link,
        subString: 'https://',
      );

      if (_containsHttp == true || _containsHttps == true) {
        _output = link!;
      }
      else {
        _output = 'https://$link';
      }

    }

    return removeExtraSlashAtTheEndIfExisted(_output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? removeExtraSlashAtTheEndIfExisted(String? fullPath){
    String? _output = fullPath;

    if (TextCheck.isEmpty(fullPath) == false){

      final String _lastChar = fullPath![fullPath.length-1];

      if (_lastChar == '/'){
        _output = TextMod.removeNumberOfCharactersFromEndOfAString(
          string: fullPath,
          numberOfCharacters: 1,
        )!;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? removeTextAfterFirstQuestionMark(String? link){
    return TextMod.removeTextAfterFirstSpecialCharacter(
      text: link,
      specialCharacter: '?',
    );
  }
  // -----------------------------------------------------------------------------

  /// U R I

  // --------------------
  /// TESTED : WORKS PERFECT
  static Uri? createURI(String? link){
    Uri? _output;

    final String? _link = cleanURL(link);

    if (_link != null) {
      _output = Uri.parse(_link);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// QUERY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String> getQueryParameters(String? link){
    // EXAMPLE PATTERN
    /// final String _example = 'key1 = value1 & key2 = value2';
    Map<String, String> _output = {};
    final String? _cleaned = TextMod.removeSpacesFromAString(link);

    if (TextCheck.isEmpty(_cleaned) == false){

      final List<String> _pairs = _cleaned!.split('&').toList();
      _pairs.removeWhere((element) => element == '');

      if (Lister.checkCanLoop(_pairs) == true){

        for (final String pair in _pairs){

          if (TextCheck.stringContainsSubString(string: pair, subString: '=') == true){

            final String? _key = TextMod.removeTextAfterFirstSpecialCharacter(text: pair, specialCharacter: '=');
            final String? _value = TextMod.removeTextBeforeFirstSpecialCharacter(text: pair, specialCharacter: '=');

            if (TextCheck.isEmpty(_key) == false && TextCheck.isEmpty(_value) == false){
              _output = MapperSS.insertPairInMapWithStringValue(
                  map: _output,
                  key: _key,
                  value: _value!,
                  overrideExisting: true,
              )!;
            }

          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
