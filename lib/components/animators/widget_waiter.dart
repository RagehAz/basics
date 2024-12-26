import 'package:flutter/material.dart';
import 'package:basics/helpers/checks/tracers.dart';

class WidgetWaiter extends StatelessWidget {
  // --------------------------------------------------------------------------
  const WidgetWaiter({
    required this.child,
    this.waitDuration = const Duration(milliseconds: 50),
    this.isOn = true,
    super.key
  });
  // --------------------
  final Widget child;
  final Duration waitDuration;
  final bool isOn;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (isOn == false || waitDuration == Duration.zero){
      return child;
    }

    else {
      return TheWaiter(
        waitDuration: waitDuration,
        child: child,
      );
    }

  }
  // --------------------------------------------------------------------------
}

class TheWaiter extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TheWaiter({
    required this.child,
    required this.waitDuration,
    super.key,
  });
  // --------------------
  final Widget child;
  final Duration waitDuration;
  // --------------------
  @override
  _TheWaiterState createState() => _TheWaiterState();
  // --------------------------------------------------------------------------
}

class _TheWaiterState extends State<TheWaiter> {
  // --------------------------------------------------------------------------
  bool _show = false;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await Future.delayed(widget.waitDuration);

        if (mounted == true){
          setState(() {
            _show = true;
          });
        }

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(TheWaiter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.waitDuration.inMicroseconds != widget.waitDuration.inMicroseconds) {

      asyncInSync(() async {

        if (mounted == true){
          setState(() {
            _show = false;
          });
        }

        await Future.delayed(widget.waitDuration);

        if (mounted == true){
          setState(() {
            _show = true;
          });
        }

      });

    }
  }
  // --------------------
  /*
  @override
  void dispose() {
    super.dispose();
  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (_show == true){
      return widget.child;
    }
    // --------------------
    else {
      return const SizedBox.shrink();
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
