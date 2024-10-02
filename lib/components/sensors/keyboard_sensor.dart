import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/wire/wire.dart';
import 'package:flutter/material.dart';

class KeyboardSensor extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const KeyboardSensor({
    required this.child,
    required this.builder,
  super.key
  });
  // --------------------
  final Widget? child;
  final Widget Function({required bool isVisible, required Widget? child}) builder;
  // --------------------
  @override
  State<KeyboardSensor> createState() => _KeyboardSensorState();
  // -----------------------------------------------------------------------------
}

class _KeyboardSensorState extends State<KeyboardSensor> with WidgetsBindingObserver {
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

    final bool _visible = context.screenInsets.bottom > 0;

    _isVisible?.set(
      value: _visible,
      mounted: mounted,
    );

  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return LiveWire(
        wire: _isVisible,
        nullChild: widget.child ?? const SizedBox(),
        child: widget.child ?? const SizedBox(),
        builder: (bool isVisible, Widget? child){

          return widget.builder(isVisible: isVisible, child: child);

        },
    );

  }
  // -----------------------------------------------------------------------------
}
