import 'package:basics/helpers/checks/object_check.dart';
import 'package:flutter/material.dart';
import 'x_box_icon.dart';

/// TAMAM
class SuperBoxIcon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperBoxIcon({
    required this.height,
    required this.corners,
    required this.icon,
    required this.loading,
    required this.iconColor,
    required this.greyScale,
    required this.solidGreyScale,
    required this.iconSizeFactor,
    required this.backgroundColor,
    required this.package,
    required this.isDisabled,
    required this.loadingIsPulse,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double height;
  final BorderRadius? corners;
  final dynamic icon;
  final bool loading;
  final Color? iconColor;
  final bool greyScale;
  final bool solidGreyScale;
  final double? iconSizeFactor;
  final Color? backgroundColor;
  final String? package;
  final bool isDisabled;
  final bool loadingIsPulse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _jpgGraphicWidth = height * (iconSizeFactor ?? 1);

    return Container(
      key: const ValueKey<String>('DreamIconBox'),
      width: height,
      height: height,
      alignment: Alignment.topCenter,
      child: Container(
        width: height,
        height: height,
        decoration: BoxDecoration(
          borderRadius: corners,
          // color: Colorz.red255
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            BoxIcon(
              icon: icon,
              loading: loading,
              size: height,
              corners: corners,
              greyscale: greyScale,
              solidGreyScale: solidGreyScale,
              iconColor: iconColor,
              iconSizeFactor: iconSizeFactor,
              backgroundColor: backgroundColor,
              package: package,
              isDisabled: isDisabled,
              loadingIsPulse: loadingIsPulse,
            ),

            /// --- BUTTON BLACK LAYER IF GREYED OUT
            if (greyScale == true && icon != null && ObjectCheck.objectIsSVG(icon) == false)
              Container(
                height: _jpgGraphicWidth,
                width: _jpgGraphicWidth,
                decoration: BoxDecoration(
                  // color: Colorz.Yellow,
                  borderRadius: corners,
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromARGB(80, 0, 0, 0),
                        Color.fromARGB(125, 0, 0, 0),
                      ],
                      stops: <double>[
                        0.5,
                        1
                      ]),
                ),
              ),

          ],

        ),
      ),
    );
  }
  /// --------------------------------------------------------------------------
}
