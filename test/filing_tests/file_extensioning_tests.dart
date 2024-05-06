import 'package:basics/filing/filing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('FileExtensioning - checkNameHasExtension method', () {

    test('Null fileName should return false', () {
      expect(FileExtensioning.checkNameHasExtension(null), false);
    });

    test('Empty fileName should return false', () {
      expect(FileExtensioning.checkNameHasExtension(''), false);
    });

    test('FileName without extension should return false', () {
      expect(FileExtensioning.checkNameHasExtension('filename'), false);
    });

    test('FileName with only dot should return false', () {
      expect(FileExtensioning.checkNameHasExtension('.'), false);
    });

    test('FileName with valid extension should return true', () {
      expect(FileExtensioning.checkNameHasExtension('filename.txt'), true);
    });

    test('FileName with multiple dots and valid extension should return true', () {
      expect(FileExtensioning.checkNameHasExtension('my.file.name.txt'), true);
    });

    test('FileName with leading dots and valid extension should return true', () {
      expect(FileExtensioning.checkNameHasExtension('.hiddenfile.txt'), true);
    });

  });

}
