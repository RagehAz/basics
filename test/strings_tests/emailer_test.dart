import 'package:basics/helpers/strings/emailer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Emailer.extractEmailsDomains', () {

    test('Extracts domains from a list of emails', () {
      final result = Emailer.extractEmailsDomains(emails: ['a@gmail.com', 'b@yahoo.com']);
      expect(result, ['gmail.com', 'yahoo.com']);
    });

    test('Deduplicates repeated domains, keeping first-occurrence order', () {
      final result = Emailer.extractEmailsDomains(emails: ['a@gmail.com', 'b@yahoo.com', 'c@gmail.com']);
      expect(result, ['gmail.com', 'yahoo.com']);
    });

    test('Deduplicates case-insensitively (lowercased before comparison)', () {
      final result = Emailer.extractEmailsDomains(emails: ['a@Gmail.com', 'b@GMAIL.COM', 'c@gmail.com']);
      expect(result, ['gmail.com']);
    });

    test('Skips entries with no @ character', () {
      final result = Emailer.extractEmailsDomains(emails: ['not-an-email', 'a@gmail.com']);
      expect(result, ['gmail.com']);
    });

    test('Returns an empty list for an empty input list', () {
      final result = Emailer.extractEmailsDomains(emails: []);
      expect(result, <String>[]);
    });

    test('Preserves the order domains first appear in', () {
      final result = Emailer.extractEmailsDomains(emails: ['a@zeta.com', 'b@alpha.com', 'c@zeta.com']);
      expect(result, ['zeta.com', 'alpha.com']);
    });

  });

}
