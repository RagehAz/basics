import 'package:flutter/material.dart';
/// => TAMAM
class BoxGradient extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BoxGradient({
    required this.width,
    required this.height,
    required this.corners,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final BorderRadius? corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: corners ?? BorderRadius.zero,
      child: Container(
        key: const ValueKey<String>('DreamBoxGradient'),
        height: height,
        width: width,
        decoration: BoxDecoration(
          // color: Colorz.Grey,
          borderRadius: corners,
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color.fromARGB(0, 0, 0, 0), Color.fromARGB(125, 0, 0, 0)],
              stops: <double>[0.5, 0.95]),
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
