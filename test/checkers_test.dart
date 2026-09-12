import 'package:basics/helpers/checks/object_check.dart';
import 'package:flutter_test/flutter_test.dart';

// void main() {
//
//   group('isBase64 function:', () {
//
//     test('Valid Base64 string should return true', () {
//       expect(ObjectCheck.isBase64('SGVsbG8gd29ybGQh'), isTrue);
//     });
//
//     test('Non-Base64 string should return false', () {
//       expect(ObjectCheck.isBase64('Hello world!'), isFalse);
//     });
//
//     test('Empty string should return false', () {
//       expect(ObjectCheck.isBase64(''), isFalse);
//     });
//
//     test('Empty string should return false', () {
//       expect(ObjectCheck.isBase64(' '), isFalse);
//     });
//
//     test('From string should not be base64', () {
//       // expect(ObjectCheck.isBase64('From'), isFalse);
//       expect(ObjectCheck.isBase64('Fromx'), isFalse);
//       // expect(ObjectCheck.isBase64('from'), isFalse);
//       expect(ObjectCheck.isBase64('pROM'), isFalse);
//       expect(ObjectCheck.isBase64('FrOom'), isFalse);
//
//     });
//
//     test('Invalid Base64 string should return false', () {
//       // Inserting an invalid character '!' in the middle of a valid Base64 string
//       expect(ObjectCheck.isBase64('SGVsbG8gd29y!bGQh'), isFalse);
//     });
//
//     test('Invalid Base64 string should return false', () {
//       // Inserting an invalid character '!' in the middle of a valid Base64 string
//       expect(ObjectCheck.isBase64('xxyxxyxxy'), isFalse);
//     });
//
//     test('Null input should return false', () {
//       expect(ObjectCheck.isBase64(null), isFalse);
//     });
//
//   });
//
// }

enum UserProfileType {
  privateProfile,
  sportEntity;

  factory UserProfileType.fromString(String string){
    switch (string){
      case 'private_profile': return UserProfileType.privateProfile;
      case 'sport_entity': return UserProfileType.sportEntity;
      default: throw UnimplementedError();
    }
  }

  @override
  String toString() => switch (this) {
    UserProfileType.privateProfile => 'private_profile',
    UserProfileType.sportEntity => 'sport_entity',
  };

}

void main(){

  test('Null input should return false', () {
  expect(ObjectCheck.isBase64(null), isFalse);
});

}
