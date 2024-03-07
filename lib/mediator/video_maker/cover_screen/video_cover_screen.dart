import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/layouts/layouts/basic_layout.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:flutter/material.dart';

class VideoCoverScreen extends StatefulWidget {
  /// -----------------------------------------------------------------------------
  const VideoCoverScreen({
    required this.video,
    required this.aspectRatio,
    required this.appIsLTR,
    required this.confirmText,
    super.key
  });
  // --------------------
  final MediaModel? video;
  final double aspectRatio;
  final bool appIsLTR;
  final String? confirmText;
  // --------------------
  @override
  _VideoCoverScreenState createState() => _VideoCoverScreenState();
  /// -----------------------------------------------------------------------------
  static double getFooterHeight(){
    return Ratioz.horizon;
  }
  // -----------------------------------------------------------------------------
  static double getImagesZoneHeight({
    required double screenHeight,
  }){
    final double _imagesFooterHeight = VideoCoverScreen.getFooterHeight();
    final double _imageSpaceHeight = screenHeight - Ratioz.stratosphere - _imagesFooterHeight;
    return _imageSpaceHeight;
  }
// -----------------------------------------------------------------------------
}

class _VideoCoverScreenState extends State<VideoCoverScreen> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(
      safeAreaIsOn: true,
      body: Column(
        children: <Widget>[

          SuperBox(
            height: 50,
            text: 'Trimming screen',
            onTap: (){},
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
