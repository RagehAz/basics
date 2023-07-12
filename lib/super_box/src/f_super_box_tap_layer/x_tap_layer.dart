import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:flutter/material.dart';

import '../../super_box.dart';
/// => TAMAM
class TapLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TapLayer({
    required this.width,
    required this.height,
    required this.onTap,
    this.splashColor,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.isDisabled = false,
    this.onDisabledTap,
    this.onLongTap,
    this.onDoubleTap,
    this.corners,
    this.child,
    this.boxColor,
    this.alignment,
    this.margin,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final Color? splashColor;
  final Function? onTap;
  final Function? onTapUp;
  final Function? onTapDown;
  final Function? onTapCancel;
  final bool isDisabled;
  final Function? onDisabledTap;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final BorderRadius? corners;
  final Color? boxColor;
  final Widget? child;
  final EdgeInsets? margin;
  final Alignment? alignment;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> onBoxTap() async {

    await SuperBoxController.onBoxTap(
        isDisabled: isDisabled,
        onDisabledTap: onDisabledTap,
        onTap: onTap
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canTap(){

    /// DEACTIVATED
    if (isDisabled == true){

      /// NO DEACTIVATED TAP
      if (onDisabledTap == null){
        return false;
      }
      /// CAN TAP DEACTIVATED
      else {
        return true;
      }
    }

    /// NOT DEACTIVATED
    else {

      if (onTap == null){
        return false;
      }
      else {
        return true;
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// NO TAPS
    if (
        onTap == null &&
        onDoubleTap == null &&
        onTapUp == null &&
        onTapDown == null &&
        onLongTap == null
    ){
      return _TapBox(
        key: const ValueKey<String>('DreamBoxTapLayer_e'),
        width: width,
        height: height,
        boxColor: boxColor,
        hasMaterial: false,
        corners: corners ?? BorderRadius.circular(0),
        margin: margin,
        alignment: alignment,
        child: child,
      );
    }

    /// IS DISABLED
    else if (isDisabled == true){

      /// NO DISABLED TAP
      if (onDisabledTap == null){
        return _TapBox(
          key: const ValueKey<String>('DreamBoxTapLayer_e'),
          width: width,
          height: height,
          boxColor: boxColor,
          hasMaterial: false,
          corners: corners ?? BorderRadius.circular(0),
          margin: margin,
          alignment: alignment,
          child: child,
        );
      }

      /// DISABLED TAP
      else {

        return _TapBox(
          key: const ValueKey<String>('DreamBoxTapLayer_c'),
          width: width,
          height: height,
          boxColor: boxColor,
          hasMaterial: false,
          corners: corners ?? BorderRadius.circular(0),
          margin: margin,
          alignment: alignment,
          child: GestureDetector(
              onTap: () => onDisabledTap!(),
              child: child,
            ),
        );
      }

    }

    /// IS NOT DISABLED
    else {

      final BorderRadius _corners = corners ?? BorderRadius.circular(0);

      final Widget _theInkWell = InkWell(
        splashColor: isDisabled == true ? const Color.fromARGB(20, 255, 255, 255) : splashColor,
        highlightColor: Colorz.black20,
        onTap: _canTap() == true ? () => onBoxTap() : null,
        onTapCancel: onTapCancel == null ? null : () => onTapCancel!(),
        onLongPress: onLongTap == null ? null : () => onLongTap!(),
        onDoubleTap: onDoubleTap == null ? null : () => onDoubleTap!(),
        borderRadius: _corners,
        hoverColor: Colorz.white10,
        // overlayColor: ,
        // highlightColor: ,
        // key: ,
        // autofocus: ,
        // canRequestFocus: ,
        // customBorder: ,
        // enableFeedback: ,
        // excludeFromSemantics: ,
        // focusColor: ,
        // focusNode: ,
        // mouseCursor: ,
        // onFocusChange: ,
        // onHighlightChanged: ,
        // onHover: ,
        // onSecondaryTap: ,
        // onSecondaryTapCancel: ,
        // onSecondaryTapDown: ,
        // onSecondaryTapUp: ,
        // onTapDown: ,
        // onTapUp: ,
        // radius: ,
        // splashFactory: ,
        // statesController: ,
        child: child,
      );

      /// NO TAP DOWN OR UP
      if (onTapDown == null && onTapUp == null){
        return _TapBox(
          hasMaterial: true,
          boxColor: boxColor,
          corners: _corners,
          width: width,
          height: height,
          margin: margin,
          alignment: alignment,
          child: Material(
            color: const Color.fromARGB(0, 255, 255, 255),
            borderRadius: _corners,
            child: _theInkWell,
          ),
        );
      }

      /// TAP DOWN OR UP
      else {

        return _TapBox(
          hasMaterial: true,
          width: width,
          height: height,
          corners: _corners,
          boxColor: boxColor,
          margin: margin,
          alignment: alignment,
          child: GestureDetector(
            // onLongPress: onLongTap,
            onTapDown: onTapDown == null ? null : (TapDownDetails details) => onTapDown?.call(),
            onTapUp: onTapUp == null ? null : (TapUpDetails details) => onTapUp?.call(),
            child: _theInkWell,
          ),
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}

class _TapBox extends StatelessWidget {

  const _TapBox({
    required this.width,
    required this.height,
    required this.corners,
    required this.boxColor,
    required this.hasMaterial,
    required this.alignment,
    required this.margin,
    this.child,
    super.key,
  });

  final double? width;
  final double? height;
  final BorderRadius corners;
  final Widget? child;
  final Color? boxColor;
  final bool hasMaterial;
  final Alignment? alignment;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {

      return Container(
        key: const ValueKey<String>('_TapBox_b'),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: corners,
          color: boxColor,
        ),
        alignment: alignment,
        margin: margin,
        child: hasMaterial == false ? child : Material(
          color: const Color.fromARGB(0, 255, 255, 255),
          borderRadius: corners,
          child: child,
        ),
      );

  }

}
