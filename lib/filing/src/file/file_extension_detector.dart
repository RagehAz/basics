// ignore_for_file: unused_element, prefer_final_locals
part of filing;
/// => TAMAM
abstract class FormatDetector {
  // --------------------------------------------------------------------------

  /// FIXERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> fixFileNameByFile({
    required File? file,
    required bool includeFileExtension,
    String? rename,
  }) async {
    String? _output = rename ?? file?.fileNameWithoutExtension;

    if (_output != null && file != null){

      if (includeFileExtension == true){

        final FileExtType _extType = await detectFile(
          file: file,
          invoker: 'fixFileNameByFile',
        );

        final String? _extension = FileExtensioning.getExtensionByType(_extType);

        if (_extension != null){
          _output = '$_output.$_extension';
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> fixFileNameByBytes({
    /// FILE NAME WITH OR WITHOUT EXTENSION
    required String? fileName,
    required Uint8List? bytes,
    required bool includeFileExtension,
  }) async {
    String? _output = fileName;

    if (_output != null && bytes != null){

      /// NAME WITHOUT EXTENSION
      _output = TextMod.removeTextAfterLastSpecialCharacter(
        text: _output,
        specialCharacter: '.',
      );

      if (includeFileExtension == true){

        final FileExtType _extType = await detectBytes(
            bytes: bytes,
            fileName: fileName,
        );

        final String? _extension = FileExtensioning.getExtensionByType(_extType);

        // blog('fixFileName : $fileName : extension : $_extension');

        if (_extension != null){
          _output = '$_output.$_extension';
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// DETECTORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileExtType> detectXFile({
    required XFile? xFile,
    required String invoker,
    Uint8List? bytesIfThere,
  }) async {
    FileExtType? _output;

    if (xFile != null){

      /// MIME BY PATH ONLY
      String? _mime = lookupMimeType(xFile.path, headerBytes: bytesIfThere);
      _output = FileMiming.getTypeByMime(_mime);

      /// MIME BY PATH AND BYTES
      if (_output == null){
        final Uint8List? _bytes = bytesIfThere ?? await Byter.fromXFile(xFile, 'detectXFile.$invoker');
        _mime = lookupMimeType(xFile.path, headerBytes: _bytes);
        _output = FileMiming.getTypeByMime(_mime);
      }

      /// BY FILE INFO : MOST LIKELY WILL NOT BE AN IMAGE
      _output ??= await _byInfo(
          xFile: xFile,
          fileName: xFile.fileName,
        );

    }

    return _output ?? FileExtType.unknown;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileExtType> detectFile({
    required File? file,
    required String invoker,
    Uint8List? bytesIfThere,
  }) async {
    FileExtType? _output;

    final XFile? _xFile = XFiler.readFile(file: file);

    if (_xFile != null){

      _output = await detectXFile(
        xFile: _xFile,
        bytesIfThere: bytesIfThere,
        invoker: 'detectFile.$invoker',
      );

    }

    return _output ?? FileExtType.unknown;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileExtType> detectBytes({
    required Uint8List? bytes,
    required String? fileName,
  }) async {
    FileExtType? _type;

    /// MIME BY PATH ONLY
    String? _mime = lookupMimeType('', headerBytes: bytes);
    _type = FileMiming.getTypeByMime(_mime);

    if (_type == null){
      await XFiler.getOrCreateTempXFile(
          invoker: 'detectBytes',
          fileName: fileName,
          bytes: bytes,
          ops: (XFile xFile) async {

            // blog('2. detectBytes : xFile : $xFile');

            _type = await detectXFile(xFile: xFile, invoker: 'detectBytes(getOrCreateTempXFile)');

            // blog('3. detectBytes : _type : $_type');

          }
      );
    }

    // blog('1. detectBytes : START');
    // blog('4. detectBytes : output : $_type');

    return _type ?? FileExtType.unknown;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileExtType> detectAvModel({
    required AvModel? avModel,
    Uint8List? bytesIfThere,
  }) async {
    return detectXFile(
      xFile: avModel?.getXFile(),
      bytesIfThere: bytesIfThere,
      invoker: 'detectAvModel',
    );
  }
  // --------------------------------------------------------------------------

  /// BY INFO

  // --------------------
  /// NEED_MIGRATION
  static Future<FileExtType?> _byInfo({
    required XFile? xFile,
    required String? fileName,
  }) async {
    FileExtType? _output;

    if (DeviceChecker.deviceIsWindows() == false){

      if (xFile != null && fileName != null){

        await tryAndCatch(
          invoker: 'FormatDetector._byInfo',
          functions: () async {

            // blog('FormatDetector._byInfo : xFile : $xFile : fileName : $fileName');

            final MediaInformationSession session = await FFprobeKit.getMediaInformation(xFile.path);

            final MediaInformation? information = session.getMediaInformation();

            /// looks like : 'mov,mp4,m4a,3gp,3g2,mj2'
            final String? _formatLine = information?.getFormat();

            if (_formatLine != null){

              final List<String> _formats = _formatLine.split(',');

              for (final String format in _formats){

                FileExtType? _type = FileExtensioning.getTypeByExtension(format);

                if (_type != null){

                  _type = await _fixWebpSituation(
                    type: _type,
                    info: information!,
                  );

                  _output = _type;
                  break;
                }
                else {
                  // blog('_getExtTypeFromSession : format : $format : NOT DETECTED');
                }

              }

            }

          },
        );

      }

    }

   return _output;
  }
  // --------------------
  /// NEED_MIGRATION
  static Future<FileExtType> _fixWebpSituation({
    required FileExtType type,
    required dynamic info,
  }) async {
    FileExtType output = type;

    if (type == FileExtType.imageWebp || type == FileExtType.videoWebp){

      final String? _duration = info.getDuration();
      if (_duration == null){
        output = FileExtType.imageWebp;
      }
      else {
        output = FileExtType.videoWebp;
      }

    }

    return output;
  }
  // -----------------------------------------------------------------------------

  /// DEPRECATED

  // --------------------
  /*
  /// TESTED : WORKS GOOD
  static String? detectBytesMime({
    required Uint8List? bytes,
    required String filePath,
  }) {
    final FileExtType fileType = detectBytesType(
      bytes: bytes,
      filePath: filePath,
    );
    return getMimeByType(fileType);
  }
  // --------------------
  /// TESTED : WORKS GOOD
  static String? detectBytesExtension({
    required Uint8List? bytes,
    required String? filePath,
  }) {
    final FileExtType fileType = detectBytesType(
      bytes: bytes,
      filePath: filePath,
    );
    return getExtensionByType(fileType);
  }
   */
  // --------------------------------------------------------------------------
}
