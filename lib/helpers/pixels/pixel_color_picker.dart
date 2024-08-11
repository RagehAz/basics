import 'dart:async';
import 'dart:typed_data';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/pixels/pixelizer.dart';
import 'package:basics/components/drawing/spacing.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/helpers/wire/wire.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

// -----------------------------------------------------------------------------

class PixelColorPickerOld extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PixelColorPickerOld({
    required this.child,
    required this.mounted,
    required this.isOn,
    this.pickedColor,
    this.loading,
    this.initialColor = Colorz.white255,
    this.indicatorSize = 20,
    this.showIndicator = true,
    this.showCrossHair = true,
    this.onPicked,
    super.key
  });
  // --------------------
  final Widget child;
  final ValueNotifier<bool> isOn;
  final ValueNotifier<Color?>? pickedColor;
  final ValueNotifier<bool>? loading;
  final bool mounted;
  final Color initialColor;
  final double indicatorSize;
  final bool showIndicator;
  final bool showCrossHair;
  final Function(Color? color)? onPicked;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: isOn,
      child: child,
      builder: (_, bool on, Widget? x) {

        if (on == true){
          return PixelColorPickerBuilderOld(
            initialColor: initialColor,
            isOn: on,
            showCrossHair: showCrossHair,
            showIndicator: showIndicator,
            indicatorSize: indicatorSize,
            child: x!,
            builder: (bool isLoading, Color? color, Widget y) {
              // --------------------
              pickedColor?.set(value: color, mounted: mounted);
              loading?.set(value: isLoading, mounted: mounted);
              // --------------------
                onPicked?.call(color);
              // --------------------
              return y;
              // --------------------
            },
          );
        }

        else {
          return x!;
        }

      }
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------

class PixelColorPickerBuilderOld extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PixelColorPickerBuilderOld({
    required this.child,
    this.builder,
    this.isOn = true,
    this.initialColor = Colorz.white255,
    this.indicatorSize = 20,
    this.showIndicator = true,
    this.showCrossHair = true,
    this.onColorChanged,
    this.onColorChangeEnded,
    this.onSnapshotCreated,
    super.key
  });
  // --------------------
  final Widget child;
  final Widget Function(bool loading, Color? color, Widget child)? builder;
  final Color initialColor;
  final bool isOn;
  final double indicatorSize;
  final bool showIndicator;
  final bool showCrossHair;
  final Function(Color? color)? onColorChanged;
  final Function(Color? color)? onColorChangeEnded;
  final Function(Uint8List? bytes)? onSnapshotCreated;
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
        onColorChanged: onColorChanged,
        onColorChangeEnded: onColorChangeEnded,
        onSnapshotCreated: onSnapshotCreated,
        child: child,
      );
    }
    // --------------------
    else if (builder == null){
      return child;
    }
    else {
      return builder!(false, initialColor, child);
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------

class _PixelColorPickerOn extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const _PixelColorPickerOn({
    required this.child,
    required this.builder,
    required this.initialColor,
    required this.indicatorSize,
    required this.showIndicator,
    required this.showCrossHair,
    required this.onColorChanged,
    this.onColorChangeEnded,
    this.onSnapshotCreated,
    // super.key
  });
  // --------------------
  final Widget child;
  final Widget Function(bool loading, Color? color, Widget child)? builder;
  final Color initialColor;
  final double indicatorSize;
  final bool showIndicator;
  final bool showCrossHair;
  final Function(Color? color)? onColorChanged;
  final Function(Color? color)? onColorChangeEnded;
  final Function(Uint8List? bytes)? onSnapshotCreated;
  // --------------------
  @override
  _PixelColorPickerOnState createState() => _PixelColorPickerOnState();
  // --------------------------------------------------------------------------
}

