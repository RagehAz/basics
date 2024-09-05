import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:flutter/material.dart';
import '../../super_box.dart';
/// => TAMAM
class BoxIcon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BoxIcon({
    required this.icon,
    required this.loading,
    required this.size,
    required this.corners,
    required this.greyscale,
    required this.solidGreyScale,
    required this.iconColor,
    required this.iconSizeFactor,
    required this.backgroundColor,
    required this.package,
    required this.isDisabled,
    required this.loadingIsPulse,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final dynamic icon;
  final bool loading;
  final double size;
  final BorderRadius? corners;
  final bool greyscale;
  final bool solidGreyScale;
  final Color? iconColor;
  final double? iconSizeFactor;
  final Color? backgroundColor;
  final String? package;
  final bool isDisabled;
  final bool loadingIsPulse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (loading == true){

      if (loadingIsPulse == true){
        return Loading(
          size: size * (iconSizeFactor ?? 0.7),
          color: iconColor ?? const Color.fromARGB(650, 255, 255, 255),
        );
      }

      else {
        return ClipRRect(
          borderRadius: Borderers.superCorners(corners: corners),
          child: InfiniteLoadingBox(
            width: size,
            height: size,
            color: iconColor,
            backgroundColor: backgroundColor ?? Colorz.white50,
          ),
        );
      }

    }

    else if (icon is Widget){
      return icon;
    }

    else {

      final Color? _iconColor = SuperBoxController.iconColor(
        colorOverride: iconColor,
        isDisabled: isDisabled,
        greyScale: greyscale,
      );

      return SuperImage(
        key: const ValueKey<String>('DreamBoxIcon'),
        width: size,
        height: size,
        pic: icon,
        scale: iconSizeFactor,
        iconColor: _iconColor,
        loading: loading,
        greyscale: greyscale,
        solidGreyScale: solidGreyScale,
        corners: corners,
        backgroundColor: backgroundColor,
        package: package,
        // fit: ,
      );
    }

  }
  /// --------------------------------------------------------------------------
}
