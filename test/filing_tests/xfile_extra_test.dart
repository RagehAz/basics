import 'dart:io';
import 'dart:typed_data';
import 'package:basics/filing/filing.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {

  late Directory _tempDir;

  setUp(() {
    _tempDir = Directory.systemTemp.createTempSync('xfile_extra_test');
  });

  tearDown(() {
    if (_tempDir.existsSync()) {
      _tempDir.deleteSync(recursive: true);
    }
  });

  XFile _writeTempXFile(String name, int byteCount) {
    final file = File(path.join(_tempDir.path, name));
    file.writeAsBytesSync(Uint8List(byteCount));
    return XFile(file.path);
  }

  group('XFile.readSize', () {

    test('Returns the exact byte count in FileSizeUnit.byte', () async {
      final xFile = _writeTempXFile('a.bin', 12345);
      final size = await xFile.readSize(fileSizeUnit: FileSizeUnit.byte);
      expect(size, 12345);
    });

    test('Converts to kilobytes correctly', () async {
      final xFile = _writeTempXFile('b.bin', 2048);
      final size = await xFile.readSize(fileSizeUnit: FileSizeUnit.kiloByte);
      expect(size, 2);
    });

    test('Converts to megabytes correctly (default unit)', () async {
      final xFile = _writeTempXFile('c.bin', 1024 * 1024 * 3);
      final size = await xFile.readSize();
      expect(size, 3);
    });

    test('Returns 0 for an empty file', () async {
      final xFile = _writeTempXFile('empty.bin', 0);
      final size = await xFile.readSize(fileSizeUnit: FileSizeUnit.byte);
      expect(size, 0);
    });

    test('Returns null for a file that does not exist', () async {
      final xFile = XFile(path.join(_tempDir.path, 'does_not_exist.bin'));
      final size = await xFile.readSize(fileSizeUnit: FileSizeUnit.byte);
      expect(size, isNull);
    });

    test('Matches the actual file length exactly for a larger file', () async {
      const byteCount = 500000;
      final xFile = _writeTempXFile('large.bin', byteCount);
      final size = await xFile.readSize(fileSizeUnit: FileSizeUnit.byte);
      expect(size, byteCount.toDouble());
    });

  });

}
