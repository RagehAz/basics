import 'package:basics/helpers/strings/text_find.dart';
import 'package:flutter_test/flutter_test.dart';

// write a flutter test group that includes several tests for following function
void main(){
  // -----------------------------------------------------------------------------

  /// hashtags

  // --------------------
  group('TextFind.findHashtags', () {

    test('Returns an empty list when text is null', () {
      final List<String> result = TextFind.hashtags(
        text: null,
      );
      expect(result, []);
    });

    test('Returns an empty list when text is an empty string', () {
      final List<String> result = TextFind.hashtags(
        text: '',
      );
      expect(result, isEmpty);
    });

    test('Returns an empty list when no hashtags are present', () {
      final List<String> result = TextFind.hashtags(
        text: 'This is a sample text without hashtags.',
      );
      expect(result, []);
    });

    test('Returns a list with hashtags when considerDash is true and removeHash is false', () {
      final List<String> result = TextFind.hashtags(
        text: 'This is a sample text with #hashtags and #multiple-dash-tags.',
        // considerDash: true, // default
        // removeHash: false, // default
      );
      expect(result, equals(['#hashtags', '#multiple-dash-tags']));
    });

    test('test', () {
      final List<String> result = TextFind.hashtags(
        text: 'This is a sample text with #hashtags and #multiple-dash-tags.',
        considerDash: false,
        // removeHash: false, // default
      );
      expect(result, equals(['#hashtags', '#multiple']));
    });

    test('Returns a list without the hash symbol when considerDash is true and removeHash is true', () {
      final List<String> result = TextFind.hashtags(
        text: 'This is a sample text with #hashtags and #multiple-dash-tags.',
        // considerDash: true, // default
        removeHash: true,
      );
      expect(result, equals(['hashtags', 'multiple-dash-tags']));
    });

    test('Returns a list with hashtags when considerDash is false and removeHash is true', () {
      final List<String> result = TextFind.hashtags(
        text: 'This is a sample text with #hashtags and #multiple-dash-tags.',
        considerDash: false,
        removeHash: true,
      );
      expect(result, equals(['hashtags', 'multiple']));
    });
  });
  // -----------------------------------------------------------------------------

  /// EMAILS

  // --------------------
  group('TextFind.emails', () {

    // Test for empty input text
    test('Empty text should return empty list', () {
      expect(TextFind.emails(text: ''), isEmpty);
    });

    // Test for text without any email addresses
    test('Text without emails should return empty list', () {
      expect(TextFind.emails(text: 'This is a test'), isEmpty);
    });

    // Test for text with a single valid email address
    test('Text with one valid email should return that email', () {
      expect(TextFind.emails(text: 'Email me at test@example.com'), equals(['test@example.com']));
    });

    // Test for text with multiple valid email addresses
    test('Text with multiple valid emails should return all emails', () {
      expect(TextFind.emails(text: 'Contact us at info@example.com or support@test.com'), equals(['info@example.com', 'support@test.com']));
    });

    // Test for text with invalid email format
    test('Text with invalid email format should return empty list', () {
      expect(TextFind.emails(text: 'Invalid email addresses: test@.com and @example.com'), isEmpty);
    });

    // Test for text with email-like patterns but not valid emails
    test('Text with email-like patterns but not valid emails should return empty list', () {
      expect(TextFind.emails(text: 'This is not an email: username@example'), isEmpty);
    });

    // Test for text containing emails within longer words
    test('Text with emails embedded in words should return valid emails', () {
      expect(TextFind.emails(text: 'Embedded emails: test@example.com within a word'), equals(['test@example.com']));
    });

    // Test for text containing emails with longer domain names
    test('Text with emails having longer domain names should return valid emails', () {
      expect(TextFind.emails(text: 'Emails with longer domain: user@verylongdomainname.com'), equals(['user@verylongdomainname.com']));
    });

    // Test for text with email addresses preceded or followed by special characters
    test('Text with emails surrounded by special characters should return valid emails', () {
      expect(TextFind.emails(text: 'Special characters: (email@example.com)!'), equals(['email@example.com']));
    });

    // Test for text with emails containing non-alphanumeric characters
    test('Text with emails containing non-alphanumeric characters should return valid emails', () {
      expect(TextFind.emails(text: 'Emails with non-alphanumeric: user_name123@example.com'), equals(['user_name123@example.com']));
    });

  });
  // -----------------------------------------------------------------------------

  /// URLS

  // --------------------
  group('TextFind.urls', () {

    // Test for empty input text
    test('Empty text should return empty list', () {
      expect(TextFind.urls(text: ''), isEmpty);
    });

    // Test for text without any URLs
    test('Text without URLs should return empty list', () {
      expect(TextFind.urls(text: 'This is a test'), isEmpty);
    });

    // Test for text with a single valid URL
    test('Text with one valid URL should return that URL', () {
      expect(TextFind.urls(text: 'Visit our website: https://example.com'), equals(['https://example.com']));
    });

    // Test for text with multiple valid URLs
    test('Text with multiple valid URLs should return all URLs', () {
      expect(TextFind.urls(text: 'Explore more at https://example.com and https://test.com'), equals(['https://example.com', 'https://test.com']));
    });

    // Test for text with invalid URL format
    test('Text with invalid URL format should return empty list', () {
      expect(TextFind.urls(text: 'Invalid URLs: https://.com and http://example'), isEmpty);
    });

    // Test for text with URL-like patterns but not valid URLs
    test('Text with URL-like patterns but not valid URLs should return empty list', () {
      expect(TextFind.urls(text: 'This is not a URL: www.example'), isEmpty);
    });

    // Test for text containing URLs within longer words
    test('Text with URLs embedded in words should return valid URLs', () {
      expect(TextFind.urls(text: 'Embedded URLs: https://example.com within a word'), equals(['https://example.com']));
    });

    // Test for text containing URLs with longer domain names
    test('Text with URLs having longer domain names should return valid URLs', () {
      expect(TextFind.urls(text: 'URLs with longer domain: https://verylongdomainname.com'), equals(['https://verylongdomainname.com']));
    });

    // Test for text with URLs preceded or followed by special characters
    test('Text with URLs surrounded by special characters should return valid URLs', () {
      expect(TextFind.urls(text: 'Special characters: (https://example.com)!'), equals(['https://example.com']));
    });

    // Test for text with URLs containing query parameters
    test('Text with URLs containing query parameters should return valid URLs', () {
      expect(TextFind.urls(text: 'URLs with query parameters: https://example.com/search?q=test'), equals(['https://example.com/search?q=test']));
    });

    // Test for text with URLs containing non-http(s) schemes
    test('Text with URLs using non-http(s) schemes should return valid URLs', () {
      expect(TextFind.urls(text: 'URLs with other schemes: ftp://example.com and mailto:user@example.com'), equals([]));
    });

  });
  // -----------------------------------------------------------------------------

  /// phones

  // --------------------
  group('TextFind.phoneNumbers', () {

    test('Extracts phone number without country code', () {
      final List<String> result = TextFind.phones(text: 'Contact me at 1234567890');
      expect(result, contains('1234567890'));
    });

    test('Extracts phone number with country code', () {
      final List<String> result = TextFind.phones(text: 'Call +1234567890');
      expect(result, contains('001234567890'));
    });


    test('Ignores non-phone numbers', () {
      final List<String> result = TextFind.phones(text: 'No phone numbers here');
      expect(result, isEmpty);
    });


    test('Handles multiple phone numbers in text', () {
      final List<String> result = TextFind.phones(text: 'Call 123-456-7890 or +9876543210');
      expect(result, contains('1234567890'));
      expect(result, contains('009876543210'));
    });

    test('Replaces specified characters in text', () {
      final List<String> result = TextFind.phones(text: 'Contact me at 12-34-56-7890');
      expect(result, contains('1234567890'));
    });

    test('Ignores malformed phone numbers', () {
      final List<String> result = TextFind.phones(text: 'Invalid number 12345');
      expect(result, isEmpty);
    });

    test('Extracts phone number with special characters', () {
      final List<String> result = TextFind.phones(text: 'Reach me at 123-456-7890');
      expect(result, contains('1234567890'));
    });

    test('Handles complex input with different replacements', () {
      final List<String> result = TextFind.phones(text: 'Text: 123-45-67890 and 987654321');
      expect(result, contains('1234567890'));
      expect(result, contains('987654321'));
    });

  });
  // -----------------------------------------------------------------------------
}
