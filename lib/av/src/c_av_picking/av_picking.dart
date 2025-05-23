part of av;

abstract class AvPicking {
  // -----------------------------------------------------------------------------

  /// IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> pickImage({
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
    return _PickImageFromGallery.pickAndProcessSingle(
      context: context,
      cropAfterPick: cropAfterPick,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      uploadPathMaker: uploadPathMaker,
      ownersIDs: ownersIDs,
      bobDocName: bobDocName,
      selectedAsset: selectedAsset,
      onCrop: onCrop,
      resizeToWidth: resizeToWidth,
      compressWithQuality: compressWithQuality,
      onError: onError,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> shootImage({
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
    return _PickImageFromCamera.shootAndCropCameraPic(
      context: context,
      cropAfterPick: cropAfterPick,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      uploadPathMaker: uploadPathMaker,
      ownersIDs: ownersIDs,
      locale: locale,
      onCrop: onCrop,
      bobDocName: bobDocName,
      resizeToWidth: resizeToWidth,
      compressWithQuality: compressWithQuality,
      onError: onError,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> pickImages({
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
    return _PickImageFromGallery.pickAndCropMultiplePics(
      context: context,
      cropAfterPick: cropAfterPick,
      langCode: langCode,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      uploadPathGenerator: uploadPathGenerator,
      ownersIDs: ownersIDs,
      onCrop: onCrop,
      onError: onError,
      compressWithQuality: compressWithQuality,
      resizeToWidth: resizeToWidth,
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,
      bobDocName: bobDocName,
    );
  }
  // -----------------------------------------------------------------------------

  /// VIDEO

  // --------------------
  ///
  static Future<AvModel?> pickVideo({
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
    return _PickVideoFromGallery.pick(
        context: context,
        langCode: langCode,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        onError: onError,
        ownersIDs: ownersIDs,
        uploadPathMaker: uploadPathMaker,
        maxDurationS: maxDurationS,
        onVideoExceedsMaxDuration: onVideoExceedsMaxDuration,
        bobDocName: bobDocName,
    );
  }
  // --------------------
  ///
  static Future<AvModel?> shootVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
    required Locale? locale,
    required List<String> ownersIDs,
    required String Function (String? title) uploadPathMaker,
    required int maxDurationS,
    required Function? onVideoExceedsMaxDuration,
    required String bobDocName,
  }) async {
    return _PickVideoFromCamera.pick(
        context: context,
        langCode: langCode,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        onError: onError,
        locale: locale,
        ownersIDs: ownersIDs,
        uploadPathMaker: uploadPathMaker,
        maxDurationS: maxDurationS,
        onVideoExceedsMaxDuration: onVideoExceedsMaxDuration,
        bobDocName: bobDocName,
    );
  }
  // --------------------
  /// NOT IMPLEMENTED
  /*
  static Future<AvModel?> pickVideos() async {
    return [];
  }
   */
  // -----------------------------------------------------------------------------

  /// SOUND

  // --------------------
  /// NOT YET IMPLEMENTED
  /*
  static Future<AvModel?> pickSound() async {
    return _PickAudioFromMic.theFunction();
  }
   */
  // --------------------
  /// NOT YET IMPLEMENTED
  static Future<AvModel?> recordSound() async {
    return null;
  }
  // -----------------------------------------------------------------------------

  /// PDF

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> pickPDF({
    required String dialogTitle,
    required String bobDocName,
    required String uploadPath,
    List<String>? ownersIDs,
  }) async {
    return _PickPDFFromDevice.pickPDF(
        dialogTitle: dialogTitle,
        bobDocName: bobDocName,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
    );
  }
  // -----------------------------------------------------------------------------
}
