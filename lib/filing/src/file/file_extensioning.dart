// ignore_for_file: constant_identifier_names
part of filing;
/// => TAMAM
class FileExtensioning {
  // -----------------------------------------------------------------------------

  const FileExtensioning();

  // ----------------------------------------------------------------------------

  /// CONSTANTS

  // ----------------------------
  /// SUPPORTED BY MIME PACKAGE
  static const String _ext_pdf = 'pdf';
  static const String _ext_postScript = 'postscript';
  static const String _ext_aiff = 'aiff';
  static const String _ext_flac = 'flac';
  static const String _ext_wav = 'wav';
  static const String _ext_gif = 'gif';
  static const String _ext_jpeg = 'jpeg';
  static const String _ext_png = 'png';
  static const String _ext_tiff = 'tiff';
  static const String _ext_aac = 'aac';
  static const String _ext_weba = 'weba';
  static const String _ext_mpeg = 'mpeg';
  static const String _ext_ogg = 'ogg';
  static const String _ext_gpp = '3gpp';
  static const String _ext_mp4 = 'mp4';
  static const String _ext_gltf = 'gltf';
  static const String _ext_webp = 'webp';
  static const String _ext_woff = 'woff2';
  static const String _ext_heic = 'heic';
  static const String _ext_heif = 'heif';
  // ----------------------------
  /// NOT SUPPORTED BY MIME PACKAGE
  static const String _ext_bmp = 'bmp';
  static const String _ext_vmpeg = 'vmpeg';
  static const String _ext_quicktime = 'quicktime';
  static const String _ext_msword = 'msword';
  static const String _ext_plain = 'plain';
  static const String _ext_mp3 = 'mp3';
  // -----------------------------------------------------------------------------

  /// FILE EXT TYPE - EXTENSION CYPHERS

  // --------------------
  /// TESTED : WORKS GOOD
  static String? getExtensionByType(FileExtType? fileType) {
    String? _output;

    switch (fileType) {

      case FileExtType.pdf          : _output = _ext_pdf        ;
      case FileExtType.postScript   : _output = _ext_postScript ;
      case FileExtType.aiff         : _output = _ext_aiff       ;
      case FileExtType.flac         : _output = _ext_flac       ;
      case FileExtType.wav          : _output = _ext_wav        ;
      case FileExtType.gif          : _output = _ext_gif        ;
      case FileExtType.jpeg         : _output = _ext_jpeg       ;
      case FileExtType.png          : _output = _ext_png        ;
      case FileExtType.tiff         : _output = _ext_tiff       ;
      case FileExtType.aac          : _output = _ext_aac        ;
      case FileExtType.weba         : _output = _ext_weba       ;
      case FileExtType.mpeg         : _output = _ext_mpeg       ;
      case FileExtType.ogg          : _output = _ext_ogg        ;
      case FileExtType.gpp          : _output = _ext_gpp        ;
      case FileExtType.mp4          : _output = _ext_mp4        ;
      case FileExtType.gltf         : _output = _ext_gltf       ;
      case FileExtType.webp         : _output = _ext_webp       ;
      case FileExtType.woff         : _output = _ext_woff       ;
      case FileExtType.heic         : _output = _ext_heic       ;
      case FileExtType.heif         : _output = _ext_heif       ;

      case FileExtType.bmp          : _output = _ext_bmp        ;
      case FileExtType.vmpeg        : _output = _ext_vmpeg      ;
      case FileExtType.quicktime    : _output = _ext_quicktime  ;
      case FileExtType.msword       : _output = _ext_msword     ;
      case FileExtType.plainText    : _output = _ext_plain      ;
      case FileExtType.mp3          : _output = _ext_mp3        ;

      default: _output = null;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS GOOD
  static FileExtType? getTypeByExtension(String? extension) {
    FileExtType? _output;

    switch (extension){

      case _ext_pdf         : _output = FileExtType.pdf;
      case _ext_postScript  : _output = FileExtType.postScript;
      case _ext_aiff        : _output = FileExtType.aiff;
      case _ext_flac        : _output = FileExtType.flac;
      case _ext_wav         : _output = FileExtType.wav;
      case _ext_gif         : _output = FileExtType.gif;
      case _ext_jpeg        : _output = FileExtType.jpeg;
      case _ext_png         : _output = FileExtType.png;
      case _ext_tiff        : _output = FileExtType.tiff;
      case _ext_aac         : _output = FileExtType.aac;
      case _ext_weba        : _output = FileExtType.weba;
      case _ext_mpeg        : _output = FileExtType.mpeg;
      case _ext_ogg         : _output = FileExtType.ogg;
      case _ext_gpp         : _output = FileExtType.gpp;
      case _ext_mp4         : _output = FileExtType.mp4;
      case _ext_gltf        : _output = FileExtType.gltf;
      case _ext_webp        : _output = FileExtType.webp;
      case _ext_woff        : _output = FileExtType.woff;
      case _ext_heic        : _output = FileExtType.heic;
      case _ext_heif        : _output = FileExtType.heif;

      case _ext_bmp         : _output = FileExtType.bmp;
      case _ext_vmpeg       : _output = FileExtType.vmpeg;
      case _ext_quicktime   : _output = FileExtType.quicktime;
      case _ext_msword      : _output = FileExtType.msword;
      case _ext_plain       : _output = FileExtType.plainText;
      case _ext_mp3         : _output = FileExtType.mp3;

      default: _output = null;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GET FROM PATH

  // --------------------
  /// AI TESTED
  static String? getExtensionFromPath(dynamic path){
    String? _output;

    if (path != null && path is String){

      final bool _containsExtension = TextCheck.stringContainsSubString(
        string: path,
        subString: '.',
      );

      if (_containsExtension == true){

        _output = TextMod.removeTextBeforeLastSpecialCharacter(
          text: path,
          specialCharacter: '.',
        );

      }

    }

    return _output;
  }
  // --------------------
  /// DEPRECATED
  /*
  static String? getFileExtensionFromPath(String? path){

    if (kIsWeb == true || path == null){
      return null;
    }

    ///  NOTE 'jpg' - 'png' - 'pdf' ... etc => which does not include the '.'
    else {

      final String _dotExtension = extension(path);

      return TextMod.removeTextBeforeLastSpecialCharacter(
        text: _dotExtension,
        specialCharacter: '.',
      );

    }

  }
   */
  // --------------------
  /// DEPRECATED
  /*
  /// AI TESTED
  static String? getExtension({
    required dynamic object
  }) {
    String? _output;

    if (object != null) {

      if (object is String){
        _output = _getExtensionFromPath(object);
      }
      else if (object is File){
        final File _file = object;
        _output = _getExtensionFromPath(_file.path);
      }
      else if (object is XFile){
        final XFile _file = object;
        _output = _getExtensionFromPath(_file.path);
      }
      else if (object is SuperFile){
        final SuperFile _file = object;
        _output = _getExtensionFromPath(_file.path);
      }
      else if (object is MediaModel){
        final MediaModel _media = object;
        _output = _media.getExtension();//detectBytesExtension(bytes: _media.bytes, filePath: _media.getFilePath());
      }
      else if (object is Uint8List){
        final Uint8List _bytes = object;
        _output = detectBytesExtension(bytes: _bytes, filePath: null);
      }


    }

    return _output;
  }
   */
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// AI TESTED
  static bool checkNameHasExtension(String? fileName){
    bool _output = false;

    if (fileName != null){

      final String? _ext = getExtensionFromPath(fileName);

      _output = TextCheck.isEmpty(_ext) == false;

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
