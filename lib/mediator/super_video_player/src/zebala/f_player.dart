// part of super_video_player;
//
// class _Player extends StatefulWidget {
//   // --------------------------------------------------------------------------
//   const _Player({
//     required this.superVideoController,
//     required this.file,
//     required this.asset,
//     required this.url,
//     // required this.controller,
//     required this.width,
//     required this.autoPlay,
//     required this.loop,
//     required this.errorIcon,
//     required this.corners,
//   });
//   // --------------------
//   final SuperVideoController? superVideoController;
//   final String? url;
//   final String? asset;
//   final File? file;
//   // final VideoPlayerController? controller;
//   final double? width;
//   final bool autoPlay;
//   final bool loop;
//   final String? errorIcon;
//   final dynamic corners;
//   // --------------------------------------------------------------------------
//   @override
//   _PlayerState createState() => _PlayerState();
//   // --------------------------------------------------------------------------
// }
//
// class _PlayerState extends State<_Player> {
//   // --------------------------------------------------------------------------
//   late SuperVideoController _superController;
//   // --------------------------------------------------------------------------
//   // late ValueNotifier<VideoPlayerValue?> _videoValue;
//   // late ValueNotifier<bool> _isChangingVolume;
//   // VideoPlayerController? _videoPlayerController;
//   // --------------------
//   // double _volume = 1;
//   // --------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.superVideoController == null){
//
//       _superController = SuperVideoController();
//
//       _superController.initialize(
//         url: widget.url,
//         file: widget.file,
//         autoPlay: widget.autoPlay,
//         asset: widget.asset,
//         loop: widget.loop,
//       );
//
//     }
//
//     else {
//       _superController = widget.superVideoController!;
//     }
//
//
//     // _videoValue = ValueNotifier(null);
//     // _isChangingVolume = ValueNotifier(false);
//
//     // _videoPlayerController = widget.controller ?? _Player.initializeVideoController(
//     //   url: widget.url,
//     //   file: widget.file,
//     //   _videoValue: _videoValue,
//     //   mounted: mounted,
//     //   autoPlay: widget.autoPlay,
//     //   asset: widget.asset,
//     //   loop: widget.loop,
//     //   // addListener: true,
//     // )!;
//
//     // /// REMOVED
//     // _videoPlayerController!.addListener(listen);
//
//
//   }
//   // --------------------
//   /*
//   @override
//   void didUpdateWidget(FileAndURLVideoPlayer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     // String? url;
//     // String? asset;
//     // File? file;
//     // VideoPlayerController? controller;
//     // double? width;
//     // bool autoPlay;
//     // bool loop;
//     // String? errorIcon;
//
//     if (
//         oldWidget.url != widget.url ||
//         oldWidget.asset != widget.asset ||
//         Filers.checkFilesAreIdentical(file1: oldWidget.file, file2: widget.file) == false
//     ) {
//
//       blog('should restart video player');
//
//       _pause();
//
//       _videoValue.value = null;
//       _isChangingVolume.value = false;
//
//       _videoPlayerController?.removeListener(listen);
//       _videoPlayerController?.dispose();
//       _videoPlayerController = null;
//
//       _videoPlayerController = FileAndURLVideoPlayer.initializeVideoController(
//         url: widget.url,
//         file: widget.file,
//         videoValue: _videoValue,
//         mounted: mounted,
//         autoPlay: widget.autoPlay,
//         asset: widget.asset,
//         loop: widget.loop,
//         // addListener: true,
//       )!;
//
//       /// REMOVED
//       // _videoPlayerController!.initialize();
//       _videoPlayerController!.addListener(listen);
//
//       setState(() {});
//
//     }
//   }
//    */
//   // --------------------
//   // void listen(){
//   //   _Player.listenToVideoValue(
//   //     mounted: mounted,
//   //     _videoValue: _videoValue,
//   //     _videoPlayerController: _videoPlayerController,
//   //   );
//   // }
//   // --------------------
//   @override
//   void dispose() {
//
//     if (widget.superVideoController == null){
//       _superController.dispose();
//     }
//
//     super.dispose();
//   }
//   // --------------------------------------------------------------------------
//
//   /// CONTROLS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void _play() {
//
//     setState(() {
//       _superController.play();
//       // _videoPlayerController?.play();
//       // _videoPlayerController?.setLooping(true);
//     });
//     // _value.isPlaying.log();
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void _pause() {
//
//     setState(() {
//       _superController.pause();
//       // _videoPlayerController?.pause();
//       // _videoPlayerController?.setLooping(false);
//     });
//     // _value.isPlaying.log();
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _setVolume(double volume) async {
//
//
//
//     if (_superController._volume.value != volume){
//       setState(() {
//         _superController.setVolume(volume: volume, mounted: mounted);
//         // _videoPlayerController?.setVolume(volume);
//         // _volume = volume;
//       });
//     }
//
//   }
//   // --------------------
//   /*
//   /// TESTED : WORKS PERFECT
//   Future<void> _increaseVolume() async {
//
//     final bool _canIncrease = _volume < _maxVolume;
//
//     blog('canIncrease : $_canIncrease : _volume : $_volume : _maxVolume : $_maxVolume');
//
//     if (_canIncrease){
//       await _setVolume(
//         _fixVolume(
//           num: _volume + 0.1,
//           isIncreasing: true,
//         ),
//       );
//     }
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _decreaseVolume() async {
//
//     if (_volume > 0){
//       await _setVolume(
//         _fixVolume(
//           num: _volume - 0.1,
//           isIncreasing: false,
//         ),
//       );
//     }
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   double _fixVolume({
//     required double num,
//     required bool isIncreasing,
//   }){
//
//     /// INCREASING
//     if (isIncreasing){
//       final double _n = (num * 10).ceilToDouble();
//       return Numeric.removeFractions(number: _n) / 10;
//     }
//
//     /// DECREASING
//     else {
//       final double _n = (num * 10).floorToDouble();
//       return Numeric.removeFractions(number: _n) / 10;
//     }
//
//   }
//    */
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     return VideoViewer(
//       onPlay: _play,
//       onPause: _pause,
//       width: widget.width ?? Scale.screenWidth(context),
//       videoPlayerController: _superController.videoPlayerController,
//       videoValue: _superController.videoValue,
//       onVolumeChanged: _setVolume,
//       isChangingVolume: _superController.isChangingVolume,
//       errorIcon: widget.errorIcon,
//       corners: widget.corners,
//     );
//     // --------------------
//   }
// // --------------------------------------------------------------------------
// }
