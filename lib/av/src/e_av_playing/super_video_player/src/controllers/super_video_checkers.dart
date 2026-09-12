part of super_video_player;
/// => TAMAM
abstract class SuperVideoCheckers {

  // -----------------------------------------------------------------------------

  /// YOUTUBE CHECKERS

  // --------------------
  /// shared with SuperYoutubeMethods (same super_video_player library) --
  /// hoisted instead of compiling a fresh RegExp on every call.
  static final RegExp youtubeVideoIdPattern = RegExp(r'^[a-zA-Z0-9_-]+$');
  static final RegExp youtubeLinkPattern = RegExp(
      r'^(https?\:\/\/)?(www\.youtube\.com\/watch\?v=|m\.youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)');
  // --------------------
  /// AI TESTED
  static bool checkIsValidYoutubeVideoID(String? videoID) {
    if (videoID == null){
      return false;
    }
    else {
      return youtubeVideoIdPattern.hasMatch(videoID) && videoID.length <= 11;
    }
  }
  // --------------------
  /// AI TESTED
  static bool checkIsValidYoutubeLink(String? link) {

    if (TextCheck.isEmpty(link) == true){
      return false;
    }

    else {
      return youtubeLinkPattern.hasMatch(link!);
    }

  }
  // --------------------------------------------------------------------------
}
