import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/wire/wire.dart';
import 'package:flutter/material.dart';

class KeyboardSensor extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const KeyboardSensor({
    required this.builder,
    this.onChanged,
    this.child,
    this.isOn = false,
    super.key
  });
  // --------------------
  final Widget? child;
  final Widget Function(bool isVisible, Widget? child) builder;
  final void Function(bool isVisible)? onChanged;
  final bool isOn;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (isOn == true){
      return _KeyboardSensorOn(
        builder: builder,
        onChanged: onChanged,
        child: child,
      );
    }
    // --------------------
    else {
      return _KeyboardSensorOff(
        child: child,
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class _KeyboardSensorOff extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _KeyboardSensorOff({
    required this.child,
    // super.key
  });
  // --------------------
  final Widget? child;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return child ?? const SizedBox();
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class _KeyboardSensorOn extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const _KeyboardSensorOn({
    required this.child,
    required this.builder,
    required this.onChanged,
    // super.key
  });
  // --------------------
  final Widget? child;
  final void Function(bool visible)? onChanged;
  final Widget Function(bool isVisible, Widget? child) builder;
  // --------------------
  @override
  State<_KeyboardSensorOn> createState() => _KeyboardSensorOnState();
// -----------------------------------------------------------------------------
}

class _KeyboardSensorOnState extends State<_KeyboardSensorOn> with WidgetsBindingObserver {
  // -----------------------------------------------------------------------------
  ValueNotifier<bool>? _isVisible;
  // --------------------
  @override
  void initState() {
    super.initState();
    _isVisible = ValueNotifier(false);
    WidgetsBinding.instance.addObserver(this);
  }
  // --------------------
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isVisible?.dispose();
    _isVisible = null;
    super.dispose();
  }
  // --------------------
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    if (mounted == true){

      final bool _visible = Scale.screenInsets(context).bottom > 0;

      if (_visible != _isVisible?.value){
        _isVisible?.set(
          value: _visible,
          mounted: mounted,
        );

        widget.onChanged?.call(_visible);
      }

    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return LiveWire(
      wire: _isVisible,
      nullChild: widget.child ?? const SizedBox(),
      child: widget.child ?? const SizedBox(),
      builder: (bool isVisible, Widget? child){

        return widget.builder(isVisible, child);

      },
    );

  }
// -----------------------------------------------------------------------------
}
