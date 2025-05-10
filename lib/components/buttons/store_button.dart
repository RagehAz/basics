import 'package:basics/av/av.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/layers/tap_layer/tap_layer.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:flutter/material.dart';

enum StoreType {
  appStore,
  googlePlay,
}

abstract class StoreBadge {
  // --------------------------------------------------------------------------

  /// APP STORES LABELS

  // --------------------
  /// ON GOOGLE PLAY STORE
  static const String onGooglePlayStoreLabelPicPath = 'storage/bldrs/on_google_play_store_badge.png';
  static const String onGooglePlayStoreLabelPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fon_google_play_store_badge.png?alt=media&token=221fb970-0e24-4b77-b7f1-7c57b3cdde0e';
  // --------------------
  /// ON APP STORE
  static const String onAppleStoreLabelPicPath = 'storage/bldrs/on_app_store_badge.png';
  static const String onAppleStoreLabelPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fon_app_store_badge.png?alt=media&token=4738626b-db32-4694-8b0e-22de48d8ecef';
  // --------------------------------------------------------------------------

  /// SMALL STORE BADGES

  // --------------------
  static const String storeBadgeArGoogleColorPath = 'storage/bldrs/badge_google_ar_color.png';
  static const String storeBadgeArGoogleColorUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_ar_color.png?alt=media&token=655ac4ce-b843-467e-b01d-79cadcbb3d7a';
  static String _getArGoogleColorSmall({required bool isPath}) => isPath ? storeBadgeArGoogleColorPath : storeBadgeArGoogleColorUrl;
  // --------------------
  static const String storeBadgeArGoogleBlackPath = 'storage/bldrs/badge_google_ar_black.png';
  static const String storeBadgeArGoogleBlackUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_ar_black.png?alt=media&token=9dc52739-53e5-4a53-8abd-9f130f018491';
  static String _getArGoogleBlackSmall({required bool isPath}) => isPath ? storeBadgeArGoogleBlackPath : storeBadgeArGoogleBlackUrl;
  // --------------------
  static const String storeBadgeArGoogleWhitePath = 'storage/bldrs/badge_google_ar_white.png';
  static const String storeBadgeArGoogleWhiteUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_ar_white.png?alt=media&token=1f35cecf-e5fb-4b50-b920-8d59754be84d';
  static String _getArGoogleWhiteSmall({required bool isPath}) => isPath ? storeBadgeArGoogleWhitePath : storeBadgeArGoogleWhiteUrl;
  // --------------------
  static const String storeBadgeArAppleBlackPath = 'storage/bldrs/badge_apple_ar_black.png';
  static const String storeBadgeArAppleBlackUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_apple_ar_black.png?alt=media&token=0df3b68a-e048-4ece-96c2-6197d3fb782f';
  static String _getArAppleBlackSmall({required bool isPath}) => isPath ? storeBadgeArAppleBlackPath : storeBadgeArAppleBlackUrl;
  // --------------------
  static const String storeBadgeArAppleWhitePath = 'storage/bldrs/badge_apple_ar_white.png';
  static const String storeBadgeArAppleWhiteUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_apple_ar_white.png?alt=media&token=2560845b-ded2-4ca0-9965-330cc425d766';
  static String _getArAppleWhiteSmall({required bool isPath}) => isPath ? storeBadgeArAppleWhitePath : storeBadgeArAppleWhiteUrl;
  // --------------------
  static const String storeBadgeEnGoogleColorPath = 'storage/bldrs/badge_google_en_color.png';
  static const String storeBadgeEnGoogleColorUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_en_color.png?alt=media&token=447769ae-4fd3-451e-8f12-80ff1f0ec536';
  static String _getEnGoogleColorSmall({required bool isPath}) => isPath ? storeBadgeEnGoogleColorPath : storeBadgeEnGoogleColorUrl;
  // --------------------
  static const String storeBadgeEnGoogleBlackPath = 'storage/bldrs/badge_google_en_black.png';
  static const String storeBadgeEnGoogleBlackUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_en_black.png?alt=media&token=d7ae4002-956f-4562-995b-58c586f585a3';
  static String _getEnGoogleBlackSmall({required bool isPath}) => isPath ? storeBadgeEnGoogleBlackPath : storeBadgeEnGoogleBlackUrl;
  // --------------------
  static const String storeBadgeEnGoogleWhitePath = 'storage/bldrs/badge_google_en_white.png';
  static const String storeBadgeEnGoogleWhiteUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_en_white.png?alt=media&token=4af74192-6107-4c65-a52c-c4c30017981d';
  static String _getEnGoogleWhiteSmall({required bool isPath}) => isPath ? storeBadgeEnGoogleWhitePath : storeBadgeEnGoogleWhiteUrl;
  // --------------------
  static const String storeBadgeEnAppleBlackPath = 'storage/bldrs/badge_apple_en_black.png';
  static const String storeBadgeEnAppleBlackUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_apple_en_black.png?alt=media&token=9a589340-8428-4377-8061-7b5f5df8a2fb';
  static String _getEnAppleBlackSmall({required bool isPath}) => isPath ? storeBadgeEnAppleBlackPath : storeBadgeEnAppleBlackUrl;
  // --------------------
  static const String storeBadgeEnAppleWhitePath = 'storage/bldrs/badge_apple_en_white.png';
  static const String storeBadgeEnAppleWhiteUrl = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_apple_en_white.png?alt=media&token=104aafe0-3437-4361-9dd1-17b9ec11f345';
  static String _getEnAppleWhiteSmall({required bool isPath}) => isPath ? storeBadgeEnAppleWhitePath : storeBadgeEnAppleWhiteUrl;
  // --------------------------------------------------------------------------

