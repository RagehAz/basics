// ignore_for_file: unused_catch_clause
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// => TAMAM
class Errorize {
  // -----------------------------------------------------------------------------

  const Errorize();

  // -----------------------------------------------------------------------------

  /// THROW

  // ----------------------
  /// TESTED : WORKS PERFECT
  static Future<void> throwText({
    required String text,
    required String invoker,
  }) async {

    final String _text = '''
Errorized : Invoker : [ $invoker ]
          : text :- 
            $text
    ''';

    await _throwAndCaptureException(_text);

  }
  // ----------------------
  /// TESTED : WORKS PERFECT
  static Future<void> throwMap({
    required String invoker,
    required Map<String, dynamic>? map,
  }) async {

    final String _maw = stringifyMap(map);

    final String _text = '''
Errorized : Invoker : [ $invoker ]
          : Map :- 
$_maw
    ''';

    await _throwAndCaptureException(_text);

  }
  // ----------------------
  /// TESTED : WORKS PERFECT
  static Future<void> throwMaps({
    required String invoker,
    required List<Map<String, dynamic>> maps,
  }) async {

    final String _maw = stringifyMaps(maps);

    final String _text = '''
Errorized : Invoker : [ $invoker ]
          : Maps :- 
$_maw
    ''';

    await _throwAndCaptureException(_text);

  }
  // -----------------------------------------------------------------------------

  /// STRINGIFICATION

  // ----------------------
  /// TESTED : WORKS PERFECT
  static String stringifyMap(Map<String, dynamic>? map) {

    if (map != null){

      final List<String> _lines = [];
      final List<dynamic> _keys = map.keys.toList();
      final List<dynamic> _values = map.values.toList();

      for (int i = 0; i < _keys.length; i++) {

        final String? _index = Numeric.formatIndexDigits(
          index: i,
          listLength: _keys.length,
        );

        final String _line = '         $_index. ${_keys[i]} : <${_values[i].runtimeType}>( ${_values[i]} ), ';
        _lines.add(_line);
      }

      String _b = '';
      for (final String _line in _lines){
        _b = _b == '' ? _line : '$_b\n$_line';
      }
      _b = '$_b\n';

      return '''
       <String, dynamic>{
$_b
       }.........Length : ${_keys.length} keys    
      ''';
    }

    else {
      return 'MAP IS NULL';
    }

  }
  // ----------------------
  /// TESTED : WORKS PERFECT
  static String stringifyMaps(List<Map<String, dynamic>> maps){

      String _x = '';
      for (final Map<String, dynamic> _map in maps){
        final String _maw = stringifyMap(_map);
        _x = _x == '' ? _maw : '$_x\n$_maw';
      }
      _x = '$_x\n';

            final String _text = '''
$_x
    ''';

            return _text;
  }
  // -----------------------------------------------------------------------------

  /// CAPTURING

  // ----------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _throwAndCaptureException(String text) async {

    try {
      throw Exception(text);
    }

    on Exception catch (error, stackTrace) {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
      blog('_throwAndCaptureException : $error');
    }

  }
  // -----------------------------------------------------------------------------
}

/// => TAMAM
class Sentrize {
  // -----------------------------------------------------------------------------

  const Sentrize();

  // -----------------------------------------------------------------------------

  /// SENTRY INITIALIZATION

  // ----------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeApp({
    required Function(WidgetsBinding binding) functions,
    required String dns,
    required Widget app,
  }) async {

    // --------------------
    final PackageInfo pkg = await PackageInfo.fromPlatform();
    blog('XXX === >>> INITIALIZING SENTRY : ${pkg.appName}');
    // --------------------
    await SentryFlutter.init((options) async {

      // final release = AppPatcher.fullVersion;
      options.dsn = dns; // AppConstants.sentryDsn;
      options.release = pkg.version;
      options.sendDefaultPii = true;
      options.environment = 'production';
      options.attachScreenshot = true;
      options.beforeSend = (SentryEvent? event,{Hint? hint}) async {
        blog('XXX === >>> CRASH : ${event?.message}');
        return event;
      };
      },

      appRunner: () async {
        // --------------------
        /// BINDING
        final WidgetsBinding _binding = WidgetsFlutterBinding.ensureInitialized();
        // --------------------
        /// FUNCTIONS
        await functions(_binding);
        // --------------------
        /// SENTRY CONFIGURATIONS
        Sentry.configureScope((scope) async {

          /// SET DEVICE INFO
          final BaseDeviceInfo? deviceInfo = await DeviceChecker.getBaseDeviceInfo();
          if (deviceInfo != null){
            await scope.setContexts('device_info', deviceInfo.data);
          }

          /// SET PACKAGE INFO
          final Map<String, String> packageInfoAsMap = <String, String>{
            'packageName': pkg.packageName,
            'appName': pkg.appName,
            'buildNumber': pkg.buildNumber,
            'buildSignature': pkg.buildSignature,
            'version': pkg.version,
          };
          await scope.setContexts('package_info', packageInfoAsMap);


        });
        // --------------------
        /// RUN
        return runApp(
          DefaultAssetBundle(
            bundle: SentryAssetBundle(),
            child: SentryScreenshotWidget(
              child: app,
            ),
          ),
        );
        // --------------------
      },
    );
    // --------------------

  }
  // -----------------------------------------------------------------------------
}
