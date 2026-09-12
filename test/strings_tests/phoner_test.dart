import 'package:basics/helpers/strings/phoner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// cleanNumber

  // --------------------
  group('Phoner.cleanNumber', () {

    test('Strips parentheses, dots, dashes, spaces and zerofies-to-plus a leading 00', () {
      final result = Phoner.cleanNumber(phone: '00 (20) 100.200-300');
      expect(result, '+20100200300');
    });

    test('Strips parentheses, spaces and dashes from a plain local number', () {
      final result = Phoner.cleanNumber(phone: '(555) 123-4567');
      expect(result, '5551234567');
    });

    test('Cleans a WhatsApp tel: link (removes %20) and keeps a leading +', () {
      final result = Phoner.cleanNumber(phone: 'tel:+1%20555%20123');
      expect(result, '+1555123');
    });

    test('Strips internal spaces from an already-plusified number', () {
      final result = Phoner.cleanNumber(phone: '+20 100 200 300');
      expect(result, '+20100200300');
    });

    test('Leaves a number starting with a single 0 untouched (not zerofied)', () {
      final result = Phoner.cleanNumber(phone: '020100200300');
      expect(result, '020100200300');
    });

    test('Returns null when phone is null', () {
      final result = Phoner.cleanNumber(phone: null);
      expect(result, isNull);
    });

    test('Returns null when phone is an empty string', () {
      final result = Phoner.cleanNumber(phone: '');
      expect(result, isNull);
    });

    test('Returns null when phone is only whitespace', () {
      final result = Phoner.cleanNumber(phone: '  ');
      expect(result, isNull);
    });

  });
  // -----------------------------------------------------------------------------

  /// cleanNumbers

  // --------------------
  group('Phoner.cleanNumbers', () {

    test('Cleans every phone in the list', () {
      final result = Phoner.cleanNumbers(phones: ['(555) 123-4567', '00 20 100 200 300']);
      expect(result, ['5551234567', '+20100200300']);
    });

    test('Returns an empty list when phones is null', () {
      final result = Phoner.cleanNumbers(phones: null);
      expect(result, <String>[]);
    });

    test('Returns an empty list when phones is empty', () {
      final result = Phoner.cleanNumbers(phones: <String>[]);
      expect(result, <String>[]);
    });

    test('Skips entries that clean to null', () {
      final result = Phoner.cleanNumbers(phones: ['(555) 123-4567', '', '  ']);
      expect(result, ['5551234567']);
    });

  });
  // -----------------------------------------------------------------------------

  /// isZerofied / isPlusified

  // --------------------
  group('Phoner.isZerofied', () {

    test('Returns true for a number starting with 00', () {
      expect(Phoner.isZerofied('0020100'), true);
    });

    test('Returns false for a plusified number', () {
      expect(Phoner.isZerofied('+20100'), false);
    });

    test('Returns false for a number starting with a single 0', () {
      expect(Phoner.isZerofied('020100'), false);
    });

  });
  // --------------------
  group('Phoner.isPlusified', () {

    test('Returns true for a number starting with +', () {
      expect(Phoner.isPlusified('+20100'), true);
    });

    test('Returns false for a zerofied number', () {
      expect(Phoner.isPlusified('0020100'), false);
    });

  });
  // -----------------------------------------------------------------------------

  /// zerofyPhone / plusifyPhone

  // --------------------
  group('Phoner.zerofyPhone', () {

    test('Converts a plusified number to a zerofied one', () {
      final result = Phoner.zerofyPhone(phone: '+20100');
      expect(result, '0020100');
    });

    test('Leaves an already-zerofied (non-plusified) number untouched', () {
      final result = Phoner.zerofyPhone(phone: '020100');
      expect(result, '020100');
    });

  });
  // --------------------
  group('Phoner.plusifyPhone', () {

    test('Converts a zerofied number to a plusified one', () {
      final result = Phoner.plusifyPhone(phone: '0020100');
      expect(result, '+20100');
    });

    test('Leaves an already-plusified number untouched', () {
      final result = Phoner.plusifyPhone(phone: '+20100');
      expect(result, '+20100');
    });

  });
}
