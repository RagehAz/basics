import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/layouts/basic_layout.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/pic_maker/cropping_screen/cropper_footer.dart';
import 'package:basics/mediator/pic_maker/cropping_screen/cropper_pages.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';


class CroppingScreen extends StatefulWidget {
  /// -----------------------------------------------------------------------------
  const CroppingScreen({
    required this.bytezz,
    this.confirmText = 'Crop',
    this.appIsLTR = true,
    this.aspectRatio = 1,
    super.key
  });
  /// -----------------------------------------------------------------------------
  final List<Uint8List> bytezz;
  final double aspectRatio;
  final String confirmText;
  final bool appIsLTR;
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
  final ValueNotifier<List<Uint8List>?> _croppedBytezz = ValueNotifier(null);
  final ValueNotifier<int> _currentImageIndex = ValueNotifier(0);
  final List<CropController> _controllers = <CropController>[];
  final PageController _pageController = PageController();
  /// ON CROP TAP : ALL CONTROLLERS CROP, TAKE TIME THEN END AND ADD A CropStatus.ready to this list
  /// when it reaches the length of the given files,, goes back with new cropped files
  ValueNotifier<List<CropStatus>>? _statuses;
  bool _canGoBack = false;
  // -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
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

    setNotifier(notifier: _croppedBytezz, mounted: mounted, value: widget.bytezz);

    _initializeControllers();
    _statuses?.addListener(() async {

      /// CHECK IF STATUSES ARE ALL READY
      final bool _allImagesCropped = Mapper.checkListsAreIdentical(
        list1: _statuses?.value,
        list2: List.filled(widget.bytezz.length, CropStatus.ready),
      );

      if (_allImagesCropped == true && _canGoBack == true){

        await _triggerLoading(setTo: false);

        /// GO BACK AND PASS THE FILES
        await Nav.goBack(
          context: context,
          invoker: 'CroppingScreen',
          passedData: _croppedBytezz.value,
        );

      }

    });
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      // _triggerLoading(setTo: true).then((_) async {
      //
      //   await _triggerLoading(setTo: false);
      // });
    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _pageController.dispose();
    _currentImageIndex.dispose();
    _statuses?.dispose();
    _croppedBytezz.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _initializeControllers(){

    for (int i = 0; i < widget.bytezz.length; i++){
      final CropController _controller = CropController();
      _controllers.add(_controller);
    }

    final List<CropStatus> _statusesList =  List.filled(widget.bytezz.length, CropStatus.nothing);
    _statuses = ValueNotifier(_statusesList);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _cropImages() async {

    await _triggerLoading(setTo: true);

    for (final CropController controller in _controllers){
      controller.crop();

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.screenHeight(context);

    return BasicLayout(
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
            currentImageIndex: _currentImageIndex,
            aspectRatio: widget.aspectRatio,
            screenHeight: _screenHeight,
            controllers: _controllers,
            croppedImages: _croppedBytezz,
            originalBytezz: widget.bytezz,
            pageController: _pageController,
            statuses: _statuses!,
            mounted: mounted,
          ),

          /// CROPPER FOOTER
          CropperFooter(
            appIsLTR: widget.appIsLTR,
            confirmText: widget.confirmText,
            screenHeight: _screenHeight,
            aspectRatio: widget.aspectRatio,
            currentImageIndex: _currentImageIndex,
            bytezz: widget.bytezz, /// PUT CROPPED BYTEZZ HERE IF YOU WANT TO LISTEN TO CHANGES
            onCropImages: () async {

              await _cropImages();
              _canGoBack = true;

            },
            onImageTap: (int index) async {

              setNotifier(notifier: _currentImageIndex, mounted: mounted, value: index);

              await _pageController.animateToPage(index,
                duration: Ratioz.durationFading200,
                curve: Curves.easeInOut,
              );

            },
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
