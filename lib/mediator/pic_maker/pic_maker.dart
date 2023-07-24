// ignore_for_file: unnecessary_import
import 'dart:io';
import 'dart:typed_data';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/error_helpers.dart';
import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/permissions/permits_protocols.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/pic_maker/cropping_screen/cropping_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_image_compress/flutter_image_compress.dart';
// -----------------------------------------------------------------------------
/*
/// GIF THING
// check this
// https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
// https://pub.dev/packages/file_picker
// Container(
//   width: 200,
//   height: 200,
//   margin: EdgeInsets.all(30),
//   color: Colorz.BloodTest,
//   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
// ),
 */
// -----------------------------------------------------------------------------

enum PicMakerType {
  cameraImage,
  galleryImage,
}

enum PicType {
  userPic,
  authorPic,
  bzLogo,
  slideHighRes,
  slideLowRes,
  dum,
  askPic,
  notiBanner,
}

/// => TAMAM
class PicMaker {
  // -----------------------------------------------------------------------------

  const PicMaker();

  // -----------------------------------------------------------------------------

  /// SINGLE GALLERY IMAGE PIC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> pickAndCropSinglePic({
    required BuildContext context,
    required bool cropAfterPick,
    required double aspectRatio,
    required bool appIsLTR,
    double? finalWidth,
    int? compressionQuality,
    AssetEntity? selectedAsset,
    String confirmText = 'Crop',
    bool onlyCompress = false,
  }) async {
    Uint8List? _bytes;

    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      _bytes = await _pickWindowsOrWebImage(
        context: context,
        aspectRatio: aspectRatio,
        cropAfterPick: cropAfterPick,
        appIsLTR: appIsLTR,
        confirmText: confirmText,
        resizeToWidth: finalWidth,
      );
    }

    else {

      final List<AssetEntity> _assets = selectedAsset == null ?
      <AssetEntity>[]
          :
      <AssetEntity>[selectedAsset];

      final List<Uint8List> _bytezz = await pickAndCropMultiplePics(
        context: context,
        maxAssets: 1,
        selectedAssets: _assets,
        cropAfterPick: cropAfterPick,
        aspectRatio: aspectRatio,
        finalWidth: finalWidth,
        compressionQuality: compressionQuality,
        confirmText: confirmText,
        appIsLTR: appIsLTR,
        onlyCompress: onlyCompress,
      );

      if (Mapper.checkCanLoopList(_bytezz) == true){
        _bytes = _bytezz.first;
      }

    }

    return _bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _pickWindowsOrWebImage({
    required BuildContext context,
    required double aspectRatio,
    required bool cropAfterPick,
    double? resizeToWidth,
    String confirmText = 'Crop',
    bool appIsLTR = true,
  }) async {

      final ImagePicker _picker = ImagePicker();

      final XFile? _file = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      Uint8List? _bytes = await _file?.readAsBytes();

          /// RESIZE
      if (resizeToWidth != null && _bytes != null){
        _bytes = await resizePic(
          bytes: _bytes,
          finalWidth: resizeToWidth,
          // isFlyerRatio: isFlyerRatio,
        );
      }

      /// CROP
      if (cropAfterPick == true && _bytes != null){
        _bytes = await cropPic(
          context: context,
          bytes: _bytes,
          aspectRatio: aspectRatio,
          appIsLTR: appIsLTR,
          confirmText: confirmText,
        );
      }

      return _bytes;
    }
  // -----------------------------------------------------------------------------

  /// MULTI GALLERY IMAGES PICK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> pickAndCropMultiplePics({
    required BuildContext context,
    required double aspectRatio,
    required bool cropAfterPick,
    double? finalWidth,
    int? compressionQuality,
    int maxAssets = 10,
    List<AssetEntity>? selectedAssets,
    String confirmText = 'Crop',
    bool appIsLTR = true,
    bool onlyCompress = false,
  }) async {

    /// PICK
    List<Uint8List> _bytezz = await _pickMultiplePics(
      context: context,
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,
    );

    /// RESIZE
    if (onlyCompress == false && finalWidth != null && Mapper.checkCanLoopList(_bytezz) == true){
      _bytezz = await resizePics(
        bytezz: _bytezz,
        resizeToWidth: finalWidth,
        // isFlyerRatio: isFlyerRatio,
      );
    }

    /// COMPRESS
    if (compressionQuality != null && finalWidth != null && Mapper.checkCanLoopList(_bytezz) == true){
      _bytezz = await compressPics(
          bytezz: _bytezz,
          compressToWidth: finalWidth,
          quality: compressionQuality,
      );
    }

    /// CROP
    if (cropAfterPick == true && Mapper.checkCanLoopList(_bytezz) == true){
      _bytezz = await cropPics(
        context: context,
        bytezz: _bytezz,
        aspectRatio: aspectRatio,
        appIsLTR: appIsLTR,
        confirmText: confirmText,
      );
    }

    return _bytezz;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> _pickMultiplePics({
    required BuildContext context,
    required int maxAssets,
    List<AssetEntity>? selectedAssets,
  }) async {

    final List<Uint8List> _output = <Uint8List>[];

    final bool _canPick = await PermitProtocol.fetchGalleryPermit(
      context: context,
    );

    if (_canPick == true){

      final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
        context,
        // pageRouteBuilder: ,
        // useRootNavigator: true,
        pickerConfig: await assetPickerConfig(
          context: context,
          maxAssets: maxAssets,
          selectedAssets: selectedAssets,
          // titleTextStyle: ,
          // textStyle: ,
          // titleTextSpacing: ,
          locale: const Locale('en'),
          // gridCount: ,
          // pageSize: ,
        ),
      );

      if (Mapper.checkCanLoopList(pickedAssets) == true){

        for (final AssetEntity asset in pickedAssets!){

          final Uint8List? _bytes = await Floaters.getUint8ListFromFile(await asset.file);

          if (_bytes != null){
            _output.add(_bytes);
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TAKE IMAGE FROM CAMERA

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> shootAndCropCameraPic({
    required BuildContext context,
    required bool cropAfterPick,
    required double aspectRatio,
    required bool appIsLTR,
    double? finalWidth,
    int? compressionQuality,
    String confirmText = 'Crop',
    bool onlyCompress = false,
  }) async {

    Uint8List? _output;

    /// SHOOT
    final Uint8List? _bytes = await _shootCameraPic(
      context: context,
    );

    /// RESIZE -> COMPRESS -> CROP
    if (_bytes != null){

      List<Uint8List> _bytezz = <Uint8List>[_bytes];

      /// RESIZE
      if (onlyCompress == false && finalWidth != null && Mapper.checkCanLoopList(_bytezz) ==true){
        _bytezz = await resizePics(
          bytezz: _bytezz,
          resizeToWidth: finalWidth,
        );
      }

      /// COMPRESS
      if (compressionQuality != null && finalWidth != null && Mapper.checkCanLoopList(_bytezz) ==true){
      _bytezz = await compressPics(
          bytezz: _bytezz,
          compressToWidth: finalWidth,
          quality: compressionQuality,
      );
    }

      /// CROP
      if (cropAfterPick == true){
        _bytezz = await cropPics(
          context: context,
          bytezz: _bytezz,
          aspectRatio: aspectRatio,
          confirmText: confirmText,
          appIsLTR: appIsLTR,
        );
      }

      /// ASSIGN THE FILE
      if (Mapper.checkCanLoopList(_bytezz) == true){
        _output = _bytezz.first;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _shootCameraPic({
    required BuildContext context,
    String langCode = 'en',
  }) async {

    final bool _canShoot = await PermitProtocol.fetchCameraPermit(
      context: context,
    );

    if (_canShoot == true){
      final AssetEntity? entity = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: CameraPickerConfig(

          /// TURNS - ORIENTATION
          // cameraQuarterTurns: 1, // DEFAULT
          lockCaptureOrientation: DeviceOrientation.portraitUp, // DEFAULT

          /// AUDIO
          // enableAudio: true, // DEFAULT

          /// EXPOSURE
          // enableExposureControlOnPoint: true, // DEFAULT
          // enableSetExposure: true, // DEFAULT

          /// ZOOMING
          // enablePinchToZoom: true, // DEFAULT
          // enablePullToZoomInRecord: true, // DEFAULT

          /// PREVIEW
          // enableScaledPreview: true, // DEFAULT
          // shouldAutoPreviewVideo: false, // DEFAULT
          // shouldDeletePreviewFile: false, // DEFAULT

          /// VIDEO
          // enableRecording: false, // DEFAULT
          // enableTapRecording: false, // DEFAULT
          // onlyEnableRecording: false, // DEFAULT
          // maximumRecordingDuration: const Duration(seconds: 15), // DEFAULT

          /// FORMAT
          imageFormatGroup: DeviceChecker.deviceIsIOS() == true ? ImageFormatGroup.bgra8888 : ImageFormatGroup.jpeg, // DEFAULT
          // resolutionPreset: ResolutionPreset.max, // DEFAULT

          /// CAMERA
          // preferredLensDirection: CameraLensDirection.back, // DEFAULT

          /// THEME - TEXTS
          textDelegate: langCode == 'ar' ?
          const ArabicCameraPickerTextDelegate()
          :
          const EnglishCameraPickerTextDelegate(),

          // theme: ThemeData.dark(),

          // onError: (Object object, StackTrace trace){
          //   blog('onError : $object : trace : $trace');
          // },
          //
          // foregroundBuilder: (BuildContext ctx, CameraController cameraController){
          //   blog('onXFileCaptured : cameraController.cameraId : ${cameraController?.cameraId}');
          //   return Container();
          // },
          //
          // onEntitySaving: (BuildContext xxx, CameraPickerViewType cameraPickerViewType, File file) async {
          //   blog('onEntitySaving : cameraPickerViewType : ${cameraPickerViewType.name} : file : ${file.path}');
          // },
          //
          // onXFileCaptured: (XFile xFile, CameraPickerViewType cameraPickerViewType){
          //   blog('onXFileCaptured : cameraPickerViewType : ${cameraPickerViewType.name} : xFile : ${xFile.path}');
          //   return true;
          // },
          //
          // previewTransformBuilder: (BuildContext xyz, CameraController cameraController, Widget widget){
          //   blog('onXFileCaptured : cameraController.cameraId : ${cameraController.cameraId}');
          //   return Container();
          // },

        ),
      );

      if (entity == null){
        return null;
      }

      else {
        final File? _file = await entity.file;
        final Uint8List? _bytes = await Floaters.getUint8ListFromFile(_file);
        return _bytes;
      }

    }

      else {
        return null;
      }

  }
  // -----------------------------------------------------------------------------

  /// CROP IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> cropPic({
    required BuildContext context,
    required Uint8List? bytes,
    required double aspectRatio,
    required String confirmText,
    required bool appIsLTR,
  }) async {
    Uint8List? _bytes;

    final List<Uint8List> _bytezz = await cropPics(
      context: context,
      bytezz: bytes == null ? [] : <Uint8List>[bytes],
      aspectRatio: aspectRatio,
      appIsLTR: appIsLTR,
      confirmText: confirmText,
    );

    if (Mapper.checkCanLoopList(_bytezz) == true){
      _bytes = _bytezz.first;
    }

    return _bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> cropPics({
    required BuildContext context,
    required List<Uint8List>? bytezz,
    required double aspectRatio,
    required String confirmText,
    required bool appIsLTR,
  }) async {

    List<Uint8List> _bytezz = <Uint8List>[];

    if (Mapper.checkCanLoopList(bytezz) == true){

      _bytezz = bytezz!;

      _bytezz = await Nav.goToNewScreen(
        context: context,
        screen: CroppingScreen(
          bytezz: bytezz,
          aspectRatio: aspectRatio,
          appIsLTR: appIsLTR,
          confirmText: confirmText,
        ),
      );

    }

    return _bytezz;
  }
  // -----------------------------------------------------------------------------

  /// RESIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> resizePic({
    required Uint8List? bytes,
    /// image width will be resized to this final width
    required double? finalWidth,
  }) async {

    blog('resizeImage : START');

    Uint8List? _output = bytes;

    if (bytes != null && finalWidth != null){

      img.Image? _imgImage = await Floaters.getImgImageFromUint8List(bytes);

      /// only resize if final width is smaller than original
      if (_imgImage != null && finalWidth < _imgImage.width){

        final double? _aspectRatio = await Dimensions.getPicAspectRatio(bytes);

        _imgImage = Floaters.resizeImgImage(
          imgImage: _imgImage,
          width: finalWidth.floor(),
          height: Dimensions.getHeightByAspectRatio(
              aspectRatio: _aspectRatio,
              width: finalWidth
          )!.floor(),
        );

        _output = Floaters.getUint8ListFromImgImage(_imgImage);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> resizePics({
    required List<Uint8List>? bytezz,
    required double resizeToWidth,
  }) async {
    final List<Uint8List> _output = <Uint8List>[];

    if (Mapper.checkCanLoopList(bytezz) == true){

      for (final Uint8List bytes in bytezz!){

        final Uint8List? _resized = await resizePic(
          bytes: bytes,
          finalWidth: resizeToWidth,
        );

        if (_resized != null){
          _output.add(_resized);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// COMPRESS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> compressPic({
    required Uint8List? bytes,
    required double? compressToWidth,
    required int quality,
  }) async {
    Uint8List? _output;

    if (bytes != null && compressToWidth != null){

      final Dimensions? _dims = await Dimensions.superDimensions(bytes);
      final double? _aspectRatio = _dims?.getAspectRatio();

      final double? _compressToHeight = Dimensions.getHeightByAspectRatio(
          aspectRatio: _aspectRatio,
          width: compressToWidth,
      );

      if (_dims != null && _aspectRatio != null && _compressToHeight != null){

        await tryAndCatch(
          invoker: 'compressPic',
          functions: () async {
            _output = await FlutterImageCompress.compressWithList(
              bytes,
              minWidth: compressToWidth.toInt(),
              minHeight: _compressToHeight.toInt(),
              quality: quality,
              // autoCorrectionAngle: ,
              // format: ,
              // inSampleSize: ,
              // keepExif: ,
              // rotate: ,
            );
            },
          onError: (String error) async {
            blog(error);
            _output = await FlutterImageCompress.compressWithList(
              bytes,
              minWidth: compressToWidth.toInt(),
              minHeight: _compressToHeight.toInt(),
              quality: quality,
              // autoCorrectionAngle: ,
              // format: ,
              // inSampleSize: ,
              // keepExif: ,
              // rotate: ,
            );
            },
        );

      }


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> compressPics({
    required List<Uint8List>? bytezz,
    required double? compressToWidth,
    required int quality,
  }) async {
    final List<Uint8List> _output = <Uint8List>[];

    if (Mapper.checkCanLoopList(bytezz) == true && compressToWidth != null){

      for (final Uint8List bytes in bytezz!){

        final Uint8List? _resized = await compressPic(
          bytes: bytes,
          compressToWidth: compressToWidth,
          quality: quality,
        );

        if (_resized != null){
          _output.add(_resized);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool picturesURLsAreIdentical({
    required List<String>? urls1,
    required List<String>? urls2,
  }) {
    return Mapper.checkListsAreIdentical(
        list1: urls1,
        list2: urls2
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPicIsEmpty(dynamic pic){
    bool _isEmpty = true;

    if (pic != null){

      if (ObjectCheck.isAbsoluteURL(pic) == true){
        _isEmpty = TextCheck.isEmpty(pic);
      }

      /// FILE
      else if (pic is File){
        final File _file = pic;
        _isEmpty = TextCheck.isEmpty(_file.path);
      }

      /// STRING
      else if (pic is String){
        _isEmpty = TextCheck.isEmpty(pic);
      }

      /// BYTES
      else if (ObjectCheck.objectIsUint8List(pic) == true){
        final Uint8List _uInts = pic;
        _isEmpty = _uInts.isEmpty;
      }

    }

    return _isEmpty;
  }
  // -----------------------------------------------------------------------------

  /// IMAGE QUALITY

  // --------------------
  /*
  static int concludeImageQuality(PicType picType) {
    switch (picType) {
      case PicType.userPic:return 100;break;
      case PicType.authorPic:return 100;break;
      case PicType.bzLogo:return 100;break;
      case PicType.slideHighRes:return 100;break;
      case PicType.slideLowRes:return 80;break;
      case PicType.dum:return 100;break;
      case PicType.askPic:return 100;break;
      case PicType.notiBanner:return 100;break;
      default:return 100;
    }
  }
  // --------------------
  static double concludeImageMaxWidth(PicType picType) {
    switch (picType) {
      case PicType.userPic:return 150;break;
      case PicType.authorPic:return 150;break;
      case PicType.bzLogo:return 150;break;
      case PicType.slideHighRes:return 1000;break;
      case PicType.slideLowRes:return 150;break;
      case PicType.dum:return 150;break;
      case PicType.askPic:return 150;break;
      default:return 200;
    }
  }
   */
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPictureInfo(PictureInfo info){
    blog('blogPictureInfo : START');

    blog('x---');
    blog('info.size.height                   : ${info.size.height}');
    blog('info.size.width                    : ${info.size.width}');
    blog('info.size.aspectRatio              : ${info.size.aspectRatio}');
    blog('info.size.longestSide              : ${info.size.longestSide}');
    blog('info.size.shortestSide             : ${info.size.shortestSide}');
    blog('x---');
    blog('info.picture.approximateBytesUsed  : ${info.picture.approximateBytesUsed}');
    blog('x---');
    blog('info.size.isEmpty                  : ${info.size.isEmpty}');
    blog('info.size.isFinite                 : ${info.size.isFinite}');
    blog('info.size.isInfinite               : ${info.size.isInfinite}');
    blog('x---');
    blog('info.viewport.left                 : ${info.picture.approximateBytesUsed}');
    blog('info.viewport.bottom               : ${info.picture.debugDisposed}');
    blog('x---');
    // info.size.flipped.
    blog('blogPictureInfo : END');
  }
  // -----------------------------------------------------------------------------

  /// PICKER CONFIG

  // --------------------
  static Future<AssetPickerConfig> assetPickerConfig({
    required BuildContext context,
    required int maxAssets,
    required List<AssetEntity>? selectedAssets,
    Locale? locale,
    TextStyle? textStyle,
    int gridCount = 3,
    int pageSize = 12,
    TextStyle? titleTextStyle,
    double? titleTextSpacing,
  }) async {

    return AssetPickerConfig(

      /// ASSETS SELECTION
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,

      /// ASSETS TYPE
      requestType: RequestType.image,

      /// GRID AND SIZING
      gridCount: gridCount,
      // gridThumbnailSize: defaultAssetGridPreviewSize,
      pageSize: pageSize,
      // pathThumbnailSize: defaultPathThumbnailSize,
                // previewThumbnailSize: ThumbnailSize.square(50),
                // shouldRevertGrid: false,

      /// THEME
      // themeColor: Colorz.yellow255, /// either use themeColor or pickerTheme
      pickerTheme: ThemeData(
        /// FONT
        fontFamily: BldrsThemeFonts.fontBldrsHeadlineFont,
        /// BACKGROUND COLOR
        canvasColor: Colorz.blackSemi255,
        /// BUTTON AND CHECK COLOR : DEPRECATED
        // accentColor: Colorz.yellow255,
        /// COLOR THEME
        colorScheme: const ColorScheme(
          // ----------------------------------------------------->
          /// BRIGHTNESS
          brightness: Brightness.dark,
          /// DEVICE FOLDERS LIST BACKGROUND
          background: Colorz.black200,
          /// APP BAR BACKGROUND
          surface: Colorz.black255,
          /// BUTTON AND CHECK BACKGROUND COLOR
          secondary: Colorz.yellow255,
          /// DROPDOWN ARROW
          primary: Colorz.blue255,
          /// ERRORS
          onError: Colorz.red255,
          error: Colorz.red255,
          // errorContainer: Colorz.white50,
          // onErrorContainer: Colorz.white50,
          /// UNKNOWN
          onBackground: Colorz.nothing,
          /// primary
          onPrimary: Colorz.nothing,
          // inversePrimary: Colorz.green50,
          // primaryVariant: Colorz.white50, // deprecated on favor of primaryContainer
          // onPrimaryContainer: Colorz.green50,
          // primaryContainer: Colorz.white50,
          /// surface
          onSurface: Colorz.nothing,
          // onSurfaceVariant: Colorz.green50,
          // inverseSurface: Colorz.green50,
          // surfaceTint: Colorz.green50,
          // surfaceVariant: Colorz.green50,
          // onInverseSurface: Colorz.green50,
          /// secondary
          onSecondary: Colorz.nothing, /// LAYER ON TOP OF BACKGROUND AND BEHIND THE IMAGE
          // secondaryVariant: Colorz.white50, // deprecated on favor of secondaryContainer
          // secondaryContainer: Colorz.green50,
          // onSecondaryContainer: Colorz.green50,
          /// tertiary
          // onTertiary: Colorz.green50,
          // onTertiaryContainer: Colorz.green50,
          // tertiary: Colorz.green50,
          // tertiaryContainer: Colorz.green50,
          /// outline
          // outline: Colorz.green50,
          // outlineVariant: Colorz.green50,
          // scrim: Colorz.green50,
          // shadow: Colorz.green50,
          // ----------------------------------------------------->
        ),
        textTheme: TextTheme(
          ///DISPLAY
          displayLarge: textStyle,
          displayMedium: textStyle,
          displaySmall: textStyle,
          /// HEADLINE
          headlineLarge: textStyle,
          headlineMedium:textStyle,
          headlineSmall: textStyle,
          /// TITLE
          titleLarge: textStyle,
          titleMedium:textStyle,
          titleSmall:textStyle,
          /// BODY
          bodyLarge:textStyle,
          bodyMedium:textStyle,
          bodySmall:textStyle,
          /// LABEL
          labelLarge:textStyle,
          labelMedium:textStyle,
          labelSmall:textStyle,
          /// DEPRECATED
          // headline2: ,
          // headline1: ,
          // button: ,
          // bodyText2: ,
          // bodyText1: ,
          // caption: ,
          // headline3: ,
          // headline4: ,
          // headline5: ,
          // headline6: ,
          // overline: ,
          // subtitle1: ,
          // subtitle2: ,
        ),
        appBarTheme: AppBarTheme(
          /// BACKGROUND COLOR
          // color: Colorz.darkGrey255, // backgroundColor: Colorz.black255,
          // foregroundColor: Colorz.green255,
          // shadowColor: Colorz.bloodTest,
          centerTitle: false,
          elevation: 10,
          scrolledUnderElevation: 100,
          // shape: ,
          // surfaceTintColor: Colorz.bloodTest,
          // systemOverlayStyle: SystemUiOverlayStyle.dark,
          /// ICON
          // actionsIconTheme: ,
          // iconTheme: ,
          /// TITLE
          titleTextStyle: titleTextStyle,
          titleSpacing: titleTextSpacing,
          // textTheme: , /// deprecated in favor of titleTextStyle & toolbarTextStyle
          /// TOOL BAR
          // toolbarTextStyle: ,
          // toolbarHeight: ,
          /// DEPRECATED
          // backwardsCompatibility: ,
          // brightness: Brightness.light,
        ),
      ),
      textDelegate: assetPickerTextDelegateFromLocale(locale),
      /// SCROLLING
      // keepScrollOffset: false,
      // specialItemPosition: SpecialItemPosition.none,
      /// PERMISSION
      // limitedPermissionOverlayPredicate: (PermissionState permissionState){
      //   blog('pickMultipleImages : permissionState : $permissionState');
      //   return true;
      // },
      /// LOADING
      // loadingIndicatorBuilder: (BuildContext context, bool loading){
      //   return Loading(loading: loading);
      // },
      /// ASSET NAME
      // pathNameBuilder: (AssetPathEntity assetPathEntity){
      //   blog('assetPathEntity : $assetPathEntity');
      //   return 'Fuck you';
      // },
      // sortPathDelegate: SortPathDelegate.common,
      /// WHO THE FUCK ARE YOU
      // selectPredicate: (BuildContext xxx, AssetEntity assetEntity, bool wtf) async {
      //   blog('pickMultipleImages : ${assetEntity.id} : wtf : $wtf');
      //   return wtf;
      // },
      // specialItemBuilder: (BuildContext xyz, AssetPathEntity assetPathEntity, int number){
      //   return const SizedBox();;
      // },
      // specialPickerType: SpecialPickerType.wechatMoment,
      //
      // filterOptions: FilterOptionGroup(
      //   audioOption: const FilterOption(
      //     durationConstraint: DurationConstraint(
      //       allowNullable: false,
      //       max: const Duration(days: 1),
      //       min: Duration.zero,
      //     ),
      //     needTitle: true,
      //     sizeConstraint: SizeConstraint(
      //       maxHeight: 100000,
      //       minHeight: 0,
      //       ignoreSize: true,
      //       maxWidth: 100000,
      //       minWidth: 0,
      //     ),
      //   ),
      //   containsEmptyAlbum: true,
      //   containsLivePhotos: true,
      //   containsPathModified: true,
      //   createTimeCond: DateTimeCond(
      //     ignore: true,
      //     min: DateTime.now(),
      //     max: DateTime.now(),
      //   ),
      //   imageOption: FilterOption(
      //     sizeConstraint: SizeConstraint(
      //       maxHeight: 100000,
      //       minHeight: 0,
      //       ignoreSize: true,
      //       maxWidth: 100000,
      //       minWidth: 0,
      //     ),
      //     needTitle: true,
      //     durationConstraint: DurationConstraint(
      //       allowNullable: false,
      //       max: const Duration(days: 1),
      //       min: Duration.zero,
      //     ),
      //   ),
      //   onlyLivePhotos: false,
      //   orders: <OrderOption>[
      //     OrderOption(
      //       asc: false,
      //       type: OrderOptionType.createDate,
      //     ),
      //   ],
      //     updateTimeCond: DateTimeCond(
      //     ignore: true,
      //     min: 0,
      //     max: ,
      //   ),
      //   videoOption: FilterOption(
      //     sizeConstraint: SizeConstraint(
      //       maxHeight: 100000,
      //       minHeight: 0,
      //       ignoreSize: true,
      //       maxWidth: 100000,
      //       minWidth: 0,
      //     ),
      //   ),
      // ),
    );

  }
  // -----------------------------------------------------------------------------
}

/// => TAMAM TRANSLATE_THE_WORLD
class ArabicCameraPickerTextDelegate extends CameraPickerTextDelegate {

  /// Text delegate implements with Arabic.

  const ArabicCameraPickerTextDelegate();

  @override
  String get languageCode => 'ar';

  @override
  String get confirm => 'تأكيد';

  @override
  String get shootingTips => 'اضغط للتصوير';

  @override
  String get shootingWithRecordingTips =>
      'اضغط لتصوير صورة، و اضغط طويلا لتسجيل فيديو';

  @override
  String get shootingOnlyRecordingTips => 'اضغط طويلا لتسجيل فيديو';

  @override
  String get shootingTapRecordingTips => 'اضغط لتسجيل فيديو';

  @override
  String get loadFailed => 'فشلت عميلة التحميل';

  @override
  String get loading => 'جاري التحميل ...';

  @override
  String get saving => 'جاري الحفظ ...';

  @override
  String get sActionManuallyFocusHint => 'تعديل البؤرة يدويا';

  @override
  String get sActionPreviewHint => 'عرض';

  @override
  String get sActionRecordHint => 'تسجيل';

  @override
  String get sActionShootHint => 'صور صورة';

  @override
  String get sActionShootingButtonTooltip => 'زر التصوير';

  @override
  String get sActionStopRecordingHint => 'إيقاف التسجيل';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value){
    if (value == CameraLensDirection.back){
      return 'الكاميرا الخلفية';
    }
    else if (value == CameraLensDirection.front){
      return 'الكاميرا الأمامية';
    }
    else {
      return 'الكاميرا';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == CameraLensDirection.front.name){
      return 'عرض الكاميرا الأمامية';
    }
    else if (sCameraLensDirectionLabel(value) == CameraLensDirection.back.name){
      return 'عرض الكاميرا الخلفية';
    }
    else {
      return 'عرض الكاميرا';
    }

  }

  @override
  String sFlashModeLabel(FlashMode mode){

    if (mode == FlashMode.always){
      return 'فلاش مستمر';
    }
    else if (mode == FlashMode.auto){
      return 'فلاش أوتوماتيكي';
    }
    else if (mode == FlashMode.off){
      return 'بدون فلاش';
    }
    else if (mode == FlashMode.torch){
      return 'فلاش متقطع';
    }
    else {
      return 'فلاش';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value){

    if (value == CameraLensDirection.back){
      return 'التحويل للكاميرا الخلفية';
    }
    else if (value == CameraLensDirection.front){
      return 'التحويل للكاميرا الأمامية';
    }
    else {
      return 'تحويل الكاميرا';
    }

  }

}
