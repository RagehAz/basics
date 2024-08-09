import 'package:flutter/material.dart';
import 'package:basics/helpers/checks/tracers.dart';

typedef Wire<T> = ValueNotifier<T>;

extension ExtraWire<T> on Wire<T> {
  // -----------------------------------------------------------------------------

  /// SET

  // --------------------
  /// TESTED : WORKS PERFECT
  void set({
    required T value,
    bool mounted = true,
  }){
    setNotifier(notifier: this, mounted: mounted, value: value);
  }
  // -----------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  ///
  void clear(){
    dispose();
  }
  // -----------------------------------------------------------------------------

  /// BUILDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Widget liveWire({
    required Widget Function(T value, Widget? child) builder,
    Widget? child,
  }){
    return LiveWire(
      wire: this,
      builder: builder,
      child: child,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget singleWire({
    required Widget Function(T value) builder,
  }){
    return SingleWire(
      wire: this,
      builder: builder,
    );
  }
  // -----------------------------------------------------------------------------
}

class LiveWire<T> extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LiveWire({
    required this.wire,
    required this.builder,
    this.child,
    super.key
  });
  // --------------------
  final Wire<T> wire;
  final Widget Function(T value, Widget? child) builder;
  final Widget? child;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder<T>(
        valueListenable: wire,
        child: child,
        builder: (_, T value, Widget? child){
          return builder(value, child);
        }
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class SingleWire<T> extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SingleWire({
    required this.wire,
    required this.builder,
    super.key
  });
  // --------------------
  final Wire<T> wire;
  final Widget Function(T value) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder<T>(
        valueListenable: wire,
        builder: (_, T value, Widget? child){
          return builder(value);
        }
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class MultiWires extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MultiWires({
    required this.wires,
    required this.builder,
    this.child,
    super.key
  });
  // --------------------
  final Iterable<Listenable?> wires;
  final Widget? child;
  final Widget Function(Widget? child) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return AnimatedBuilder(
        animation: Listenable.merge(wires),
        child: child,
        builder: (_, Widget? child) {

          return builder(child);

        }
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
