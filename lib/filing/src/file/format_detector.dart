part of filing;

class FormatDetector {
  // --------------------------------------------------------------------------

  const FormatDetector();

  // --------------------------------------------------------------------------

  /// DETECTORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileExtType> detectXFile({
    required XFile? xFile,
  }) async {
    FileExtType? _output;

    if (xFile != null){

      /// MIME BY PATH ONLY
      String? _mime = lookupMimeType(xFile.path);
      _output = FileTyper.getTypeByMime(_mime);

      if (_output == null){

        /// BY FILE INFO
        _output = await _byInfo(
            xFile: xFile,
            fileName: xFile.fileName
        );

        /// MIME BY PATH AND BYTES
        if (_output == null){
          final Uint8List? _bytes = await Byter.fromXFile(xFile);
          _mime = lookupMimeType(xFile.path, headerBytes: _bytes);
          _output = FileTyper.getTypeByMime(_mime);
        }

      }

    }

    return _output ?? FileExtType.unknown;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileExtType> detectFile({
    required File? file,
  }) async {
    FileExtType? _output;

    final XFile? _xFile = XFiler.readFile(file: file);

    if (_xFile != null){

      _output = await detectXFile(
        xFile: _xFile,
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

    final XFile? _xFile = await XFiler.createFromBytes(
        bytes: bytes,
        fileName: fileName,
    );

    return detectXFile(xFile: _xFile);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileExtType> detectMediaModel({
    required MediaModel? mediaModel,
  }) async {

    final XFile? _xFile = await XFiler.createFromMediaModel(
      mediaModel: mediaModel,
    );

    return detectXFile(xFile: _xFile);
  }
  // --------------------------------------------------------------------------

  /// BY INFO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileExtType?> _byInfo({
    required XFile? xFile,
    required String? fileName,
  }) async {
    FileExtType? _output;

    if (xFile != null && fileName != null){

      final MediaInformationSession session = await FFprobeKit.getMediaInformation(xFile.path);

      _output = _getExtTypeFromSession(
        session: session,
      );

    }

   return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FileExtType? _getExtTypeFromSession({
    required MediaInformationSession session,
  }) {
    FileExtType? _output;

    final MediaInformation? information = session.getMediaInformation();

    /// looks like : 'mov,mp4,m4a,3gp,3g2,mj2'
    final String? _formatLine = information?.getFormat();

    if (_formatLine != null){

      final List<String> _formats = _formatLine.split(',');

      for (final String format in _formats){

        final FileExtType? _type = FileTyper.getTypeByExtension(format);

        if (_type != null){
          _output = _type;
          break;
        }
        else {
          blog('_getExtTypeFromSession : format : $format : NOT DETECTED');
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------
}
