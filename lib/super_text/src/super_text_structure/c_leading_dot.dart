import 'package:flutter/material.dart';

class LeadingDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LeadingDot({
    required this.textHeight,
    required this.color,
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? textHeight;
  final Color? color;
  /// --------------------------------------------------------------------------
  static Widget dot({
    required double? dotSize,
    required Color? color,
  }){
    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _textHeight = textHeight ?? 20;

    return Container(
      key: const ValueKey<String>('the_leading_dot'),
      padding: EdgeInsets.only(
        left: _textHeight * 0.2,
        right: _textHeight * 0.2,
        top: _textHeight * 0.4,
      ),
      // color: Colorz.bloodTest,
      // margin: EdgeInsets.only(top: textHeight),
      child: dot(
        dotSize: _textHeight * 0.3,
        color: color,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
