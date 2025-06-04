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
  }) async {
    bool _saved = false;

    if (avModel != null && avModel.xFilePath != null){

      final Permission _permission = await _getDeviceStoragePermission();

      final bool hasPermit = await Permit.requestPermission(
        permission: _permission,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      );

      blog('hasPermit($hasPermit).permission($_permission)');

      if (hasPermit == true) {

        bool? result = false;

        await tryAndCatch(
          invoker: 'toDeviceGallery',
          functions: () async {


            if (avModel.isImage() == true){
              result = await GallerySaver.saveImage(
                avModel.xFilePath!,
                // toDcim: avModel.nameWithExtension,
                // isReturnImagePathOfIOS: ,
              );
            }
            else if (avModel.isVideo() == true){
              result = await GallerySaver.saveVideo(
                avModel.xFilePath!,

                // toDcim: avModel.nameWithExtension,
                // isReturnImagePathOfIOS: ,
              );
            }

            // final Uint8List? _bytes = await avModel.getBytes();
            // if (_bytes != null){
              // result = await ImageGallerySaverPlus.saveImage(
              //   _bytes,
              //   quality: 100,
              //   name: avModel.nameWithExtension,
              //   // isReturnImagePathOfIOS: ,
              // );
            //   blog(result);
            // }

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
