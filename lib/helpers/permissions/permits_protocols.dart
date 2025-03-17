import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/permissions/permits.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

abstract class PermitProtocol {
  // -----------------------------------------------------------------------------

  /// PHOTO GALLERY

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchGalleryPermit({
    required Function(Permission) onPermissionPermanentlyDenied,
  }) async {
    bool _output = false;

    if (DeviceChecker.deviceIsIOS() == true){
      _output = await _galleryPermitIOS(
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      );
    }

    else if (DeviceChecker.deviceIsAndroid() == true) {
      _output = await _galleryPermitAndroid(
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      );
    }

    return _output;
  }
  // --------------------
  static Future<bool> _galleryPermitAndroid({
    required Function(Permission) onPermissionPermanentlyDenied,
  }) async {

    final PermissionState? per = await Permit.requestPhotoManagerPermission();
    bool _canPick = per?.hasAccess ?? false;

    // blog('[A] name(${per?.name} index(${per?.index})) hasAccess(${per?.hasAccess}) isAuth(${per?.isAuth})');

    if (_canPick == false) {

      final bool _canOpenStorage = await Permit.requestPermission(
          permission: Permission.storage,
          onPermissionPermanentlyDenied: onPermissionPermanentlyDenied
      );

      // blog('[B] canOpenStorage($_canOpenStorage)');
      //
      // final bool _canOpenPhotos = await Permit.requestPermission(
      //   permission: Permission.photos,
      //   onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      // );
      //
      // blog('[C] canOpenPhotos($_canOpenPhotos)');
      //
      // final bool _canOpenMediaLibrary = await Permit.requestPermission(
      //   permission: Permission.mediaLibrary,
      //   onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      // );
      //
      // blog('[D] canOpenMediaLibrary($_canOpenMediaLibrary)');

      _canPick = _canOpenStorage == true;

      if (_canPick == false) {
        onPermissionPermanentlyDenied(Permission.storage);
      }

    }

    return _canPick;
  }
  // --------------------
  /// WORKS PERFECT FOR IOS
  static Future<bool> _galleryPermitIOS({
    required Function(Permission) onPermissionPermanentlyDenied,
  }) async {

    final PermissionState? per = await Permit.requestPhotoManagerPermission();
    bool _canPick = per?.hasAccess ?? false;

    if (_canPick == false) {

      final bool _canOpenStorage = await Permit.requestPermission(
          permission: Permission.storage,
          onPermissionPermanentlyDenied: onPermissionPermanentlyDenied
      );

      final bool _cnaOpenPhotos = await Permit.requestPermission(
        permission: Permission.photos,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      );

      _canPick = _cnaOpenPhotos == true && _canOpenStorage == true;

    }

    return _canPick;
  }
  // -----------------------------------------------------------------------------

  /// CAMERA

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchCameraPermit({
    required Function(Permission) onPermissionPermanentlyDenied,
  }) async {

    // CameraPicker().pickerConfig.

    // /// IOS HANDLES PERMISSION DIALOG NATIVELY
    // if (DeviceChecker.deviceIsIOS() == true){
    //   return true;
    // }
    // else {

      final bool _permissionGranted = await Permit.requestPermission(
        permission: Permission.camera,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      );

      return _permissionGranted;

    // }

  }
  // -----------------------------------------------------------------------------

  /// LOCATION

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchLocationPermitA({
    required Function(Permission) onPermissionPermanentlyDenied,
  }) async {

    final bool _permissionGranted = await Permit.requestPermission(
      permission: Permission.location,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
    );

    return _permissionGranted;
  }
  // --------------------
  /// GEOLOCATOR_DOES_NOT_WORK
  /*
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchLocationPermitB({
    required BuildContext context,
  }) async {

    final bool _permissionGranted = await Permit.requestGeolocatorPermission(
      context: context,
    );

    return _permissionGranted;
  }
   */
  // -----------------------------------------------------------------------------
}
