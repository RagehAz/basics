part of super_video_player;

abstract class SuperYoutubeMethods {
  // -----------------------------------------------------------------------------

  /// YOUTUBE VIDEO ID

  // --------------------
  /// AI TESTED
  static String? extractVideoIDFromYoutubeURL(String? youtubeURL) {
    String? _output;

    if (SuperVideoCheckers.checkIsValidYoutubeLink(youtubeURL) == true) {

      final youtubeLinkPattern = RegExp(
          r'^(https?\:\/\/)?(www\.youtube\.com\/watch\?v=|m\.youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)');

      final match = youtubeLinkPattern.firstMatch(youtubeURL!);

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
  static bool checkIsValidYoutubeVideoID(String? videoID) {
    if (videoID == null){
      return false;
    }
    else {
      final youtubeVideoIdPattern = RegExp(r'^[a-zA-Z0-9_-]+$');
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
      final youtubeLinkPattern = RegExp(
          r'^(https?\:\/\/)?(www\.youtube\.com\/watch\?v=|m\.youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)');
      return youtubeLinkPattern.hasMatch(link!);
    }

  }
  // --------------------------------------------------------------------------
}
