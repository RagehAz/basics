import 'package:flutter/material.dart';
/// => TAMAM
class SuperBoxChild extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperBoxChild({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.childAlignment,
    required this.subChild,
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Alignment? childAlignment;
  final Widget? subChild;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('DreamBoxChild'),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      alignment: childAlignment,
      child: subChild,
    );

  }
  /// --------------------------------------------------------------------------
}
