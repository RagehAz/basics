// ignore_for_file: constant_identifier_names
part of filing;

/// => TAMAM
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
  imageWebp,
  videoWebp,
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

/// => TAMAM
class FileTyper {
  // -----------------------------------------------------------------------------

  const FileTyper();

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
      case FileExtType.imageWebp : return true; /// <----- pic
      case FileExtType.videoWebp : return false; // <-video
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
      case FileExtType.imageWebp : return false; // <- pic
      case FileExtType.videoWebp : return true; /// <----- video
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
      case FileExtType.imageWebp : return false; // <- pic
      case FileExtType.videoWebp : return false; // <-video
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
}
