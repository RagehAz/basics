// part of super_video_player;
//
// class FileAndURLVideoPlayer extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const FileAndURLVideoPlayer({
//     this.corners,
//     this.superVideoController,
//     this.file,
//     this.asset,
//     this.url,
//     // this.controller,
//     this.width,
//     this.autoPlay = false,
//     this.loop = false,
//     this.errorIcon,
//     super.key
//   });
//   // --------------------
//   final String? url;
//   final String? asset;
//   final File? file;
//   // final VideoPlayerController? controller;
//   final double? width;
//   final bool autoPlay;
//   final bool loop;
//   final String? errorIcon;
//   final dynamic corners;
//   final SuperVideoController? superVideoController;
//   // --------------------------------------------------------------------------
//   @override
//   _FileAndURLVideoPlayerState createState() => _FileAndURLVideoPlayerState();
//   // --------------------------------------------------------------------------
// }
//
// class _FileAndURLVideoPlayerState extends State<FileAndURLVideoPlayer> {
//   // --------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
//   // --------------------
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
//         Filer.checkFilesAreIdentical(file1: oldWidget.file, file2: widget.file) == false
//     ) {
//
//       _reload();
//
//     }
//   }
//   // --------------------------------------------------------------------------
//
//   /// CONTROLS
//
//   // --------------------
//   bool _show = true;
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void _reload() {
//
//     asyncInSync(() async {
//
//       setState(() {
//         _show = false;
//       });
//
//       await Future.delayed(const Duration(milliseconds: 300));
//
//       setState(() {
//         _show = true;
//       });
//
//   });
//
//   }
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     if (_show == false){
//       return const SizedBox();
//     }
//     // --------------------
//     else {
//       return _Player(
//         // controller: widget.controller,
//         file: widget.file,
//         url: widget.url,
//         asset: widget.asset,
//         loop: widget.loop,
//         autoPlay: widget.autoPlay,
//         width: widget.width ?? Scale.screenWidth(context),
//         errorIcon: widget.errorIcon,
//         superVideoController: widget.superVideoController,
//         corners: widget.corners,
//       );
//     }
//     // --------------------
//   }
//   // --------------------------------------------------------------------------
// }
