import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:flutter/material.dart';
import '../a_the_box_of_super_box/x_custom_box_shadow.dart';
/// => TAMAM
class BoxHighlight extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BoxHighlight({
    required this.width,
    required this.height,
    required this.corners,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final dynamic corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = height ?? 0;
    final BorderRadius _borders = corners ?? Borderers.superCorners(
      corners: _height * 0.6,
    );

    return Container(
      key: const ValueKey<String>('DreamBoxHighlight'),
      width: width,
      height: _height * 0.27,
      decoration: BoxDecoration(
        // color: Colorz.White,
        borderRadius:_borders,
        boxShadow: <BoxShadow>[

          CustomBoxShadow(
              color: const Color.fromARGB(50, 255, 255, 255),
              offset: Offset(0, _height * -0.33),
              blurRadius: _height * 0.2,
          ),

        ],

      ),
    );

  }
  /// --------------------------------------------------------------------------
}
