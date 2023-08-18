import 'dart:io';

import 'package:basics/helpers/classes/checks/error_helpers.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:device_info_plus/device_info_plus.dart';
export 'package:device_info_plus/device_info_plus.dart';

/// => TAMAM
class DeviceChecker {
  // --------------------
  /// private constructor to create instances of this class only in itself
  DeviceChecker.singleton();
  // --------------------
  /// Singleton instance
  static final DeviceChecker _singleton = DeviceChecker.singleton();
  // --------------------
  /// Singleton accessor
  static DeviceChecker get instance => _singleton;
  // --------------------

  /// CONNECTIVITY

  // --------------------
  /// CONNECTIVITY SINGLETON
  Connectivity? _connectivity;
  Connectivity get connectivity => _connectivity ??= Connectivity();
  static Connectivity getConnectivity() => DeviceChecker.instance.connectivity;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkConnectivity({
    ConnectivityResult? streamResult,
  }) async {

    ConnectivityResult? _result;

    await tryAndCatch(
        functions: () async {
          _result = streamResult ?? await getConnectivity().checkConnectivity();
        },
        onError: (String error){
          blog('DISCONNECTED : $error');
        }
    );


    /// THROUGH MOBILE NETWORK
    if (_result == ConnectivityResult.mobile) {
      return true;
    }

    /// THROUGH WIFI
    else if (_result == ConnectivityResult.wifi) {
      return true;
    }

    /// THROUGH BLUETOOTH
    else if (_result == ConnectivityResult.bluetooth){
      return true;
    }

    /// THROUGH ETHERNET
    else if (_result == ConnectivityResult.ethernet){
      return true;
    }

    /// NOT CONNECTED
    else if (_result == ConnectivityResult.none){
      return false;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// DEVICE INFO PLUGIN

  // --------------------
  /// CONNECTIVITY SINGLETON
  DeviceInfoPlugin? _deviceInfoPlugin;
  DeviceInfoPlugin get deviceInfoPlugin => _deviceInfoPlugin ??= DeviceInfoPlugin();
  static DeviceInfoPlugin getDeviceInfoPlugin() => DeviceChecker.instance.deviceInfoPlugin;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> getDeviceID() async {

    final DeviceInfoPlugin deviceInfo = getDeviceInfoPlugin();

    if (kIsWeb == true){

      final WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
      // The web doesn't have a device UID, so use a combination fingerprint as an example
      final String _combined =  (webInfo.vendor ?? 'vendor')
                              + (webInfo.userAgent ?? 'user_agent')
                              + webInfo.browserName.name
                              + webInfo.hardwareConcurrency.toString();

      final String? _cleaned = TextMod.idifyString(_combined);
      return TextMod.modifyAllCharactersWith(
        characterToReplace: ';',
        replacement: '',
        input: _cleaned,
      );
    }

    /// IS IOS
    else if (deviceIsIOS() == true) {
      // final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      // return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      final String _deviceID = await FlutterUdid.consistentUdid;
      return _deviceID;
    }

    /// IS ANDROID
    else if(deviceIsAndroid() == true) {
      // final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      // return androidDeviceInfo.id; // unique ID on Android
      final String _deviceID = await FlutterUdid.consistentUdid;
      return _deviceID;
    }

    /// NOT ANDROID + NOT IOS
    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> getDeviceName() async {

    final DeviceInfoPlugin deviceInfo = getDeviceInfoPlugin();

    if (kIsWeb == true){

      final WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
      // The web doesn't have a device UID, so use a combination fingerprint as an example
      final String _combined =  (webInfo.vendor ?? 'vendor')
                              + (webInfo.userAgent ?? 'user_agent')
                              + webInfo.browserName.name
                              + webInfo.hardwareConcurrency.toString();

      return TextMod.idifyString(_combined);
    }

    /// IS IOS
    else if (deviceIsIOS() == true) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.name;
    }

    /// IS ANDROID
    else if(deviceIsAndroid() == true) {
      final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model;
    }

    /// NOT ANDROID + NOT IOS
    else {
      return null;
    }

  }
  // --------------------
  /*
  static Future<String> getDeviceVersion() async {

    final DeviceInfoPlugin deviceInfo = getDeviceInfoPlugin();

    /// IS IOS
    if (deviceIsIOS() == true) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo?.systemVersion;
    }

    /// IS ANDROID
    else if(deviceIsAndroid() == true) {
      final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo?.version?.incremental;
    }

    /// NOT ANDROID + NOT IOS
    else {
      return null;
    }

  }
   */
  // -----------------------------------------------------------------------------

  /// DEVICE OS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsIOS(){
    if (kIsWeb == true) {
      return false;
    } else {
      if (Platform.isIOS == true) {
        return true;
      } else {
        return false;
      }
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsAndroid(){
    if (kIsWeb == true) {
      return false;
    } else {
      if (Platform.isAndroid == true) {
        return true;
      } else {
        return false;
      }
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsWindows(){
    if (kIsWeb == true) {
      return false;
    } else {
      if (Platform.isWindows == true) {
        return true;
      } else {
        return false;
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// SCREEN DIRECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsLandscape(BuildContext context){

    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    if (_mediaQuery.orientation == Orientation.landscape){
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
}