  /// SMALL STORE BADGES

  // --------------------
  static const String storeBadgeArGoogleColorPathBig = 'storage/bldrs/badge_google_ar_color_big.png';
  static const String storeBadgeArGoogleColorUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_ar_color_big.png?alt=media&token=0b6cc729-d308-4c00-836f-8571563f1704';
  static String _getArGoogleColorBig({required bool isPath}) => isPath ? storeBadgeArGoogleColorPathBig : storeBadgeArGoogleColorUrlBig;
  // --------------------
  static const String storeBadgeArGoogleBlackPathBig = 'storage/bldrs/badge_google_ar_black_big.png';
  static const String storeBadgeArGoogleBlackUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_ar_black_big.png?alt=media&token=092ba572-8376-49ba-83ea-fad14d86220f';
  static String _getArGoogleBlackBig({required bool isPath}) => isPath ? storeBadgeArGoogleBlackPathBig : storeBadgeArGoogleBlackUrlBig;
  // --------------------
  static const String storeBadgeArGoogleWhitePathBig = 'storage/bldrs/badge_google_ar_white_big.png';
  static const String storeBadgeArGoogleWhiteUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_ar_white_big.png?alt=media&token=478bfbea-434b-40e5-b29b-75306174a270';
  static String _getArGoogleWhiteBig({required bool isPath}) => isPath ? storeBadgeArGoogleWhitePathBig : storeBadgeArGoogleWhiteUrlBig;
  // --------------------
  static const String storeBadgeArAppleBlackPathBig = 'storage/bldrs/badge_apple_ar_black_big.png';
  static const String storeBadgeArAppleBlackUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_apple_ar_black_big.png?alt=media&token=f7b3bd25-804b-49aa-801d-92c347e76dc1';
  static String _getArAppleBlackBig({required bool isPath}) => isPath ? storeBadgeArAppleBlackPathBig : storeBadgeArAppleBlackUrlBig;
  // --------------------
  static const String storeBadgeArAppleWhitePathBig = 'storage/bldrs/badge_apple_ar_white_big.png';
  static const String storeBadgeArAppleWhiteUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_apple_ar_white_big.png?alt=media&token=35ae7ce1-415d-4918-8735-ab33946a7edb';
  static String _getArAppleWhiteBig({required bool isPath}) => isPath ? storeBadgeArAppleWhitePathBig : storeBadgeArAppleWhiteUrlBig;
  // --------------------
  static const String storeBadgeEnGoogleColorPathBig = 'storage/bldrs/badge_google_en_color_big.png';
  static const String storeBadgeEnGoogleColorUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_en_color_big.png?alt=media&token=314e66c2-4eee-43d2-9c3b-228de04b05ea';
  static String _getEnGoogleColorBig({required bool isPath}) => isPath ? storeBadgeEnGoogleColorPathBig : storeBadgeEnGoogleColorUrlBig;
  // --------------------
  static const String storeBadgeEnGoogleBlackPathBig = 'storage/bldrs/badge_google_en_black_big.png';
  static const String storeBadgeEnGoogleBlackUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_en_black_big.png?alt=media&token=83720f54-add6-4fb0-a642-51eb8199a917';
  static String _getEnGoogleBlackBig({required bool isPath}) => isPath ? storeBadgeEnGoogleBlackPathBig : storeBadgeEnGoogleBlackUrlBig;
  // --------------------
  static const String storeBadgeEnGoogleWhitePathBig = 'storage/bldrs/badge_google_en_white_big.png';
  static const String storeBadgeEnGoogleWhiteUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_google_en_white_big.png?alt=media&token=f652b996-b5e7-4201-b6bb-6be149bfc881';
  static String _getEnGoogleWhiteBig({required bool isPath}) => isPath ? storeBadgeEnGoogleWhitePathBig : storeBadgeEnGoogleWhiteUrlBig;
  // --------------------
  static const String storeBadgeEnAppleBlackPathBig = 'storage/bldrs/badge_apple_en_black_big.png';
  static const String storeBadgeEnAppleBlackUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_apple_en_black_big.png?alt=media&token=299c6895-ff78-4ca5-9c20-444b5d1eb991';
  static String _getEnAppleBlackBig({required bool isPath}) => isPath ? storeBadgeEnAppleBlackPathBig : storeBadgeEnAppleBlackUrlBig;
  // --------------------
  static const String storeBadgeEnAppleWhitePathBig = 'storage/bldrs/badge_apple_en_white_big.png';
  static const String storeBadgeEnAppleWhiteUrlBig = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbadge_apple_en_white_big.png?alt=media&token=2819e00e-4ec5-47e4-80f8-c532d192ce3a';
  static String _getEnAppleWhiteBig({required bool isPath}) => isPath ? storeBadgeEnAppleWhitePathBig : storeBadgeEnAppleWhiteUrlBig;
  // --------------------------------------------------------------------------

