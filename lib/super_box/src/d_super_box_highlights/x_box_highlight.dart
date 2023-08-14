import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

/// => TAMAM
class BoxHighlights extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BoxHighlights({
    required this.width,
    required this.height,
    required this.corners,
    super.key
  }); 
  // --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    if (height == null || height == 0 || width == null || height == 0){
      return const SizedBox();
    }

    else {

      if (corners == null || corners == BorderRadius.zero){
        return _HighLightLayers(
          key: key,
          width: width!,
          height: height!,
        );
      }

      else {
        return ClipRRect(
          borderRadius: corners,
          child: _HighLightLayers(
            key: key,
            width: width!,
            height: height!,
          ),
        );
      }

    }

  }
  /// --------------------------------------------------------------------------
}

/// => TAMAM
class _HighLightLayers extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _HighLightLayers({
    required this.width,
    required this.height,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Transform.scale(
      /// SCALE . graphicWidth = targetWidth
      scaleX: width / height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          /// WHITE
          Container(
            width: width,
            height: height,
            alignment: Alignment.topCenter,
            child: WebsafeSvg.asset(
              Iconz.boxShadowWhite,
              fit: BoxFit.fitWidth,
              width: height,
              height: height,
              alignment: Alignment.topCenter,
            ),
          ),

          /// BLACK
          Positioned(
            bottom: -1,
            child: Container(
              width: width,
              height: height,
              alignment: Alignment.bottomCenter,
              child: WebsafeSvg.asset(
                Iconz.boxShadowBlack,
                fit: BoxFit.fitWidth,
                width: height,
                height: height,
                alignment: Alignment.bottomCenter,
              ),

            ),
          ),

        ],
      ),
    );
  }
  // --------------------------------------------------------------------------
}
