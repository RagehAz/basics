import 'package:basics/models/phrase_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Phrase.getPhrasesIDs', () {

    test('Extracts ids from a list of phrases', () {
      final phrases = [
        const Phrase(value: 'a', id: '1'),
        const Phrase(value: 'b', id: '2'),
      ];
      expect(Phrase.getPhrasesIDs(phrases), ['1', '2']);
    });

    test('Deduplicates repeated ids, keeping first-occurrence order', () {
      final phrases = [
        const Phrase(value: 'a', id: '1'),
        const Phrase(value: 'b', id: '2'),
        const Phrase(value: 'c', id: '1'),
      ];
      expect(Phrase.getPhrasesIDs(phrases), ['1', '2']);
    });

    test('Skips phrases with a null id', () {
      final phrases = [
        const Phrase(value: 'a', id: '1'),
        const Phrase(value: 'b', id: null),
        const Phrase(value: 'c', id: '2'),
      ];
      expect(Phrase.getPhrasesIDs(phrases), ['1', '2']);
    });

    test('Returns an empty list for a null phrases list', () {
      expect(Phrase.getPhrasesIDs(null), <String>[]);
    });

    test('Returns an empty list for an empty phrases list', () {
      expect(Phrase.getPhrasesIDs([]), <String>[]);
    });

    test('Returns an empty list when every phrase has a null id', () {
      final phrases = [
        const Phrase(value: 'a', id: null),
        const Phrase(value: 'b', id: null),
      ];
      expect(Phrase.getPhrasesIDs(phrases), <String>[]);
    });

    test('Preserves order across a longer list with scattered duplicates', () {
      final phrases = [
        const Phrase(value: 'a', id: '3'),
        const Phrase(value: 'b', id: '1'),
        const Phrase(value: 'c', id: '2'),
        const Phrase(value: 'd', id: '1'),
        const Phrase(value: 'e', id: '3'),
      ];
      expect(Phrase.getPhrasesIDs(phrases), ['3', '1', '2']);
    });

  });

}
