part of filing;

enum FileSizeUnit {
  byte,
  kiloByte,
  megaByte,
  gigaByte,
  teraByte,
}

class FileSizer {
  // -----------------------------------------------------------------------------

  const FileSizer();

  // -----------------------------------------------------------------------------

  /// FROM SUPER FILE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<double?> getSuperFileSizeInMb(SuperFile? file) async {
    final Uint8List? _bytes = await file?.readBytes();
    return calculateSize(_bytes?.length, FileSizeUnit.megaByte);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<double?> getSuperileSizeWithUnit({
    required SuperFile? file,
    required FileSizeUnit unit,
    int fractionDigits = 1,
  }) async {

    if (kIsWeb == true || file == null){
      return 0;
    }

    else {
      final int _bytes = await file.length();
      final double? _output = calculateSize(_bytes, unit);
      return Numeric.roundFractions(_output, fractionDigits);
    }

  }
  // -----------------------------------------------------------------------------

  /// FROM FILE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getFileSizeInMb(File? file){

    if (kIsWeb == true || file == null){
      return 0;
    }

    else {
      return getFileSizeWithUnit(
        file: file,
        unit: FileSizeUnit.megaByte,
      );
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getFileSizeWithUnit({
    required File? file,
    required FileSizeUnit unit,
    int fractionDigits = 1,
  }){

    if (kIsWeb == true || file == null){
      return 0;
    }

    else {
      final int _bytes = Filer.getLengthSync(file);
      final double? _output = calculateSize(_bytes, unit);
      return Numeric.roundFractions(_output, fractionDigits);
    }

  }
  // -----------------------------------------------------------------------------

  /// BYTES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? calculateSize(int? bytes, FileSizeUnit unit){

    double? _size;

    if (bytes != null){
      switch (unit){
        case FileSizeUnit.byte:      _size = bytes.toDouble(); break;
        case FileSizeUnit.kiloByte:  _size = bytes / 1024; break;
        case FileSizeUnit.megaByte:  _size = bytes/ (1024 * 1024); break;
        case FileSizeUnit.gigaByte:  _size = bytes/ (1024 * 1024 * 1024); break;
        case FileSizeUnit.teraByte:  _size = bytes/ (1024 * 1024 * 1024 * 1024); break;
        // default:                     _size = bytes.toDouble(); break;
      }
    }

    return Numeric.roundFractions(_size, 2);
  }
  // -----------------------------------------------------------------------------

  /// COMPARE

  // --------------------
  /*
      static bool checkFileSizeIsBiggerThan({
        required File file,
        required double megaBytes,
      }){
        bool _bigger = false;

        if (file != null && megaBytes != null){

          final double fileSize = getFileSize(file);

            _bigger = fileSize > megaBytes;

        }

        return _bigger;
      }
     */
  // -----------------------------------------------------------------------------
}
