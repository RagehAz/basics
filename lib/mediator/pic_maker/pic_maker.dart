// ignore_for_file: unnecessary_import, unused_local_variable, avoid_redundant_argument_values
import 'dart:io';
import 'dart:typed_data';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/permissions/permits_protocols.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/configs/asset_picker_configs.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/pic_maker/cropping_screen/cropping_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
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

/// => TAMAM
class PicMaker {
  // -----------------------------------------------------------------------------

  const PicMaker();

  // -----------------------------------------------------------------------------
  /// NO IMAGE WILL EVER BE WIDER THAN THIS TO BE PROCESSED IN THE APP
  static const double maxPicWidthBeforeCrop = 1500;
  // -----------------------------------------------------------------------------

  /// SINGLE GALLERY IMAGE PIC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> pickAndCropSinglePic({
    required BuildContext context,
    required bool cropAfterPick,
    required double aspectRatio,
    required bool appIsLTR,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    double? resizeToWidth,
    int? compressWithQuality,
    AssetEntity? selectedAsset,
    String confirmText = 'Crop',
    Function(String? error)? onError,
  }) async {
    Uint8List? _bytes;

    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      _bytes = await _pickWindowsOrWebImage(
        context: context,
        aspectRatio: aspectRatio,
        cropAfterPick: cropAfterPick,
        appIsLTR: appIsLTR,
        confirmText: confirmText,
        resizeToWidth: resizeToWidth,
        compressWithQuality: compressWithQuality,
        onError: onError,
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
        resizeToWidth: resizeToWidth,
        compressWithQuality: compressWithQuality,
        confirmText: confirmText,
        appIsLTR: appIsLTR,
        langCode: langCode,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        onError: onError,
      );

      if (Lister.checkCanLoop(_bytezz) == true){
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
    required Function(String? error)? onError,
    double? resizeToWidth,
    int? compressWithQuality,
    String confirmText = 'Crop',
    bool appIsLTR = true,
  }) async {

    Uint8List? _bytes;

    await tryAndCatch(
      onError: onError,
      invoker: '_pickWindowsOrWebImage',
      functions: () async {

        final ImagePicker _picker = ImagePicker();

        final XFile? _file = await _picker.pickImage(
          source: ImageSource.gallery,
        );

        _bytes = await _file?.readAsBytes();

        },
    );

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

    /// RESIZE
    if (resizeToWidth != null && _bytes != null){
      _bytes = await resizePic(
        bytes: _bytes,
        resizeToWidth: resizeToWidth,
        // isFlyerRatio: isFlyerRatio,
      );
    }

    /// COMPRESS
    if (compressWithQuality != null && _bytes != null){
      _bytes = await compressPic(
        bytes: _bytes,
        quality: compressWithQuality,
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
    required bool appIsLTR,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    double? resizeToWidth,
    int? compressWithQuality,
    int maxAssets = 10,
    List<AssetEntity>? selectedAssets,
    String confirmText = 'Crop',
    Function(String? error)? onError,
  }) async {

    /// PICK
    List<Uint8List> _bytezz = await _pickMultiplePics(
      context: context,
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onError,
    );

    /// CROP
    if (cropAfterPick == true && Lister.checkCanLoop(_bytezz) == true){
      _bytezz = await cropPics(
        context: context,
        bytezz: _bytezz,
        aspectRatio: aspectRatio,
        appIsLTR: appIsLTR,
        confirmText: confirmText,
      );
    }

    /// RESIZE
    if (resizeToWidth != null && Lister.checkCanLoop(_bytezz) == true){
      _bytezz = await resizePics(
        bytezz: _bytezz,
        resizeToWidth: resizeToWidth,
        // isFlyerRatio: isFlyerRatio,
      );
    }

    /// COMPRESS
    if (compressWithQuality != null && Lister.checkCanLoop(_bytezz) == true){
      _bytezz = await compressPics(
          bytezz: _bytezz,
          quality: compressWithQuality,
      );
    }

    return _bytezz;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> _pickMultiplePics({
    required BuildContext context,
    required int maxAssets,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required List<AssetEntity>? selectedAssets,
  }) async {

    final List<Uint8List> _output = <Uint8List>[];

    final bool _canPick = await PermitProtocol.fetchGalleryPermit(
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
    );

    if (_canPick == true){

      List<AssetEntity>? pickedAssets = [];

      await tryAndCatch(
        invoker: '_pickMultiplePics',
        onError: onError,
        functions: () async {

          pickedAssets = await AssetPicker.pickAssets(
            context,
            // pageRouteBuilder: ,
            // useRootNavigator: true,
            pickerConfig: WeChatPickerConfigs.picker(
              maxAssets: maxAssets,
              selectedAssets: selectedAssets,
              langCode: langCode,
              // titleTextStyle: ,
              // textStyle: ,
              // titleTextSpacing: ,
              // gridCount: ,
              // pageSize: ,
            ),
          );

          },
      );

      if (Lister.checkCanLoop(pickedAssets) == true){

        for (final AssetEntity asset in pickedAssets!){

          final Uint8List? _bytes = await Floaters.getBytesFromFile(await asset.file);

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
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    double? resizeToWidth,
    int? compressWithQuality,
    String confirmText = 'Crop',
    Function(String? error)? onError,
    Locale? locale,
  }) async {

    Uint8List? _output;

    /// SHOOT
    final Uint8List? _bytes = await _shootCameraPic(
      context: context,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onError,
      locale: locale,
    );

    /// CROP -> RESIZE -> COMPRESS
    if (_bytes != null){

      List<Uint8List> _bytezz = <Uint8List>[_bytes];

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

      /// RESIZE
      if (resizeToWidth != null && Lister.checkCanLoop(_bytezz) ==true){
        _bytezz = await resizePics(
          bytezz: _bytezz,
          resizeToWidth: resizeToWidth,
        );
      }

      /// COMPRESS
      if (compressWithQuality != null && Lister.checkCanLoop(_bytezz) ==true){
      _bytezz = await compressPics(
          bytezz: _bytezz,
          quality: compressWithQuality,
      );
    }

      /// ASSIGN THE FILE
      if (Lister.checkCanLoop(_bytezz) == true){
        _output = _bytezz.first;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _shootCameraPic({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required Locale? locale,
  }) async {

    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      return null;
    }

    else {

      final bool _canShoot = await PermitProtocol.fetchCameraPermit(
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      );

      if (_canShoot == true){
        AssetEntity? entity;

        await tryAndCatch(
          invoker: '_shootCameraPic',
          onError: onError,
          functions: () async {

            entity = await CameraPicker.pickFromCamera(
              context,
              pickerConfig: WeChatPickerConfigs.camera(
                langCode: langCode,
                isVideo: false,
              ),
              locale: locale,
              // useRootNavigator: ,
              // pageRouteBuilder: ,
              // createPickerState: ,
            );

            },
        );

        if (entity == null){
          return null;
        }

        else {
          final File? _file = await entity!.file;
          final Uint8List? _bytes = await Floaters.getBytesFromFile(_file);
          return _bytes;
        }

      }

      else {
        return null;
      }

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

    if (Lister.checkCanLoop(_bytezz) == true){
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

    if (Lister.checkCanLoop(bytezz) == true){

      _bytezz = await resizePics(bytezz: bytezz!, resizeToWidth: maxPicWidthBeforeCrop);

      final List<Uint8List>? _received = await Nav.goToNewScreen(
        appIsLTR: appIsLTR,
        context: context,
        screen: CroppingScreen(
          bytezz: _bytezz,
          aspectRatio: aspectRatio,
          appIsLTR: appIsLTR,
          confirmText: confirmText,
        ),
      );

      if (Lister.checkCanLoop(_received) == true){
        _bytezz = _received!;
      }

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
    required double? resizeToWidth,
  }) async {

    blog('resizeImage : START');

    Uint8List? _output = bytes;

    if (bytes != null && resizeToWidth != null){

      // img.Image? _imgImage = await Floaters.getImgImageFromUint8List(bytes);
      //
      // /// only resize if final width is smaller than original
      // if (_imgImage != null && resizeToWidth < _imgImage.width){
      //
      //   final double? _aspectRatio = await Dimensions.getPicAspectRatio(bytes);
      //
      //   _imgImage = Floaters.resizeImgImage(
      //     imgImage: _imgImage,
      //     width: resizeToWidth.floor(),
      //     height: Dimensions.getHeightByAspectRatio(
      //         aspectRatio: _aspectRatio,
      //         width: resizeToWidth
      //     )!.floor(),
      //   );
      //
      //   _output = Floaters.getBytesFromImgImage(_imgImage);
      // }

      _output = await Floaters.resizeBytes(
        bytes: bytes,
        resizeToWidth: resizeToWidth,
      );

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

    if (Lister.checkCanLoop(bytezz) == true){

      for (final Uint8List bytes in bytezz!){

        final Uint8List? _resized = await resizePic(
          bytes: bytes,
          resizeToWidth: resizeToWidth,
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
    required int quality,
  }) async {
    Uint8List? _output = bytes;

    if (bytes != null){

      final Dimensions? _dims = await Dimensions.superDimensions(bytes);
      final double? _aspectRatio = _dims?.getAspectRatio();

      if (
          _dims != null
              &&
          _aspectRatio != null
      ){

        await tryAndCatch(
          invoker: 'compressPic',
          functions: () async {

            final ImageFile input = ImageFile(
              filePath: 'x',
              rawBytes: bytes,
              // width: _dims.width?.toInt(),
              // height: _dims.height?.toInt(),
              // contentType: ,
            );

            final Configuration config = Configuration(
              outputType: ImageOutputType.webpThenJpg,
              /// can only be true for Android and iOS while using ImageOutputType.jpg or ImageOutputType.pngÏ
              useJpgPngNativeCompressor: false,
              /// set quality between 0-100
              quality: quality,
            );

            final ImageFileConfiguration param = ImageFileConfiguration(
              input: input,
              config: config,
            );

            final ImageFile outputFile = await compressor.compress(param);

            _output = outputFile.rawBytes;

            },
          onError: (String error) async {
            // blog(error);
            // _output = await FlutterImageCompress.compressWithList(
            //   bytes,
            //   minWidth: compressToWidth.toInt(),
            //   minHeight: _compressToHeight.toInt(),
            //   quality: quality,
            //   // autoCorrectionAngle: ,
            //   // format: ,
            //   // inSampleSize: ,
            //   // keepExif: ,
            //   // rotate: ,
            // );
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
    required int quality,
  }) async {
    final List<Uint8List> _output = <Uint8List>[];

    if (Lister.checkCanLoop(bytezz) == true){

      for (final Uint8List bytes in bytezz!){

        final Uint8List? _resized = await compressPic(
          bytes: bytes,
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
    return Lister.checkListsAreIdentical(
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
}
