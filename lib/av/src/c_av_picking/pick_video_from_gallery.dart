part of av;

abstract class PickVideoFromGallery {
  // -----------------------------------------------------------------------------

  /// PICK

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<AvModel?> pick({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required List<String> ownersIDs,
    required String Function (String? title) uploadPathMaker,
    required int maxDurationS,
    required Function? onVideoExceedsMaxDuration,
    required String bobDocName,
  }) async {
    AvModel? _output;

    final bool _canPick = await PermitProtocol.fetchGalleryPermit(
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
    );

    if (_canPick == true){

      await tryAndCatch(
        invoker: 'pickVideo',
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
              maxDurationS: maxDurationS,
              // titleTextStyle: ,
              // textStyle: ,
              // titleTextSpacing: ,
              // gridCount: ,
              // pageSize: ,
            ),
          );

          if (Lister.checkCanLoop(pickedAssets) == true){

            final AssetEntity _entity = pickedAssets!.first;

            if (_entity.duration > maxDurationS){
              await onVideoExceedsMaxDuration?.call();
            }

            else {
              _output = await AvFromAssetEntity.createSingle(
                entity: _entity,
                ownersIDs: ownersIDs,
                origin: AvOrigin.galleryVideo,
                uploadPath: uploadPathMaker(_entity.title),
                skipMeta: false,
                bobDocName: bobDocName,
                // includeFileExtension: ,
                // caption: ,
              );
            }

          }

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
