// ignore_for_file: unnecessary_import, unused_local_variable, avoid_redundant_argument_values
import 'dart:io';
import 'dart:typed_data';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/files/x_filers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/permissions/permits_protocols.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/configs/asset_picker_configs.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/models/file_typer.dart';
import 'package:basics/mediator/models/media_model.dart';
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

/// TASK : TEST_ME_NOW
class PicMaker {
  // -----------------------------------------------------------------------------

  const PicMaker();

  // -----------------------------------------------------------------------------
  /// NO IMAGE WILL EVER BE WIDER THAN THIS TO BE PROCESSED IN THE APP
  static const double maxPicWidthBeforeCrop = 1500;
  // -----------------------------------------------------------------------------

  /// SINGLE GALLERY IMAGE PIC

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> pickAndCropSinglePic({
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
    MediaModel? _output;

    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      _output = await _pickWindowsOrWebImage(
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

      final List<MediaModel> _mediaModels = await pickAndCropMultiplePics(
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

      if (Lister.checkCanLoop(_mediaModels) == true){
        _output = _mediaModels.first;
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> _pickWindowsOrWebImage({
    required BuildContext context,
    required double aspectRatio,
    required bool cropAfterPick,
    required Function(String? error)? onError,
    double? resizeToWidth,
    int? compressWithQuality,
    String confirmText = 'Crop',
    bool appIsLTR = true,
  }) async {
    MediaModel? _output;

    await tryAndCatch(
      onError: onError,
      invoker: '_pickWindowsOrWebImage',
      functions: () async {

        final ImagePicker _picker = ImagePicker();

        final XFile? _file = await _picker.pickImage(
          source: ImageSource.gallery,
        );

        if (_file != null){

          _output = await MediaModel.combineMediaModel(
            file: _file,
            mediaOrigin: MediaOrigin.galleryImage,
            fileType: FileType.jpeg,
            uploadPath: null,
            ownersIDs: [],
            name: _file.name,
          );

        }

        },
    );

    /// CROP
    if (cropAfterPick == true && _output != null){
      _output = await cropPic(
        context: context,
        mediaModel: _output!,
        aspectRatio: aspectRatio,
        appIsLTR: appIsLTR,
        confirmText: confirmText,
      );
    }

    /// RESIZE
    if (resizeToWidth != null && _output != null){
      _output = await resizePic(
        mediaModel: _output,
        resizeToWidth: resizeToWidth,
        // isFlyerRatio: isFlyerRatio,
      );
    }

    /// COMPRESS
    if (compressWithQuality != null && _output != null){
      _output = await compressPic(
        mediaModel: _output!,
        quality: compressWithQuality,
      );
    }

    return _output;
    }
  // -----------------------------------------------------------------------------

  /// MULTI GALLERY IMAGES PICK

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<MediaModel>> pickAndCropMultiplePics({
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
    List<MediaModel> _mediaModels = await _pickMultiplePics(
      context: context,
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onError,
    );

    /// CROP
    if (cropAfterPick == true && Lister.checkCanLoop(_mediaModels) == true){
      _mediaModels = await cropPics(
        context: context,
        mediaModels: _mediaModels,
        aspectRatio: aspectRatio,
        appIsLTR: appIsLTR,
        confirmText: confirmText,
      );
    }

    /// RESIZE
    if (resizeToWidth != null && Lister.checkCanLoop(_mediaModels) == true){
      _mediaModels = await resizePics(
        mediaModels: _mediaModels,
        resizeToWidth: resizeToWidth,
        // isFlyerRatio: isFlyerRatio,
      );
    }

    /// COMPRESS
    if (compressWithQuality != null && Lister.checkCanLoop(_mediaModels) == true){
      _mediaModels = await compressPics(
        mediaModels: _mediaModels,
          quality: compressWithQuality,
      );
    }

    return _mediaModels;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<MediaModel>> _pickMultiplePics({
    required BuildContext context,
    required int maxAssets,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required List<AssetEntity>? selectedAssets,
  }) async {

    final List<MediaModel> _output = <MediaModel>[];

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

          final XFile? _xFile = await XFiler.createXFileFromAssetEntity(
            assetEntity: asset,
          );

          final MediaModel? _model = await MediaModel.combineMediaModel(
              file: _xFile,
              mediaOrigin: MediaOrigin.galleryImage,
              fileType: FileType.jpeg,
              uploadPath: null,
              ownersIDs: [],
              name: _xFile?.name,
          );

          if (_model != null){
            _output.add(_model);
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TAKE IMAGE FROM CAMERA

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> shootAndCropCameraPic({
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

    MediaModel? _output;

    /// SHOOT
    final MediaModel? _mediaModel = await _shootCameraPic(
      context: context,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onError,
      locale: locale,
    );

    /// CROP -> RESIZE -> COMPRESS
    if (_mediaModel != null){

      List<MediaModel> _models = <MediaModel>[_mediaModel];

      /// CROP
      if (cropAfterPick == true){
        _models = await cropPics(
          context: context,
          mediaModels: _models,
          aspectRatio: aspectRatio,
          confirmText: confirmText,
          appIsLTR: appIsLTR,
        );
      }

      /// RESIZE
      if (resizeToWidth != null && Lister.checkCanLoop(_models) ==true){
        _models = await resizePics(
          mediaModels: _models,
          resizeToWidth: resizeToWidth,
        );
      }

      /// COMPRESS
      if (compressWithQuality != null && Lister.checkCanLoop(_models) ==true){
      _models = await compressPics(
          mediaModels: _models,
          quality: compressWithQuality,
      );
    }

      /// ASSIGN THE FILE
      if (Lister.checkCanLoop(_models) == true){
        _output = _models.first;
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> _shootCameraPic({
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

          final XFile? _xFile = await XFiler.createXFileFromAssetEntity(
              assetEntity: entity,
          );

          final MediaModel? _model = await MediaModel.combineMediaModel(
            file: _xFile,
            mediaOrigin: MediaOrigin.galleryImage,
            fileType: FileType.jpeg,
            uploadPath: null,
            ownersIDs: [],
            name: _xFile?.name,
          );

          return _model;

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
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> cropPic({
    required BuildContext context,
    required MediaModel? mediaModel,
    required double aspectRatio,
    required String confirmText,
    required bool appIsLTR,
  }) async {
    MediaModel? _bytes;

    final List<MediaModel> _mediaModels = await cropPics(
      context: context,
      mediaModels: mediaModel == null ? [] : <MediaModel>[mediaModel],
      aspectRatio: aspectRatio,
      appIsLTR: appIsLTR,
      confirmText: confirmText,
    );

    if (Lister.checkCanLoop(_mediaModels) == true){
      _bytes = _mediaModels.first;
    }

    return _bytes;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<MediaModel>> cropPics({
    required BuildContext context,
    required List<MediaModel>? mediaModels,
    required double aspectRatio,
    required String confirmText,
    required bool appIsLTR,
  }) async {

    List<MediaModel> _output = <MediaModel>[];

    if (Lister.checkCanLoop(mediaModels) == true){

      _output = await resizePics(
          mediaModels: mediaModels!,
          resizeToWidth: maxPicWidthBeforeCrop,
      );

      final List<MediaModel>? _received = await Nav.goToNewScreen(
        appIsLTR: appIsLTR,
        context: context,
        screen: CroppingScreen(
          mediaModels: mediaModels,
          aspectRatio: aspectRatio,
          appIsLTR: appIsLTR,
          confirmText: confirmText,
        ),
      );

      if (Lister.checkCanLoop(_received) == true){
        _output = _received!;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RESIZE

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> resizePic({
    required MediaModel? mediaModel,
    /// image width will be resized to this final width
    required double? resizeToWidth,
  }) async {

    blog('resizeImage : START');

    MediaModel? _output = mediaModel;

    if (mediaModel != null && resizeToWidth != null){

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

      Uint8List? _bytes = await _output?.file?.readAsBytes();

      _bytes = await Floaters.resizeBytes(
        bytes: _bytes,
        resizeToWidth: resizeToWidth,
      );

      _output = await _output?.replaceBytes(
        bytes: _bytes,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<MediaModel>> resizePics({
    required List<MediaModel>? mediaModels,
    required double resizeToWidth,
  }) async {
    final List<MediaModel> _output = <MediaModel>[];

    if (Lister.checkCanLoop(mediaModels) == true){

      for (final MediaModel mediaModel in mediaModels!){

        final MediaModel? _resized = await resizePic(
          mediaModel:mediaModel,
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
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> compressPic({
    required MediaModel? mediaModel,
    required int quality,
  }) async {
    MediaModel? _output = mediaModel;

    if (mediaModel != null){

      final Dimensions? _dims = await Dimensions.superDimensions(_output);
      final double? _aspectRatio = _dims?.getAspectRatio();

      if (
          _dims != null
              &&
          _aspectRatio != null
      ){

        await tryAndCatch(
          invoker: 'compressPic',
          functions: () async {

            final Uint8List? _bytes = await mediaModel.file?.readAsBytes();

            if (_bytes != null){

              final ImageFile input = ImageFile(
                filePath: 'x',
                rawBytes: _bytes,
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

              _output = await _output?.replaceBytes(
                bytes: outputFile.rawBytes,
              );

            }


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
  /// TASK : TEST_ME_NOW
  static Future<List<MediaModel>> compressPics({
    required List<MediaModel>? mediaModels,
    required int quality,
  }) async {
    final List<MediaModel> _output = <MediaModel>[];

    if (Lister.checkCanLoop(mediaModels) == true){

      for (final MediaModel mediaModel in mediaModels!){

        final MediaModel? _resized = await compressPic(
          mediaModel: mediaModel,
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
