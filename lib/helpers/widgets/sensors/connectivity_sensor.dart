// ignore_for_file: unused_element
import 'dart:async';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

typedef ConnectivityBuilder = Widget Function({
  required bool? connected,
  required Widget? child,
});

/*
// -----------------------------------------------------------------------------
Future<void> _initializeConnectivity({
  required BuildContext context,
  required bool mounted,
}) async {

  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  await _generalProvider.getSetConnectivity(
    context: context,
    mounted: mounted,
    notify: true,
  );

}
// -----------------------------------------------------------------------------
Future<void> connectivityListener({
  required ConnectivityResult streamResult,
  required BuildContext context,
  required bool mounted,
}) async {

  final bool _connected = await DeviceChecker.checkConnectivity(
    context: context,
    streamResult: streamResult,
  );

  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  _generalProvider.setConnectivity(
    isConnected: _connected,
    notify: true,
  );

  // blog('CONNECTIVITY HAD CHANGED TO : ${streamResult.toString()}');

}
// -----------------------------------------------------------------------------
 */

class ConnectivitySensor extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ConnectivitySensor({
    required this.onConnectivityChanged,
    this.builder,
    this.child,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget? child;
  final ConnectivityBuilder? builder;
  final Function({required bool isConnected})? onConnectivityChanged;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (onConnectivityChanged == null && builder == null){
      return child ?? const SizedBox();
    }
    else {
      return _TheSensor(
        onConnectivityChanged: onConnectivityChanged ?? ({required bool? isConnected}){},
        builder: builder ?? ({required bool? connected, required Widget? child}){
          return child ?? const SizedBox();
        },
        child: child ?? const SizedBox(),
      );
    }

  }
  /// --------------------------------------------------------------------------
}

class _TheSensor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _TheSensor({
    required this.onConnectivityChanged,
    this.builder,
    this.child,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget? child;
  final ConnectivityBuilder? builder;
  final Function({required bool isConnected})? onConnectivityChanged;
  /// --------------------------------------------------------------------------
  @override
  _TheSensorState createState() => _TheSensorState();
  /// --------------------------------------------------------------------------
}

class _TheSensorState extends State<_TheSensor> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool?>? _isConnected = ValueNotifier(null);
  StreamSubscription<ConnectivityResult>? _subscription;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initConnectivity();

    _subscription = DeviceChecker
        .getConnectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {

          final bool _connected = await DeviceChecker.checkConnectivity();

          await _onConnectivityChanged(_connected);

        });

  }
  // --------------------
  @override
  void dispose() {
    _isConnected?.dispose();
    _subscription?.cancel();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> initConnectivity() async {

    final bool _connected = await DeviceChecker.checkConnectivity();

    if (mounted == true) {

      setNotifier(
        notifier: _isConnected,
        mounted: mounted,
        value: _connected,
      );

      if (widget.onConnectivityChanged != null){
        await widget.onConnectivityChanged!(isConnected: _connected);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onConnectivityChanged(bool isConnected) async {

    if (mounted == true){

      /// ASSIGN LOCAL VALUE
      setNotifier(
          notifier: _isConnected,
          mounted: mounted,
          value: isConnected,
      );

      /// IF PROVIDER VALUE IS NOT UPDATED
      if (widget.onConnectivityChanged != null){
        await widget.onConnectivityChanged!(isConnected: isConnected);
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.builder == null){
      return widget.child ?? const SizedBox();
    }

    else if (_isConnected == null){
      return widget.builder!(connected: false, child: widget.child ?? const SizedBox());
    }

    else {

      return ValueListenableBuilder<bool?>(
          valueListenable: _isConnected!,
          child: widget.child,
          builder: (_, bool? connected, Widget? child){
            return widget.builder!(connected: connected, child: child);
          }
          );

    }

  }
  // -----------------------------------------------------------------------------
}
