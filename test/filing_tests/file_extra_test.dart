import 'dart:io';
import 'dart:typed_data';
import 'package:basics/filing/filing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {

  late Directory _tempDir;

  setUp(() {
    _tempDir = Directory.systemTemp.createTempSync('file_extra_test');
  });

  tearDown(() {
    if (_tempDir.existsSync()) {
      _tempDir.deleteSync(recursive: true);
    }
  });

  File _writeTempFile(String name, int byteCount) {
    final file = File(path.join(_tempDir.path, name));
    file.writeAsBytesSync(Uint8List(byteCount));
    return file;
  }

  group('File.readSize', () {

    test('Returns the exact byte count in FileSizeUnit.byte', () async {
      final file = _writeTempFile('a.bin', 12345);
      final size = await file.readSize(fileSizeUnit: FileSizeUnit.byte);
      expect(size, 12345);
    });

    test('Converts to kilobytes correctly', () async {
      final file = _writeTempFile('b.bin', 2048);
      final size = await file.readSize(fileSizeUnit: FileSizeUnit.kiloByte);
      expect(size, 2);
    });

    test('Converts to megabytes correctly (default unit)', () async {
      final file = _writeTempFile('c.bin', 1024 * 1024 * 3);
      final size = await file.readSize();
      expect(size, 3);
    });

    test('Returns 0 for an empty file', () async {
      final file = _writeTempFile('empty.bin', 0);
      final size = await file.readSize(fileSizeUnit: FileSizeUnit.byte);
      expect(size, 0);
    });

    test('Returns null for a file that does not exist', () async {
      final file = File(path.join(_tempDir.path, 'does_not_exist.bin'));
      final size = await file.readSize(fileSizeUnit: FileSizeUnit.byte);
      expect(size, isNull);
    });

    test('Matches the actual file length exactly for a larger file', () async {
      const byteCount = 500000;
      final file = _writeTempFile('large.bin', byteCount);
      final size = await file.readSize(fileSizeUnit: FileSizeUnit.byte);
      expect(size, byteCount.toDouble());
    });

  });

}
