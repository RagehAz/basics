import 'package:flutter/material.dart';

class ClockRebuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ClockRebuilder({
    required this.startTime,
    this.child,
    this.builder,
    this.duration,
  super.key
  });/// --------------------------------------------------------------------------
  final Widget? child;
  final Duration? duration;
  final DateTime startTime;
  final Widget Function(int timeDifference, Widget? child)? builder;
  /// --------------------------------------------------------------------------
  @override
  _ClockRebuilderState createState() => _ClockRebuilderState();
/// --------------------------------------------------------------------------
}

class _ClockRebuilderState extends State<ClockRebuilder> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<int> timeDifference = ValueNotifier(0);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    startClockRebuilder();
  }
  // --------------------
  @override
  void didUpdateWidget(ClockRebuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (checkTimesAreIdentical(time1: oldWidget.startTime, time2: widget.startTime) == false) {
      setState(() {});
    }
  }
  // --------------------
  @override
  void dispose() {
    timeDifference.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  bool checkTimesAreIdentical({
    required DateTime? time1,
    required DateTime? time2,
  }){
    bool _areIdentical = false;

    if (time1 == null && time2 == null){
      _areIdentical = true;
    }

    else if (time1 != null && time2 != null){
      if (time1.second == time2.second) {
        _areIdentical = true;
      }
    }

    // else {
    //
    // }

    // print('timesAreTheSame : $_areIdentical : accuracy : ${accuracy} : timeA ${timeA} : timeB ${timeB}');

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setNotifier({
    required ValueNotifier<dynamic>? notifier,
    required bool mounted,
    required dynamic value,
    bool addPostFrameCallBack = false,
    Function? onFinish,
    bool shouldHaveListeners = false,
  }){

  if (mounted == true){
    // blog('setNotifier : setting to ${value.toString()}');

    if (notifier != null){

      if (value != notifier.value){

        /// ignore: invalid_use_of_protected_member
        if (shouldHaveListeners == false || notifier.hasListeners == true){

          if (addPostFrameCallBack == true){
            WidgetsBinding.instance.addPostFrameCallback((_){
              notifier.value  = value;
              if(onFinish != null){
                onFinish();
              }
            });
          }

          else {
            notifier.value  = value;
            if(onFinish != null){
              onFinish();
            }
          }

        }

      }

    }

  }

}
  // --------------------
  /// TESTED : WORKS PERFECT
  int? calculateTimeDifferenceInSeconds({
    required DateTime? from,
    required DateTime? to,
  }){
    int? _output;

    if (to != null && from != null){
      _output = to.difference(from).inSeconds;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> startClockRebuilder() async {

    if (mounted){

      final Duration _duration = widget.duration ?? const Duration(seconds: 1);

      await Future.delayed(_duration, () async {

        if (mounted){

          setNotifier(
              notifier: timeDifference,
              mounted: mounted,
              value: calculateTimeDifferenceInSeconds(
                from: widget.startTime,
                to: DateTime.now(),
              ),
          );

          await startClockRebuilder();
        }

      });

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: timeDifference,
        child: widget.child,
        builder: (_, int _timeDifference, Widget? child){

          if (widget.builder == null){
            return child ?? const SizedBox();
          }
          else {
            return widget.builder!(_timeDifference, child);
          }

        }
    );

  }
// -----------------------------------------------------------------------------
}
