part of super_stop_watch;

class StopWatchRecordsBuilder extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const StopWatchRecordsBuilder({
    required this.controller,
    required this.builder,
    super.key
  });
  /// -----------------------------------------------------------------------------
  final StopWatchController controller;
  final Widget Function(List<StopWatchRecord> records) builder;
  /// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<StopWatchRecord>>(
      stream: controller.timer.records,
      initialData: controller.timer.records.value,
      builder: (BuildContext context, AsyncSnapshot<List<StopWatchRecord>> snap) {

        final List<StopWatchRecord> records = snap.data ?? [];

        return builder(records);

      },
    );

  }
  /// -----------------------------------------------------------------------------
}
