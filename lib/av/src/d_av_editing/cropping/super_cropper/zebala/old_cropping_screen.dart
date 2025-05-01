
// class OldCroppingScreen extends StatefulWidget {
//   /// -----------------------------------------------------------------------------
//   const OldCroppingScreen({
//     required this.mediaModels,
//     this.confirmText = 'Continue',
//     this.appIsLTR = true,
//     this.aspectRatio = 1,
//     super.key
//   });
//   /// -----------------------------------------------------------------------------
//   final List<MediaModel> mediaModels;
//   final double aspectRatio;
//   final String confirmText;
//   final bool appIsLTR;
//   /// -----------------------------------------------------------------------------
//   @override
//   _OldCroppingScreenState createState() => _OldCroppingScreenState();
//   /// -----------------------------------------------------------------------------
//   static double getFooterHeight(){
//     return Ratioz.horizon;
//   }
//   // -----------------------------------------------------------------------------
//   static double getImagesZoneHeight({
//     required double screenHeight,
//   }){
//     final double _imagesFooterHeight = OldCroppingScreen.getFooterHeight();
//     final double _imageSpaceHeight = screenHeight - Ratioz.stratosphere - _imagesFooterHeight;
//     return _imageSpaceHeight;
//   }
//   // -----------------------------------------------------------------------------
// }
//
// class _OldCroppingScreenState extends State<OldCroppingScreen> {
//   // -----------------------------------------------------------------------------
//   final ValueNotifier<List<Uint8List>?> _croppedBytezz = ValueNotifier(null);
//   List<Uint8List> _originalBytezz = [];
//   final ValueNotifier<int> _currentImageIndex = ValueNotifier(0);
//   final List<CropController> _controllers = <CropController>[];
//   final PageController _pageController = PageController();
//   /// ON CROP TAP : ALL CONTROLLERS CROP, TAKE TIME THEN END AND ADD A CropStatus.ready to this list
//   /// when it reaches the length of the given files,, goes back with new cropped files
//   ValueNotifier<List<CropStatus>>? _statuses;
//   bool _canGoBack = false;
//   // -----------------------------------------------------------------------------
//   /// --- FUTURE LOADING BLOCK
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // -----------------------------------
//   Future<void> _triggerLoading({required bool setTo}) async {
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//     );
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//
//     _initializeControllers();
//
//     /// REMOVED
//     _statuses?.addListener(_statusesListener);
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       asyncInSync(() async {
//
//         final List<Uint8List> _bytezz = Byter.fromMediaModels(widget.mediaModels,);
//
//         setNotifier(
//           notifier: _croppedBytezz,
//           mounted: mounted,
//           value: _bytezz,
//         );
//
//         setState(() {
//           _originalBytezz = _bytezz;
//         });
//
//       });
//
//       // _triggerLoading(setTo: true).then((_) async {
//       //
//       //   await _triggerLoading(setTo: false);
//       // });
//     }
//
//     super.didChangeDependencies();
//   }
//   // --------------------
//   @override
//   void dispose() {
//     _statuses?.removeListener(_statusesListener);
//     _loading.dispose();
//     _pageController.dispose();
//     _currentImageIndex.dispose();
//     _statuses?.dispose();
//     _croppedBytezz.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//
//   /// INITIALIZATION
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void _initializeControllers(){
//
//     for (int i = 0; i < widget.mediaModels.length; i++){
//       final CropController _controller = CropController();
//       _controllers.add(_controller);
//     }
//
//     final List<CropStatus> _statusesList =  List.filled(widget.mediaModels.length, CropStatus.nothing);
//     _statuses = ValueNotifier(_statusesList);
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// LISTENER
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _statusesListener() async {
//
//     /// CHECK IF STATUSES ARE ALL READY
//     final bool _allImagesCropped = Lister.checkListsAreIdentical(
//       list1: _statuses?.value,
//       list2: List.filled(widget.mediaModels.length, CropStatus.ready),
//     );
//
//     if (_allImagesCropped == true && _canGoBack == true){
//
//       final List<MediaModel> _mediaModels = await MediaModel.replaceBytezzInMediaModels(
//         mediaModels: widget.mediaModels,
//         bytezz: _croppedBytezz.value,
//       );
//
//       await _triggerLoading(setTo: false);
//
//       /// GO BACK AND PASS THE FILES
//       await Nav.goBack(
//         context: context,
//         invoker: 'CroppingScreen',
//         passedData: _mediaModels,
//       );
//
//     }
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// CROP
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _cropImages() async {
//
//     await _triggerLoading(setTo: true);
//
//     for (final CropController controller in _controllers){
//       controller.crop();
//
//     }
//
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double _screenHeight = Scale.screenHeight(context);
//
//     return BasicLayout(
//       safeAreaIsOn: true,
//       // backgroundColor: Colorz.red255,
//       body:  Column(
//         children: <Widget>[
//
//           /// STRATOSPHERE SPACING
//           const SizedBox(
//             width: 10,
//             height: Ratioz.stratosphere,
//           ),
//
//           /// CROPPER PAGES
//           OldCropperPages(
//             currentImageIndex: _currentImageIndex,
//             aspectRatio: widget.aspectRatio,
//             screenHeight: _screenHeight,
//             controllers: _controllers,
//             croppedImages: _croppedBytezz,
//             originalBytezz: _originalBytezz,
//             pageController: _pageController,
//             statuses: _statuses!,
//             mounted: mounted,
//           ),
//
//           /// CROPPER FOOTER
//           CropperFooter(
//             loading: _loading,
//             appIsLTR: widget.appIsLTR,
//             confirmText: widget.confirmText,
//             screenHeight: _screenHeight,
//             aspectRatio: widget.aspectRatio,
//             currentImageIndex: _currentImageIndex,
//             bytezz: _originalBytezz, /// PUT CROPPED BYTEZZ HERE IF YOU WANT TO LISTEN TO CHANGES
//             onCropImages: () async {
//
//               await _cropImages();
//               _canGoBack = true;
//
//             },
//             onImageTap: (int index) async {
//
//               setNotifier(notifier: _currentImageIndex, mounted: mounted, value: index);
//
//               await _pageController.animateToPage(index,
//                 duration: Ratioz.durationFading200,
//                 curve: Curves.easeInOut,
//               );
//
//             },
//           ),
//
//         ],
//       ),
//     );
//
//   }
// // -----------------------------------------------------------------------------
// }

///

// class OldBldrsCroppingScreen extends StatefulWidget {
//   // -----------------------------------------------------------------------------
//   const OldBldrsCroppingScreen({
//     required this.mediaModels,
//     this.aspectRatio = 1,
//     super.key
//   });
//   // --------------------
//   final List<MediaModel>? mediaModels;
//   final double aspectRatio;
//   // --------------------
//   @override
//   _OldBldrsCroppingScreenState createState() => _OldBldrsCroppingScreenState();
//   // -----------------------------------------------------------------------------
//
//   /// ON CROP
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<MediaModel?> onCropSinglePic({
//     required MediaModel? media,
//     required double aspectRatio,
//   }) async {
//     MediaModel? _output;
//
//     if (media != null){
//
//       final MediaModel? _media = await PicMaker.resizePic(
//         mediaModel: media,
//         resizeToWidth: PicMaker.maxPicWidthBeforeCrop,
//       );
//
//       if (_media != null){
//
//         final List<MediaModel>? _received = await BldrsNav.goToNewScreen(
//           screen: OldBldrsCroppingScreen(
//             mediaModels: [_media],
//             aspectRatio: aspectRatio,
//           ),
//         );
//
//         _output = _received?.firstOrNull;
//
//       }
//
//
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<MediaModel>> onCropMultiplePics({
//     required List<MediaModel>? medias,
//     required double aspectRatio,
//   }) async {
//     List<MediaModel>? _output = <MediaModel>[];
//     List<MediaModel>? _resized = <MediaModel>[];
//     if (Lister.checkCanLoop(medias) == true){
//       _resized = await PicMaker.resizePics(
//         mediaModels: medias,
//         resizeToWidth: PicMaker.maxPicWidthBeforeCrop,
//       );
//       if (Lister.checkCanLoop(_resized) == true){
//         _output = await BldrsNav.goToNewScreen(
//           screen: OldBldrsCroppingScreen(
//             mediaModels: _resized,
//             aspectRatio: aspectRatio,
//           ),
//         );
//       }
//     }
//     return _output ?? _resized;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// SIZES
//
//   // --------------------
//   static double getFooterHeight(){
//     return Ratioz.horizon;
//   }
//   // --------------------
//   static double getImagesZoneHeight({
//     required double screenHeight,
//   }){
//     final double _imagesFooterHeight = OldBldrsCroppingScreen.getFooterHeight();
//     final double _imageSpaceHeight = screenHeight - Ratioz.stratosphere - _imagesFooterHeight;
//     return _imageSpaceHeight;
//   }
//   // -----------------------------------------------------------------------------
// }
//
// class _OldBldrsCroppingScreenState extends State<OldBldrsCroppingScreen> {
//   // -----------------------------------------------------------------------------
//   List<Uint8List> _originalBytezz = [];
//   // --------------------
//   final Wire<List<Uint8List>?> _croppedBytezz = Wire<List<Uint8List>?>(null);
//   final Wire<int> _currentImageIndex = Wire<int>(0);
//   final List<CropController> _controllers = <CropController>[];
//   final PageController _pageController = PageController();
//   // --------------------
//   /// ON CROP TAP : ALL CONTROLLERS CROP, TAKE TIME THEN END AND ADD A CropStatus.ready to this list
//   // --------------------
//   /// when it reaches the length of the given files,, goes back with new cropped files
//   // --------------------
//   Wire<List<CropStatus>>? _statuses;
//   bool _canGoBack = false;
//   // -----------------------------------------------------------------------------
//   /// --- FUTURE LOADING BLOCK
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // --------------------
//   Future<void> _triggerLoading({required bool setTo}) async {
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//     );
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     _initializeControllers();
//
//     /// REMOVED
//     _statuses?.addListener(_statusesListener);
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       asyncInSync(() async {
//
//         if (Lister.checkCanLoop(widget.mediaModels) == true){
//
//           final List<Uint8List> _bytezz = Byter.fromMediaModels(widget.mediaModels!);
//
//           _croppedBytezz.set(
//             mounted: mounted,
//             value: _bytezz,
//           );
//
//           setState(() {
//             _originalBytezz = _bytezz;
//           });
//
//         }
//
//       });
//
//     }
//
//     super.didChangeDependencies();
//   }
//   // --------------------
//   @override
//   void dispose() {
//     _statuses?.removeListener(_statusesListener);
//     _loading.dispose();
//     _pageController.dispose();
//     _currentImageIndex.dispose();
//     _statuses?.dispose();
//     _croppedBytezz.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//
//   /// INITIALIZATION
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void _initializeControllers(){
//
//     if (Lister.checkCanLoop(widget.mediaModels) == true){
//       for (int i = 0; i < widget.mediaModels!.length; i++){
//         final CropController _controller = CropController();
//         _controllers.add(_controller);
//       }
//
//       final List<CropStatus> _statusesList =  List.filled(widget.mediaModels!.length, CropStatus.nothing);
//       _statuses = ValueNotifier(_statusesList);
//     }
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// LISTENER
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _statusesListener() async {
//
//     /// CHECK IF STATUSES ARE ALL READY
//     final bool _allImagesCropped = Lister.checkListsAreIdentical(
//       list1: _statuses?.value,
//       list2: List.filled(widget.mediaModels?.length ?? 0, CropStatus.ready),
//     );
//
//     if (_allImagesCropped == true && _canGoBack == true){
//
//       final List<MediaModel> _mediaModels = await MediaModel.replaceBytezzInMediaModels(
//         mediaModels: widget.mediaModels ?? [],
//         bytezz: _croppedBytezz.value,
//       );
//
//       await _triggerLoading(setTo: false);
//
//       /// GO BACK AND PASS THE FILES
//       await Nav.goBack(
//         context: context,
//         invoker: 'CroppingScreen',
//         passedData: _mediaModels,
//       );
//
//     }
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// CROP
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _cropImages() async {
//
//     await _triggerLoading(setTo: true);
//
//     for (int i = 0; i < _controllers.length; i++){
//
//       await tryAndCatch(
//           invoker: '_cropImages',
//           functions: () async {
//
//             final CropController controller = _controllers[i];
//             final Uint8List? _bytes = _croppedBytezz.value?[i];
//
//             final bool _isDecodable = Decoding.checkImageIsDecodable(
//               bytes: _bytes,
//             );
//
//             if (mounted && _isDecodable == true){
//               controller.crop();
//             }
//
//           },
//       );
//     }
//
//     _canGoBack = true;
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _onImageTap(int index) async {
//
//     setNotifier(
//       notifier: _currentImageIndex,
//       mounted: mounted,
//       value: index,
//     );
//
//     await _pageController.animateToPage(index,
//       duration: Ratioz.durationFading200,
//       curve: Curves.easeInOut,
//     );
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// EXIT
//
//   // --------------------
//   Future<void> _onBack() async {
//     await Nav.goBack(
//       context: context,
//     );
//   }
//   // -----------------------------------------------------------------------------
//
//   /// CROP LISTENERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void _updateCropStatus(CropStatus status, int index){
//     if (_statuses != null && _statuses?.value[index] != status){
//
//       final List<CropStatus> _list = <CropStatus>[..._statuses!.value];
//
//       _list[index] = status;
//
//       _statuses?.set(
//         value: _list,
//         mounted: mounted,
//       );
//
//     }
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void _onPageChanged(int index){
//     _currentImageIndex.set(
//       mounted: mounted,
//       value: index,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void _onPicCropped(Uint8List bytes, int index){
//
//     final List<Uint8List> _pics = _croppedBytezz.value ?? [];
//
//     /// WITHIN RANGE
//     if (index < _pics.length){
//       _pics.removeAt(index);
//       _pics.insert(index, bytes);
//     }
//     else {
//       _pics.add(bytes);
//     }
//
//     _croppedBytezz.set(
//       value: _pics,
//       mounted: mounted,
//     );
//
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final bool _panelIsOn = Lister.superLength(_originalBytezz) > 1;
//
//     return BasicLayout(
//       safeAreaIsOn: true,
//       // backgroundColor: Colorz.red255,
//       body:  Column(
//         children: <Widget>[
//
//           /// CROPPER PAGES
//           BldrsCropperPages(
//             panelIsOn: _panelIsOn,
//             aspectRatio: widget.aspectRatio,
//             controllers: _controllers,
//             croppedImages: _croppedBytezz,
//             originalBytezz: _originalBytezz,
//             pageController: _pageController,
//             updateCropStatus: _updateCropStatus,
//             onPageChanged: _onPageChanged,
//             onPicCropped: _onPicCropped,
//           ),
//
//           /// CROPPER PANEL
//           BldrsCropperPanel(
//             panelIsOn: _panelIsOn,
//             aspectRatio: widget.aspectRatio,
//             bytezz: _originalBytezz,
//             currentImageIndex: _currentImageIndex,
//             onImageTap: _onImageTap,
//           ),
//
//           /// CROPPER FOOTER
//           BldrsCropperFooter(
//             loading: _loading,
//             onCropImages: _cropImages,
//             onBack: _onBack,
//           ),
//
//         ],
//       ),
//     );
//
//   }
// // -----------------------------------------------------------------------------
// }
