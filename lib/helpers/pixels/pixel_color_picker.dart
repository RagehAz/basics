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

class PixelColorPicker extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PixelColorPicker({
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
          return PixelColorPickerBuilder(
            initialColor: initialColor,
            isOn: on,
            showCrossHair: showCrossHair,
            showIndicator: showIndicator,
            indicatorSize: indicatorSize,
            child: x!,
            builder: (bool isLoading, Color? color, Widget y) {
              // --------------------
              setNotifier(
                  notifier: pickedColor,
                  mounted: mounted,
                  value: color
              );
              // --------------------
                setNotifier(
                  notifier: loading,
                  mounted: mounted,
                  value: isLoading,
                );
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

class PixelColorPickerBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PixelColorPickerBuilder({
    required this.child,
    required this.builder,
    this.isOn = true,
    this.initialColor = Colorz.white255,
    this.indicatorSize = 20,
    this.showIndicator = true,
    this.showCrossHair = true,
    this.onColorChanged,
    this.onColorChangeEnded,
    super.key
  });
  // --------------------
  final Widget child;
  final Widget Function(bool loading, Color? color, Widget child) builder;
  final Color initialColor;
  final bool isOn;
  final double indicatorSize;
  final bool showIndicator;
  final bool showCrossHair;
  final Function(Color? color)? onColorChanged;
  final Function(Color? color)? onColorChangeEnded;
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
        child: child,
      );
    }
    // --------------------
    else {
      return builder(false, initialColor, child);
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------

class _PixelColorPickerOn extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _PixelColorPickerOn({
    required this.child,
    required this.builder,
    required this.initialColor,
    required this.indicatorSize,
    required this.showIndicator,
    required this.showCrossHair,
    required this.onColorChanged,
    this.onColorChangeEnded,
    // super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final Widget Function(bool loading, Color? color, Widget child) builder;
  final Color initialColor;
  final double indicatorSize;
  final bool showIndicator;
  final bool showCrossHair;
  final Function(Color? color)? onColorChanged;
  final Function(Color? color)? onColorChangeEnded;
  /// --------------------------------------------------------------------------
  @override
  _PixelColorPickerOnState createState() => _PixelColorPickerOnState();
  /// --------------------------------------------------------------------------
}

class _PixelColorPickerOnState extends State<_PixelColorPickerOn> {
  // --------------------
  final Wire<Color?> _colorWire = Wire<Color?>(null);
  // --------------------
  GlobalKey paintKey = GlobalKey();
  // final StreamController<Color> _stateController = StreamController<Color>();
  img.Image? photo;
  final Wire<Offset> _offset = Wire(Offset.zero);
  bool _indicatorIsOn = false;
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

    Future.delayed(const Duration(milliseconds: 100), () {
      photo = null;
      unawaited(_snapshotWidgetTree());
    });

  }
  // --------------------
  @override
  void dispose() {
    // _stateController.close();
    _colorWire.clear();
    _offset.clear();
    super.dispose();
  }
  // --------------------
  bool _loading = false;
  Future<void> _snapshotWidgetTree() async {

    await Future.delayed(const Duration(milliseconds: 200));

    if (photo == null){

      if (mounted == true){
        setState(() {
          _loading = true;
        });
      }

      final Uint8List? _bytes = await Pixelizer.snapshotWidget(
        key: paintKey,
        context: context,
      );

      if (mounted == true){
        setState(() {
          if (_bytes != null){
            photo = img.decodeImage(_bytes);
          }
          _loading = false;
        });
      }

    }

  }
  // --------------------
  Future<Color?> _calculatePixel({
    required Offset? globalPosition,
    required bool autoHideIndicator,
  }) async {
    Color? _color;

    _indicatorIsOn = true;

    if (photo == null) {
      await _snapshotWidgetTree();
    }

    final img.Pixel? _pixel = Pixelizer.getPixelFromGlobalPosition(
      key: paintKey,
      image: photo,
      globalPosition: globalPosition,
      scaleToImage: true,
    );

    if (_pixel != null){

      _offset.set(
        value: Offset(_pixel.x.toDouble(), _pixel.y.toDouble()),
        mounted: mounted,
      );

       _color = Pixelizer.getPixelColor(
        pixel: _pixel,
      );

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
      if (mounted == true){
        setState(() {
          _indicatorIsOn = false;
        });
      }
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

        child: LiveWire<Color?>(
          wire: _colorWire,
          child: widget.child,
          builder: (Color? _color, Widget? child) {

            return Stack(
              children: <Widget>[

                widget.builder(_loading, _color, child!),

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
                    child: WidgetFader(
                      fadeType: _indicatorIsOn == true ? FadeType.fadeIn : FadeType.fadeOut,
                      duration: _indicatorIsOn == true ?
                      const Duration(milliseconds: 200)
                          :
                      const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

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
                            const Spacing(
                              // size: 10
                            ),

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
            );

          }
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}


// -----------------------------------------------------------------------------

/// ORIGINAL

// class _PixelColorPickerOn extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const _PixelColorPickerOn({
//     required this.child,
//     required this.builder,
//     required this.initialColor,
//     required this.indicatorSize,
//     required this.showIndicator,
//     required this.showCrossHair,
//     required this.onColorChanged,
//     // super.key
//   });
//   /// --------------------------------------------------------------------------
//   final Widget child;
//   final Widget Function(bool loading, Color color, Widget child) builder;
//   final Color initialColor;
//   final double indicatorSize;
//   final bool showIndicator;
//   final bool showCrossHair;
//   final Function(Color? color)? onColorChanged;
//   /// --------------------------------------------------------------------------
//   @override
//   _PixelColorPickerOnState createState() => _PixelColorPickerOnState();
// /// --------------------------------------------------------------------------
// }
//
// class _PixelColorPickerOnState extends State<_PixelColorPickerOn> {
//   // --------------------
//   GlobalKey paintKey = GlobalKey();
//   final StreamController<Color> _stateController = StreamController<Color>();
//   img.Image? photo;
//   Offset _offset = Offset.zero;
//   bool _indicatorIsOn = false;
//   // -----------------------------------------------------------------------------
//   /*
//   @override
//   void initState() {
//     super.initState();
//   }
//    */
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       asyncInSync(() async {
//         await _snapshotWidgetTree();
//       });
//
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   @override
//   void didUpdateWidget(_PixelColorPickerOn oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     Future.delayed(const Duration(milliseconds: 100), () {
//       photo = null;
//       unawaited(_snapshotWidgetTree());
//     });
//
//   }
//   // --------------------
//   @override
//   void dispose() {
//     _stateController.close();
//     super.dispose();
//   }
//   // --------------------
//   bool _loading = false;
//   Future<void> _snapshotWidgetTree() async {
//
//     await Future.delayed(const Duration(milliseconds: 200));
//
//     if (photo == null){
//
//       if (mounted == true){
//         setState(() {
//           _loading = true;
//         });
//       }
//
//       final Uint8List? _bytes = await Pixelizer.snapshotWidget(
//         key: paintKey,
//         context: context,
//       );
//
//       if (mounted == true){
//         setState(() {
//           if (_bytes != null){
//             photo = img.decodeImage(_bytes);
//           }
//           _loading = false;
//         });
//       }
//
//     }
//
//   }
//   // --------------------
//   Future<void> _calculatePixel({
//     required Offset? globalPosition,
//     required bool autoHideIndicator,
//   }) async {
//
//     _indicatorIsOn = true;
//
//     if (photo == null) {
//       await _snapshotWidgetTree();
//     }
//
//     final img.Pixel? _pixel = Pixelizer.getPixelFromGlobalPosition(
//       key: paintKey,
//       image: photo,
//       globalPosition: globalPosition,
//       scaleToImage: true,
//     );
//
//     if (_pixel != null){
//
//       _offset = Offset(_pixel.x.toDouble(), _pixel.y.toDouble());
//
//       final Color? _color = Pixelizer.getPixelColor(
//         pixel: _pixel,
//       );
//
//       widget.onColorChanged?.call(_color);
//
//       if (_color != null){
//         _stateController.add(_color);
//       }
//
//     }
//
//     if (autoHideIndicator == true){
//       await _hideIndicator();
//     }
//
//   }
//   // --------------------
//   Future<void> _hideIndicator() async {
//     await Future.delayed(const Duration(seconds: 1), () {
//       if (mounted == true){
//         setState(() {
//           _indicatorIsOn = false;
//         });
//       }
//     });
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     return StreamBuilder(
//         initialData: widget.initialColor,
//         stream: _stateController.stream,
//         builder: (buildContext, snapshot) {
//
//           final Color _color = snapshot.data ?? widget.initialColor;
//
//           return RepaintBoundary(
//             key: paintKey,
//             child: GestureDetector(
//
//               /// ON START
//               onPanStart: (details) => _calculatePixel(
//                 globalPosition: details.globalPosition,
//                 autoHideIndicator: false,
//               ),
//               /// ON MOVING
//               onPanUpdate: (details) => _calculatePixel(
//                 globalPosition: details.globalPosition,
//                 autoHideIndicator: false,
//               ),
//               /// ON END
//               onPanEnd: (details) => _calculatePixel(
//                 globalPosition: _offset,
//                 autoHideIndicator: true,
//               ),
//
//               child: Stack(
//                 children: <Widget>[
//
//                   widget.builder(_loading, _color, widget.child),
//
//                   if (widget.showIndicator == true)
//                     Positioned(
//                       top: _offset.dy - (widget.indicatorSize / 2) - (widget.indicatorSize) - 10,
//                       left: _offset.dx - (widget.indicatorSize / 2),
//                       child: WidgetFader(
//                         fadeType: _indicatorIsOn == true ? FadeType.fadeIn : FadeType.fadeOut,
//                         duration: _indicatorIsOn == true ?
//                         const Duration(milliseconds: 200)
//                             :
//                         const Duration(milliseconds: 400),
//                         curve: Curves.easeOutCubic,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//
//                             Container(
//                               width: widget.indicatorSize,
//                               height: widget.indicatorSize,
//                               decoration: BoxDecoration(
//                                 color: _color,
//                                 border: Border.all(
//                                   color: Colorz.white200,
//                                 ),
//                                 borderRadius: BorderRadius.circular(widget.indicatorSize / 2),
//                               ),
//                             ),
//
//                             if (widget.showCrossHair == true)
//                               const Spacing(
//                                 // size: 10
//                               ),
//
//                             if (widget.showCrossHair == true)
//                               Material(
//                                 child: SuperBox(
//                                   width: widget.indicatorSize,
//                                   height: widget.indicatorSize,
//                                   icon: '+',
//                                   bubble: false,
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                 ],
//               ),
//             ),
//           );
//
//         });
//     // --------------------
//   }
// // -----------------------------------------------------------------------------
// }

// -----------------------------------------------------------------------------
