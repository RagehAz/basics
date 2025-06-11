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
    return SingleWire<VideoPlayerValue?>(
      wire: superVideoController.videoValue,
      builder: (VideoPlayerValue? value) {

        final double _videoHeight = SuperVideoScale.getHeightOnScreen(
          videoHeight: value?.size.height ?? height,
          videoWidth: value?.size.width ?? width,
          canvasWidth: width,
          canvasHeight: height,
        );

        final double _videoWidth = SuperVideoScale.getWidthOnScreen(
          videoHeight: value?.size.height ?? height,
          videoWidth: value?.size.width ?? width,
          canvasWidth: width,
          canvasHeight: height,
        );

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

        String _fileName = superVideoController._videoFile?.fileName ?? 'x';
        _fileName = Idifier.idifyString(_fileName)!;

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
