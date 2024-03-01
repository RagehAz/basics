part of super_video_player;

class SuperVideoPlayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperVideoPlayer({
    required this.width,
    this.file,
    this.url,
    this.autoPlay = false,
    this.asset,
    this.loop = false,
    // this.aspectRatio,
    this.errorIcon,
    super.key
  });
  // --------------------
  final String? url;
  final File? file;
  final double width;
  final bool autoPlay;
  final String? asset;
  final bool loop;
  // final double? aspectRatio;
  final String? errorIcon;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// ASSET OR FILE
    if (asset != null || file != null){
        return FileAndURLVideoPlayer(
          width: width,
          asset: asset,
          file: file,
          autoPlay: autoPlay,
          loop: loop,
          // aspectRatio: aspectRatio,
          errorIcon: errorIcon,
        );
    }

    /// URL
    else if (url != null){

      final bool _isYoutubeLink = YoutubeVideoPlayer.checkIsValidYoutubeLink(url);

      /// YOUTUBE URL
      if (_isYoutubeLink == true){
        return YoutubeVideoPlayer(
          videoID: YoutubeVideoPlayer.extractVideoIDFromYoutubeURL(url),
          width: width,
          autoPlay: autoPlay,
          /// LOOPING WAS NOT CONNECTED HERE
        );
      }

      /// MP4 URL
      else {
        return FileAndURLVideoPlayer(
          url: url,
          width: width,
          autoPlay: autoPlay,
          loop: loop,
          errorIcon: errorIcon,
          // height: height,
          // aspectRatio: aspectRatio,
        );
      }

    }

    /// NOTHING
    else {
      return VideoBox(
        width: width,
        aspectRatio: 19/6,//aspectRatio,
      );
    }

  }
  /// --------------------------------------------------------------------------
}
