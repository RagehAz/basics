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

  group('extractWebsitesDomains', () {
    test('Extracts domains from a list of links', () {
      final result = Linker.extractWebsitesDomains(links: ['https://www.example.com', 'https://sub.other.com']);
      expect(result, ['example.com', 'sub.other.com']);
    });

    test('Deduplicates repeated domains, keeping first-occurrence order', () {
      final result = Linker.extractWebsitesDomains(links: ['https://example.com/a', 'https://other.com', 'https://example.com/b']);
      expect(result, ['example.com', 'other.com']);
    });

    test('Skips empty links that resolve to null domains', () {
      final result = Linker.extractWebsitesDomains(links: ['', 'https://example.com']);
      expect(result, ['example.com']);
    });

    test('Returns an empty list for an empty input list', () {
      final result = Linker.extractWebsitesDomains(links: []);
      expect(result, <String>[]);
    });

    test('Treats differently-cased domains as distinct (case-sensitive)', () {
      final result = Linker.extractWebsitesDomains(links: ['https://Example.com', 'https://example.com']);
      expect(result, ['Example.com', 'example.com']);
    });

    test('Returns a single-element list for one link', () {
      final result = Linker.extractWebsitesDomains(links: ['https://example.com']);
      expect(result, ['example.com']);
    });

    test('Preserves order across a longer list with scattered duplicates', () {
      final result = Linker.extractWebsitesDomains(links: [
        'https://zeta.com',
        'https://alpha.com',
        'https://zeta.com/path',
        'https://beta.com',
      ]);
      expect(result, ['zeta.com', 'alpha.com', 'beta.com']);
    });
  });
}
