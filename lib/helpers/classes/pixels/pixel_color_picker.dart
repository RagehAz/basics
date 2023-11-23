import 'dart:async';
import 'dart:typed_data';
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/pixels/pixelizer.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class PixelColorPicker extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PixelColorPicker({
    required this.child,
    required this.builder,
    this.isOn = true,
    this.initialColor = Colorz.white255,
    this.indicatorSize = 20,
    this.showIndicator = true,
    this.showCrossHair = true,
    super.key
  });
  // --------------------
  final Widget child;
  final Widget Function(Color color, Widget child) builder;
  final Color initialColor;
  final bool isOn;
  final double indicatorSize;
  final bool showIndicator;
  final bool showCrossHair;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (isOn == true){
      return _PixelColorPickerOn(
        initialColor: initialColor,
        builder: builder,
        indicatorSize: indicatorSize,
        showIndicator: showIndicator,
        showCrossHair: showCrossHair,
        child: child,
      );
    }
    // --------------------
    else {
      return builder(initialColor, child);
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class _PixelColorPickerOn extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _PixelColorPickerOn({
    required this.child,
    required this.builder,
    required this.initialColor,
    required this.indicatorSize,
    required this.showIndicator,
    required this.showCrossHair,
    // super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final Widget Function(Color color, Widget child) builder;
  final Color initialColor;
  final double indicatorSize;
  final bool showIndicator;
  final bool showCrossHair;
  /// --------------------------------------------------------------------------
  @override
  _PixelColorPickerOnState createState() => _PixelColorPickerOnState();
  /// --------------------------------------------------------------------------
}

class _PixelColorPickerOnState extends State<_PixelColorPickerOn> {
  // --------------------
  GlobalKey paintKey = GlobalKey();
  final StreamController<Color> _stateController = StreamController<Color>();
  img.Image? photo;
  Offset _offset = Offset.zero;
  bool _indicatorIsOn = false;
  // -----------------------------------------------------------------------------
  /*
  @override
  void initState() {
    super.initState();
  }
   */
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _isInit = false; // good
    }
    super.didChangeDependencies();
  }
   */
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
  /*
  @override
  void dispose() {
    super.dispose();
  }
   */
  // --------------------
  Future<void> _snapshotWidgetTree() async {

    final Uint8List? _bytes = await Pixelizer.snapshotWidget(
      key: paintKey,
    );

    if (_bytes != null){
      photo = img.decodeImage(_bytes);
    }

  }
  // --------------------
  Future<void> _calculatePixel({
    required Offset? globalPosition,
    required bool autoHideIndicator,
  }) async {

    _indicatorIsOn = true;

    if (photo == null) {
      await _snapshotWidgetTree();
    }

    final img.Pixel? _pixel = Pixelizer.getPixelFromGlobalPosition(
      key: paintKey,
      image: photo,
      globalPosition: globalPosition,
      // scaleToImage: false,
    );

    if (_pixel != null){

      _offset = Offset(_pixel.x.toDouble(), _pixel.y.toDouble());

      final Color? _color = Pixelizer.getPixelColor(
        pixel: _pixel,
      );

      if (_color != null){
        _stateController.add(_color);
      }

    }

    if (autoHideIndicator == true){
      await _hideIndicator();
    }

  }
  // --------------------
  Future<void> _hideIndicator() async {
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _indicatorIsOn = false;
      });
    });
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return StreamBuilder(
        initialData: widget.initialColor,
        stream: _stateController.stream,
        builder: (buildContext, snapshot) {

          final Color _color = snapshot.data ?? widget.initialColor;

          return RepaintBoundary(
            key: paintKey,
            child: GestureDetector(

              /// ON START
              onPanStart: (details) => _calculatePixel(
                globalPosition: details.globalPosition,
                autoHideIndicator: false,
              ),
              /// ON MOVING
              onPanUpdate: (details) => _calculatePixel(
                globalPosition: details.globalPosition,
                autoHideIndicator: false,
              ),
              /// ON END
              onPanEnd: (details) => _calculatePixel(
                globalPosition: _offset,
                autoHideIndicator: true,
              ),

              child: Stack(
                children: <Widget>[

                  widget.builder(_color, widget.child),

                  if (widget.showIndicator == true)
                    Positioned(
                      top: _offset.dy - (widget.indicatorSize / 2) - (widget.indicatorSize) - 10,
                      left: _offset.dx - (widget.indicatorSize / 2),
                      child: WidgetFader(
                        fadeType: _indicatorIsOn == true ? FadeType.fadeIn : FadeType.fadeOut,
                        duration: _indicatorIsOn == true ?
                        const Duration(milliseconds: 200)
                            :
                        const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Container(
                              width: widget.indicatorSize,
                              height: widget.indicatorSize,
                              decoration: BoxDecoration(
                                color: _color,
                                border: Border.all(
                                  color: Colorz.white200,
                                ),
                                borderRadius: BorderRadius.circular(widget.indicatorSize / 2),
                              ),
                            ),

                            if (widget.showCrossHair == true)
                            const Spacing(size: 10,),

                            if (widget.showCrossHair == true)
                            Material(
                              child: SuperBox(
                                width: widget.indicatorSize,
                                height: widget.indicatorSize,
                                icon: '+',
                                bubble: false,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                ],
              ),
            ),
          );

        });
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
