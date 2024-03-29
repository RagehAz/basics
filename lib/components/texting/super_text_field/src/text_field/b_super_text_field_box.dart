import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

class SuperTextFieldBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperTextFieldBox({
    required this.child,
    required this.width,
    required this.margins,
    required this.corners,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget? child;
  final double? width;
  final dynamic margins;
  final dynamic corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      return Container(
        key: const ValueKey<String>('SuperTextFieldBox'),
        width: width,
        margin: Scale.superMargins(margin: margins),
        decoration: BoxDecoration(
          borderRadius: Borderers.superCorners(corners: corners),
        ),
        alignment: Alignment.topCenter,
        child: child,
      );

  }
  /// --------------------------------------------------------------------------
}
