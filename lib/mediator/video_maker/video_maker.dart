// ignore_for_file: unnecessary_import, unused_local_variable, avoid_redundant_argument_values
import 'dart:io';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/permissions/permits_protocols.dart';
import 'package:basics/mediator/configs/asset_picker_configs.dart';
import 'package:basics/mediator/models/file_typer.dart';
import 'package:basics/mediator/models/media_model.dart';
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
  static Future<MediaModel?> pickVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required int? compressWithQuality,
    required String uploadPath,
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
          uploadPath: uploadPath,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SHOOT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> shootVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required Locale? locale,
    required int? compressWithQuality,
    required String uploadPath,
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
            uploadPath: uploadPath,
          );

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
