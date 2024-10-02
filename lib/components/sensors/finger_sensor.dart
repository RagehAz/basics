import 'package:basics/helpers/wire/wire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class FingersSensor extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const FingersSensor({
    required this.builder,
    this.child,
    super.key,
  });
  // --------------------
  final Widget? child;
  final Widget Function(int numberOfFingers, Widget? child) builder;
  // --------------------
  @override
  _FingersSensorState createState() => _FingersSensorState();
  // -----------------------------------------------------------------------------
}

class _FingersSensorState extends State<FingersSensor> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final Wire<int> _fingers = ValueNotifier<int>(0);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
  }
  */
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _fingers.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _onPointerDown(PointerDownEvent event) {

    final int _count = _fingers.value;

    _fingers.set(
      value: _count + 1,
      mounted: mounted,
    );
  }
  // --------------------
  void _onPointerUp(PointerUpEvent event) {

    final int _count = _fingers.value;

    _fingers.set(
      value: _count - 1,
      mounted: mounted,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,

      child: LiveWire(
          wire: _fingers,
          child: widget.child,
          builder: (int fingers, Widget? child){

            return widget.builder(fingers, child);

          },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
