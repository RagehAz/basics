part of super_stop_watch;

class StopWatchController {
  // -----------------------------------------------------------------------------
  StopWatchController({
    this.onStart,
    this.onStop,
    this.onLap,
    this.onPause,
  });
  // -----------------------------------------------------------------------------
  final Function? onStart;
  final Function? onPause;
  final Function? onLap;
  final Function? onStop;
  // -----------------------------------------------------------------------------

  /// STOPWATCH SINGLETON

  // --------------------
  /// TIMER INSTANCE
  StopWatchTimer? _timer;
  StopWatchTimer get timer => _timer ??= StopWatchTimer();
  // -----------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose() {
    timer.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CONTROLS

  // --------------------
  /// TESTED : WORKS PERFECT
  void start() {

    timer.onExecute.add(StopWatchExecute.start);

    onStart?.call();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void pause() {

    timer.onExecute.add(StopWatchExecute.stop);

    onPause?.call();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void lap() {

    timer.onExecute.add(StopWatchExecute.lap);

    onLap?.call();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void stop() {

    timer.onExecute.add(StopWatchExecute.reset);

    onStop?.call();

  }
  // -----------------------------------------------------------------------------
}
