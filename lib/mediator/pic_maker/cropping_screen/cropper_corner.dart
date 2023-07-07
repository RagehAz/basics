import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:flutter/material.dart';

class CropperCorner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CropperCorner({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colorz.black20,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: const SuperImage(
        width: 10,
        height: 10,
        pic: Iconz.plus,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
