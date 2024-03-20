import 'dart:io';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:flutter_test/flutter_test.dart';

void main (){

  test('is url ObjectCheck.isAbsoluteURL(pic)', () {
    // Arrange
    const pic =
        'https://firebasestorage.googleapis.com/v0/b/talktohumanity.appspot.com/o/talkersImages%2F-NQ_uNna_EFbzRUW9WVQ?alt=media&token=7d18800f-a4db-451c-88ad-e1204e76c247';

    // Act
    final bool result = ObjectCheck.isAbsoluteURL(pic);

    // Assert
    expect(result, true);
  });

  group('fileExtensionOf', () {

    test('should return null when file is null', () {
      final result = FileTyper.getExtension(object: null);
      expect(result, isNull);
    });

    test('should return the file extension when file is a string', () {
      final result = FileTyper.getExtension(object: 'example.txt');
      expect(result, 'txt');
    });

    test('should return the file extension when file is a File object', () {
      final file = File('path/to/example.jpg');
      final result = file.extension;
      expect(result, 'jpg');
    });

    // test('should return null when file is null', () {
    //   final result = ObjectCheck.fileExtensionOf(null);
    //   expect(result, isNull);
    //   expect(result, File(null)?.fileExtension);
    // });

    test('should return the file extension when file is a string', () {
      final result = FileTyper.getExtension(object: 'example.txt');
      expect(result, 'txt');
      expect(result, File('example.txt').extension);
    });

    test('should return the file extension when file is a File object', () {
      final file = File('path/to/example.jpg');
      final result = file.extension;
      expect(result, 'jpg');
      expect(result, file.extension);
    });

  });

  test('is url ObjectCheck.isAbsoluteURL(pic)', () {
    // Arrange
    const pic =
        'https://firebasestorage.googleapis.com/v0/b/talktohumanity.appspot.com/o/talkersImages%2F-NQ_uNna_EFbzRUW9WVQ?alt=media&token=7d18800f-a4db-451c-88ad-e1204e76c247';

    // Act
    final bool result = ObjectCheck.isAbsoluteURL(pic);

    // Assert
    expect(result, true);
  });

  group('objectIsPicPath', () {
    test('should return false for null object', () {
      const String? object = null;
      final bool result = ObjectCheck.objectIsPicPath(object);
      expect(result, false);
    });

    test('should return false for non-string object', () {
      const dynamic object = 123;
      final bool result = ObjectCheck.objectIsPicPath(object);
      expect(result, false);
    });

    test('should return false for empty string', () {
      const String object = '';
      final bool result = ObjectCheck.objectIsPicPath(object);
      expect(result, false);
    });

    test('should return false for string without "storage/" prefix', () {
      const String object = 'path/to/image.jpg';
      final bool result = ObjectCheck.objectIsPicPath(object);
      expect(result, false);
    });

    test('should return true for string with "storage/" prefix', () {
      const String object = 'storage/image.jpg';
      final bool result = ObjectCheck.objectIsPicPath(object);
      expect(result, true);
    });

    test('should return true for string with "storage/" prefix and additional characters', () {
      const String object = 'storage/path/to/image.jpg';
      final bool result = ObjectCheck.objectIsPicPath(object);
      expect(result, true);
    });
  });

  group('fileExtensionOf', () {

    test('should return null when file is null', () {
      final result = FileTyper.getExtension(object: null);
      expect(result, isNull);
    });

    test('should return the file extension when file is a string', () {
      final result = FileTyper.getExtension(object: 'example.txt');
      expect(result, 'txt');
    });

    test('should return the file extension when file is a File object', () {
      final file = File('path/to/example.jpg');
      final result = file.extension;
      expect(result, 'jpg');
    });

    // test('should return null when file is null', () {
    //   final result = ObjectCheck.fileExtensionOf(null);
    //   expect(result, isNull);
    //   expect(result, File(null)?.fileExtension);
    // });

    test('should return the file extension when file is a string', () {
      final result = FileTyper.getExtension(object: 'example.txt');
      expect(result, 'txt');
      expect(result, File('example.txt').extension);
    });



    test('should return the file extension when file is a File object', () {
      final file = File('path/to/example.jpg');
      final result = file.extension;
      expect(result, 'jpg');
      expect(result, file.extension);
    });

  });

}
