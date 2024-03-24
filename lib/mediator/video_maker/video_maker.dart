// ignore_for_file: unnecessary_import, unused_local_variable, avoid_redundant_argument_values
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/permissions/permits_protocols.dart';
import 'package:basics/mediator/configs/asset_picker_configs.dart';
import 'package:basics/mediator/models/media_models.dart';
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
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> pickVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required List<String> ownersIDs,
    required String Function (String? title) uploadPathMaker,
  }) async {
    MediaModel? _output;

    final bool _canPick = await PermitProtocol.fetchGalleryPermit(
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
    );

    if (_canPick == true){

      await tryAndCatch(
        invoker: '_pickMultiplePics',
        onError: onError,
        functions: () async {

          final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
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

          if (Lister.checkCanLoop(pickedAssets) == true){

            final AssetEntity _entity = pickedAssets!.first;

            _output = await MediaModelCreator.fromAssetEntity(
              entity: _entity,
              ownersIDs: ownersIDs,
              mediaOrigin: MediaOrigin.galleryVideo,
              uploadPath: uploadPathMaker(_entity.title),
            );

          }

        },
      );





    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SHOOT

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> shootVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required Locale? locale,
    required List<String> ownersIDs,
    required String Function (String? title) uploadPathMaker,
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
            pickerConfig: WeChatPickerConfigs.camera(
              langCode: langCode,
              isVideo: true,
            ),
            // createPickerState: ,
            // pageRouteBuilder: ,
            // useRootNavigator: ,
            locale: locale,
          );

          if (entity != null){
            _output = await MediaModelCreator.fromAssetEntity(
              entity: entity,
              ownersIDs: ownersIDs,
              mediaOrigin: MediaOrigin.galleryVideo,
              uploadPath: uploadPathMaker(entity.title),
            );
          }


        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
