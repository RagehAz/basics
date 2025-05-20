part of av;
/// => GREAT
abstract class _PickImageFromCamera {
  // -----------------------------------------------------------------------------

  /// TAKE IMAGE FROM CAMERA

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> shootAndCropCameraPic({
    required BuildContext context,
    required bool cropAfterPick,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required String Function (String? title) uploadPathMaker,
    required List<String>? ownersIDs,
    required Locale? locale,
    required Future<AvModel?> Function(AvModel avModel) onCrop,
    required String bobDocName,
    double? resizeToWidth,
    int? compressWithQuality,
    Function(String? error)? onError,
  }) async {

    final AvModel? _output = await _shootCameraPic(
      context: context,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onError,
      locale: locale,
      uploadPathMaker: uploadPathMaker,
      ownersIDs: ownersIDs,
      bobDocName: bobDocName,
    );

    return ImageProcessor.processImage(
      avModel: _output,
      resizeToWidth: resizeToWidth,
      quality: compressWithQuality,
      onCrop: onCrop,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> _shootCameraPic({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required Locale? locale,
    required String Function(String? title) uploadPathMaker,
    required List<String>? ownersIDs,
    required String bobDocName,
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

          final AvModel? _model = await _AvFromAssetEntity.createSingle(
            entity: entity,
            data: CreateSingleAVConstructor(
              origin: AvOrigin.cameraImage,
              uploadPath: uploadPathMaker(entity!.title),
              ownersIDs: ownersIDs,
              skipMeta: false,
              bobDocName: bobDocName,

            ),
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
}
