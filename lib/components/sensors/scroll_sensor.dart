import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/material.dart';

class ScrollSensor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ScrollSensor({
    required this.child,
    required this.scrollController,
    this.onStartEdge,
    this.onEndEdge,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final ScrollController scrollController;
  final Function? onStartEdge;
  final Function? onEndEdge;
  /// --------------------------------------------------------------------------
  @override
  _ScrollSensorState createState() => _ScrollSensorState();
  /// --------------------------------------------------------------------------
}

class _ScrollSensorState extends State<ScrollSensor> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    /// REMOVED
    widget.scrollController.addListener(listenToScrolling);
  }
  // --------------------
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
    widget.scrollController.removeListener(listenToScrolling);
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void listenToScrolling() {
    if (widget.scrollController.position.atEdge) {

      final bool isTop = widget.scrollController.position.pixels == 0;


      if (isTop) {
        widget.onStartEdge?.call();
      }

      else {
        widget.onEndEdge?.call();
      }

    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return widget.child;
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
