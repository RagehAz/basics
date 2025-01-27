import 'package:basics/components/dialogs/center_dialog.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
export 'package:permission_handler/permission_handler.dart';
import 'package:basics/helpers/nums/booler.dart';

/// => TAMAM
class Permit {
  // -----------------------------------------------------------------------------

  const Permit();

  // -----------------------------------------------------------------------------

  /// ALL PERMITS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>?> allPermissionsMaps(){

    return [
      null,
      {'permission': Permission.camera, 'name': 'camera',},
      {'permission': Permission.mediaLibrary, 'name': 'mediaLibrary',},
      {'permission': Permission.photos, 'name': 'photos',},
      {'permission': Permission.photosAddOnly, 'name': 'photosAddOnly',},
      {'permission': Permission.accessMediaLocation, 'name': 'accessMediaLocation',},
      null,
      {'permission': Permission.contacts, 'name': 'contacts',},
      null,
      {'permission': Permission.location, 'name': 'location',},
      {'permission': Permission.locationAlways, 'name': 'locationAlways',},
      {'permission': Permission.locationWhenInUse, 'name': 'locationWhenInUse',},
      null,
      {'permission': Permission.microphone, 'name': 'microphone',},
      {'permission': Permission.speech, 'name': 'speech',},
      null,
      {'permission': Permission.notification, 'name': 'notification',},
      {'permission': Permission.phone, 'name': 'phone',},
      {'permission': Permission.storage, 'name': 'storage',},
      null,
      {'permission': Permission.sensors, 'name': 'sensors',},
      {'permission': Permission.bluetooth, 'name': 'bluetooth'},
      null,
      {'permission': Permission.reminders, 'name': 'reminders',},
      // {'permission': Permission.calendarReadOnly, 'name': 'calendarReadOnly',},
      {'permission': Permission.calendarFullAccess, 'name': 'calendarFullAccess',},
      null,
      {'permission': Permission.sms, 'name': 'sms',},
      {'permission': Permission.activityRecognition, 'name': 'activityRecognition',},
      {'permission': Permission.unknown, 'name': 'unknown',},
      {'permission': Permission.ignoreBatteryOptimizations, 'name': 'ignoreBatteryOptimizations',},
      {'permission': Permission.manageExternalStorage, 'name': 'manageExternalStorage',},
      {'permission': Permission.systemAlertWindow, 'name': 'systemAlertWindow',},
      {'permission': Permission.requestInstallPackages, 'name': 'requestInstallPackages',},
      {'permission': Permission.appTrackingTransparency, 'name': 'appTrackingTransparency',},
      {'permission': Permission.criticalAlerts, 'name': 'criticalAlerts',},
      {'permission': Permission.accessNotificationPolicy, 'name': 'accessNotificationPolicy',},
      {'permission': Permission.bluetoothScan, 'name': 'bluetoothScan',},
      {'permission': Permission.bluetoothAdvertise, 'name': 'bluetoothAdvertise',},
      {'permission': Permission.bluetoothConnect, 'name': 'bluetoothConnect',},
      {'permission': Permission.nearbyWifiDevices, 'name': 'nearbyWifiDevices',},
      {'permission': Permission.videos, 'name': 'videos',},
      {'permission': Permission.audio, 'name': 'audio',},
      {'permission': Permission.scheduleExactAlarm, 'name': 'scheduleExactAlarm',},

    ];

  }
  // -----------------------------------------------------------------------------

  /// REQUEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> requestPermission({
    required Permission? permission,
    required Function(Permission permission) onPermissionPermanentlyDenied,
    bool showDebugDialog = false,
  }) async {

    bool _granted = false;

    if (permission == null) {
      blog('requestPermission: permission is null');
    }

    else {

      _granted = await permission.isGranted;

      if (_granted == false){

        final PermissionStatus _status = await permission.request();
        final bool _isDeniedOnIOS = DeviceChecker.deviceIsIOS() && _status.isDenied == true;

        if (_status.isGranted == true){
          _granted = true;
        }

        /// PERMANENTLY DENIED
        else if(_status.isPermanentlyDenied == true || _isDeniedOnIOS == true){
          blog('requestPermission: permission is permanently denied');
          // await allowPermissionDialog(
          //   context: context,
          //   permission: permission,
          //
          // );
          await onPermissionPermanentlyDenied(permission);
          _granted = await permission.isGranted;
          blog('requestPermission: permission is permanently denied and is : _granted : $_granted');
        }

        /// RESTRICTED
        else if (_status.isRestricted == true) {
          blog('requestPermission: permission is restricted');
        }

        /// DENIED
        else if (_status.isDenied == true) {
          blog('requestPermission: permission is denied');
        }

        /// LIMITED
        else if (_status.isLimited == true) {
          blog('requestPermission: permission is limited');
        }

      }

    }

    if (_granted == false && kDebugMode == true && showDebugDialog == true) {
      await blogPermission(
          permission: permission,
      );
    }

    return _granted;
  }
  // -----------------------------------------------------------------------------

  /// PHOTO MANAGER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PermissionState?> requestPhotoManagerPermission() async {
    PermissionState? per;

    await tryAndCatch(
        invoker: 'Permit.requestPhotoManagerPermission',
        functions: () async {
          per = await PhotoManager.requestPermissionExtend();
        }
        );

    return per;
  }
  // -----------------------------------------------------------------------------

  /// LOCATION

  // --------------------
  /// GEOLOCATOR_DOES_NOT_WORK
  /*
  /// TESTED : WORKS PERFECT
  static Future<bool> _enableLocationServiceIfDisabled() async {

    bool _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (_serviceEnabled == false) {
      await Permit.jumpToLocationServiceScreen();
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    return _serviceEnabled;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _locationPermissionIsGranted(LocationPermission permission){
    bool _granted = false;
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      _granted = true;
    }
    return _granted;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> requestGeolocatorPermission({
    required BuildContext context,
  }) async {

    bool _granted = false;

    final bool _serviceEnabled = await _enableLocationServiceIfDisabled();

    if (_serviceEnabled == true) {

       LocationPermission _permission = await Geolocator.checkPermission();

      _granted = _locationPermissionIsGranted(_permission);

      if (_granted == false){

        _permission = await Geolocator.requestPermission();

        if (_locationPermissionIsGranted(_permission) == true){
          _granted = true;
        }

        /// PERMANENTLY DENIED
        else if(_permission == LocationPermission.deniedForever){
          blog('requestGeolocatorPermission: permission is permanently denied');
          await allowPermissionDialog(
            context: context,
            permission: Permission.location,
          );
          _permission = await Geolocator.checkPermission();
          _granted = _locationPermissionIsGranted(_permission);
          blog('requestGeolocatorPermission: permission is permanently denied and is : _granted : $_granted');
        }

        /// DENIED
        else if (_permission == LocationPermission.denied) {
          blog('requestGeolocatorPermission: permission is denied');
        }

        /// UNABLE TO DETERMINE
        else if (_permission == LocationPermission.unableToDetermine) {
          blog('requestGeolocatorPermission: permission is unableToDetermine');
        }

      }

    }

    return _granted;
  }
   */
  // -----------------------------------------------------------------------------

  /// DIALOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> blogPermission({
    required Permission? permission,
    Function(String? title, String? blog)? onBlog,
  }) async {

    String? _text;

    if (permission == null){
      _text = 'permission is null';
    }
    else {

      final PermissionStatus _status = await permission.status;

      final String _statusName = _status.name;
      final int _statusIndex = _status.index;

      final bool _statusIsDenied = _status.isDenied;
      final bool _perDenied = await permission.isDenied;

      final bool _statusIsGranted = _status.isGranted;
      final bool _perIsGranted = await permission.isGranted;

      final bool _statusIsRestricted = _status.isRestricted;
      final bool _perIsRestricted = await permission.isRestricted;

      final bool _statusIsLimited = _status.isLimited;
      final bool _perIsLimited = await permission.isLimited;

      final bool _perIsPermanentlyDenied = await permission.isPermanentlyDenied;
      final bool _perShouldShowRequestRationale = await permission.shouldShowRequestRationale;

      _text =
          '[ toString() ]         : $permission\n'
          '[ name ]                : $_statusName\n'
          '[ index ]                : $_statusIndex\n'
          '\n'
          '[ Granted ]            : $_statusIsGranted : $_perIsGranted\n'
          '[ Denied ]              : $_statusIsDenied : $_perDenied\n'
          '\n'
          '[ Restricted ]         : $_statusIsRestricted : $_perIsRestricted\n'
          '[ Limited ]              : $_statusIsLimited : $_perIsLimited\n'
          '\n'
          '[ Permanently denied ] : $_perIsPermanentlyDenied\n'
          '\n'
          '[ shouldRationale ]       : $_perShouldShowRequestRationale\n'
          ;

      blog(_text);
      if (onBlog != null){
        onBlog(permission.toString(), _text);
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> allowPermissionDialog({
    required BuildContext context,
    required Permission? permission,
    Widget? dialogBubble,
  }) async {

    final bool? _go = await CenterDialog.showCenterDialog(
        context: context,
        bubble: dialogBubble ?? CenterDialog.buildBubble(
          context: context,
          boolDialog: true,
          title: 'Permission is required',
          body: permission?.toString(),
          buttons: CenterDialog.yesNoButtons(
            context: context,
            boolDialog: true,
          )
        ),
    );

    if (Booler.boolIsTrue(_go) == true){
      await jumpToAppSettingsScreen();
    }

  }
  // -----------------------------------------------------------------------------

  /// SETTINGS NAVIGATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToAppSettingsScreen() async {
    await openAppSettings();
  }
  // --------------------
  /// GEOLOCATOR_DOES_NOT_WORK
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToLocationServiceScreen() async {
    await Geolocator.openLocationSettings();
  }
   */
  // -----------------------------------------------------------------------------
}
