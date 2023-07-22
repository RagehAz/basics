import 'package:basics/helpers/classes/checks/device_checker.dart';
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
          final bool _shouldUpdate = versionShouldBe != null && versionShouldBe != text.data;
          return builder(context, _shouldUpdate, text.data ?? '0.0.0');
        }
        );

  }
  // -----------------------------------------------------------------------------
}
