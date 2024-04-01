// part of super_video_player;
//
// class VideoViewer extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const VideoViewer({
//     required this.onPause,
//     required this.onPlay,
//     required this.width,
//     required this.videoValue,
//     required this.videoPlayerController,
//     required this.onVolumeChanged,
//     required this.isChangingVolume,
//     required this.errorIcon,
//     required this.corners,
//     super.key
//   });
//   // --------------------------------------------------------------------------
//    final Function onPause;
//    final Function onPlay;
//    final double width;
//    final ValueNotifier<VideoPlayerValue?>? videoValue;
//    final VideoPlayerController? videoPlayerController;
//    final ValueChanged<double> onVolumeChanged;
//    final ValueNotifier<bool> isChangingVolume;
//    final String? errorIcon;
//    final dynamic corners;
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool _videoIsLoading({
//     required VideoPlayerValue? value,
//   }){
//
//     // blog('_videoIsLoading value.hasError : ${value?.hasError} : isInitialized : ${value?.isInitialized} : ${value?.isBuffering}');
//
//     if (value == null) {
//       return true;
//     }
//
//     else if (value.hasError == true){
//       return false;
//     }
//
//     else if (value.isInitialized == false) {
//       return true;
//     }
//
//     else if (value.isBuffering == true){
//       return true;
//     }
//
//     else {
//       return false;
//     }
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool _canShowPlayIcon({
//     required VideoPlayerValue? value,
//   }){
//
//     if (value == null) {
//       return false;
//     }
//
//     else if (value.hasError == true){
//       return false;
//     }
//
//     else if (value.isInitialized == false) {
//       return false;
//     }
//
//     else if (value.isBuffering == true){
//       return false;
//     }
//     else if (value.isPlaying == true){
//       return false;
//     }
//     else {
//       return true;
//     }
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool _canShowVideo({
//     required VideoPlayerValue? value,
//   }){
//
//     // blog('value : $value : error ${value?.hasError} : init ${value?.isInitialized}');
//
//     // return true;
//
//     if (value == null) {
//       return false;
//     }
//
//     else if (value.hasError == true){
//       return false;
//     }
//
//     else if (value.isInitialized == false) {
//       return false;
//     }
//     else {
//       return true;
//     }
//
//   }
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     // final double _boxWidth = 0;
//     // final double _videoWidth = 0;
//     // final double _videoHeight = 0;
//
//     if (videoValue == null || videoPlayerController == null){
//       return const SizedBox();
//     }
//     else {
//
//       final BorderRadius _corners = Borderers.superCorners(
//         corners: corners ?? BorderRadius.circular(width * 0.02),
//       );
//
//       return ValueListenableBuilder(
//         valueListenable: videoValue!,
//         builder: (_, VideoPlayerValue? value, Widget? child) {
//
//           final double _boxHeight = VideoBox.getHeightByAspectRatio(
//             width: width,
//             aspectRatio: value?.aspectRatio,//aspectRatio ?? value?.aspectRatio ?? 0,
//             force169: false,
//           );
//
//           // blog('value?.aspectRatio : ${1 / value!.aspectRatio} : ${19/6}');
//
//           // final double _videoHeight = getHeightByAspectRatio(
//           //   width: width,
//           //   aspectRatio: value?.aspectRatio,
//           //   force169: value?.isInitialized == false,
//           // );
//
//           // blog('''
//           // value :
//           // isInitialized : ${value?.isInitialized} :
//           // isBuffering : ${value?.isBuffering} :
//           // isPlaying ${value?.isPlaying} :
//           // hasError ${value?.hasError} :
//           // isLooping : ${value?.isLooping} :
//           // aspectRatio : ${value?.aspectRatio} :
//           //     ''');
//
//           final bool _isLoading = _videoIsLoading(
//             value: value,
//           );
//
//           final bool _showPlayIcon = _canShowPlayIcon(
//             value: value,
//           );
//
//           final bool _showVideo = _canShowVideo(
//             value: value,
//           );
//
//           return GestureDetector(
//             key: const ValueKey<String>('URLVideoPlayer'),
//             onTap: value == null ? null : () async {
//
//               if (value.isPlaying == true){
//                 onPause();
//               }
//               else {
//                 onPlay();
//               }
//
//             },
//             child: Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//
//                 /// CHILD
//                 Container(
//                   width: width,
//                   height: _boxHeight,
//                   decoration: BoxDecoration(
//                     borderRadius: _corners,
//                     // color: Colorz.bloodTest,
//                   ),
//                   child: _showVideo == false ? const SizedBox()
//                   :
//                   Card(
//                       clipBehavior: Clip.antiAlias,
//                       /// to clip the child corners to be circular forcefully
//                       shape: RoundedRectangleBorder(borderRadius: _corners),
//                       // color: Colorz.black255,
//                       child: VideoPlayer(videoPlayerController!)
//                   )
//                   ,
//                 ),
//
//                 /// LOADING
//                 if (_isLoading == true)
//                   SuperBox(
//                     height: width * 0.3,
//                     width: width * 0.3,
//                     icon: Iconz.reload,
//                     bubble: false,
//                     opacity: 0.5,
//                     loading: true,
//                   ),
//
//                 /// PLAY ICON ON TOP
//                 if (_showPlayIcon == true)
//                   SuperBox(
//                     height: width * 0.3,
//                     width: width * 0.3,
//                     icon: Iconz.play,
//                     bubble: false,
//                     opacity: 0.5,
//                   ),
//
//                 /// ERROR ICON
//                 if (value != null && value.hasError == true)
//                   SuperBox(
//                     height: width * 0.2,
//                     width: width * 0.2,
//                     icon: errorIcon,
//                     bubble: false,
//                     opacity: 0.1,
//                   ),
//
//                 /// VOLUME SLIDER
//                 if (value?.hasError == false)
//                 ValueListenableBuilder(
//                   valueListenable: isChangingVolume,
//                   builder: (_, bool isChanging, Widget? child) {
//                     return Opacity(
//                         opacity: isChanging == true ? 1.0 : 0.0,
//                         child: child
//                     );
//                   },
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       width: width * 0.1,
//                       height: _boxHeight,
//                       color: Colorz.black150,
//                       child: RotatedBox(
//                         quarterTurns: 3,
//                         child: Slider(
//                           // max: 1.0,
//                           // min: 0.0,
//                           onChanged: onVolumeChanged,
//                           thumbColor: Colors.white,
//                           activeColor: Colors.white,
//                           inactiveColor: Colors.grey,
//                           value: value?.volume ?? 1,
//
//                           // label: 'Volume',
//                           // secondaryActiveColor: Colorz.blue125,
//                           // secondaryTrackValue: 0.5,
//                           // focusNode: ,
//                           // mouseCursor: ,
//                           // autofocus: ,
//                           // divisions: ,
//                           onChangeStart: (double value) {
//                             setNotifier(
//                               notifier: isChangingVolume,
//                               mounted: true,
//                               value: true,
//                             );
//                           },
//                           onChangeEnd: (double value) async {
//                             await Future.delayed(const Duration(seconds: 1), () async {
//                               setNotifier(
//                                 notifier: isChangingVolume,
//                                 mounted: true,
//                                 value: false,
//                               );
//                             });
//                             },
//                           // overlayColor: ,
//                           // semanticFormatterCallback: ,
//                           // key: ,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           );
//         },
//         child: Card(
//             clipBehavior: Clip.antiAlias,
//             /// to clip the child corners to be circular forcefully
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.02)),
//             // color: Colorz.black255,
//             child: VideoPlayer(videoPlayerController!)
//         ),
//       );
//     }
//
//
//   }
//   // --------------------------------------------------------------------------
// }
