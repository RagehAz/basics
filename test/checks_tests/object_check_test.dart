import 'dart:io';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:flutter_test/flutter_test.dart';

void main (){

  group('ObjectCheck.isAbsoluteURL Tests', () {
    // Test valid absolute URLs
    test('Valid URL with https scheme', () {
      expect(ObjectCheck.isAbsoluteURL('https://www.bldrs.net/#/terms'), true);
    });

    test('Valid URL with http scheme', () {
      expect(ObjectCheck.isAbsoluteURL('http://example.com'), true);
    });

    // Test URL with missing scheme
    test('URL with missing scheme', () {
      expect(ObjectCheck.isAbsoluteURL('www.example.com'), false);
    });

    // Test relative URL
    test('Relative URL (not absolute)', () {
      expect(ObjectCheck.isAbsoluteURL('/path/to/resource'), false);
    });

    // Test null input
    test('Null input should return false', () {
      expect(ObjectCheck.isAbsoluteURL(null), false);
    });

    // Test non-string input
    test('Non-string input (integer)', () {
      expect(ObjectCheck.isAbsoluteURL(12345), false);
    });

    // Test URL with spaces
    test('URL with leading/trailing spaces', () {
      expect(ObjectCheck.isAbsoluteURL('   https://example.com  '), true);
    });

    // Test empty string
    test('Empty string should return false', () {
      expect(ObjectCheck.isAbsoluteURL(''), false);
    });

    test('is url ObjectCheck.isAbsoluteURL(pic)', () {
      // Arrange
      const pic = 'https://firebasestorage.googleapis.com/v0/b/talktohumanity.appspot.com/o/talkersImages%2F-NQ_uNna_EFbzRUW9WVQ?alt=media&token=7d18800f-a4db-451c-88ad-e1204e76c247';

      // Act
      final bool result = ObjectCheck.isAbsoluteURL(pic);

      // Assert
      expect(result, true);
    });

    test('is url ObjectCheck.isAbsoluteURL(pic)', () {
      // Arrange
      const pic = 'https://firebasestorage.googleapis.com/v0/b/talktohumanity.appspot.com/o/talkersImages%2F-NQ_uNna_EFbzRUW9WVQ?alt=media&token=7d18800f-a4db-451c-88ad-e1204e76c247';

      // Act
      final bool result = ObjectCheck.isAbsoluteURL(pic);

      // Assert
      expect(result, true);
    });

    // ---

    // Test uncommon URL scheme (ftp)
    test('Valid URL with ftp scheme', () {
      expect(ObjectCheck.isAbsoluteURL('ftp://ftp.example.com/file.zip'), true);
    });

    // Test URL with mailto scheme
    test('Valid URL with mailto scheme', () {
      expect(ObjectCheck.isAbsoluteURL('mailto:someone@example.com'), true);
    });

    // Test URL with file scheme
    test('Valid URL with file scheme', () {
      expect(ObjectCheck.isAbsoluteURL('file:///home/user/file.txt'), true);
    });

    // Test data URL scheme
    test('Valid data URL scheme', () {
      expect(ObjectCheck.isAbsoluteURL('data:text/plain;base64,SGVsbG8sIFdvcmxkIQ=='), true);
    });

    // Test URL with internationalized domain name (IDN)
    test('Valid URL with internationalized domain name', () {
      expect(ObjectCheck.isAbsoluteURL('http://xn--fsq.com'), true); // Equivalent to http://例.com
    });

    // Test URL with port number
    test('Valid URL with port number', () {
      expect(ObjectCheck.isAbsoluteURL('https://example.com:8080/path'), true);
    });

    // Test URL with query parameters
    test('Valid URL with query parameters', () {
      expect(ObjectCheck.isAbsoluteURL('https://example.com/path?name=value'), true);
    });

    // Test URL with complex query parameters
    test('Valid URL with complex query parameters', () {
      expect(ObjectCheck.isAbsoluteURL('https://example.com/path?name=value&key=val#section'), true);
    });

    // Test URL with unusual but valid scheme
    test('Uncommon but valid scheme (custom scheme)', () {
      expect(ObjectCheck.isAbsoluteURL('customscheme://example.com'), true);
    });

    // Test invalid URL scheme
    test('Invalid URL scheme (invalid characters)', () {
      expect(ObjectCheck.isAbsoluteURL('ht@tp://example.com'), false);
    });

    // Test URL with multiple slashes after scheme
    test('URL with multiple slashes after scheme', () {
      expect(ObjectCheck.isAbsoluteURL('https:///example.com'), false); // Incorrect number of slashes
    });

    // Test URL with user info
    test('Valid URL with user info', () {
      expect(ObjectCheck.isAbsoluteURL('https://user:pass@example.com'), true);
    });

    // Test URL with IPv6 address
    test('Valid URL with IPv6 address', () {
      expect(ObjectCheck.isAbsoluteURL('http://[2001:db8::1]:8080'), true);
    });


  });

  group('fileExtensionOf', () {

    test('should return null when file is null', () {
      final result = FileExtensioning.getExtensionFromPath(null);
      expect(result, isNull);
    });

    test('should return the file extension when file is a string', () {
      final result = FileExtensioning.getExtensionFromPath('example.txt');
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
      final result = FileExtensioning.getExtensionFromPath('example.txt');
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

  group('fileExtensionOf', () {

    test('should return null when file is null', () {
      final result = FileExtensioning.getExtensionFromPath(null);
      expect(result, isNull);
    });

    test('should return the file extension when file is a string', () {
      final result = FileExtensioning.getExtensionFromPath('example.txt');
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
      final result = FileExtensioning.getExtensionFromPath('example.txt');
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
