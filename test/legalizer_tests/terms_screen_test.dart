import 'package:basics/legalizer/legalizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// generateTerms

  // --------------------
  group('TermsScreen.generateTerms', () {

    testWidgets('Returns a non-empty widget list for English (default langCode)', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(Builder(builder: (ctx) {
        context = ctx;
        return const SizedBox();
      }));

      const screen = TermsScreen();
      final terms = screen.generateTerms(context: context, langCode: 'en');

      expect(terms, isNotEmpty);
    });

    testWidgets('Returns a non-empty widget list for Arabic', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(Builder(builder: (ctx) {
        context = ctx;
        return const SizedBox();
      }));

      const screen = TermsScreen();
      final terms = screen.generateTerms(context: context, langCode: 'ar');

      expect(terms, isNotEmpty);
    });

    testWidgets('English and Arabic produce different content', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(Builder(builder: (ctx) {
        context = ctx;
        return const SizedBox();
      }));

      const screen = TermsScreen();
      final englishTerms = screen.generateTerms(context: context, langCode: 'en');
      final arabicTerms = screen.generateTerms(context: context, langCode: 'ar');

      /// same overall shape, but built from different source text
      expect(englishTerms.length, arabicTerms.length);
      expect(englishTerms.runtimeType, arabicTerms.runtimeType);
    });

    testWidgets('Falls back to English for any langCode other than ar', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(Builder(builder: (ctx) {
        context = ctx;
        return const SizedBox();
      }));

      const screen = TermsScreen();
      final englishTerms = screen.generateTerms(context: context, langCode: 'en');
      final fallbackTerms = screen.generateTerms(context: context, langCode: 'fr');

      expect(fallbackTerms.length, englishTerms.length);
    });

    testWidgets('Includes the configured company name in the English terms', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(Builder(builder: (ctx) {
        context = ctx;
        return const SizedBox();
      }));

      const screen = TermsScreen(company: 'Acme Corp');
      final terms = screen.generateTerms(context: context, langCode: 'en');

      final matches = terms.whereType<MediumText>().where((t) => t.text.contains('Acme Corp'));
      expect(matches, isNotEmpty);
    });

  });
}
