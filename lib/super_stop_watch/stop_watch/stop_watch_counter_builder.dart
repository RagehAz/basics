part of super_stop_watch;

class StopWatchCounterBuilder extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const StopWatchCounterBuilder({
    required this.controller,
    required this.builder,
    super.key
  });
  /// -----------------------------------------------------------------------------
  final StopWatchController controller;
  final Widget Function(String displayTime) builder;
  /// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<int>(
      stream: controller.timer.rawTime,
      initialData: controller.timer.rawTime.value,
      builder: (BuildContext context, AsyncSnapshot<int> snap) {

        final int value = snap.data ?? 0;
        final String displayTime = StopWatchTimer.getDisplayTime(
            value,
            // hours: true,
        );

        return builder(displayTime);

      },
    );

  }
  /// -----------------------------------------------------------------------------
}
