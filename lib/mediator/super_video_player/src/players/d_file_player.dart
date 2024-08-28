part of super_video_player;

class _FilePlayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _FilePlayer({
    required this.superVideoController,
    required this.width,
    required this.height,
    this.errorIcon,
    this.corners = 10,
  });
  // --------------------
  final SuperVideoController superVideoController;
  final double width;
  final double height;
  final String? errorIcon;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: superVideoController.videoValue,
      builder: (_, VideoPlayerValue? value, Widget? child) {

        final double _videoHeight = SuperVideoController.getHeightOnScreen(
          videoHeight: value?.size.height ?? height,
          videoWidth: value?.size.width ?? width,
          areaWidth: width,
          areaHeight: height,
        );

        final double _videoWidth = SuperVideoController.getWidthOnScreen(
          videoHeight: value?.size.height ?? height,
          videoWidth: value?.size.width ?? width,
          areaWidth: width,
          areaHeight: height,
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

        return GestureDetector(
          key: const ValueKey<String>('_TheVideoPlayer'),
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
