import 'package:basics/helpers/strings/linker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('extractDomainFromUrl', () {
    test('URL with http and www', () {
      expect(Linker.extractWebsiteDomain(link:'http://www.example.com'), 'example.com');
    });

    test('URL with https and subdomain', () {
      expect(Linker.extractWebsiteDomain(link:'https://sub.example.com'), 'sub.example.com');
    });

    test('URL with path', () {
      expect(Linker.extractWebsiteDomain(link:'https://www.example.com/path'), 'example.com');
    });

    test('URL with port number', () {
      expect(Linker.extractWebsiteDomain(link:'http://example.com:8080'), 'example.com');
    });

    test('URL with trailing slash', () {
      expect(Linker.extractWebsiteDomain(link:'http://example.com/'), 'example.com');
    });

    test('URL without protocol', () {
      expect(Linker.extractWebsiteDomain(link:'www.example.com'), 'example.com');
    });

    test('URL with path and query parameters', () {
      expect(Linker.extractWebsiteDomain(link:'https://example.com/path?param=value'), 'example.com');
    });

    test('URL with protocol and no domain', () {
      expect(Linker.extractWebsiteDomain(link:'https://'), '');
    });


    test('Empty URL', () {
      expect(Linker.extractWebsiteDomain(link:''), null);
    });

    test('Invalid URL format', () {
      expect(Linker.extractWebsiteDomain(link:'invalid-url-format'), 'invalid-url-format');
    });
  });
}
