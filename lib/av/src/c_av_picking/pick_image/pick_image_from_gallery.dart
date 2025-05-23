part of av;
/// => GREAT
abstract class _PickImageFromGallery {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> pickAndProcessSingle({
    required BuildContext context,
    required bool cropAfterPick,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required String Function (String? title) uploadPathMaker,
    required List<String>? ownersIDs,
    required String bobDocName,
    double? resizeToWidth,
    int? compressWithQuality,
    AssetEntity? selectedAsset,
    Function(String? error)? onError,
    Future<AvModel?> Function(AvModel avModel)? onCrop,
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
      );
    }

    /// SMART PHONE
    else {

      _output = await _pickOnSmartPhone(
        context: context,
        onError: onError,
        ownersIDs: ownersIDs,
        uploadPathMaker: uploadPathMaker,
        langCode: langCode,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        selectedAsset: selectedAsset,
        bobDocName: bobDocName,
      );

    }

    /// PROCESS
    if (_output != null){
      _output = await ImageProcessor.processImage(
        avModel: _output,
        resizeToWidth: resizeToWidth,
        quality: compressWithQuality,
        onCrop: cropAfterPick == true ? onCrop : null,
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

          _output = await _AvFromXFile.createSingle(
            xFile: _file,
            data: CreateSingleAVConstructor(
              origin: AvOrigin.galleryImage,
              uploadPath: uploadPathMaker(_file.fileName),
              ownersIDs: ownersIDs,
              skipMeta: false,
              bobDocName: bobDocName,
              // caption: null,
            ),
          );

        }

      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> _pickOnSmartPhone({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required String Function (String? title) uploadPathMaker,
    required List<String>? ownersIDs,
    required String bobDocName,
    AssetEntity? selectedAsset,
    Function(String? error)? onError,
  }) async {

    final List<AssetEntity> _assets = <AssetEntity>[
      if (selectedAsset != null)
      selectedAsset,
    ];

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
      bobDocName: bobDocName,
    );

    return _models.firstOrNull;
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
    required Future<List<AvModel>> Function(List<AvModel> avModels) onCrop,
    required String bobDocName,
    double? resizeToWidth,
    int? compressWithQuality,
    int maxAssets = 10,
    List<AssetEntity>? selectedAssets,
    Function(String? error)? onError,
  }) async {

    /// PICK
    final List<AvModel> _avModels = await _pickMultiplePics(
      context: context,
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onError,
      uploadPathGenerator: uploadPathGenerator,
      ownersIDs: ownersIDs,
      bobDocName: bobDocName,
    );

    return ImageProcessor.processAvModels(
      avModels: _avModels,
      quality: compressWithQuality,
      resizeToWidth: resizeToWidth,
      onCrop: cropAfterPick == true ? onCrop : null,
    );

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
    required String bobDocName,
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
              // requestType: RequestType.image,
            ),
          );

          _output = await _AvFromAssetEntity.createMany(
            entities: pickedAssets,
            data: CreateMultiAVConstructor(
              uploadPathGenerator: uploadPathGenerator,
              origin: AvOrigin.galleryImage,
              ownersIDs: ownersIDs,
              skipMeta: false,
              bobDocName: bobDocName,
            ),
          );

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
