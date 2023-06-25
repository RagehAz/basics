import 'package:basics/dialogs/center_dialog.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/error_helpers.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

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
      {'permission': Permission.calendar, 'name': 'reminders',},
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getPermissionWarningPhid(Permission permission){

    switch (permission.toString()){
      case  'Permission.photos': return 'phid_media_permit_warning';
      case  'Permission.storage': return 'phid_media_permit_warning';
      case  'Permission.camera': return 'phid_camera_permit_warning';
      case  'Permission.mediaLibrary': return 'phid_media_permit_warning';
      case  'Permission.photosAddOnly': return 'phid_media_permit_warning';
      case  'Permission.accessMediaLocation': return 'phid_media_permit_warning';

      case  'Permission.location': return 'phid_location_permit_warning';
      case  'Permission.locationAlways': return 'phid_location_permit_warning';
      case  'Permission.locationWhenInUse': return 'phid_location_permit_warning';

      // case  'Permission.notification': return 'phid_notification_permit_warning'; break;

      // case  'Permission.microphone': return 'phid_microphone_permit_warning'; break;
      // case  'Permission.videos': return 'phid_videos_permit_warning'; break;
      // case  'Permission.audio': return 'phid_audio_permit_warning'; break;
      // case  'Permission.contacts': return 'phid_contacts_permit_warning'; break;
      // case  'Permission.speech': return 'phid_speech_permit_warning'; break;
      // case  'Permission.phone': return 'phid_phone_permit_warning'; break;
      // case  'Permission.sensors': return 'phid_sensors_permit_warning'; break;
      // case  'Permission.bluetooth': return 'phid_bluetooth_permit_warning'; break;
      // case  'Permission.reminders': return 'phid_reminders_permit_warning'; break;
      // case  'Permission.calendar': return 'phid_calendar_permit_warning'; break;
      // case  'Permission.sms': return 'phid_sms_permit_warning'; break;
      // case  'Permission.activityRecognition': return 'phid_activityRecognition_permit_warning'; break;
      // case  'Permission.unknown': return 'phid_unknown_permit_warning'; break;
      // case  'Permission.ignoreBatteryOptimizations': return 'phid_ignoreBatteryOptimizations_permit_warning'; break;
      // case  'Permission.manageExternalStorage': return 'phid_manageExternalStorage_permit_warning'; break;
      // case  'Permission.systemAlertWindow': return 'phid_systemAlertWindow_permit_warning'; break;
      // case  'Permission.requestInstallPackages': return 'phid_requestInstallPackages_permit_warning'; break;
      // case  'Permission.appTrackingTransparency': return 'phid_appTrackingTransparency_permit_warning'; break;
      // case  'Permission.criticalAlerts': return 'phid_criticalAlerts_permit_warning'; break;
      // case  'Permission.accessNotificationPolicy': return 'phid_accessNotificationPolicy_permit_warning'; break;
      // case  'Permission.bluetoothScan': return 'phid_bluetoothScan_permit_warning'; break;
      // case  'Permission.bluetoothAdvertise': return 'phid_bluetoothAdvertise_permit_warning'; break;
      // case  'Permission.bluetoothConnect': return 'phid_bluetoothConnect_permit_warning'; break;
      // case  'Permission.nearbyWifiDevices': return 'phid_nearbyWifiDevices_permit_warning'; break;
      // case  'Permission.scheduleExactAlarm': return 'phid_scheduleExactAlarm_permit_warning'; break;

      default: return 'phid_permission_warning';
    }

  }
  // -----------------------------------------------------------------------------

  /// REQUEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> requestPermission({
    required BuildContext context,
    required Permission? permission,
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
          await allowPermissionDialog(
            context: context,
            permission: permission,
          );
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

    final bool _go = await CenterDialog.showCenterDialog(
        context: context,
        bubble: dialogBubble ?? CenterDialog.buildBubble(
          context: context,
          boolDialog: true,
          title: 'Permission is required',
          body: permission?.toString(),
        ),
    );

    if (_go == true){
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
