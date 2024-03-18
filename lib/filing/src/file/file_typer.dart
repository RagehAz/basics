part of filing;

enum FileExt {
  png,
  jpeg,
  gif,
  bmp,
  webp,
  mp3,
  wav,
  ogg,
  mp4,
  mpeg,
  quicktime,
  pdf,
  doc,
  docx,
  xls,
  xlsx,
  ppt,
  pptx,
  plainText,
  unknown,
}

class FileTyper {
  // -----------------------------------------------------------------------------

  const FileTyper();

  // -----------------------------------------------------------------------------
  /// AI GENERATED
  static FileExt _detectFileType(Uint8List bytes) {
    FileExt _output = FileExt.unknown;


    if (_hasSignature(bytes, [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])) {
      _output = FileExt.png;
    }

    else if (_hasSignature(bytes, [0xFF, 0xD8, 0xFF])) {
      _output = FileExt.jpeg;
    }

    else if (_hasSignature(bytes, [0x47, 0x49, 0x46, 0x38])) {
      _output = FileExt.gif;
    }

    else if (_hasSignature(bytes, [0x42, 0x4D])) {
      _output = FileExt.bmp;
    }

    else if (_hasSignature(bytes, [0x52, 0x49, 0x46, 0x46]) && _hasSignature(bytes, [0x57, 0x45, 0x42, 0x50], offset: 8)) {
      _output = FileExt.webp;
    }

    else if (_hasSignature(bytes, [0x49, 0x44, 0x33])) {
      _output = FileExt.mp3;
    }

    else if (_hasSignature(bytes, [0x52, 0x49, 0x46, 0x46]) && _hasSignature(bytes, [0x57, 0x41, 0x56, 0x45], offset: 8)) {
      _output = FileExt.wav;
    }

    else if (_hasSignature(bytes, [0x4F, 0x67, 0x67, 0x53])) {
      _output = FileExt.ogg;
    }

    // else if (_hasSignature(bytes, [0x00, 0x00, 0x00, 0x20]) &&
    //     _hasSignature(bytes, [0x66, 0x74, 0x79, 0x70], offset: 4) &&
    //     _hasSignature(bytes, [0x6D, 0x70, 0x34, 0x32], offset: 8)) {
    //   return FileType.mp4;
    // }
    else if (_hasSignature(bytes, [0x66, 0x74, 0x79, 0x70, 0x6D, 0x70, 0x34, 0x32])) {
      _output = FileExt.mp4;
    }

    else if (_hasSignature(bytes, [0x00, 0x00, 0x01, 0xBA])) {
      _output = FileExt.mpeg;
    }

    else if (_hasSignature(bytes, [0x00, 0x00, 0x00, 0x18, 0x66, 0x74, 0x79, 0x70])) {
      _output = FileExt.quicktime;
    }

    else if (_hasSignature(bytes, [0x25, 0x50, 0x44, 0x46])) {
      _output = FileExt.pdf;
    }

    else if (_hasSignature(bytes, [0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1])) {
      _output = FileExt.doc;
    }

    else if (_hasSignature(bytes, [0x50, 0x4B, 0x03, 0x04])) {
      _output = FileExt.docx;
    }

    else if (_hasSignature(bytes, [0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1])) {
      _output = FileExt.xls;
    }

    else if (_hasSignature(bytes, [0x50, 0x4B, 0x03, 0x04, 0x14, 0x00, 0x06, 0x00])) {
      _output = FileExt.xlsx;
    }

    else if (_hasSignature(bytes, [0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1])) {
      _output = FileExt.ppt;
    }

    else if (_hasSignature(bytes, [0x50, 0x4B, 0x03, 0x04, 0x14, 0x00, 0x06, 0x00])) {
      _output = FileExt.pptx;
    }

    else if (_hasSignature(bytes, [0x00, 0x00, 0x00, 0x00]) && _hasSignature(bytes, [0x6C, 0x6F, 0x63, 0x61, 0x6C, 0x65, 0x20, 0x74], offset: 8)) {
      _output = FileExt.plainText;
    }

    else {
      _output = FileExt.unknown;
    }

    // blog('_detectFileType : output : $_output');

    return _output;
  }
  // --------------------
  /// AI GENERATED
  static bool _hasSignature(Uint8List? bytes, List<int>? signature, {int offset = 0}) {

    if (bytes == null || signature == null || offset < 0) {
      return false;
    }

    else {

      if (offset + signature.length > bytes.length) {
        return false;
      }

      for (var i = 0; i < signature.length; i++) {
        if (bytes[offset + i] != signature[i]) {
          return false;
        }
      }

      return true;

    }
  }
  // --------------------
  static const String _png = 'image/png';
  static const String _jpeg = 'image/jpeg';
  static const String _gif = 'image/gif';
  static const String _bmp = 'image/bmp';
  static const String _webp = 'image/webp';
  static const String _ampeg = 'audio/mpeg';
  static const String _wav = 'audio/wav';
  static const String _ogg = 'audio/ogg';
  static const String _mp4 = 'video/mp4';
  static const String _vmpeg = 'video/mpeg';
  static const String _quicktime = 'video/quicktime';
  static const String _pdf = 'application/pdf';
  static const String _msword = 'application/msword';
  // static const String _x = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
  // static const String _x = 'application/vnd.ms-excel';
  // static const String _x = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
  // static const String _x = 'application/vnd.ms-powerpoint';
  // static const String _x = 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
  static const String _plain = 'text/plain';
  // --------------------
  /// AI GENERATED
  static String? cipherType(FileExt? fileType) {

    switch (fileType) {
      case FileExt.png:        return _png;
      case FileExt.jpeg:       return _jpeg;
      case FileExt.gif:        return _gif;
      case FileExt.bmp:        return _bmp;
      case FileExt.webp:       return _webp;
      case FileExt.mp3:        return _ampeg;
      case FileExt.wav:        return _wav;
      case FileExt.ogg:        return _ogg;
      case FileExt.mp4:        return _mp4;
      case FileExt.mpeg:       return _vmpeg;
      case FileExt.quicktime:  return _quicktime;
      case FileExt.pdf:        return _pdf;
      case FileExt.doc:        return _msword;
      case FileExt.plainText:  return _plain;
      // case FileType.docx:       return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      // case FileType.xls:        return 'application/vnd.ms-excel';
      // case FileType.xlsx:       return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      // case FileType.ppt:        return 'application/vnd.ms-powerpoint';
      // case FileType.pptx:       return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      default: return null;
    }
  }
  // --------------------
  /// AI GENERATED
  static FileExt? decipherType(String? fileType) {

    switch (fileType) {
      case _png         : return FileExt.png;
      case _jpeg        : return FileExt.jpeg;
      case _gif         : return FileExt.gif;
      case _bmp         : return FileExt.bmp;
      case _webp        : return FileExt.webp;
      case _ampeg       : return FileExt.mp3;
      case _wav         : return FileExt.wav;
      case _ogg         : return FileExt.ogg;
      case _mp4         : return FileExt.mp4;
      case _vmpeg       : return FileExt.mpeg;
      case _quicktime   : return FileExt.quicktime;
      case _pdf         : return FileExt.pdf;
      case _msword      : return FileExt.doc;
      case _plain       : return FileExt.plainText;
      default: return null;
    }
  }
  // --------------------
  /// AI GENERATED
  static String? getContentType({
    required Uint8List? bytes,
    required FileExt? forceType,
  }) {
    if (bytes == null){
      return null;
    }
    else if (forceType != null){
      return cipherType(forceType);
    }
    else {
      final fileType = _detectFileType(bytes);
      return cipherType(fileType);
    }
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static FileExt? getFileTypeByBytes({
    required Uint8List? bytes,
    FileExt? forceType,
  }){

    if (forceType != null){
      return forceType;
    }
    else {

      final String? _type = getContentType(
          bytes: bytes,
          forceType: forceType
      );

      return decipherType(_type);

    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFileIsImage(FileExt? fileType){

    switch (fileType){
      case FileExt.png       : return true; /// <----- pic
      case FileExt.jpeg      : return true; /// <----- pic
      case FileExt.gif       : return false; // <-video
      case FileExt.bmp       : return true; /// <----- pic
      case FileExt.webp      : return false; // <-video
      case FileExt.mp3       : return false; // <-audio
      case FileExt.wav       : return false; // <-audio
      case FileExt.ogg       : return false; // <-video
      case FileExt.mp4       : return false; // <-video
      case FileExt.mpeg      : return false; // <-video
      case FileExt.quicktime : return false; // <-x
      case FileExt.pdf       : return false; // <-PDF
      case FileExt.doc       : return false; // <-word
      case FileExt.docx      : return false; // <-word
      case FileExt.xls       : return false; // <-excel
      case FileExt.xlsx      : return false; // <-excel
      case FileExt.ppt       : return false; // <-power point
      case FileExt.pptx      : return false; // <-power point
      case FileExt.plainText : return false; // <-text
      case FileExt.unknown   : return false; // <-x
      default: return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFileIsVideo(FileExt? fileType){

    switch (fileType){
      case FileExt.png       : return false; // <- pic
      case FileExt.jpeg      : return false; // <- pic
      case FileExt.gif       : return true; /// <----- video
      case FileExt.bmp       : return false; // <- pic
      case FileExt.webp      : return true; /// <----- video
      case FileExt.mp3       : return false; // <-audio
      case FileExt.wav       : return false; // <-audio
      case FileExt.ogg       : return true; /// <----- video
      case FileExt.mp4       : return true; /// <----- video
      case FileExt.mpeg      : return true; /// <----- video
      case FileExt.quicktime : return false; // <-x
      case FileExt.pdf       : return false; // <-PDF
      case FileExt.doc       : return false; // <-word
      case FileExt.docx      : return false; // <-word
      case FileExt.xls       : return false; // <-excel
      case FileExt.xlsx      : return false; // <-excel
      case FileExt.ppt       : return false; // <-power point
      case FileExt.pptx      : return false; // <-power point
      case FileExt.plainText : return false; // <-text
      case FileExt.unknown   : return false; // <-x
      default: return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFileIsAudio(FileExt? fileType){

    switch (fileType){
      case FileExt.png       : return false; // <- pic
      case FileExt.jpeg      : return false; // <- pic
      case FileExt.gif       : return false; // <-video
      case FileExt.bmp       : return false; // <- pic
      case FileExt.webp      : return false; // <-video
      case FileExt.mp3       : return true; /// <----- audio
      case FileExt.wav       : return true; /// <----- audio
      case FileExt.ogg       : return false; // <-video
      case FileExt.mp4       : return false; // <-video
      case FileExt.mpeg      : return false; // <-video
      case FileExt.quicktime : return false; // <-x
      case FileExt.pdf       : return false; // <-PDF
      case FileExt.doc       : return false; // <-word
      case FileExt.docx      : return false; // <-word
      case FileExt.xls       : return false; // <-excel
      case FileExt.xlsx      : return false; // <-excel
      case FileExt.ppt       : return false; // <-power point
      case FileExt.pptx      : return false; // <-power point
      case FileExt.plainText : return false; // <-text
      case FileExt.unknown   : return false; // <-x
      default: return false;
    }

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

  /// FILE EXTENSION

  // --------------------
  /// AI TESTED
  static String? fileExtensionOf(dynamic file) {

    if (file == null) {
      return null;
    }

    else if (file is String) {
      final lastIndex = file.lastIndexOf('.');
      return lastIndex != -1 ? file.substring(lastIndex + 1) : null;
    }

    else if (file is File) {
      final path = file.path;
      final lastIndex = path.lastIndexOf('.');
      return lastIndex != -1 ? path.substring(lastIndex + 1) : null;
    }

    // else if (file is Blob) {
    //   final type = file.type;
    //   final lastIndex = type.lastIndexOf('/');
    //   return lastIndex != -1 ? type.substring(lastIndex + 1) : null;
    // }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------
}
