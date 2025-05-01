part of av;

abstract class PickImageFromGallery {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> pickAndProcessSingle({
    required BuildContext context,
    required bool cropAfterPick,
    required bool appIsLTR,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required String Function (String? title) uploadPathMaker,
    required List<String>? ownersIDs,
    required String bobDocName,
    required bool includeFileExtension,
    double? resizeToWidth,
    int? compressWithQuality,
    AssetEntity? selectedAsset,
    Function(String? error)? onError,
    Future<AvModel> Function(AvModel avModel)? onCrop,
  }) async {
    AvModel? _output;

    /// WEB - WINDOWS
    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      _output = await _pickWindowsOrWebImage(
        cropAfterPick: cropAfterPick,
        resizeToWidth: resizeToWidth,
        compressWithQuality: compressWithQuality,
        onError: onError,
        ownersIDs: ownersIDs,
        uploadPathMaker: uploadPathMaker,
        bobDocName: bobDocName,
        includeFileExtension: includeFileExtension,
      );
    }

    /// SMART PHONE
    else {

      _output = await _pickOnSmartPhone(
        cropAfterPick: cropAfterPick,
        resizeToWidth: resizeToWidth,
        compressWithQuality: compressWithQuality,
        onError: onError,
        ownersIDs: ownersIDs,
        uploadPathMaker: uploadPathMaker,
        langCode: langCode,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        context: context,
        appIsLTR: appIsLTR,
        selectedAsset: selectedAsset,
      );

    }

    /// PROCESS
    if (_output != null){
      _output = await ImageProcessor.processImage(
        avModel: _output,
        resizeToWidth: resizeToWidth,
        quality: compressWithQuality,
        onCrop: onCrop,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> _pickWindowsOrWebImage({
    required bool cropAfterPick,
    required Function(String? error)? onError,
    required String Function (String? title) uploadPathMaker,
    required List<String>? ownersIDs,
    required String bobDocName,
    double? resizeToWidth,
    int? compressWithQuality,
    bool includeFileExtension = false,
  }) async {
    AvModel? _output;

    await tryAndCatch(
      onError: onError,
      invoker: '_pickWindowsOrWebImage',
      functions: () async {

        final ImagePicker _picker = ImagePicker();

        final XFile? _file = await _picker.pickImage(
          source: ImageSource.gallery,
        );

        if (_file != null){

          _output = await AvFromXFile.createSingle(
            xFile: _file,
            origin: AvOrigin.galleryImage,
            uploadPath: uploadPathMaker(_file.fileName),
            ownersIDs: ownersIDs,
            skipMeta: false,
            bobDocName: bobDocName,
            // caption: null,
            includeFileExtension: includeFileExtension,
          );

        }

      },
    );

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<AvModel?> _pickOnSmartPhone({
    required BuildContext context,
    required bool cropAfterPick,
    required bool appIsLTR,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required String Function (String? title) uploadPathMaker,
    required List<String>? ownersIDs,
    double? resizeToWidth,
    int? compressWithQuality,
    AssetEntity? selectedAsset,
    Function(String? error)? onError,
  }) async {
    AvModel? _output;

    final List<AssetEntity> _assets = selectedAsset == null ?
    <AssetEntity>[]
        :
    <AssetEntity>[selectedAsset];

    final List<AvModel> _models = await _pickMultiplePics(
      context: context,
      maxAssets: 1,
      selectedAssets: _assets,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onError,
      uploadPathGenerator: (int i, String? title){
        return uploadPathMaker(title);
      },
      ownersIDs: ownersIDs,
    );

    if (Lister.checkCanLoop(_models) == true){
      _output = _models.first;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> pickAndCropMultiplePics({
    required BuildContext context,
    required bool cropAfterPick,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required String Function(int index, String? title) uploadPathGenerator,
    required List<String>? ownersIDs,
    required Future<List<AvModel>> Function(List<AvModel> medias) onCrop, double? resizeToWidth,
    int? compressWithQuality,
    int maxAssets = 10,
    List<AssetEntity>? selectedAssets,
    Function(String? error)? onError,
    // CompressFormat outputType = CompressFormat.jpeg,
  }) async {

    /// PICK
    List<AvModel> _mediaModels = await _pickMultiplePics(
      context: context,
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onError,
      uploadPathGenerator: uploadPathGenerator,
      ownersIDs: ownersIDs,
    );

    /// CROP
    if (cropAfterPick == true && Lister.checkCanLoop(_mediaModels) == true){
      _mediaModels = await cropPics(
        mediaModels: _mediaModels,
        onCrop: onCrop,
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
        // outputType: outputType,
      );
    }

    return _mediaModels;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> _pickMultiplePics({
    required BuildContext context,
    required int maxAssets,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required List<AssetEntity>? selectedAssets,
    required String Function(int index, String? title) uploadPathGenerator,
    required List<String>? ownersIDs,
  }) async {

    List<AvModel> _output = <AvModel>[];

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
              requestType: RequestType.image,
            ),
          );

          _output = await MediaModelCreator.fromAssetEntities(
            entities: pickedAssets,
            uploadPathGenerator: uploadPathGenerator,
            mediaOrigin: AvOrigin.galleryImage,
            ownersIDs: ownersIDs,
            skipMetaData: false,
          );

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
