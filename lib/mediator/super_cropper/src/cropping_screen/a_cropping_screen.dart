part of super_cropper;

class CroppingScreen extends StatefulWidget {
  /// -----------------------------------------------------------------------------
  const CroppingScreen({
    required this.mediaModels,
    this.confirmText = 'Continue',
    this.appIsLTR = true,
    this.aspectRatio = 1,
    this.imageSpaceHeight,
    this.somethingIsWrongText,
    this.panelHeight = 15,
    super.key
  });
  /// -----------------------------------------------------------------------------
  final List<MediaModel>? mediaModels;
  final double aspectRatio;
  final String confirmText;
  final bool appIsLTR;
  final String? somethingIsWrongText;
  final double? imageSpaceHeight;
  final double panelHeight;
  /// -----------------------------------------------------------------------------
  @override
  _CroppingScreenState createState() => _CroppingScreenState();
  /// -----------------------------------------------------------------------------
  static double getFooterHeight(){
    return Ratioz.horizon;
  }
  // -----------------------------------------------------------------------------
  static double getImagesZoneHeight({
    required double screenHeight,
  }){
    final double _imagesFooterHeight = CroppingScreen.getFooterHeight();
    final double _imageSpaceHeight = screenHeight - Ratioz.stratosphere - _imagesFooterHeight;
    return _imageSpaceHeight;
  }
// -----------------------------------------------------------------------------
}

class _CroppingScreenState extends State<CroppingScreen> {
  // -----------------------------------------------------------------------------
  final Wire<List<MediaModel>> _cropped = Wire<List<MediaModel>>([]);
  final Wire<int> _currentImageIndex = Wire<int>(0);
  final List<PicMediaCropController> _controllers = <PicMediaCropController>[];
  final PageController _pageController = PageController();
  // -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final Wire<bool> _loading = Wire<bool>(false);
  // -----------------------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        _cropped.set(
          mounted: mounted,
          value: widget.mediaModels ?? [],
        );

      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _pageController.dispose();
    _currentImageIndex.dispose();
    _cropped.dispose();
    PicMediaCropController.disposeMultiple(
      controllers: _controllers,
    );
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeControllers(){
    if (Lister.checkCanLoop(widget.mediaModels) == true){
      for (int i = 0; i < widget.mediaModels!.length; i++){
        final PicMediaCropController _controller = PicMediaCropController();
        _controllers.add(_controller);
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// CROP

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _cropImages() async {

    await _triggerLoading(setTo: true);

    for (final PicMediaCropController controller in _controllers){
      await controller.cropPic();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onFooterImageTap(int index) async {

    if (Lister.checkCanLoop(widget.mediaModels) == true){

      _currentImageIndex.set(mounted: mounted, value: index);

      if (widget.mediaModels!.length > 1){
        await _pageController.animateToPage(index,
          duration: Ratioz.durationFading200,
          curve: Curves.easeInOut,
        );
      }


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onPageChanged(int index){
    _currentImageIndex.set(value: index, mounted: mounted);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.screenHeight(context);
    final bool _panelIsOn = Lister.superLength(widget.mediaModels) > 1;

    return BasicLayout(
      safeAreaIsOn: true,
      // backgroundColor: Colorz.red255,
      body:  Column(
        children: <Widget>[

          /// STRATOSPHERE SPACING
          const SizedBox(
            width: 10,
            height: Ratioz.stratosphere,
          ),

          /// CROPPER PAGES
          CropperPages(
            aspectRatio: widget.aspectRatio,
            controllers: _controllers,
            originalPics: widget.mediaModels,
            pageController: _pageController,
            onPageChanged: _onPageChanged,
            imageSpaceHeight: widget.imageSpaceHeight ?? CroppingScreen.getImagesZoneHeight(
              screenHeight: Scale.screenHeight(context),
            ),
            somethingIsWrongText: widget.somethingIsWrongText,
          ),

          BldrsCropperPanel(
            appIsLTR: widget.appIsLTR,
            aspectRatio: widget.aspectRatio,
            mediaModels: widget.mediaModels,
            currentImageIndex: _currentImageIndex,
            onImageTap: _onFooterImageTap,
            panelHeight: widget.panelHeight,
            panelIsOn: _panelIsOn,
          ),

          /// CROPPER FOOTER
          CropperFooter(
            loading: _loading,
            appIsLTR: widget.appIsLTR,
            confirmText: widget.confirmText,
            screenHeight: _screenHeight,
            aspectRatio: widget.aspectRatio,
            currentImageIndex: _currentImageIndex,
            pics: widget.mediaModels, /// PUT CROPPED BYTEZZ HERE IF YOU WANT TO LISTEN TO CHANGES
            onCropImages: _cropImages,
            onImageTap: _onFooterImageTap,
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
