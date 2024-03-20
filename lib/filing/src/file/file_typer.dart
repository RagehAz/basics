// ignore_for_file: constant_identifier_names

part of filing;

enum FileExtType {
  /// recognized by mime package
  pdf,
  postScript,
  aiff,
  flac,
  wav,
  gif,
  jpeg,
  png,
  tiff,
  aac,
  weba,
  mpeg,
  ogg,
  gpp,
  mp4,
  gltf,
  webp,
  woff,
  heic,
  heif,
  /// unrecognized by mime package
  bmp,
  vmpeg,
  quicktime,
  msword,
  plainText,
  mp3,
  doc,
  docx,
  xls,
  xlsx,
  ppt,
  pptx,

  unknown,
}

class FileTyper {
  // -----------------------------------------------------------------------------

  const FileTyper();

  // -----------------------------------------------------------------------------

  /// MIMES

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

  /// EXTENSIONS

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

  /// DETECTION

  // --------------------
  /// TESTED : WORKS GOOD
  static FileExtType detectBytesType(Uint8List? bytes) {
    FileExtType _output = FileExtType.unknown;

    if (bytes != null){

      final String? _mime = lookupMimeType('', headerBytes: bytes);

      if (_mime != null){

        switch (_mime){

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

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS GOOD
  static String? detectBytesMime(Uint8List? bytes) {

    final FileExtType fileType = detectBytesType(bytes);
    return getMimeByType(fileType);

  }
  // --------------------
  /// TESTED : WORKS GOOD
  static String? detectBytesExtension(Uint8List? bytes) {

    final FileExtType fileType = detectBytesType(bytes);
    return getExtensionByType(fileType);

  }
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

  /// EXTENSION CIPHERS

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

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTypeIsImage(FileExtType? fileType){

    switch (fileType){

      case FileExtType.pdf       : return false; // <-PDF
      case FileExtType.postScript: return false; // <-doc
      case FileExtType.aiff      : return false; // <-audio
      case FileExtType.flac      : return false; // <-audio
      case FileExtType.wav       : return false; // <-audio
      case FileExtType.gif       : return false; // <-video
      case FileExtType.jpeg      : return true; /// <----- pic
      case FileExtType.png       : return true; /// <----- pic
      case FileExtType.tiff      : return true; /// <----- pic
      case FileExtType.aac       : return false; // <-video
      case FileExtType.weba      : return false; // <-video
      case FileExtType.mpeg      : return false; // <-video
      case FileExtType.ogg       : return false; // <-video
      case FileExtType.gpp       : return false; // <-video
      case FileExtType.mp4       : return false; // <-video
      case FileExtType.gltf      : return false; // <-3d
      case FileExtType.webp      : return false; // <-video
      case FileExtType.woff      : return false; // <-font
      case FileExtType.heic      : return true; /// <----- pic
      case FileExtType.heif      : return true; /// <----- pic

      case FileExtType.bmp       : return true; /// <----- pic
      case FileExtType.vmpeg     : return false; // <-video
      case FileExtType.quicktime : return false; // <-video
      case FileExtType.msword    : return false; // <-doc
      case FileExtType.plainText : return false; // <-doc
      case FileExtType.mp3       : return false; // <-audio

      case FileExtType.doc       : return false; // <-doc
      case FileExtType.docx      : return false; // <-doc
      case FileExtType.xls       : return false; // <-excel
      case FileExtType.xlsx      : return false; // <-excel
      case FileExtType.ppt       : return false; // <-power point
      case FileExtType.pptx      : return false; // <-power point

      case FileExtType.unknown   : return false; // <-x

      default: return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTypeIsVideo(FileExtType? fileType){

    switch (fileType){

      case FileExtType.pdf       : return false; // <-PDF
      case FileExtType.postScript: return false; // <-doc
      case FileExtType.aiff      : return false; // <-audio
      case FileExtType.flac      : return false; // <-audio
      case FileExtType.wav       : return false; // <-audio
      case FileExtType.gif       : return true; /// <----- video
      case FileExtType.jpeg      : return false; // <- pic
      case FileExtType.png       : return false; // <- pic
      case FileExtType.tiff      : return false; // <- pic
      case FileExtType.aac       : return true; /// <----- video
      case FileExtType.weba      : return true; /// <----- video
      case FileExtType.mpeg      : return true; /// <----- video
      case FileExtType.ogg       : return true; /// <----- video
      case FileExtType.gpp       : return true; /// <----- video
      case FileExtType.mp4       : return true; /// <----- video
      case FileExtType.gltf      : return false; // <-3d
      case FileExtType.webp      : return true; /// <----- video
      case FileExtType.woff      : return false; // <-font
      case FileExtType.heic      : return false; // <- pic
      case FileExtType.heif      : return false; // <- pic

      case FileExtType.bmp       : return false; // <- pic
      case FileExtType.vmpeg     : return true; /// <----- video
      case FileExtType.quicktime : return true; /// <----- video
      case FileExtType.msword    : return false; // <-doc
      case FileExtType.plainText : return false; // <-doc
      case FileExtType.mp3       : return false; // <-audio

      case FileExtType.doc       : return false; // <-doc
      case FileExtType.docx      : return false; // <-doc
      case FileExtType.xls       : return false; // <-excel
      case FileExtType.xlsx      : return false; // <-excel
      case FileExtType.ppt       : return false; // <-power point
      case FileExtType.pptx      : return false; // <-power point

      case FileExtType.unknown   : return false; // <-x

      default: return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTypeIsAudio(FileExtType? fileType){

    switch (fileType){

      case FileExtType.pdf       : return false; // <-PDF
      case FileExtType.postScript: return false; // <-doc
      case FileExtType.aiff      : return true; /// <----- audio
      case FileExtType.flac      : return true; /// <----- audio
      case FileExtType.wav       : return true; /// <----- audio
      case FileExtType.gif       : return false; // <-video
      case FileExtType.jpeg      : return false; // <- pic
      case FileExtType.png       : return false; // <- pic
      case FileExtType.tiff      : return false; // <- pic
      case FileExtType.aac       : return false; // <-video
      case FileExtType.weba      : return false; // <-video
      case FileExtType.mpeg      : return false; // <-video
      case FileExtType.ogg       : return false; // <-video
      case FileExtType.gpp       : return false; // <-video
      case FileExtType.mp4       : return false; // <-video
      case FileExtType.gltf      : return false; // <-3d
      case FileExtType.webp      : return false; // <-video
      case FileExtType.woff      : return false; // <-font
      case FileExtType.heic      : return false; // <- pic
      case FileExtType.heif      : return false; // <- pic

      case FileExtType.bmp       : return false; // <- pic
      case FileExtType.vmpeg     : return false; // <-video
      case FileExtType.quicktime : return false; // <-video
      case FileExtType.msword    : return false; // <-doc
      case FileExtType.plainText : return false; // <-doc
      case FileExtType.mp3       : return true; /// <----- audio

      case FileExtType.doc       : return false; // <-doc
      case FileExtType.docx      : return false; // <-doc
      case FileExtType.xls       : return false; // <-excel
      case FileExtType.xlsx      : return false; // <-excel
      case FileExtType.ppt       : return false; // <-power point
      case FileExtType.pptx      : return false; // <-power point

      case FileExtType.unknown   : return false; // <-x

      default: return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// FILE EXTENSION GETTERS

  // --------------------
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
      else if (object is MediaModel){
        final MediaModel _media = object;
        _output = _getExtensionFromPath(_media.file?.path);
      }
      else if (object is Uint8List){
        final Uint8List _bytes = object;
        _output = detectBytesExtension(_bytes);
      }


    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? _getExtensionFromPath(String? path){
    String? _output;

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

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FILE NAME FIXER

  // --------------------
  /// TASK : TEST_ME_NOW
  static String? fixFileName({
    required String? fileName,
    required Uint8List? bytes,
  }){
    String? _output = fileName;

    if (_output != null && bytes != null){

      final String? _extension = detectBytesExtension(bytes);

      if (_extension != null){

        _output = TextMod.removeTextAfterLastSpecialCharacter(
          text: _output,
          specialCharacter: '.',
        );

        _output = '$_output.$_extension';

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DECODER

  // --------------------
  /// TESTED : WORKS PERFECT
  static img.Decoder? getImageDecoderFromBytes({
    required Uint8List? bytes,
  }){
    img.Decoder? _output;

    if (bytes != null){

      _output = img.findDecoderForData(bytes);

    }

    return _output;
  }
  // --------------------
  /*
    static img.Image decodeToImgImage({
      required List<int> bytes,
      required PicFormat picFormat,
    }){

          switch (picFormat){
            case PicFormat.image : return img.decodeImage(bytes); break;
            case PicFormat.jpg : return img.decodeJpg(bytes); break;
            case PicFormat.png : return img.decodePng(bytes); break;
            case PicFormat.tga : return img.decodeTga(bytes); break;
            case PicFormat.webP : return img.decodeWebP(bytes); break;
            case PicFormat.gif : return img.decodeGif(bytes); break;
            case PicFormat.tiff : return img.decodeTiff(bytes); break;
            case PicFormat.psd : return img.decodePsd(bytes); break;
            case PicFormat.exr : return img.decodeExr(bytes); break;
            case PicFormat.bmp : return img.decodeBmp(bytes); break;
            case PicFormat.ico : return img.decodeIco(bytes); break;
            // case PicFormat.animation : return img.decodeAnimation(bytes); break;
            // case PicFormat.pngAnimation : return img.decodePngAnimation(bytes); break;
            // case PicFormat.webPAnimation : return img.decodeWebPAnimation(bytes); break;
            // case PicFormat.gifAnimation : return img.decodeGifAnimation(bytes); break;
            default: return null;
          }

      }
   */
  // -----------------------------------------------------------------------------
}
