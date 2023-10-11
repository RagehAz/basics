import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionBuilder extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const AppVersionBuilder({
    required this.builder,
    required this.versionShouldBe,
    super.key,
  });
  // --------------------
  final String? versionShouldBe;
  final Widget Function(BuildContext context,bool shouldUpdate, String version) builder;
  // -----------------------------------------------------------------------------

  /// VERSION DIVISIONS

  // --------------------
  /*
  /// TESTED : WORKS PERFECTLY
  static bool appVersionIsInSync({
    required String globalVersion,
    required String userVersion,
    required String detectedVersion,
  }){
    return
        globalVersion == userVersion &&
        globalVersion == detectedVersion &&
        userVersion == detectedVersion;
  }

    static List<int> fixVersionDivisions(List<int> divs){
    List<int> _output = <int>[];

    if (Mapper.checkCanLoopList(divs) == true){

      if (divs.length == 3){
        _output = divs;
      }
      else if (divs.length > 3){
        _output = [divs[0], divs[1], divs[2]];
      }
      else {
        _output = <int>[0,0,0];
        for (int i = 0; i < divs.length; i++){
          _output.removeAt(i);
          _output.insert(i, divs[i]);
        }
      }

    }
    else {
      _output = [0,0,0];
    }

    return _output;
  }

   */
  // --------------------
  /// AI TESTED
  static int? getAppVersionNumbered(String version){
    int? _output;

    final bool _appVersionIsValid = appVersionIsValid(version);

    if (_appVersionIsValid == true){


      final String _removedBuildNumber = TextMod.removeTextAfterLastSpecialCharacter(
        text: version,
          specialCharacter: '+',
      )!;

      final List<String> _strings = _removedBuildNumber.split('.');

      final String _rejoined = '${_strings[0]}${_strings[1]}${_strings[2]}';
      _output = Numeric.transformStringToInt(_rejoined);

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static bool versionIsBigger({
    required String? thisIsBigger,
    required String? thanThis,
  }){

    /// THEY COME IN THIS FORM 0.0.0
    /// AND ONLY NEED TO UPDATE IF GLOBAL IS BIGGER THAN THE SMALLER

    bool _isBigger = false;

    final bool _globalVersionIsValid = appVersionIsValid(thisIsBigger);
    final bool _localVersionIsValid = appVersionIsValid(thanThis);

    if (_globalVersionIsValid == true && _localVersionIsValid == true){

      final int _bigger = getAppVersionNumbered(thisIsBigger!)!;
      final int _thanThis = getAppVersionNumbered(thanThis!)!;

      _isBigger = _bigger > _thanThis;

    }


    return _isBigger;
  }
  // --------------------
  /// AI TESTED
  static bool appVersionIsValid(String? version) {

    if (version == null) {
      return false;
    }

    else {
      const pattern = r'^\d+\.\d+\.\d+(\+\d+)?$';
      final regex = RegExp(pattern);
      return regex.hasMatch(version);
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECTLY
  static Future<String> detectAppVersion() async {
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    if (DeviceChecker.deviceIsAndroid() == true){
      return _packageInfo.version;
    }
    else if (DeviceChecker.deviceIsIOS() == true){
      return _packageInfo.buildNumber;
    }
    else {
      return _packageInfo.version;
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: detectAppVersion(),
        builder: (context, AsyncSnapshot<String> text) {

          final String _deviceVersion = text.data ?? '0.0.0';

          final bool _shouldUpdate = versionShouldBe != null && AppVersionBuilder.versionIsBigger(
            thisIsBigger: versionShouldBe, // given version is bigger than
            thanThis: _deviceVersion, // device app version so should update app
          );

          return builder(context, _shouldUpdate, _deviceVersion);
        }
        );

  }
  // -----------------------------------------------------------------------------
}
