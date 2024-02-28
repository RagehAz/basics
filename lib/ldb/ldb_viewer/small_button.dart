import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SmallButton({
    required this.verse,
    required this.onTap,
    this.width = 80,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? verse;
  final Function? onTap;
  final double? width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonWidth = width ?? Scale.getUniformRowItemWidth(
      numberOfItems: 4,
      boxWidth: Scale.screenWidth(context) - 20,
    );

    return SuperBox(
      height: 50,
      width: _buttonWidth,
      color: Colorz.black255,
      margins: const EdgeInsets.symmetric(horizontal: 1),
      text: verse?.toUpperCase(),
      textScaleFactor: 0.6,
      textWeight: FontWeight.w600,
      textMaxLines: 2,
      onTap: onTap,
      textItalic: true,
      textFont: BldrsThemeFonts.fontHead,
    );
  }
  /// --------------------------------------------------------------------------
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('verse', verse));
  //   properties.add(DiagnosticsProperty<Function>('onTap', onTap));
  // }
  /// --------------------------------------------------------------------------
}
