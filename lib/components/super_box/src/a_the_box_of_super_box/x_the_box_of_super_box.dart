// ignore_for_file: unused_element
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:flutter/material.dart';

import '../../super_box.dart';

/// => TAMAM
class TheBoxOfSuperBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TheBoxOfSuperBox({
    required this.isDisabled,
    required this.opacity,
    required this.margins,
    required this.width,
    required this.height,
    required this.boxColor,
    required this.greyScale,
    required this.borderRadius,
    required this.children,
    required this.onTapDown,
    required this.onTapUp,
    required this.onTap,
    required this.onTapCancel,
    required this.splashColor,
    required this.onDisabledTap,
    required this.onLongTap,
    required this.onDoubleTap,
    required this.borderColor,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final bool isDisabled;
  final double? opacity;
  final dynamic margins;
  final double? width;
  final double? height;
  final Color? boxColor;
  final bool greyScale;
  final BorderRadius? borderRadius;
  final List<Widget> children;
  final Function? onTapDown;
  final Function? onTapUp;
  final Function? onTap;
  final Function? onTapCancel;
  final Color? splashColor;
  final Function? onDisabledTap;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final Color? borderColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /*
       // boxShadow: const <BoxShadow>[
       // CustomBoxShadow(
       //     color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
       //     offset: new Offset(0, 0),
       //     blurRadius: height * 0.15,
       //     blurStyle: BlurStyle.outer
       // ),
       // ]
     */

    return _FluidArea(
      isDisabled: isDisabled,
      opacity: opacity,
      child: TapLayer(
        width: width,
        height: height,
        alignment: Alignment.center,
        margin: SuperBoxController.superMargins(
          margin: margins,
        ),
        boxColor: SuperBoxController.boxColor(
          color: boxColor,
          greyScale: greyScale,
          isDisabled: isDisabled,
        ),
        splashColor: splashColor,
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        isDisabled: isDisabled,
        onDisabledTap: onDisabledTap,
        onLongTap: onLongTap,
        onDoubleTap: onDoubleTap,
        corners: borderRadius,
        borderColor: borderColor,
        child: Stack(
          alignment: Alignment.center,
          children: children,
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}

class _FluidArea extends StatelessWidget {

  const _FluidArea({
    required this.opacity,
    required this.isDisabled,
    required this.child,
    super.key
  });

  final double? opacity;
  final bool isDisabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {

    final bool _hasOpacity = (opacity != null && opacity! < 1) || isDisabled == true;

    return Row(
      key: const ValueKey<String>('_FluidArea'),
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        if (_hasOpacity == true)
        IntrinsicWidth(
          child: Opacity(
            opacity: isDisabled == true ? 0.7 : (opacity ?? 1),
            child: child,
          ),
        ),

        if (_hasOpacity == false)
        IntrinsicWidth(
          child: child,
        ),

      ],
    );

  }

}
