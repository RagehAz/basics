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
          height: height,
        );
      }

      else {
        return ClipRRect(
          borderRadius: corners,
          child: _HighLightLayers(
            key: key,
            width: width!,
            height: height,
          ),
        );
      }

    }

  }
  /// --------------------------------------------------------------------------
}

class _HighLightLayers extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _HighLightLayers({
    required this.width,
    required this.height,
    super.key
  });
  // --------------------
  final double width;
  final double? height;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _targetHeight = height ?? 0;
    final double _targetWidth = width;
    final double _graphicWidth = _targetHeight;
    // const ColorFilter? _colorFilter = ColorFilter.mode(Colorz.white80, BlendMode.srcATop);

    return Transform.scale(
      /// SCALE . graphicWidth = targetWidth
      scaleX: _targetWidth / _graphicWidth,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          /// WHITE
          Container(
            width: _targetWidth,
            height: _targetHeight,
            alignment: Alignment.topCenter,
            child: WebsafeSvg.asset(
              Iconz.boxShadowWhite,
              // BoxHighlights.getWhiteHighlight(
              //   width: _targetWidth,
              //   height: _targetHeight,
              // ),
              fit: BoxFit.fitWidth,
              width: _targetWidth,
              height: _targetHeight,
              alignment: Alignment.topCenter,
              // colorFilter: const ColorFilter.mode(Colorz.red230, BlendMode.srcIn),
            ),

          ),

          /// BLACK
          Positioned(
            bottom: -1,
            child: Container(
              width: _targetWidth,
              height: _targetHeight,
              alignment: Alignment.bottomCenter,
              child: WebsafeSvg.asset(
                Iconz.boxShadowBlack,
                  // BoxHighlights.getBlackHighlight(
                  //   width: _targetWidth,
                  //   height: height,
                  // ),
                  fit: BoxFit.fitWidth,
                  width: _targetWidth,
                  height: _targetHeight,
                  alignment: Alignment.bottomCenter,
                  // colorFilter: const ColorFilter.mode(Colorz.red230, BlendMode.srcIn),
              ),

            ),
          ),

        ],
      ),
    );
  }
  // --------------------------------------------------------------------------
}
