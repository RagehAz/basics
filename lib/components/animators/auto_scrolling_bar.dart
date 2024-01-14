import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AutoScrollingBar extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AutoScrollingBar({
    required this.scrollController,
    required this.height,
    required this.child,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ScrollController scrollController;
  final double height;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  _AutoScrollingBarState createState() => _AutoScrollingBarState();
  /// --------------------------------------------------------------------------
}

class _AutoScrollingBarState extends State<AutoScrollingBar> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<Map<String, dynamic>?> _scroll = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    /// REMOVED
    widget.scrollController.addListener(_scrollListener);

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
    widget.scrollController.removeListener(_scrollListener);
    _scroll.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _scrollListener() {

    setNotifier(
      notifier: _scroll,
      mounted: mounted,
      value: {
        'offset': widget.scrollController.offset,
        'direction': widget.scrollController.positions.first.userScrollDirection,
      },
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: _scroll,
      builder: (_, Map<String, dynamic>? scroll, Widget? child) {

        final ScrollDirection _direction = scroll?['direction'] ?? ScrollDirection.idle;

        /// this goes between 0 and (-_barHeight)
        double _barPosition = 0;

        /// WHEN GOING UP
        if (_direction == ScrollDirection.forward){
          _barPosition = 0;
        }

        /// WHEN GOING DOWN
        else if (_direction == ScrollDirection.reverse){
          _barPosition = -widget.height;
        }

        return AnimatedPositioned(
          top: _barPosition,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInBack,
          child: child!,
        );

      },
      child: widget.child,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
