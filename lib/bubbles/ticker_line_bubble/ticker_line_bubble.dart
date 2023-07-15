import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:flutter/material.dart';

class TickerLineBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TickerLineBubble({
    required this.width,
    required this.height,
    required this.children,
    this.corners = Borderers.constantCornersAll10,
    this.color = Colorz.white10,
    this.margin,
    this.padding,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BorderRadius? corners;
  final double width;
  final double height;
  final Color color;
  final List<Widget> children;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ClipRRect(
      borderRadius: corners,
      child: Container(
        width: width,
        height: 50,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: Borderers.constantCornersAll10,
          color: color,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          children: children,
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
