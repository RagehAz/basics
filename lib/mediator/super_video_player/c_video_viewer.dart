import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/mediator/super_video_player/b_video_box.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const VideoViewer({
    required this.onPause,
    required this.onPlay,
    required this.width,
    required this.videoValue,
    required this.videoPlayerController,
    required this.onVolumeChanged,
    required this.isChangingVolume,
    required this.errorIcon,
    this.aspectRatio = 16 / 9,
    super.key
  });
  // --------------------------------------------------------------------------
   final Function onPause;
   final Function onPlay;
   final double width;
   final ValueNotifier<VideoPlayerValue?>? videoValue;
   final VideoPlayerController? videoPlayerController;
   final double? aspectRatio;
   final ValueChanged<double> onVolumeChanged;
   final ValueNotifier<bool> isChangingVolume;
   final String? errorIcon;
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _videoIsLoading({
    required VideoPlayerValue? value,
  }){

    if (value == null) {
      return true;
    }

    else if (value.hasError == true){
      return false;
    }

    else if (value.isInitialized == false) {
      return true;
    }

    else if (value.isBuffering == true){
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _canShowPlayIcon({
    required VideoPlayerValue? value,
  }){

    if (value == null) {
      return false;
    }

    else if (value.hasError == true){
      return false;
    }

    else if (value.isInitialized == false) {
      return false;
    }

    else if (value.isBuffering == true){
      return false;
    }
    else if (value.isPlaying == true){
      return false;
    }
    else {
      return true;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _canShowVideo({
    required VideoPlayerValue? value,
  }){

    if (value == null) {
      return false;
    }

    else if (value.hasError == true){
      return false;
    }

    else if (value.isInitialized == false) {
      return false;
    }
    else {
      return true;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxHeight = VideoBox.getHeightByAspectRatio(
      width: width,
      aspectRatio: aspectRatio,
      force169: false,
    );

    // final double _boxWidth = 0;
    // final double _videoWidth = 0;
    // final double _videoHeight = 0;

    if (videoValue == null || videoPlayerController == null){
      return const SizedBox();
    }
    else {
      return ValueListenableBuilder(
        valueListenable: videoValue!,
        builder: (_, VideoPlayerValue? value, Widget? child) {

          // final double _videoHeight = getHeightByAspectRatio(
          //   width: width,
          //   aspectRatio: value?.aspectRatio,
          //   force169: value?.isInitialized == false,
          // );

          // blog('''
          // value :
          // isInitialized : ${value?.isInitialized} :
          // isBuffering : ${value?.isBuffering} :
          // isPlaying ${value?.isPlaying} :
          // hasError ${value?.hasError} :
          // isLooping : ${value?.isLooping} :
          // aspectRatio : ${value?.aspectRatio} :
          //     ''');

          final bool _isLoading = _videoIsLoading(
            value: value,
          );

          final bool _showPlayIcon = _canShowPlayIcon(
            value: value,
          );

          final bool _showVideo = _canShowVideo(
            value: value,
          );

          return GestureDetector(
            key: const ValueKey<String>('URLVideoPlayer'),
            onTap: value == null ? null : () async {

              if (value.isPlaying == true){
                onPause();
              }
              else {
                onPlay();
              }

            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                Container(
                  width: width,
                  height: _boxHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    color: Colorz.black255,
                  ),
                  child: _showVideo == true ? child : const SizedBox(),
                ),

                /// LOADING
                if (_isLoading == true)
                  SuperBox(
                    height: width * 0.3,
                    width: width * 0.3,
                    icon: Iconz.reload,
                    bubble: false,
                    opacity: 0.5,
                    loading: true,
                  ),

                /// PLAY ICON ON TOP
                if (_showPlayIcon == true)
                  SuperBox(
                    height: width * 0.3,
                    width: width * 0.3,
                    icon: Iconz.play,
                    bubble: false,
                    opacity: 0.5,
                  ),

                if (value != null && value.hasError == true)
                  SuperBox(
                    height: width * 0.2,
                    width: width * 0.2,
                    icon: errorIcon,
                    bubble: false,
                    opacity: 0.1,
                  ),

                if (value?.hasError == false)
                ValueListenableBuilder(
                  valueListenable: isChangingVolume,
                  builder: (_, bool isChanging, Widget? child) {
                    return Opacity(
                        opacity: isChanging == true ? 1.0 : 0.0,
                        child: child
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: width * 0.1,
                      height: _boxHeight,
                      color: Colorz.black150,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          // max: 1.0,
                          // min: 0.0,
                          onChanged: onVolumeChanged,
                          thumbColor: Colors.white,
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                          value: value?.volume ?? 1,

                          // label: 'Volume',
                          // secondaryActiveColor: Colorz.blue125,
                          // secondaryTrackValue: 0.5,
                          // focusNode: ,
                          // mouseCursor: ,
                          // autofocus: ,
                          // divisions: ,
                          onChangeStart: (double value) {
                            setNotifier(
                              notifier: isChangingVolume,
                              mounted: true,
                              value: true,
                            );
                          },
                          onChangeEnd: (double value) async {
                            await Future.delayed(const Duration(seconds: 1), () async {
                              setNotifier(
                                notifier: isChangingVolume,
                                mounted: true,
                                value: false,
                              );
                            });
                            },
                          // overlayColor: ,
                          // semanticFormatterCallback: ,
                          // key: ,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          );
        },
        child: SizedBox(
          width: width,
          height: _boxHeight,
          child: Card(
              clipBehavior: Clip.antiAlias,
              /// to clip the child corners to be circular forcefully
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.02)),
              // color: Colorz.black255,
              child: VideoPlayer(videoPlayerController!)
          ),
        ),
      );
    }


  }
  // --------------------------------------------------------------------------
}
