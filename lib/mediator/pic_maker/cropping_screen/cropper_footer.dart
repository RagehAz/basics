import 'dart:typed_data';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/space/aligner.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:flutter/material.dart';

class CropperFooter extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const CropperFooter({
    required this.currentImageIndex,
    required this.onCropImages,
    required this.bytezz,
    required this.onImageTap,
    required this.aspectRatio,
    required this.screenHeight,
    required this.appIsLTR,
    required this.confirmText,
    super.key
  });
  // -----------------------------------------------------------------------------
  final ValueNotifier<int> currentImageIndex;
  final Function onCropImages;
  final List<Uint8List> bytezz;
  final ValueChanged<int> onImageTap;
  final double aspectRatio;
  final double screenHeight;
  final bool appIsLTR;
  final String confirmText;
  // --------------------
  static const double imagesSpacing = 5;
  // --------------------
  static double getMiniImageHeight(){
    const double _imagesFooterHeight = Ratioz.horizon;
    return _imagesFooterHeight - (imagesSpacing * 2);
  }
  // --------------------
  static double getMiniImagesWidth({
    required double aspectRatio,
  }){
    final double _miniImageHeight = getMiniImageHeight();
    final double _miniImageWidth = _miniImageHeight * aspectRatio;
    return _miniImageWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    const double _imagesFooterHeight = Ratioz.horizon;
    // --------------------
    final double _miniImageHeight = getMiniImageHeight();
    final double _miniImageWidth = getMiniImagesWidth(
      aspectRatio: aspectRatio,
    );
    // --------------------
    return Container(
      width: _screenWidth,
      height: _imagesFooterHeight,
      alignment: Alignment.bottomLeft,
      child: ValueListenableBuilder(
        valueListenable: currentImageIndex,
        builder: (_, int imageIndex, Widget? confirmButton){

          return Stack(
            children: <Widget>[

              /// MINI PICTURES
              SizedBox(
                width: _screenWidth,
                height: _imagesFooterHeight,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: bytezz.length,
                  padding: Scale.superInsets(
                    context: context,
                    appIsLTR: appIsLTR,
                    enRight: _screenWidth * 0.5,
                    enLeft: 10,
                  ),
                  itemBuilder: (_, int index){

                    final bool _isSelected = imageIndex == index;

                    return GestureDetector(
                      onTap: () => onImageTap(index),
                      child: Center(
                        child: Container(
                          width: _miniImageWidth,
                          height: _miniImageHeight,
                          margin: Scale.superInsets(
                            context: context,
                            appIsLTR: appIsLTR,
                            enRight: 5,
                          ),
                          decoration: BoxDecoration(
                            color: _isSelected == true ? Colorz.white125 : Colorz.white50,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: _isSelected == true ? Border.all(color: Colorz.white200) : null,
                          ),
                          child: SuperImage(
                            width: _miniImageWidth,
                            height: _miniImageWidth,
                            pic: bytezz[index],
                          ),
                        ),
                      ),
                    );

                  },
                ),
              ),

              /// CONFIRM BUTTON
              confirmButton!,

            ],
          );

        },
        child: Align(
          alignment: Aligner.bottom(
            appIsLTR: appIsLTR,
            inverse: true,
          ),
          child: SuperBox(
            height: _miniImageHeight,
            text: confirmText,
            onTap: onCropImages,
            appIsLTR: appIsLTR,
            textScaleFactor: 0.7,
            textFont: BldrsThemeFonts.fontBldrsHeadlineFont,
            textItalic: true,
            margins: 10,
          ),
        ),
      ),

    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
