import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/permissions/permits.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class PermitProtocol {
  // -----------------------------------------------------------------------------

  const PermitProtocol();

  // -----------------------------------------------------------------------------

  /// PHOTO GALLERY

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchGalleryPermit({
    required BuildContext context,
  }) async {

    // // final bool _permissionGranted =
    // await Permit.requestPermission(
    //   context: context,
    //   permission: Permission.photos,
    // );
    //
    // // final bool _storageGranted =
    // await Permit.requestPermission(
    //   context: context,
    //   permission: Permission.storage,
    // );

    final PermissionState? per = await Permit.requestPhotoManagerPermission();
    bool _canPick = per?.hasAccess ?? false;

    if (_canPick == false){

      final bool _canOpenStorage = await Permit.requestPermission(
        context: context,
        permission: Permission.storage,
      );

      if (DeviceChecker.deviceIsIOS() == true){

        final bool _cnaOpenPhotos = await Permit.requestPermission(
          context: context,
          permission: Permission.photos,
        );

        _canPick = _cnaOpenPhotos == true && _canOpenStorage == true;
      }

      else {
        _canPick = _canOpenStorage;
      }

    }

    return _canPick;
  }
  // -----------------------------------------------------------------------------

  /// CAMERA

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchCameraPermit({
    required BuildContext context,
  }) async {

    // CameraPicker().pickerConfig.

    // /// IOS HANDLES PERMISSION DIALOG NATIVELY
    // if (DeviceChecker.deviceIsIOS() == true){
    //   return true;
    // }
    // else {

      final bool _permissionGranted = await Permit.requestPermission(
        context: context,
        permission: Permission.camera,
      );

      return _permissionGranted;

    // }

  }
  // -----------------------------------------------------------------------------

  /// LOCATION

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchLocationPermitA({
    required BuildContext context,
  }) async {

    final bool _permissionGranted = await Permit.requestPermission(
      context: context,
      permission: Permission.location,
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
