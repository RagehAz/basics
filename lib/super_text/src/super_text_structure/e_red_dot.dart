import 'package:flutter/material.dart';
import 'c_leading_dot.dart';

class RedDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RedDot({
    required this.textHeight,
    required this.labelColor,
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? textHeight;
  final Color? labelColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _textHeight = textHeight ?? 20;

    return Container(
      key: const ValueKey<String>('the_red_dot'),
      height: _textHeight,
      margin: labelColor == null ?
      EdgeInsets.symmetric(horizontal: _textHeight * 0.2)
          :
      EdgeInsets.symmetric(horizontal: _textHeight * 0.02),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: labelColor == null ?
        EdgeInsets.only(top: _textHeight * 0.2)
            :
        EdgeInsets.only(top: _textHeight * 0.05),
        child: LeadingDot.dot(
          dotSize: _textHeight * 0.15,
          color: const Color.fromARGB(255, 233, 0, 0),
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