  /// DIMENSIONS

  // --------------------
  static const Dimensions bigDims = Dimensions(width: 800, height: 262);
  static const Dimensions smallDims = Dimensions(width: 150, height: 49);
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBadge({
    required bool isSmall,
    required bool isBlack,
    required bool isEnglish,
    required bool isGoogle,
    required bool isPath,
    required bool isColored,
  }){

    /// SMALL
    if (isSmall == true){
      return _getSmallBadge(
        isBlack: isBlack,
        isEnglish: isEnglish,
        isGoogle: isGoogle,
        isPath: isPath,
        isColored: isColored,
      );
    }

    /// BIG
    else {
      return _getBigBadge(
        isBlack: isBlack,
        isEnglish: isEnglish,
        isGoogle: isGoogle,
        isPath: isPath,
        isColored: isColored,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getSmallBadge({
    required bool isBlack,
    required bool isEnglish,
    required bool isGoogle,
    required bool isPath,
    required bool isColored,
  }) {

    /// ENGLISH
    if (isEnglish == true){

      /// COLORED
      if (isColored == true){
        return isGoogle ? _getEnGoogleColorSmall(isPath: isPath) : _getEnAppleBlackSmall(isPath: isPath);
      }

      /// BLACK
      else if (isBlack == true){
        return isGoogle ? _getEnGoogleBlackSmall(isPath: isPath) : _getEnAppleBlackSmall(isPath: isPath);
      }

      /// WHITE
      else {
        return isGoogle ? _getEnGoogleWhiteSmall(isPath: isPath) : _getEnAppleWhiteSmall(isPath: isPath);
      }

    }

    /// ARABIC
    else {

      /// COLORED
      if (isColored == true){
        return isGoogle ? _getArGoogleColorSmall(isPath: isPath) : _getArAppleBlackSmall(isPath: isPath);
      }

      /// BLACK
      else if (isBlack == true){
        return isGoogle ? _getArGoogleBlackSmall(isPath: isPath) : _getArAppleBlackSmall(isPath: isPath);
      }

      /// WHITE
      else {
        return isGoogle ? _getArGoogleWhiteSmall(isPath: isPath) : _getArAppleWhiteSmall(isPath: isPath);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getBigBadge({
    required bool isBlack,
    required bool isEnglish,
    required bool isGoogle,
    required bool isPath,
    required bool isColored,
  }) {

    /// ENGLISH
    if (isEnglish == true){

      /// COLORED
      if (isColored == true){
        return isGoogle ? _getEnGoogleColorBig(isPath: isPath) : _getEnAppleBlackBig(isPath: isPath);
      }

      /// BLACK
      else if (isBlack == true){
        return isGoogle ? _getEnGoogleBlackBig(isPath: isPath) : _getEnAppleBlackBig(isPath: isPath);
      }

      /// WHITE
      else {
        return isGoogle ? _getEnGoogleWhiteBig(isPath: isPath) : _getEnAppleWhiteBig(isPath: isPath);
      }

    }

    /// ARABIC
    else {

      /// COLORED
      if (isColored == true){
        return isGoogle ? _getArGoogleColorBig(isPath: isPath) : _getArAppleBlackBig(isPath: isPath);
      }

      /// BLACK
      else if (isBlack == true){
        return isGoogle ? _getArGoogleBlackBig(isPath: isPath) : _getArAppleBlackBig(isPath: isPath);
      }

      /// WHITE
      else {
        return isGoogle ? _getArGoogleWhiteBig(isPath: isPath) : _getArAppleWhiteBig(isPath: isPath);
      }

    }

  }
// -----------------------------------------------------------------------------
}

class StoreButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const StoreButton({
    required this.storeType,
    required this.onTap,
    this.isDisabled = false,
    this.height,
    this.corners,
    this.bigGraphic = true,
    this.isBlack = true,
    this.isPath = false,
    this.isEnglish = true,
    this.isColored = false,
    super.key
  });
  // --------------------------------------------------------------------------
  final StoreType? storeType;
  final Function onTap;
  final bool isDisabled;
  final double? height;
  final BorderRadius? corners;
  final bool bigGraphic;
  final bool isBlack;
  final bool isPath;
  final bool isEnglish;
  final bool isColored;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double getHeight({
    required BuildContext context,
    double? heightOverride,
  }){

    if (heightOverride == null){
      final double _referenceLength = Scale.screenShortestSide(context);
      return _referenceLength * 0.08;
    }
    else {
      return heightOverride;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getWidth({
    required BuildContext context,
    double? heightOverride,
  }){
    final double _buttonHeight = getHeight(
      context: context,
      heightOverride: heightOverride,
    );
    const double _aspectRatio = 800 / 262;
    return _buttonHeight * _aspectRatio;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius getCorner({
    required BuildContext context,
    double? heightOverride,
  }){
    /// corner is 40 when height is 262
    /// corner will be 40 * (height / 262)
    final double _buttonHeight = getHeight(
      context: context,
      heightOverride: heightOverride,
    );
    return Borderers.superCorners(
      corners: 40 * (_buttonHeight / 262),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getGraphic({
    required StoreType storeType,
  }){

    switch (storeType){
      case StoreType.appStore:    return Iconz.onAppStore;
      case StoreType.googlePlay:  return Iconz.onGooglePlay;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StoreType? getStoreType(){

    if (DeviceChecker.deviceIsAndroid() == true){
      return StoreType.googlePlay;
    }
    else if (DeviceChecker.deviceIsIOS() == true){
      return StoreType.appStore;
    }
    else {
      return null;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (storeType == null){
      return const SizedBox();
    }

    else {

      final double _buttonHeight = getHeight(
        context: context,
        heightOverride: height,
      );
      final double _buttonWidth = getWidth(
        context: context,
        heightOverride: height,
      );
      final BorderRadius _corners = corners ?? getCorner(
        context: context,
        heightOverride: height,
      );

      return SizedBox(
        height: _buttonHeight,
        width: _buttonWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            Opacity(
              opacity: isDisabled ? 0.3 : 1,
              child: SuperImage(
                height: _buttonHeight,
                width: _buttonWidth,
                corners: _corners,
                greyscale: isDisabled,
                // pic: getGraphic(storeType: storeType!),
                pic: StoreBadge.getBadge(
                  isSmall: !bigGraphic,
                  isBlack: isBlack,
                  isEnglish: isEnglish,
                  isGoogle: storeType == StoreType.googlePlay,
                  isPath: false,
                  isColored: isColored,
                ),
                loading: false,
              ),
            ),

            TapLayer(
              height: _buttonHeight,
              width: _buttonWidth,
              corners: _corners,
              isDisabled: isDisabled,
              splashColor: Colorz.yellow125,
              borderColor: isBlack ? Colorz.white200 : Colorz.black200,
              onTap: onTap,
              // child: SuperImage(
              //   height: _buttonHeight,
              //   width: _buttonWidth,
              //   corners: _corners,
              //   greyscale: isDisabled,
              //   pic: getGraphic(storeType: storeType!),
              //   loading: false,
              // ),
            ),

          ],
        ),
      );

    }

  }
// --------------------------------------------------------------------------
}
