// ignore_for_file: constant_identifier_names
part of filing;

class FileMiming {
  // -----------------------------------------------------------------------------

  const FileMiming();

  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // ----------------------------
  /// SUPPORTED BY MIME PACKAGE
  static const String _mime_pdf = 'application/pdf';
  static const String _mime_postScript = 'application/postscript';
  static const String _mime_aiff = 'audio/x-aiff';
  static const String _mime_flac = 'audio/x-flac';
  static const String _mime_wav = 'audio/x-wav';
  static const String _mime_gif = 'image/gif';
  static const String _mime_jpeg = 'image/jpeg';
  static const String _mime_png = 'image/png';
  static const String _mime_tiff = 'image/tiff';
  static const String _mime_aac = 'audio/aac';
  static const String _mime_weba = 'audio/weba';
  static const String _mime_mpeg = 'audio/mpeg';
  static const String _mime_ogg = 'audio/ogg';
  static const String _mime_gpp = 'video/3gpp';
  static const String _mime_mp4 = 'video/mp4';
  static const String _mime_gltf = 'model/gltf-binary';
  static const String _mime_webp = 'image/webp';
  static const String _mime_woff = 'font/woff2';
  static const String _mime_heic = 'image/heic';
  static const String _mime_heif = 'image/heif';
  // ----------------------------
  /// NOT SUPPORTED BY MIME PACKAGE
  static const String _mime_bmp = 'image/bmp';
  static const String _mime_vmpeg = 'video/mpeg';
  static const String _mime_quicktime = 'video/quicktime';
  static const String _mime_msword = 'application/msword';
  static const String _mime_plain = 'text/plain';
  static const String _mime_mp3 = 'audio/mp3';
  // -----------------------------------------------------------------------------

  /// MIME CIPHERS

  // --------------------
  /// TESTED : WORKS GOOD
  static String? getMimeByType(FileExtType? fileType) {
    String? _output;

    switch (fileType) {

      case FileExtType.pdf          : _output = _mime_pdf        ;
      case FileExtType.postScript   : _output = _mime_postScript ;
      case FileExtType.aiff         : _output = _mime_aiff       ;
      case FileExtType.flac         : _output = _mime_flac       ;
      case FileExtType.wav          : _output = _mime_wav        ;
      case FileExtType.gif          : _output = _mime_gif        ;
      case FileExtType.jpeg         : _output = _mime_jpeg       ;
      case FileExtType.png          : _output = _mime_png        ;
      case FileExtType.tiff         : _output = _mime_tiff       ;
      case FileExtType.aac          : _output = _mime_aac        ;
      case FileExtType.weba         : _output = _mime_weba       ;
      case FileExtType.mpeg         : _output = _mime_mpeg       ;
      case FileExtType.ogg          : _output = _mime_ogg        ;
      case FileExtType.gpp          : _output = _mime_gpp        ;
      case FileExtType.mp4          : _output = _mime_mp4        ;
      case FileExtType.gltf         : _output = _mime_gltf       ;
      case FileExtType.webp         : _output = _mime_webp       ;
      case FileExtType.woff         : _output = _mime_woff       ;
      case FileExtType.heic         : _output = _mime_heic       ;
      case FileExtType.heif         : _output = _mime_heif       ;

      case FileExtType.bmp          : _output = _mime_bmp        ;
      case FileExtType.vmpeg        : _output = _mime_vmpeg      ;
      case FileExtType.quicktime    : _output = _mime_quicktime  ;
      case FileExtType.msword       : _output = _mime_msword     ;
      case FileExtType.plainText    : _output = _mime_plain      ;
      case FileExtType.mp3          : _output = _mime_mp3        ;

      default: _output = null;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS GOOD
  static FileExtType? getTypeByMime(String? mime) {
    FileExtType? _output;

    switch (mime){

      case _mime_pdf         : _output = FileExtType.pdf;
      case _mime_postScript  : _output = FileExtType.postScript;
      case _mime_aiff        : _output = FileExtType.aiff;
      case _mime_flac        : _output = FileExtType.flac;
      case _mime_wav         : _output = FileExtType.wav;
      case _mime_gif         : _output = FileExtType.gif;
      case _mime_jpeg        : _output = FileExtType.jpeg;
      case _mime_png         : _output = FileExtType.png;
      case _mime_tiff        : _output = FileExtType.tiff;
      case _mime_aac         : _output = FileExtType.aac;
      case _mime_weba        : _output = FileExtType.weba;
      case _mime_mpeg        : _output = FileExtType.mpeg;
      case _mime_ogg         : _output = FileExtType.ogg;
      case _mime_gpp         : _output = FileExtType.gpp;
      case _mime_mp4         : _output = FileExtType.mp4;
      case _mime_gltf        : _output = FileExtType.gltf;
      case _mime_webp        : _output = FileExtType.webp;
      case _mime_woff        : _output = FileExtType.woff;
      case _mime_heic        : _output = FileExtType.heic;
      case _mime_heif        : _output = FileExtType.heif;

      case _mime_bmp         : _output = FileExtType.bmp;
      case _mime_vmpeg       : _output = FileExtType.vmpeg;
      case _mime_quicktime   : _output = FileExtType.quicktime;
      case _mime_msword      : _output = FileExtType.msword;
      case _mime_plain       : _output = FileExtType.plainText;
      case _mime_mp3         : _output = FileExtType.mp3;

      default: _output = null;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
