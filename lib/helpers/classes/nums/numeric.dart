import 'dart:math' as math;
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';

/// => AI TESTED
class Numeric {
  // -----------------------------------------------------------------------------

  const Numeric();

  // -----------------------------------------------------------------------------

  /// FORMATTERS

  // --------------------
  /// AI TESTED
  static String formatNumToSeparatedKilos({
    required dynamic number,
    int fractions = 2,
    String separator = "'",
  }) {

    // assert(number is int || number is double || number == null, '_theNum is neither int nor double');

    /// THE SEPARATOR AFTER EACH 3 DIGITS IN AN INTEGER X'XXX'XXX ...
    String _result = '0';

    if (number == null){
      return _result;
    }

    else {

      final double? _theNum = roundFractions(number?.toDouble(), fractions);
      final String? _fractions = Numeric.getFractionStringWithoutZero(
        number: _theNum ?? 0,
        fractionDigits: fractions,
      );

      if (_theNum != null) {
        final int _numAsInt = _theNum.toInt();

        /// -999 < x < 999
        if (_numAsInt > -1000 && _numAsInt < 1000) {
          _result = _numAsInt.toString();
        }

        /// 1000 < x
        else {

          final double? _fractions = getFractions(
            number: _numAsInt.toDouble(),
          );

          if (_fractions != null) {
            final int _number = _numAsInt; //.floor();
            final String _digits = _number.abs().toString();
            final StringBuffer _separatedNumberWithoutFractions =
                StringBuffer(_number < 0 ? '-' : '');
            final int _maxDigitIndex = _digits.length - 1;

            for (int i = 0; i <= _maxDigitIndex; i += 1) {
              _separatedNumberWithoutFractions.write(_digits[i]);

              if (i < _maxDigitIndex && (_maxDigitIndex - i) % 3 == 0) {
                _separatedNumberWithoutFractions.write("'");
              }
            }

            if (_fractions > 0) {
              final String? _fractionWithoutZero = getFractionStringWithoutZero(
                number: _fractions,
              );

              _result = '$_separatedNumberWithoutFractions.$_fractionWithoutZero';
            } else {
              _result = '$_separatedNumberWithoutFractions';
            }
          }
        }

        // if (_theNum == null) return '0';
        // if (_theNum > -1000 && _theNum < 1000) return _theNum.toString();

        final String _digits = _numAsInt.abs().toString();
        final StringBuffer _resultStringBuffer = StringBuffer(_numAsInt < 0 ? '-' : '');
        final int maxDigitIndex = _digits.length - 1;

        for (int i = 0; i <= maxDigitIndex; i += 1) {
          _resultStringBuffer.write(_digits[i]);

          if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) {
            _resultStringBuffer.write(separator);
          }
        }
        _result = _resultStringBuffer.toString();
      }

      if (TextCheck.isEmpty(_fractions) == false && _fractions != '0') {
        return '$_result.$_fractions';
      }

      else {
        return _result;
      }

    }

  }
  // --------------------
  /// AI TESTED
  static String formatNumToCounterCaliber({
    required int? x,
    String thousand = 'thousand',
    String million = 'million',
  }) {
    String _stringOfCalibratedNumber = '0';

    if (x != null) {
      /// FROM 0 TO 999
      if (x >= 0 && x < 1000) {
        _stringOfCalibratedNumber = x.toString();
      }

      /// FROM 1000 TO 99995
      else if (x >= 1000 && x < 99995) {
        _stringOfCalibratedNumber =
        '${(x / 1000).toStringAsFixed(1).replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
            ' $thousand';
      }

      /// FROM 99995 TO 999445
      else if (x >= 99995 && x < 999445) {
        _stringOfCalibratedNumber = '${int.parse((x / 1000).toStringAsFixed(0))}'
            ' $thousand';
      }

      /// FROM 999445 TO INFINITY
      else if (x >= 999445) {
        _stringOfCalibratedNumber =
        '${(x / 1000000).toStringAsFixed(1).replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
            ' $million';
      } else {
        _stringOfCalibratedNumber = x.toStringAsFixed(0);
      }
    }

    return _stringOfCalibratedNumber;
  }
  // --------------------
  /// AI TESTED
  static String? formatIntWithinDigits({
    required int? num,
    required int? digits,
  }) {

    /// this should put the number within number of digits
    /// for digits = 4,, any number should be written like this 0000
    /// 0001 -> 0010 -> 0100 -> 1000 -> 9999
    /// when num = 10000 => should return 'increase digits to view number'

    String? _output;

    if (num != null && digits != null) {

      final int _maxPlusOne = calculateIntegerPower(num: 10, power: digits);
      final int _maxPossibleNum = _maxPlusOne - 1;

      if (num > _maxPossibleNum) {
        _output = 'XXXX';
      }

      else {

        String _numAsText = num.toString();

        for (int i = 1; i <= digits; i++) {

          if (_numAsText.length < digits) {
            _numAsText = '0$_numAsText';
          }

          else {
            break;
          }

        }

        _output = _numAsText;
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? formatDoubleWithinDigits({
    required double? value,
    required int? digits,
    bool addPlus = true,
  }) {
    String? _output;

    if (value != null && digits != null) {

      // final double _maxPossibleValue =
      //         calculateDoublePower(num: 10, power: digits)
      //         -
      //         1 / math.pow(10, digits);

      _output = value.toStringAsFixed(digits);

      if (addPlus == true && value > 0){
        _output = '+$_output';
      }
      if (addPlus == true && value == 0){
        _output = '±$_output';
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static int concludeNumberOfDigits(int? length){
    int _length = 0;

    if (length != null && length != 0){
      _length = modulus(length.toDouble())?.toInt() ?? 0;
      _length = _length.toString().length;
    }

    return _length;
  }
  // --------------------
  /// AI TESTED
  static String? formatIndexDigits({
    required int? index,
    required int? listLength,
  }){

    return formatIntWithinDigits(
      digits: concludeNumberOfDigits(listLength),
      num: index,
    );

  }
  // --------------------
  /// AI TESTED
  static String formatToRomanA(int number) {
    // Define mappings for Roman numerals and their corresponding values.
    final Map<String, int> romanNumerals = {
      'M': 1000,
      'CM': 900,
      'D': 500,
      'CD': 400,
      'C': 100,
      'XC': 90,
      'L': 50,
      'XL': 40,
      'X': 10,
      'IX': 9,
      'V': 5,
      'IV': 4,
      'I': 1,
    };

    // Check if the input number is within the valid range (1 to 3999).
    if (number < 1 || number > 3999) {
      return '';
    }

    // Initialize an empty string to store the Roman numeral representation.
    String result = '';

    // Use a local variable to perform calculations.
    int remainingValue = number;

    // Iterate through the Roman numerals mapping and build the Roman numeral string.
    romanNumerals.forEach((numeral, value) {
      while (remainingValue >= value) {
        // Append the Roman numeral to the result.
        result += numeral;
        // Subtract the value of the Roman numeral from the remainingValue.
        remainingValue -= value;
      }
    });

    return result;
}
  // --------------------
  /// AI TESTED
  static String formatToRomanB(int input) {
    const List<int> arabianRomanNumbers = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];

    const List<String> romanNumbers = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I'
    ];

    var num = input;

    if (num < 0) {
      return '';
    } else if (num == 0) {
      return '';
    }

    final builder = StringBuffer();
    for (var a = 0; a < arabianRomanNumbers.length; a++) {
      final times = (num / arabianRomanNumbers[a])
          .truncate(); // equals 1 only when arabianRomanNumbers[a] = num
      // executes n times where n is the number of times you have to add
      // the current roman number value to reach current num.
      builder.write(romanNumbers[a] * times);
      num -= times * arabianRomanNumbers[a]; // subtract previous roman number value from num
    }

    return builder.toString();
  }
  // -----------------------------------------------------------------------------

  /// TRANSFORMERS

  // --------------------
  /// AI TESTED
  static int? transformStringToInt(String? string) {
    int? _value;

    if (string != null) {
      final double? _doubleValue = double.tryParse(string);
      _value = _doubleValue?.toInt();
    }

    return _value;
  }
  // --------------------
  /// AI TESTED
  static double? transformStringToDouble(String? string) {
    double? _value;

    if (string != null && string.trim() != '') {
      _value = double.tryParse(string);
    }

    return _value;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String stringifyDouble(double? value){

    if (value == null){
      return '';
    }

    else {

      final int? _int = value.toInt();

      if (_int == value){
        return _int.toString();
      }

      else {

        String _text = value.toString();
        _text = _text == '0.0' ? '' : _text;

        final String? _fraction = TextMod.removeTextBeforeLastSpecialCharacter(
            text: _text,
            specialCharacter: '.',
        );

        if (_fraction == '0'){
          _text = TextMod.removeTextAfterLastSpecialCharacter(
              text: _text,
              specialCharacter: '.',
          )!;
        }

        return _text;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// AI TESTED
  static int createRandomIndex({
    int listLength = 1001, /// FOR 1000 ITEMS => ONLY VALUES FROM ( 0 -> 999 ) MAY RESULT
  }) {
    return math.Random().nextInt(listLength);
  }
  // --------------------
  /// AI TESTED
  static int createUniqueIndex({
    required List<int>? existingIndexes,
    int maxIndex = 999999,
  }) {
    /// from 0 up to 999'999 included if max index is not defined
    int _randomNumber = math.Random().nextInt(maxIndex + 1);

    // blog('random number is : $_randomNumber');

    if (existingIndexes != null && existingIndexes.contains(_randomNumber) == true) {
      _randomNumber = createUniqueIndex(
        existingIndexes: existingIndexes,
        maxIndex: maxIndex,
      );
    }

    return _randomNumber;
  }
  // --------------------
  /// AI TESTED
  static int createUniqueID({
    int maxDigitsCount = 16, // 8'640'000'000'000'000'000
  }) {
    assert(maxDigitsCount > 0 && maxDigitsCount <= 16, 'Take care : 0 < maxDigitsCount <= 16',);

    /// some smart ass stunt online said : DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String _string = DateTime.now().microsecondsSinceEpoch.toString();

    final String? _trimmed = TextMod.removeNumberOfCharactersFromBeginningOfAString(
      string: _string,
      numberOfCharacters: _string.length - maxDigitsCount,
    );


    return transformStringToInt(_trimmed)!;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static ValueKey<int> createUniqueKeyFrom({
    required List<ValueKey<int>> existingKeys,
    int maxIndex = 9999,
  }) {

    final List<int> _existingValues = getValuesFromKeys(
        keys: existingKeys
    );

    final int _newValue = createUniqueIndex(
      existingIndexes: _existingValues,
      maxIndex: maxIndex,
    );

    return ValueKey<int>(_newValue);
  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static List<dynamic> createListWithDummyValue({
    required int length,
    required int value,
  }) {
    final List<dynamic> _dummies = <dynamic>[];

    for (int i = 0; i < length; i++) {
      _dummies.add(value);
    }

    return _dummies;
  }
   */
  // --------------------
  /// AI TESTED
  static List<int> createRandomIndexes({
    required int numberOfIndexes,
    required int maxIndex,
  }) {
    final List<int> _indexes = <int>[];

    for (int i = 0; i < numberOfIndexes; i++) {

      final int _newIndex = createUniqueIndex(
          existingIndexes: _indexes,
          maxIndex: maxIndex
      );

      _indexes.add(_newIndex);
    }
    return _indexes;
  }
  // -----------------------------------------------------------------------------

  /// BOOL CYPHERS

  // --------------------
  /// AI TESTED
  static int cipherBool({
    required bool? bool,
  }) {
    /// true => 1; false => 0 else => null => return false instead of null
    switch (bool) {
      case true: return 1;
      case false: return 0;
      default: return 0;
    }
  }
  // --------------------
  /// AI TESTED
  static bool decipherBool(int? int) {
    /// 1 => true; 0 => false else => null (returning false instead of null)
    switch (int) {
      case 1: return true;
      case 0: return false;
      default: return false;
    }
  }
  // -----------------------------------------------------------------------------

  /// FRACTION

  // --------------------
  /// AI TESTED
  static double? getFractions({
    required double? number,
    int? fractionDigits,
  }) {

    /// NOTE : for 1.123 => returns 0.123

    if (number == null) {
      return null;
    }

    else {
      final String? _numberAsString = fractionDigits == null ?
      number.toString()
          :
      getFractionStringWithoutZero(number: number, fractionDigits: fractionDigits);

      final String? _fractionsString = TextMod.removeTextBeforeLastSpecialCharacter(
          text: _numberAsString,
          specialCharacter: '.',
      );

      return transformStringToDouble('0.$_fractionsString');
    }
  }
  // --------------------
  /// AI TESTED
  static double? removeFractions({
    required double? number,
  }) {
    final double? _fractions = getFractions(number: number);

    if (number == null || _fractions == null) {
      return null;
    }

    else {
      if (number > 0){
        return number - _fractions;
      }
      else {
        return number + _fractions;
      }
    }

  }
  // --------------------
  /// AI TESTED
  static double? roundFractions(double? value, int? fractions) {
    if (value == null){
      return null;
    }
    else {
      final String? _roundedAsString = value.toStringAsFixed(fractions ?? 0);
      return transformStringToDouble(_roundedAsString);
    }
  }
  // --------------------
  /// AI TESTED
  static String? getFractionStringWithoutZero({
    required double? number,
    int? fractionDigits
  }) {

    final String? _numberAsString = number?.toString();
    String? _fractionAsStringWithoutZero = TextMod.removeTextBeforeLastSpecialCharacter(
        text: _numberAsString,
        specialCharacter: '.',
    );

    if (fractionDigits != null && _fractionAsStringWithoutZero != null) {

      final int _fractionStringLength = _fractionAsStringWithoutZero.length;
      final int _trimmingLength = _fractionStringLength - fractionDigits;

      if (_trimmingLength >= 0) {
        _fractionAsStringWithoutZero = TextMod.removeNumberOfCharactersFromEndOfAString(
            string: _fractionAsStringWithoutZero,
            numberOfCharacters: _trimmingLength
        );
      }

    }

    return _fractionAsStringWithoutZero;
  }
  // --------------------
  /// AI TESTED
  static int? getNumberOfFractions({
    required double? number,
  }) {

    if (number == null) {
      return null;
    }

    else {

      if (number.toInt() == number) {
        return 0;
      }

      else {
        final double? _numberFraction = getFractions(
          number: number,
          fractionDigits: 100,
        );

        final String? _numberFractionsString = TextMod.removeTextBeforeFirstSpecialCharacter(
            text: _numberFraction?.toString(),
            specialCharacter: '.',
        );

        if (_numberFractionsString == null){
          return null;
        }
        else {
          return _numberFractionsString.trim().length;
        }

      }

    }

  }
  // --------------------
  /// AI TESTED
  static bool checkNumberAsStringHasMoreThanMaxDigits({
    required String? numberAsText,
    required int? maxDigits,
  }){
    bool _hasInvalidDigits = false;

    if (TextCheck.isEmpty(numberAsText) == false && maxDigits != null){

      final double? _double = transformStringToDouble(numberAsText);
      final int? _int = transformStringToInt(numberAsText);

      if (_double != _int){

        final String? _fractionsStrings = TextMod.removeTextBeforeFirstSpecialCharacter(
            text: numberAsText?.trim(),
            specialCharacter: '.',
        );
        if (_fractionsStrings != null && _fractionsStrings != ''){
          final int _numberOfFractions = _fractionsStrings.length;
          _hasInvalidDigits = _numberOfFractions > maxDigits;
        }

      }

    }

    return _hasInvalidDigits;
  }
  // -----------------------------------------------------------------------------

  /// CALCULATORS

  // --------------------
  /// AI TESTED
  static int? calculateDiscountPercentage({
    required double? oldPrice,
    required double? currentPrice,
  }) {
    if (oldPrice == null || currentPrice == null){
      return null;
    }
    else if (oldPrice == 0){
      return 0;
    }
    else {
      final double _percent = ((oldPrice - currentPrice) / oldPrice) * 100;
      return _percent.round();
    }
  }
  // --------------------
  /// AI TESTED
  static int calculateIntegerPower({
    required int? num,
    required int? power,
  }) {

      /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
      int _output = 1;

      if (num != null && power != null) {
        for (int i = 0; i < power; i++) {
          _output *= num;
        }
      }

      return _output;

  }
  // --------------------
  /// AI TESTED
  static double calculateDoublePower({
    required double? num,
    required int? power,
  }) {

    /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
    double _output = 1;

    if (num != null && power != null){
      for (int i = 0; i < power; i++) {
        _output *= num;
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ANGLES

  // --------------------
  /// AI TESTED
  static double?  degreeToRadian(double? degree){
    /// remember that dart starts from angle 0 on the right,, rotates clockWise when
    /// incrementing the angle degree,, while rotates counter clockwise when decrementing
    /// the angle degree.
    /// simply, Negative value goes counter ClockWise
    if (degree == null){
      return null;
    }
    else {
      return degree * ( math.pi / 180 );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? radianToDegree(double? radians) {
    if (radians == null) {
      return null;
    }
    else {
      return radians * (180 / math.pi);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? radianTo360Degree(double? radians) {

    final double? _degree = radianToDegree(radians);

    if (_degree == null){
      return null;
    }
    else if (_degree < 0){
      return 360 + _degree;
    }
    else {
      return _degree;
    }

}
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? degreeTo360Degree(double? degree) {

    if (degree == null){
      return null;
    }
    else if (degree < 0){
      return 360 + degree;
    }
    else {
      return degree;
    }

}
  // --------------------
  /// AI TESTED
  static double? move360Degree({
    required double? source360Degree,
    required double? moveBy360Degree,
  }) {

    if (source360Degree == null || moveBy360Degree == null) {
      return null;
    }

    else {

      final double _after = source360Degree + moveBy360Degree;

      if (_after < 0) {
        return 360 - (-_after % 360); // Correct the result for negative values
      }

      else if (_after >= 360) {
        return _after % 360; // Correct the result for values >= 360
      }

      else {
        return _after;
      }

    }
  }
  // -----------------------------------------------------------------------------

  /// BINARY SEARCH

  // --------------------
  /// AI TESTED
  static int? binarySearch({
    required List<int?>? list,
    required int? searchedValue,
  }) {

    if (list == null || list.isEmpty || searchedValue == null) {
      return null;
    }

    else {

      int _min = 0;
      int _max = list.length - 1;
      int? _output;

      while (_min <= _max) {

        final int _mid = ((_min + _max) / 2).floor();

        if (searchedValue == list[_mid]) {
          _output = _mid;
          break; // Exit the loop when the searched value is found
        }

        else if (searchedValue < list[_mid]!) {
          _max = _mid - 1;
        }

        else {
          _min = _mid + 1;
        }

      }

      return _output;
    }

  }
  // -----------------------------------------------------------------------------

  /// MODULUS

  // --------------------
  /// AI TESTED
  static double? modulus(double? num){
    double? _val;

    /// NOTE : GETS THE ABSOLUTE VALUE OF A DOUBLE

    if (num != null){
      _val = math.sqrt(calculateDoublePower(num: num, power: 2));
    }

    return _val;
  }
  // -----------------------------------------------------------------------------

  /// INDEX MANIPULATION

  // --------------------
  /// AI TESTED
  static int? reverseIndex({
    required int? listLength,
    required int? index,
  }) {

    if (listLength != null && index != null) {

      if (index + 1 <= listLength) {
        List<int> _indexes = <int>[];

        for (int i = 0; i < listLength; i++) {
          _indexes.add(i);
        }
        _indexes = _indexes.reversed.toList();

        final int _reversedIndex = _indexes.indexOf(index);

        return _reversedIndex;
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
  static int? getNextIndex({
    required int? listLength,
    required int? currentIndex,
    required bool loop,
  }){
    int? _output;

    if (listLength == null || currentIndex == null){
      _output = null;
    }
    else {

      final bool _isAtLast = currentIndex + 1 == listLength;

      /// AT LAST
      if (_isAtLast == true){

        if (loop == true){
          _output = 0;
        }
        else {
          _output = currentIndex;
        }

      }

      /// IN THE MIDDLE
      else {
        _output = currentIndex + 1;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PYTHAGORAS

  // --------------------
  /// AI TESTED
  static double? pythagorasHypotenuse({
    required double? side,
    double? side2,
  }) {

    if (side == null){
      return null;
    }

    else {
      /// side^2 * side^2 = hypotenuse^2
      final double _side2 = side2 ?? side;
      final double _sideSquared = Numeric.calculateDoublePower(num: side, power: 2);
      final double _side2Squared = Numeric.calculateDoublePower(num: _side2, power: 2);
      return math.sqrt(_sideSquared + _side2Squared);
    }

  }
  // -----------------------------------------------------------------------------

  /// DIVISION

  // --------------------
  ///
  static double divide({
    /// بسط
    required num? dividend,
    /// مقام
    required num? divisor,
  }){
    double _output = 0;

    if (dividend != null && divisor != null){
      _output = dividend / divisor;
    }

    return _output;
  }
  // --------------------
  ///
  static double? getDivisionRemainder({
    required double? dividend,
    required double? divisor
  }) {

    if (dividend == null || divisor == null){
      return null;
    }
    else {
      final double remainder = dividend % divisor; // Modulo operator to get the remainder
      return remainder;
    }
  }
  // --------------------
  ///
  static int? getDivisionQuotient({
    required double? dividend,
    required double? divisor
  }) {
    if (dividend == null || divisor == null){
      return null;
    }
    else {
      final int quotient = dividend ~/ divisor; // Integer division to get the quotient
      return quotient;
    }
  }
  // -----------------------------------------------------------------------------

  /// RANGER

  // --------------------
  /// AI TESTED
  static int? getClosestInt({
    required List<int> ints,
    required double value,
  }) {

    if (ints.isEmpty){
      return null;
    }
    else {
      int _closest = ints.first;
      final double _value = value;
      double difference = modulus(_value - _closest)!;

      for (final int in ints){

        final double _diff = modulus(_value - int)!;

        if (_diff < difference){
          difference = _diff;
          _closest = int;
        }

      }

      return _closest;
    }


}
  // -----------------------------------------------------------------------------

  /// COMPARISON OPERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isGreaterThan({
    required num? number,
    required num? isGreaterThan,
  }){
    bool _output = false;

    if (number != null && isGreaterThan != null){
      _output = number > isGreaterThan;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isLesserThan({
    required num? number,
    required num? isLesserThan,
  }){
    bool _output = false;

    if (number != null && isLesserThan != null){
      _output = number < isLesserThan;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
