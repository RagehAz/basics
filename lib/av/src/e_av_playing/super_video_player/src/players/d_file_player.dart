part of super_video_player;

class _FilePlayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _FilePlayer({
    required this.superVideoController,
    required this.width,
    required this.height,
    required this.cover,
    this.errorIcon,
    this.corners = 10,
  });
  // --------------------
  final SuperVideoController superVideoController;
  final double width;
  final double height;
  final String? errorIcon;
  final dynamic corners;
  final dynamic cover;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    /// computed once per _FilePlayer.build() instead of once per video
    /// tick -- the file name is constant for the lifetime of a given
    /// video, but this used to sit inside the SingleWire builder callback,
    /// which re-runs on every player value change.
    String _fileName = superVideoController._videoFile?.fileName ?? 'x';
    _fileName = Idifier.idifyString(_fileName)!;

    return SingleWire<VideoPlayerValue?>(
      wire: superVideoController.videoValue,
      builder: (VideoPlayerValue? value) {

        /// getHeightOnScreen()/getWidthOnScreen() each independently call
        /// getDimsOnScreen() (a Dimensions.fitGraphicToCanvas() fit
        /// calculation) with identical inputs -- called once here instead,
        /// reading both dimensions off the one result.
        final Dimensions _fitVideoDims = SuperVideoScale.getDimsOnScreen(
          videoHeight: value?.size.height ?? height,
          videoWidth: value?.size.width ?? width,
          canvasWidth: width,
          canvasHeight: height,
        );

        final double _videoHeight = _fitVideoDims.height ?? 0;
        final double _videoWidth = _fitVideoDims.width ?? 0;

        // final Dimensions _size = Dimensions.fromSize(value?.size);
        // blog('xxx -> size : $_size : ${_size.getAspectRatio()}');
        //
        // final Dimensions _screen = Dimensions(width: width, height: _boxHeight);
        // blog('xxx -> screen : $_screen : ${_screen.getAspectRatio()}');

        // blog('''
        // value :
        // isInitialized : ${value?.isInitialized} :
        // isBuffering : ${value?.isBuffering} :
        // isPlaying ${value?.isPlaying} :
        // hasError ${value?.hasError} :
        // errorDescription: ${value?.errorDescription} :
        // isLooping : ${value?.isLooping} :
        // aspectRatio : ${value?.aspectRatio} :
        //     ''');

        final bool _isLoading = superVideoController.checkVideoIsLoading();
        final bool _showPlayIcon = superVideoController.checkCanShowPlayIcon();
        final bool _showVideo = superVideoController.checkCanShowVideo();
        final bool _hasError = superVideoController.checkHasError();
        final bool _videoInitialized = superVideoController.checkIsInitialed();

        return GestureDetector(
          key: ValueKey<String>('_TheVideoPlayer_$_fileName'),
          onTap: value == null ? null : superVideoController.onVideoTap,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// VIDEO CARD
              if (_showVideo == true)
                _VideoCard(
                  width: _videoWidth,
                  height: _videoHeight,
                  corners: corners,
                  controller: superVideoController.videoPlayerController!,
                ),

              /// COVER
              if (cover != null && _videoInitialized == false)
                SuperImage(
                  loading: false,
                  width: width,
                  height: height,
                  pic: cover,
                  // fit: BoxFit.cover,
                ),

              /// LOADING
              if (_isLoading == true)
                _VideoLoadingIndicator(
                  videoWidth: _videoWidth,
                ),

              /// PLAY ICON
              if (_showPlayIcon == true)
                _VideoPlayIcon(
                  videoWidth: _videoWidth,
                ),

              /// ERROR ICON
              if (_hasError == true)
                _VideoErrorIcon(
                  videoWidth: _videoWidth,
                  icon: errorIcon,
                ),

              /// VOLUME SLIDER
              if (superVideoController.showVolumeSlider == true)
                _VideoVolumeSlider(
                  width: _videoWidth,
                  height: _videoHeight,
                  initialVolume: value?.volume ?? 1,
                  isChangingVolume: superVideoController.isChangingVolume,
                  onVolumeChanged: (double volume) => superVideoController.setVolume(volume),
                  onVolumeChangeStarted: (double volume) => superVideoController.onVolumeChangeStarted(volume),
                  onVolumeChangeEnded: (double volume) => superVideoController.onVolumeChangeEnded(volume),
                ),

            ],
          ),
        );
      },
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