class _PixelColorPickerOnState extends State<_PixelColorPickerOn> {
  // -----------------------------------------------------------------------------
  final Wire<Color?> _colorWire = Wire<Color?>(null);
  final Wire<Offset> _offset = Wire<Offset>(Offset.zero);
  final Wire<img.Image?> _photo = Wire<img.Image?>(null);
  final Wire<Uint8List?> _bytes = Wire<Uint8List?>(null);
  final Wire<bool> _indicatorIsOn = Wire<bool>(false);
  final Wire<bool> _loading = Wire<bool>(false);
  // --------------------
  GlobalKey paintKey = GlobalKey();
  // -----------------------------------------------------------------------------
  /*
  @override
  void initState() {
    super.initState();
  }
   */
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {
        await _snapshotWidgetTree();
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(_PixelColorPickerOn oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (widget.child != oldWidget.child){
    //   blog('-pixel picker : child changed');
    // }
    // if (widget.initialColor != oldWidget.initialColor){
    //   blog('-pixel picker : initialColor changed');
    // }
    // if (widget.onColorChanged != oldWidget.onColorChanged){
    //   blog('-pixel picker : onColorChanged changed');
    // }
    // if (widget.child.key != oldWidget.child.key){
    //   blog('-pixel picker : child keys changed');
    // }

    if (
          widget.child.key != oldWidget.child.key
        || widget.initialColor != oldWidget.initialColor
        || widget.indicatorSize != oldWidget.indicatorSize
        || widget.showIndicator != oldWidget.showIndicator
        || widget.showCrossHair != oldWidget.showCrossHair
        // || widget.onColorChanged != oldWidget.onColorChanged
    ) {

      Future.delayed(const Duration(milliseconds: 100), () {
        _photo.set(value: null, mounted: mounted);
        unawaited(_snapshotWidgetTree());
      });

    }

  }
  // --------------------
  @override
  void dispose() {
    _colorWire.clear();
    _offset.clear();
    _photo.clear();
    _bytes.clear();
    _indicatorIsOn.clear();
    _loading.clear();
    super.dispose();
  }
  // --------------------
  Future<void> _snapshotWidgetTree() async {

    await Future.delayed(const Duration(milliseconds: 1000));

    if (_photo.value == null){

      if (mounted){

        // _loading.set(value: true, mounted: mounted);
        //
        // // paintKey = GlobalKey();
        //
        // final Uint8List? _b = await Pixelizer.snapshotWidget(
        //   key: paintKey,
        //   context: context,
        // );
        //
        // if (_b != null){
        //
        //   final bool _identical = Byter.checkBytesAreIdentical(
        //     bytes1: _b,
        //     bytes2: _bytes.value,
        //   );
        //
        //   if (_identical == false){
        //     _bytes.set(mounted: mounted, value: _b);
        //     _photo.set(value: img.decodeImage(_b), mounted: mounted);
        //     await widget.onSnapshotCreated?.call(_b);
        //   }
        //
        // }
        //
        // _loading.set(value: false, mounted: mounted);

      }

    }

  }
  // --------------------
  Future<Color?> _calculatePixel({
    required Offset? globalPosition,
    required bool autoHideIndicator,
  }) async {
    Color? _color;

    _indicatorIsOn.set(value: true, mounted: mounted);

    if (_photo.value == null) {
      await _snapshotWidgetTree();
    }

    final img.Pixel? _pixel = Pixelizer.getPixelFromGlobalPosition(
      key: paintKey,
      image: _photo.value,
      globalPosition: globalPosition,
      scaleToImage: true,
    );

    if (_pixel != null){

      _offset.set(
        value: Offset(_pixel.x.toDouble(), _pixel.y.toDouble()),
        mounted: mounted,
      );

       _color = Pixelizer.getPixelColor(pixel: _pixel);

      widget.onColorChanged?.call(_color);

      if (_color != null){
        _colorWire.set(value: _color, mounted: mounted);
      }

    }

    if (autoHideIndicator == true){
      await _hideIndicator();
    }

    return _color;
  }
  // --------------------
  Future<void> _hideIndicator() async {
    await Future.delayed(const Duration(seconds: 1), () {
      _indicatorIsOn.set(value: false, mounted: mounted);
    });
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
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
        onPanEnd: (details) async {

          final Color? _color = await _calculatePixel(
            globalPosition: _offset.value,
            autoHideIndicator: true,
          );

          await widget.onColorChangeEnded?.call(_color);

        },

        child: Stack(
          children: <Widget>[

            if (widget.builder != null)
              LiveWire(
                  wire: _colorWire,
                  child: widget.child,
                  builder: (Color? _color, Widget? child) {
                    return LiveWire(
                        wire: _loading,
                        child: child,
                        builder: (bool isLoading, Widget? child) {
                          return widget.builder!(isLoading, _color, child!);
                        }
                        );
                  }
                  ),

            if (widget.builder == null)
              widget.child,

            if (widget.showIndicator == true)
              LiveWire(
                wire: _offset,
                builder: (Offset offset, Widget? child) {
                  return Positioned(
                    top: offset.dy - (widget.indicatorSize / 2) - (widget.indicatorSize) - 10,
                    left: offset.dx - (widget.indicatorSize / 2),
                    child: child!,
                  );
                },
                child: _Indicator(
                  color: _colorWire,
                  showCrossHair: widget.showCrossHair,
                  indicatorSize: widget.indicatorSize,
                  indicatorIsOn: _indicatorIsOn,
                ),
              ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------

class _Indicator extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _Indicator({
    required this.indicatorSize,
    required this.showCrossHair,
    required this.color,
    required this.indicatorIsOn,
  });
  // --------------------
  final double indicatorSize;
  final bool showCrossHair;
  final Wire<Color?> color;
  final Wire<bool> indicatorIsOn;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return LiveWire(
      wire: indicatorIsOn,
      builder: (bool indicatorOn, Widget? indicator) {

        return WidgetFader(
          fadeType: indicatorOn == true ? FadeType.fadeIn : FadeType.fadeOut,
          duration: indicatorOn == true ? const Duration(milliseconds: 200) : const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          child: indicator,
        );

      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

          SingleWire(
            wire: color,
              builder: (Color? _color) {
                return Container(
                  width: indicatorSize,
                  height: indicatorSize,
                  decoration: BoxDecoration(
                    color: _color,
                    border: Border.all(
                      color: Colorz.white200,
                    ),
                    borderRadius: BorderRadius.circular(indicatorSize / 2),
                  ),
                );
              }
          ),

          if (showCrossHair == true)
            const Spacing(
              // size: 10
            ),

          if (showCrossHair == true)
            Material(
              child: SuperBox(
                width: indicatorSize,
                height: indicatorSize,
                icon: '+',
                bubble: false,
              ),
            ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------
