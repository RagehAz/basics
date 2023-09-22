// ignore_for_file: constant_identifier_names
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:flutter/foundation.dart';

class BldrsThemeSounds {
  // -----------------------------------------------------------------------------

  const BldrsThemeSounds();

  // -----------------------------------------------------------------------------

  /// SOUND FX

  // --------------------
  static const String _soundsPath = 'packages/basics/lib/bldrs_theme/assets/sounds';
  // --------------------
  static const String whip_high = '$_soundsPath/whip_high.mp3';
  static const String whip_long = '$_soundsPath/whip_long.mp3';
  static const String zip = '$_soundsPath/zip.mp3';
  static const String click_a = '$_soundsPath/click_a.mp3';
  static const String click_b = '$_soundsPath/click_b.mp3';
  static const String click_c = '$_soundsPath/click_c.mp3';
  static const String bldrs_intro = '$_soundsPath/bldrs_intro.mp3';
  // --------------------
  static const String whip_high_wav = '$_soundsPath/whip_high_wav.wav';
  static const String whip_long_wav = '$_soundsPath/whip_long_wav.wav';
  static const String zip_wav = '$_soundsPath/zip_wav.wav';
  static const String click_a_wav = '$_soundsPath/click_a_wav.wav';
  static const String click_b_wav = '$_soundsPath/click_b_wav.wav';
  static const String click_c_wav = '$_soundsPath/click_c_wav.wav';
  static const String bldrs_intro_wav = '$_soundsPath/bldrs_intro_wav.wav';
  // --------------------
  static const List<String> allIOSSounds = <String>[
    whip_high,
    whip_long,
    zip,
    click_a,
    click_b,
    click_c,
    bldrs_intro,
  ];
  // --------------------
  static const List<String> allAndroidSounds =<String>[
    whip_high_wav,
    whip_long_wav,
    zip_wav,
    click_a_wav,
    click_b_wav,
    click_c_wav,
    bldrs_intro_wav,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> allSoundsForPlatform(){

    /// WEB - ANDROID - WINDOWS
    if (
        kIsWeb == true ||
        DeviceChecker.deviceIsAndroid() == true ||
        DeviceChecker.deviceIsWindows() == true
    ){
      return allAndroidSounds;
    }

    /// IOS OR ELSE
    else {
      return allIOSSounds;
    }

  }
  // --------------------
}
