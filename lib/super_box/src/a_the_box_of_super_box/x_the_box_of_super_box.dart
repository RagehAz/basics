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
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Row(
      key: const ValueKey<String>('Dream_box_the_box'),
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        IntrinsicWidth(
          child: Opacity(
            opacity: isDisabled == true ? 0.7 : (opacity ?? 1),
            child: Padding(
              padding: SuperBoxController.superMargins(
                margin: margins,
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: SuperBoxController.boxColor(
                        color: boxColor,
                        greyScale: greyScale,
                        isDisabled: isDisabled,
                    ),

                      // borderRadius: cornersAsBorderRadius,
                      // boxShadow: const <BoxShadow>[
                        // CustomBoxShadow(
                        //     color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                        //     offset: new Offset(0, 0),
                        //     blurRadius: height * 0.15,
                        //     blurStyle: BlurStyle.outer
                        // ),
                      // ]

                  ),

                  child: Stack(
                    alignment: Alignment.center,
                    children: children,
                  ),

                ),
              ),
            ),
          ),
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
