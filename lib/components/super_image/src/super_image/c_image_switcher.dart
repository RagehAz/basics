// ignore_for_file: unused_import
import 'dart:convert';
import 'dart:typed_data';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:cross_file/cross_file.dart';
import 'package:cross_file_image/cross_file_image.dart';

class ImageSwitcher extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ImageSwitcher({
    required this.width,
    required this.height,
    required this.pic,
    required this.boxFit,
    required this.scale,
    required this.iconColor,
    required this.loading,
    required this.backgroundColor,
    required this.package,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final double? width;
  final double height;
  final BoxFit? boxFit;
  final double? scale;
  final Color? iconColor;
  final bool loading;
  final Color? backgroundColor;
  final String? package;
  // -----------------------------------------------------------------------------
  static const bool _gaplessPlayback = true;
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _errorBuilder (_, Object error, StackTrace? stackTrace) {
    // blog('SUPER IMAGE ERROR : ${pic.runtimeType} : error : $error');
    return Container(
      width: width,
      height: height,
      color: Colorz.white10,
      // child: const SuperVerse(
      //   verse: Verse(
      //     text: 'phid_error',
      //     translate: true,
      //     casing: Casing.lowerCase,
      //   ),
      //   size: 0,
      //   maxLines: 2,
      // ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _loadingBuilder(BuildContext _, Widget? child, ImageChunkEvent? imageChunkEvent){

    // blog('SUPER IMAGE LOADING BUILDER : imageChunkEvent.cumulativeBytesLoaded : ${imageChunkEvent?.cumulativeBytesLoaded} / ${imageChunkEvent?.expectedTotalBytes}');

    /// AFTER LOADED
    if (
        imageChunkEvent == null
        ||
        imageChunkEvent.expectedTotalBytes == null
        ||
        width == null
    ){
      return child ?? const SizedBox();
    }
    /// WHILE LOADING
    else {

      final int _bytes = imageChunkEvent.expectedTotalBytes ?? 0;

      if (_bytes > 0) {

        final double _percentage = imageChunkEvent.cumulativeBytesLoaded / _bytes;

        return Container(
          width: width,
          height: height,
          color: Colorz.white50,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * _percentage,
            color: backgroundColor ?? Colorz.white20,
          ),
        );

      }
      else {
        return child ?? const SizedBox();
      }

    }

  }
  // --------------------
  ///DEPRECATED
  /*
  Widget _futureBytesBuilder (BuildContext ctx, AsyncSnapshot<Uint8List> snapshot){

    return FutureImage(
      snapshot: snapshot,
      width: width,
      height: height,
      boxFit: boxFit,
      errorBuilder: _errorBuilder,
    );

  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// LOADING
    if (loading == true){
      return InfiniteLoadingBox(
          width: width!,
          height: height,
          color: backgroundColor,
        );
    }

    else if (pic != null && pic != '' && width != null){

      final BoxFit _boxFit = boxFit ?? BoxFit.cover;

      if (pic is IconData){
        return Container(
          width: width,
          height: height * (scale ?? 1) * 1.2,
          alignment: Alignment.center,
          child: Icon(
            pic,
            key: const ValueKey<String>('SuperImage_iconData'),
            // semanticLabel: 'SuperImage_iconData',
            size: height * (scale ?? 1) * 1.2,
            color: iconColor ?? Colorz.white255,
            // weight: 1,
            // fill: 1,
            // grade: 1,
            // opticalSize: 1,
            // textDirection: TextDirection.ltr,
            // shadows: [],
          ).build(context),
        );
      }

      /// MEDIA MODEL
      else if (pic is MediaModel){

        final MediaModel _mediaModel = pic;

        if (_mediaModel.file == null){
          return SizedBox(
            width: width,
            height: height,
            // color: Colorz.errorColor,
          );
        }

        else {
          return Image(
            image: XFileImage(_mediaModel.file!),
            key: const ValueKey<String>('SuperImage_media_model'),
            fit: boxFit,
            width: width,
            height: height,
            errorBuilder: _errorBuilder,
            gaplessPlayback: _gaplessPlayback,
          );
        }

      }

      /// FILE
      else if (ObjectCheck.objectIsFile(pic) == true){

        return Image.file(
          pic,
          key: const ValueKey<String>('SuperImage_file'),
          fit: boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
        );
      }

      /// X FILE
      else if (ObjectCheck.objectIsXFile(pic) == true){
        return Image(
          image: XFileImage(pic),
          key: const ValueKey<String>('SuperImage_xfile'),
          fit: boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
        );
      }

      /// URL
      else if (ObjectCheck.isAbsoluteURL(pic) == true){

        return Image.network(
          pic.trim(),
          key: const ValueKey<String>('SuperImage_url'),
          fit: boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
          loadingBuilder: _loadingBuilder,
        );

      }

      /// JPG OR PNG
      else if (ObjectCheck.objectIsJPGorPNG(pic) == true){

        return Image.asset(
          pic,
          key: const ValueKey<String>('SuperImage_png_or_jpg'),
          fit: boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          scale: 1,
          gaplessPlayback: _gaplessPlayback,
          package: package,
        );

      }

      /// SVG
      else if (ObjectCheck.objectIsSVG(pic) == true){

        return WebsafeSvg.asset(
          pic,
          fit: _boxFit,
          colorFilter: iconColor == null ? null : ColorFilter.mode(iconColor!, BlendMode.srcIn),
          width: width,
          height: height,
          package: package,

        );
      }

      /// UINT8LIST
      else if (ObjectCheck.objectIsUint8List(pic) == true){

        return CachelessImage(
          key: const ValueKey<String>('SuperImage_bytes'),
          bytes: pic,
          width: width,
          height: height,
          color: backgroundColor,
          boxFit: _boxFit,
          // blendMode: BlendMode.color,
        );
      }

      /// BASE64 -> CONTRADICTS BUILDING TEXTS
      // else if (ObjectCheck.isBase64(pic) == true){
      //   return CachelessImage(
      //     key: const ValueKey<String>('SuperImage_base64'),
      //     bytes: base64Decode(pic),
      //     width: width,
      //     height: height,
      //     color: backgroundColor,
      //     boxFit: _boxFit,
      //   );
      // }

      /// UI.IMAGE
      else if (ObjectCheck.objectIsUiImage(pic) == true){

        final ui.Image _uiImage = pic;

        return RawImage(
          /// MAIN
          key: const ValueKey<String>('SuperImage_UIIMAGE'),
          // debugImageLabel: ,

          /// IMAGE
          image: _uiImage,
          // repeat: ImageRepeat.noRepeat, // DEFAULT

          /// SIZES
          width: width,
          height: height,
          scale: scale ?? 1,

          /// COLORS
          // color: iconColor,
          // opacity: 0.5,
          // colorBlendMode: BlendMode.srcATop,
          // filterQuality: FilterQuality.low, // DEFAULT
          // invertColors: true, // DEFAULT

          /// POSITIONING
          // alignment: Alignment.center, // DEFAULT
          fit: boxFit,

          /// DUNNO
          // centerSlice: ,
          // isAntiAlias: ,
          // matchTextDirection: false, // DEFAULT : flips image horizontally
        );
      }

      /// IMG.IMAGE
      else if (ObjectCheck.objectIsImgImage(pic) == true){

        final Uint8List _bytes = img.encodeJpg(pic,
            // quality: 100,
        );

        return CachelessImage(
          key: const ValueKey<String>('SuperImage_imgImage'),
          bytes: _bytes,
          width: width,
          height: height,
          color: backgroundColor,
          boxFit: _boxFit,
        );
      }

      /// STRING - DOUBLE - INT
      else if (pic is String || pic is String? || pic is num || pic is num?){

        final String _text = pic.toString();

        return Center(
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: FittedBox(
              child: SuperText(
                // boxWidth: width,
                // boxHeight: height,
                boxColor: backgroundColor,
                text: _text,
                weight: FontWeight.w100,
                // letterSpacing: 1,
                font: BldrsThemeFonts.fontHead,
                // appIsLTR: true,
                textHeight: height * (scale ?? 1) * 1.4,
                textColor: iconColor ?? Colorz.white255,
              ),
            ),
          ),
        );
      }

      /// NEITHER ANY OF ABOVE
      else {

        // blog('SUPER IMAGE ERROR : ${pic.runtimeType} : $pic');

        return SizedBox(
          width: width,
          height: height,
          // color: Colorz.errorColor,
        );

      }

    }

    else {
      return SizedBox(
        width: width,
        height: height,
        // color: Colorz.errorColor,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
