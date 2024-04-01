part of super_video_player;

class VideoVolumeSlider extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoVolumeSlider({
    required this.width,
    required this.height,
    required this.initialVolume,
    required this.isChangingVolume,
    required this.onVolumeChanged,
    required this.onVolumeChangeStarted,
    required this.onVolumeChangeEnded,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final double initialVolume;
  final ValueNotifier<bool> isChangingVolume;
  final Function(double volume) onVolumeChangeStarted;
  final Function(double volume) onVolumeChangeEnded;
  final Function(double volume) onVolumeChanged;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: isChangingVolume,
      builder: (_, bool isChanging, Widget? child) {
        return Opacity(
            opacity: isChanging == true ? 1.0 : 0,
            child: child
        );
      },
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.centerRight,
        child: Container(
          width: width * 0.1,
          height: height,
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
              value: initialVolume,

              // label: 'Volume',
              // secondaryActiveColor: Colorz.blue125,
              // secondaryTrackValue: 0.5,
              // focusNode: ,
              // mouseCursor: ,
              // autofocus: ,
              // divisions: ,
              onChangeStart: onVolumeChangeStarted,
              onChangeEnd: onVolumeChangeEnded,
              // overlayColor: ,
              // semanticFormatterCallback: ,
              // key: ,
            ),
          ),
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
