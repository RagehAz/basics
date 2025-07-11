part of av;
/// => GREAT
abstract class AvExport {
  // -----------------------------------------------------------------------------

  /// SAVE TO DEVICE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Permission> _getDeviceStoragePermission() async {

    if (Platform.isAndroid) {

      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdk = androidInfo.version.sdkInt;

      if (sdk >= 34) {
        // Android 14+
        return Permission.photos; // or Permission.images / videos
      } else if (sdk >= 33) {
        // Android 13
        return Permission.photos;
      } else if (sdk >= 30) {
        // Android 11–12
        return Permission.storage;
      } else {
        // Android 10 and below
        return Permission.storage;
      }
    } else if (Platform.isIOS) {
      return Permission.photos;
    }

    return Permission.storage; // default fallback
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> toDeviceGallery({
    required AvModel? avModel,
    required Function(Permission permission)? onPermissionPermanentlyDenied,
    required Function(Permission permission)? onPermissionDenied,
    required Function(String error)? onError,
  }) async {
    bool _saved = false;

    if (avModel != null && avModel.xFilePath != null){

      bool hasPermit = true;

      if (DeviceChecker.deviceIsAndroid() == true){

        final Permission _permission = await _getDeviceStoragePermission();

        hasPermit = await Permit.requestPermission(
          permission: _permission,
          onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        );

        blog('hasPermit($hasPermit).permission($_permission)');

      }

      if (hasPermit == true) {

        bool? result = false;

        await tryAndCatch(
          invoker: 'toDeviceGallery',
          functions: () async {

            final File? _clone = await AvOps.cloneFileToHaveExtension(
              avModel: avModel,
            );

            if (_clone != null){

              if (avModel.isImage() == true){
                result = await GallerySaver.saveImage(
                  _clone.path,
                  // toDcim: avModel.nameWithExtension,
                  // isReturnImagePathOfIOS: ,
                );
              }

              else if (avModel.isVideo() == true){
                result = await GallerySaver.saveVideo(
                  _clone.path,
                  // toDcim: avModel.nameWithExtension,
                  // isReturnImagePathOfIOS: ,
                );
              }

            }

          },
          onError: (String error) async {

            final bool isPermissionError = error.toLowerCase().contains('permission') ||
                error.toLowerCase().contains('access denied') ||
                error.toLowerCase().contains('not authorized');

            if (isPermissionError) {

              final Permission permission = await _getDeviceStoragePermission();

              hasPermit = await Permit.requestPermission(
                permission: permission,
                onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
              );

            }

            else {
              await onError?.call(error);
            }

          },
        );

        if (Booler.boolIsTrue(result) == true) {
          _saved = true;
        }

        else {
          blog('Failed to save AV MODEL to gallery');
          blog(result);
        }

      }

      else {
        await onPermissionDenied?.call(Permission.storage);
      }

    }

    return _saved;
  }
  // -----------------------------------------------------------------------------
}
