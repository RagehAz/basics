part of av;

abstract class PickVideoFromCamera {
  // -----------------------------------------------------------------------------

  /// TITLE

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<AvModel?> pick({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required Locale? locale,
    required List<String> ownersIDs,
    required String Function (String? title) uploadPathMaker,
    required int maxDurationS,
    required Function? onVideoExceedsMaxDuration,
  }) async {
    AvModel? _output;

    final bool _canShoot = await PermitProtocol.fetchCameraPermit(
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
    );

    if (_canShoot == true){

      await tryAndCatch(
        invoker: '_shootCameraPic',
        onError: onError,
        functions: () async {

          final AssetEntity? _entity = await CameraPicker.pickFromCamera(
            context,
            pickerConfig: WeChatPickerConfigs.camera(
              langCode: langCode,
              isVideo: true,
              maxDurationS: maxDurationS,
            ),

            // createPickerState: ,
            // pageRouteBuilder: ,
            // useRootNavigator: ,
            locale: locale,
          );

          if (_entity != null){

            if (_entity.duration > maxDurationS){
              await onVideoExceedsMaxDuration?.call();
            }
            else {
              _output = await MediaModelCreator.fromAssetEntity(
                entity: _entity,
                ownersIDs: ownersIDs,
                mediaOrigin: AvOrigin.galleryVideo,
                uploadPath: uploadPathMaker(_entity.title),
                skipMetaData: false,
              );
            }

          }


        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  void x(){}
}
