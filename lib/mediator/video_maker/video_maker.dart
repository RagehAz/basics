// ignore_for_file: unnecessary_import, unused_local_variable, avoid_redundant_argument_values
import 'dart:io';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/permissions/permits_protocols.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/configs/asset_picker_configs.dart';
import 'package:basics/mediator/models/file_typer.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:basics/mediator/video_maker/cover_screen/video_cover_screen.dart';
import 'package:basics/mediator/video_maker/trimming_screen/trim_video_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class VideoMaker {
  // -----------------------------------------------------------------------------

  const VideoMaker();

  // -----------------------------------------------------------------------------

  /// PICK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, MediaModel>?> pickAndCropVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required bool cropAfterPick,
    required double aspectRatio,
    required bool appIsLTR,
    required bool createCover,
    required int? compressWithQuality,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
    double? resizeToWidth,
    String confirmText = 'Confirm',
  }) async {
    Map<String, MediaModel>? _output;

    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      /// NOT IMPLEMENTED
      blog('pickAndCropVideo Not implemented');
    }

    else {

      MediaModel? _video = await _pickVideoFile(
        context: context,
        langCode: langCode,
        onPermissionPermanentlyDenied:
        onPermissionPermanentlyDenied,
        onError: onError,
        name: name,
        assignPath: assignPath,
        compressWithQuality: compressWithQuality,
        ownersIDs: ownersIDs,
      );

      /// CROP
      if (cropAfterPick == true){
        _video = await cropVideo(
          video: _video,
          appIsLTR: appIsLTR,
          aspectRatio: aspectRatio,
          context: context,
          confirmText: confirmText,
          ownersIDs: ownersIDs,
          assignPath: assignPath,
          name: name,
          compressWithQuality: compressWithQuality,
          mediaOrigin: MediaOrigin.galleryVideo,
        );
      }

      ///
      if (_video != null){

        _output = {
          'video': _video,
        };

        if (createCover == true){

          final MediaModel? _cover = await _createCover(
            video: _video,
            context: context,
            aspectRatio: aspectRatio,
            appIsLTR: appIsLTR,
            confirmText: confirmText,
            mediaOrigin: MediaOrigin.galleryVideo,
            compressWithQuality: compressWithQuality,
            name: name,
            assignPath: assignPath,
            ownersIDs: ownersIDs,
          );

          if (_cover != null){
            _output['cover'] = _cover;
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> _pickVideoFile({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required int? compressWithQuality,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
  }) async {
    MediaModel? _output;

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
              requestType: RequestType.video,
              maxAssets: 1,
              selectedAssets: null,
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

        final File? _file = await pickedAssets!.first.file;
        final Uint8List? _bytes = await Floaters.getBytesFromFile(_file);

        _output = await MediaModel.combinePicModel(
          ownersIDs: ownersIDs,
          fileType: FileType.mp4,
          name: name,
          bytes: _bytes,
          compressWithQuality: compressWithQuality,
          mediaOrigin: MediaOrigin.galleryVideo,
          assignPath: assignPath,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SHOOT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, MediaModel>?> shootAndCropVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required Locale? locale,
    required bool cropAfterPick,
    required double aspectRatio,
    required bool appIsLTR,
    required int? compressWithQuality,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
    required bool createCover,
    double? resizeToWidth,
    String confirmText = 'Crop',
  }) async {
    Map<String, MediaModel>? _output;

    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      /// NOT IMPLEMENTED
      blog('shootAndCropVideo Not implemented');
    }

    else {

      MediaModel? _video = await _shootVideo(
        locale: locale,
        context: context,
        langCode: langCode,
        onError: onError,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        ownersIDs: ownersIDs,
        compressWithQuality: compressWithQuality,
        assignPath: assignPath,
        name: name,
      );

      /// CROP
      if (cropAfterPick == true){
        _video = await cropVideo(
          video: _video,
          appIsLTR: appIsLTR,
          aspectRatio: aspectRatio,
          context: context,
          confirmText: confirmText,
          ownersIDs: ownersIDs,
          assignPath: assignPath,
          name: name,
          compressWithQuality: compressWithQuality,
          mediaOrigin: MediaOrigin.cameraVideo,
        );
      }

      ///
      if (_video != null){

        _output = {
          'video': _video,
        };

        if (createCover == true){

          final MediaModel? _cover = await _createCover(
            video: _video,
            context: context,
            aspectRatio: aspectRatio,
            appIsLTR: appIsLTR,
            confirmText: confirmText,
            mediaOrigin: MediaOrigin.cameraVideo,
            compressWithQuality: compressWithQuality,
            name: name,
            assignPath: assignPath,
            ownersIDs: ownersIDs,
          );

          if (_cover != null){
            _output['cover'] = _cover;
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> _shootVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required Locale? locale,
    required int? compressWithQuality,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
  }) async {
    MediaModel? _output;

    final bool _canShoot = await PermitProtocol.fetchCameraPermit(
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
    );

    if (_canShoot == true){

      await tryAndCatch(
        invoker: '_shootCameraPic',
        onError: onError,
        functions: () async {

          final AssetEntity? entity = await CameraPicker.pickFromCamera(
            context,
            // createPickerState: ,
            // pageRouteBuilder: ,
            // useRootNavigator: ,
            pickerConfig: WeChatPickerConfigs.camera(
              langCode: langCode,
              isVideo: true,
            ),
            locale: locale,
          );

          final File? _file = await entity?.file;
          final Uint8List? _bytes = await Floaters.getBytesFromFile(_file);

          _output = await MediaModel.combinePicModel(
            ownersIDs: ownersIDs,
            fileType: FileType.mp4,
            name: name,
            bytes: _bytes,
            compressWithQuality: compressWithQuality,
            mediaOrigin: MediaOrigin.galleryVideo,
            assignPath: assignPath,
          );

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CROP - TRIM

  // --------------------
  ///
  static Future<MediaModel?> cropVideo({
    required BuildContext context,
    required double aspectRatio,
    required bool appIsLTR,
    required MediaModel? video,
    required int? compressWithQuality,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
    required MediaOrigin mediaOrigin,
    String confirmText = 'Crop',
  }) async {
    MediaModel? _output;

    if (video != null){

      _output = await Nav.goToNewScreen(
        appIsLTR: appIsLTR,
        context: context,
        screen: TrimVideoScreen(
          video: video,
          aspectRatio: aspectRatio,
          appIsLTR: appIsLTR,
          confirmText: confirmText,
        ),
      );

      _output = await MediaModel.combinePicModel(
        ownersIDs: ownersIDs,
        fileType: FileType.mp4,
        name: name,
        bytes: _output?.bytes,
        compressWithQuality: compressWithQuality,
        mediaOrigin: mediaOrigin,
        assignPath: assignPath,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CROP - TRIM

  // --------------------
  ///
  static Future<MediaModel?> _createCover({
    required BuildContext context,
    required double aspectRatio,
    required bool appIsLTR,
    required MediaModel? video,
    required int? compressWithQuality,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
    required MediaOrigin mediaOrigin,
    String confirmText = 'confirm',
  }) async {
    MediaModel? _output;

    if (video != null){

      _output = await Nav.goToNewScreen(
        appIsLTR: appIsLTR,
        context: context,
        screen: VideoCoverScreen(
          video: video,
          aspectRatio: aspectRatio,
          appIsLTR: appIsLTR,
          confirmText: confirmText,
        ),
      );

      _output = await MediaModel.combinePicModel(
        ownersIDs: ownersIDs,
        fileType: FileType.jpeg,
        name: name,
        bytes: _output?.bytes,
        compressWithQuality: compressWithQuality,
        mediaOrigin: mediaOrigin,
        assignPath: assignPath,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
