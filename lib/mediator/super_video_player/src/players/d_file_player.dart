part of super_video_player;

class _FilePlayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _FilePlayer({
    required this.superVideoController,
    required this.width,
    this.errorIcon,
    this.corners = 10,
  });
  // --------------------
  final SuperVideoController superVideoController;
  final double width;
  final String? errorIcon;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: superVideoController.videoValue,
      builder: (_, VideoPlayerValue? value, Widget? child) {

        final double _boxHeight = VideoBox.getHeightByAspectRatio(
          width: width,
          aspectRatio: value?.aspectRatio ?? 19/6,
          force169: false,
        );

        // blog('''
        // value :
        // isInitialized : ${value?.isInitialized} :
        // isBuffering : ${value?.isBuffering} :
        // isPlaying ${value?.isPlaying} :
        // hasError ${value?.hasError} :
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
                VideoCard(
                  width: width,
                  height: _boxHeight,
                  corners: corners,
                  controller: superVideoController.videoPlayerController!,
                ),

              /// LOADING
              if (_isLoading == true)
                VideoLoadingIndicator(
                  videoWidth: width,
                ),

              /// PLAY ICON
              if (_showPlayIcon == true)
                VideoPlayIcon(
                  videoWidth: width,
                ),

              /// ERROR ICON
              if (_hasError == true)
                VideoErrorIcon(
                  videoWidth: width,
                  icon: errorIcon,
                ),

              /// VOLUME SLIDER
              if (superVideoController.showVolumeSlider == true)
                VideoVolumeSlider(
                  width: width,
                  height: _boxHeight,
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
