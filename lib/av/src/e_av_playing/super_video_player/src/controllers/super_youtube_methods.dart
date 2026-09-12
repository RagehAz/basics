part of super_video_player;

abstract class SuperYoutubeMethods {
  // -----------------------------------------------------------------------------

  /// YOUTUBE VIDEO ID

  // --------------------
  /// AI TESTED
  static String? extractVideoIDFromYoutubeURL(String? youtubeURL) {
    String? _output;

    if (TextCheck.isEmpty(youtubeURL) == false) {

      /// reuses the already-validated match instead of first calling
      /// checkIsValidYoutubeLink (a separate hasMatch call) and then
      /// re-matching the same pattern again here -- also uses
      /// SuperVideoCheckers' hoisted RegExp instead of compiling a fresh
      /// one on every call.
      final match = SuperVideoCheckers.youtubeLinkPattern.firstMatch(youtubeURL!);

      if (match != null){
        _output = match.group(3);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// YOUTUBE COVER IMAGE

  // --------------------
  /// TASK : TEST ME
  String? getYouTubeVideoCoverImageURL(){
    String? _output;

    /// TURNED_OFF_YOUTUBE_PLAYER
    // final bool _isYoutubeLink = checkIsValidYoutubeLink(_videoURL);
    //
    // if (_youtubeController != null && _isYoutubeLink == true){
    //
    //   // final String link = 'https://www.youtube.com/watch?v=$videoID';
    //   // final meta.MetaDataModel metaData = await meta.YoutubeMetaData.getData(link);
    //
    //   final YoutubeMetaData? videoMetaData = _youtubeController?.metadata;
    //   final String? id = videoMetaData?.videoId;
    //
    //   if (id != null){
    //     _output = 'https://img.youtube.com/vi/$id/0.jpg';
    //   }
    //
    // }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// YOUTUBE CHECKERS

  // --------------------
  /// AI TESTED
  /// delegates to SuperVideoCheckers (same library) instead of maintaining
  /// a byte-for-byte duplicate RegExp/implementation here.
  static bool checkIsValidYoutubeVideoID(String? videoID) {
    return SuperVideoCheckers.checkIsValidYoutubeVideoID(videoID);
  }
  // --------------------
  /// AI TESTED
  static bool checkIsValidYoutubeLink(String? link) {
    return SuperVideoCheckers.checkIsValidYoutubeLink(link);
  }
  // --------------------------------------------------------------------------
}
