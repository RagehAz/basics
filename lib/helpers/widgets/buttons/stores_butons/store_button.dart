import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:flutter/material.dart';

enum StoreType {
  appStore,
  googlePlay,
}

class StoreButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const StoreButton({
    required this.storeType,
    required this.onTap,
    this.isDisabled = false,
    this.height,
    super.key
  });
  // --------------------------------------------------------------------------
  final StoreType storeType;
  final Function onTap;
  final bool isDisabled;
  final double? height;
  // --------------------------------------------------------------------------
  static double getHeight({
    required BuildContext context,
    double? heightOverride,
  }){

    if (heightOverride == null){
      final double _referenceLength = Scale.screenShortestSide(context);
      return _referenceLength * 0.08;
    }
    else {
      return heightOverride;
    }

  }
  // --------------------
  static double getWidth({
    required BuildContext context,
    double? heightOverride,
  }){
    final double _buttonHeight = getHeight(
      context: context,
      heightOverride: heightOverride,
    );
    const double _aspectRatio = 800 / 262;
    return _buttonHeight * _aspectRatio;
  }
  // --------------------
  static BorderRadius getCorner({
    required BuildContext context,
    double? heightOverride,
  }){
    /// corner is 40 when height is 262
    /// corner will be 40 * (height / 262)
    final double _buttonHeight = getHeight(
      context: context,
      heightOverride: heightOverride,
    );
    return Borderers.superCorners(
      corners: 40 * (_buttonHeight / 262),
    );
  }
  // --------------------
  static String getGraphic({
    required StoreType storeType,
  }){

    switch (storeType){
      case StoreType.appStore:    return Iconz.onAppStore;
      case StoreType.googlePlay:  return Iconz.onGooglePlay;
    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonHeight = getHeight(
      context: context,
      heightOverride: height,
    );
    final double _buttonWidth = getWidth(
      context: context,
      heightOverride: height,
    );
    final BorderRadius _corners = getCorner(
      context: context,
      heightOverride: height,
    );

    return SizedBox(
      height: _buttonHeight,
      width: _buttonWidth,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          Opacity(
            opacity: isDisabled ? 0.3 : 1,
            child: SuperImage(
              height: _buttonHeight,
              width: _buttonWidth,
              corners: _corners,
              greyscale: isDisabled,
              pic: getGraphic(storeType: storeType),
            ),
          ),

          SuperBox(
            height: _buttonHeight,
            width: _buttonWidth,
            corners: _corners,
            isDisabled: isDisabled,
            onTap: onTap,
          ),

        ],
      ),
    );

  }
// --------------------------------------------------------------------------
}
