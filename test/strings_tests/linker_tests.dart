import 'package:basics/helpers/strings/linker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('extractDomainFromUrl', () {
    test('URL with http and www', () {
      expect(Linker.extractDomainFromWebLink(link:'http://www.example.com'), 'www.example.com');
    });

    test('URL with https and subdomain', () {
      expect(Linker.extractDomainFromWebLink(link:'https://sub.example.com'), 'sub.example.com');
    });

    test('URL with path', () {
      expect(Linker.extractDomainFromWebLink(link:'https://www.example.com/path'), 'www.example.com');
    });

    test('URL with port number', () {
      expect(Linker.extractDomainFromWebLink(link:'http://example.com:8080'), 'example.com');
    });

    test('URL with trailing slash', () {
      expect(Linker.extractDomainFromWebLink(link:'http://example.com/'), 'example.com');
    });

    test('URL without protocol', () {
      expect(Linker.extractDomainFromWebLink(link:'www.example.com'), 'www.example.com');
    });

    test('URL with path and query parameters', () {
      expect(Linker.extractDomainFromWebLink(link:'https://example.com/path?param=value'), 'example.com');
    });

    test('URL with protocol and no domain', () {
      expect(Linker.extractDomainFromWebLink(link:'https://'), '');
    });


    test('Empty URL', () {
      expect(Linker.extractDomainFromWebLink(link:''), null);
    });

    test('Invalid URL format', () {
      expect(Linker.extractDomainFromWebLink(link:'invalid-url-format'), 'invalid-url-format');
    });
  });
}
