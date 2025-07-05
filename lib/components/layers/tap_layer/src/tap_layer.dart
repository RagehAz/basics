part of tap_layer;

enum VibrationType {
  heavy,
  medium,
  light,
  selection,
  vibration,
}

/// => TAMAM
class TapLayer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TapLayer({
    required this.width,
    required this.height,
    this.onTap,
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
    this.borderColor,
    this.customBorder,
    this.vibrationType = VibrationType.medium,
    super.key
  });
  // --------------------
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
  final Color? borderColor;
  final ShapeBorder? customBorder;
  final VibrationType vibrationType;
  // --------------------
  static const double borderThickness = 0.75;
  // --------------------
  static BoxBorder? getBorder({
    required Color? color,
  }){
    return color == null ? null : Border.all(
      color: color,
      width: borderThickness,
      strokeAlign: BorderSide.strokeAlignOutside,
    );
  }
  // --------------------
  bool _checkNoTapsGiven(){
    return  onTap == null &&
        onDoubleTap == null &&
        onTapUp == null &&
        onTapDown == null &&
        onLongTap == null;
  }
  // --------------------
  Future<void> _tapWithVibration({
    required Function? onTap,
    VibrationType? type,
  }) async {

    if (onTap != null){

      switch (type ?? vibrationType){
        case VibrationType.heavy: await HapticFeedback.heavyImpact();
        case VibrationType.medium: await HapticFeedback.mediumImpact();
        case VibrationType.light: await HapticFeedback.lightImpact();
        case VibrationType.selection: await HapticFeedback.selectionClick();
        case VibrationType.vibration: await HapticFeedback.vibrate();
      }

      await onTap();

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// NO TAPS
    if (_checkNoTapsGiven() == true){
      return _NoTapsGiven(
        key: key,
        width: width,
        height: height,
        boxColor: boxColor,
        corners: corners,
        margin: margin,
        alignment: alignment,
        borderColor: borderColor,
        child: child,
      );
    }

    /// IS DISABLED
    else if (isDisabled == true){

      return _TapStateDisabled(
        width: width,
        height: height,
        onDisabledTap: () => _tapWithVibration(onTap: onDisabledTap, type: VibrationType.light),
        corners: corners,
        boxColor: boxColor,
        alignment: alignment,
        margin: margin,
        borderColor: borderColor,
        child: child,
      );

    }

    /// IS NOT DISABLED
    else {

      /// NO TAP DOWN OR UP
      if (onTapDown == null && onTapUp == null){

        return _TapStateNoUpsAndDowns(
          key: key,
          width: width,
          height: height,
          corners: corners,
          boxColor: boxColor,
          alignment: alignment,
          margin: margin,
          borderColor: borderColor,
          onTap: onTap,
          splashColor: splashColor,
          onTapCancel: onTapCancel,
          onLongTap: () => _tapWithVibration(onTap: onLongTap),
          onDoubleTap: () => _tapWithVibration(onTap: onDoubleTap),
          customBorder: customBorder,
          child: child,
        );

      }

      /// TAP DOWN OR UP
      else {

        return _TapStateWithUpsAndDowns(
          key: key,
          width: width,
          height: height,
          corners: corners,
          boxColor: boxColor,
          alignment: alignment,
          margin: margin,
          borderColor: borderColor,
          onTap: onTap,
          splashColor: splashColor,
          onTapCancel: onTapCancel,
          onLongTap: () => _tapWithVibration(onTap: onLongTap),
          onDoubleTap: () => _tapWithVibration(onTap: onDoubleTap),
          customBorder: customBorder,
          onTapUp: () => _tapWithVibration(onTap: onTapUp),
          onTapDown: () => _tapWithVibration(onTap: onTapDown),
          child: child,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
