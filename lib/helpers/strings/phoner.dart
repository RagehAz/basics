import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/models/flag_model.dart';
/// => TAMAM
abstract class Phoner {
  // -----------------------------------------------------------------------------

  /// GLOBALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? globalizePhoneNumber({
    required String? phoneNumber,
    required String? countryID,
  }){
    String? _output = phoneNumber;

    if (phoneNumber != null){

      final String? _countryPhoneCode = Flag.getCountryPhoneCode(countryID);

      if (_countryPhoneCode != null){

        final bool _startsWithCountryCode = TextCheck.stringStartsExactlyWith(
            text: phoneNumber,
            startsWith: _countryPhoneCode,
        );

        if (_startsWithCountryCode == false){

          final List<String> _allPhoneCodes = Flag.createCountriesPhoneCodes();
          final List<String> _allCodesButStartingZeros = Phoner.zerofyPhones(
            phones: _allPhoneCodes,
          );

          final bool _startsWithAnotherCountryCode = TextCheck.stringStartsWithAny(
              text: phoneNumber,
              listThatMightIncludeText: [..._allPhoneCodes, ..._allCodesButStartingZeros],
          );

          if (_startsWithAnotherCountryCode == false){
            _output = '$_countryPhoneCode$phoneNumber';
          }


        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// AI TESTED
  static String? initializePhoneNumber({
    required String? number,
    required String? countryPhoneCode,
  }){
    String? initialNumber;

    /// NO NUMBER GIVEN
    if (TextCheck.isEmpty(number) == true){

      if (TextCheck.isEmpty(countryPhoneCode) == false){
        initialNumber = countryPhoneCode;
      }

    }

    /// NUMBER IS GIVEN
    else {
      initialNumber = number;
    }

    return initialNumber;
  }
  // -----------------------------------------------------------------------------

  /// ZEROFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? zerofyPhone({
    required String? phone,
  }){
    String? _output = phone;

    final bool _startsWithPlus = isPlusified(phone);

    if (_startsWithPlus == true){

      _output = TextMod.removeTextBeforeFirstSpecialCharacter(text: _output, specialCharacter: '+');

      _output = '00$_output';

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> zerofyPhones({
    required List<String> phones,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(phones) == true){

      for (final String phone in phones){

        final String? _zerofied = zerofyPhone(phone: phone);

        if (_zerofied == null){
          _output.add(phone);
        }
        else {
          _output.add(_zerofied);
        }


      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PLUSIFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? plusifyPhone({
    required String? phone,
  }){
    String? _output = phone;

    final bool _startsWithZeros = isZerofied(phone);

    if (_startsWithZeros == true){

      _output = TextMod.removeNumberOfCharactersFromBeginningOfAString(string: _output, numberOfCharacters: 2);

      _output = '+$_output';

    }


    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> plusifyPhones({
    required List<String> phones,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(phones) == true){

      for (final String phone in phones){

        final String? _plusified = plusifyPhone(phone: phone);

        if (_plusified == null){
          _output.add(phone);
        }
        else {
          _output.add(_plusified);
        }


      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLEAN

  // --------------------
  /// AI TESTED
  static String? nullifyNumberIfOnlyCountryCode({
    required String? number,
    required String? countryPhoneCode,
  }){
    String? _output;

    if (number != null && countryPhoneCode != null){

      if (countryPhoneCode != number){
        _output = TextMod.removeSpacesFromAString(number);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cleanNumber({
    required String? phone,
  }){
    String? value;

    if (TextCheck.isEmpty(phone) == false){

      value = cleanWhatsappLink(phone: phone);

      value = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: TextMod.removeSpacesFromAString(value),
        specialCharacter: ':',
      )?.toLowerCase();

      value = TextMod.replaceAllCharacters(characterToReplace: '(', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: ')', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: '[', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: ']', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: '.', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: ' ', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: '-', replacement: '', input: value);
      value = TextMod.replaceAllCharacters(characterToReplace: '_', replacement: '', input: value);
      value = plusifyPhone(phone: value);
      // if (TextCheck.stringStartsExactlyWith(text: value, startsWith: '00') == true){
      //   final String _n = TextMod.removeNumberOfCharactersFromBeginningOfAString(string: value, numberOfCharacters: 2)!;
      //   value = '+$_n';
      // }

    }

    return value;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> cleanNumbers({
    required List<String>? phones,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(phones) == true){

      for (final String phone in phones!){

        final String? _cleaned = cleanNumber(phone: phone);

        if (_cleaned != null){
          _output.add(_cleaned);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? fixEgyptPhoneFromFacebook({
    required String? text,
    required String? countryID,
  }){
    String? _output = text;

    if (TextCheck.isEmpty(text) == false && TextCheck.isEmpty(countryID) == false){

      if (countryID == 'egy'){

        final bool _startsWithOne = TextCheck.stringStartsExactlyWith(
            text: text,
            startsWith: '1',
        );
        final bool _isTenCharsLong = text?.length == 10;

        if (_startsWithOne && _isTenCharsLong){

          _output = '+20$_output';

        }


      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cleanWhatsappLink({
    required String? phone,
  }){
    String? _output = phone;

    if (TextCheck.isEmpty(phone) == false){

      final bool _startsWithTel = TextCheck.stringStartsExactlyWith(
          text: phone,
          startsWith: 'tel:',
      );

      final bool _includesTheMark = TextCheck.stringContainsSubString(
          string: phone,
          subString: '%',
      );

      if (_startsWithTel && _includesTheMark){
        _output = TextMod.replaceAllCharacters(characterToReplace: '%20', replacement: '', input: _output);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isZerofied(String? phone){
    return TextCheck.stringStartsExactlyWith(text: phone, startsWith: '00');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isPlusified(String? phone){
    return TextCheck.stringStartsExactlyWith(text: phone, startsWith: '+');
  }
  // -----------------------------------------------------------------------------

  /// COUNTRY PHONE CODE DETECTION

  // --------------------
  /// TASK : TEST_ME
  static String? getCountryCodeFromPhone({
    required String? phone,
    required List<String> allCodes,
  }){
    String? _output;

    for (final String code in allCodes){

      final bool _startsWithThis = TextCheck.stringStartsExactlyWith(
          text: phone,
          startsWith: code,
      );

      if (_startsWithThis == true){
        _output = code;
        break;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// COUNTRY ID DETECTION

  // --------------------
  /// TASK : TEST_ME
  static List<String> detectCountryIDFromPhone({
    required String? phone,
    required List<String> allPhoneCodes,
  }){
    List<String> _output = [];

    if (phone != null){

      final bool _startsWithZero = Phoner.isZerofied(phone);
      final bool _startsWithPlus = Phoner.isPlusified(phone);

      if (_startsWithZero || _startsWithPlus){

        final String? _phone = _startsWithZero ? Phoner.plusifyPhone(phone: phone) : phone;

        final String? _codeFromPhone = Phoner.getCountryCodeFromPhone(
          phone: _phone,
          allCodes: allPhoneCodes,
        );

        // blog('_codeFromPhone : $_codeFromPhone');

        _output = Flag.searchCountryPhoneCodesEqual(
          phoneCode: _codeFromPhone,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> detectCountryIDFromPhones({
    required List<String> phones,
    required List<String> allPhoneCodes,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(phones) == true){

      for (final String phone in phones){

        final List<String> _countriesIDs = detectCountryIDFromPhone(
          phone: phone,
          allPhoneCodes: allPhoneCodes,
        );

        if (Lister.checkCanLoop(_countriesIDs) == true){
          _output.addAll(_countriesIDs);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? detectPhoneFromWhatsappURL({
    required String? text,
  }){
    String? _output;

    if (ObjectCheck.isAbsoluteURL(text) == true){

      final bool _isWhatsapp = TextCheck.stringContainsSubString(
          string: text,
          subString: 'whatsapp',
      );

      if (_isWhatsapp == true){

        // https://api.whatsapp.com/send/?phone=5511976960971&text&type=phone_number&app_absent=0
        String? _text = TextMod.removeTextBeforeFirstSpecialCharacter(
            text: text,
            specialCharacter: '?',
        );

        // phone=5511976960971&text&type=phone_number&app_absent=0
        final bool _startsWithPhone = TextCheck.stringStartsExactlyWith(
            text: _text,
            startsWith: 'phone=',
        );

        if (_startsWithPhone == true){

          // phone=5511976960971&text&type=phone_number&app_absent=0
          _text = TextMod.removeTextAfterFirstSpecialCharacter(
              text: _text,
              specialCharacter: '&',
          );

          // phone=5511976960971
          _text = TextMod.removeTextBeforeFirstSpecialCharacter(
            text: _text,
            specialCharacter: '=',
          );

          // 5511976960971
          final bool _isNumber = Numeric.transformStringToInt(_text) != null;
          if (_isNumber == true){
            _output = '+$_text';
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
