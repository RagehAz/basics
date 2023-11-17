import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('isBase64 function:', () {

    test('Valid Base64 string should return true', () {
      expect(ObjectCheck.isBase64('SGVsbG8gd29ybGQh'), isTrue);
    });

    test('Non-Base64 string should return false', () {
      expect(ObjectCheck.isBase64('Hello world!'), isFalse);
    });

    test('Empty string should return false', () {
      expect(ObjectCheck.isBase64(''), isFalse);
    });

    test('Empty string should return false', () {
      expect(ObjectCheck.isBase64(' '), isFalse);
    });

    test('From string should not be base64', () {
      // expect(ObjectCheck.isBase64('From'), isFalse);
      expect(ObjectCheck.isBase64('Fromx'), isFalse);
      // expect(ObjectCheck.isBase64('from'), isFalse);
      expect(ObjectCheck.isBase64('pROM'), isFalse);
      expect(ObjectCheck.isBase64('FrOom'), isFalse);

    });

    test('Invalid Base64 string should return false', () {
      // Inserting an invalid character '!' in the middle of a valid Base64 string
      expect(ObjectCheck.isBase64('SGVsbG8gd29y!bGQh'), isFalse);
    });

    test('Invalid Base64 string should return false', () {
      // Inserting an invalid character '!' in the middle of a valid Base64 string
      expect(ObjectCheck.isBase64('xxyxxyxxy'), isFalse);
    });

    test('Null input should return false', () {
      expect(ObjectCheck.isBase64(null), isFalse);
    });

  });

}
