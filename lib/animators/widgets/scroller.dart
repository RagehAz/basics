// ignore_for_file: unused_element
import 'package:flutter/material.dart';

class Scroller extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Scroller({
    required this.child,
    this.controller,
    this.isOn = true,
  super.key
  });// --------------------
  final Widget child;
  final ScrollController? controller;
  final bool isOn;
  // --------------------
  static Widget getScrollbar({
    required ScrollController? controller,
    required Widget child,
  }){

    return Scrollbar(
        thickness: 3,
        radius: const Radius.circular(1.5),
        thumbVisibility: false,
        controller: controller,
        interactive: false,
        // hoverThickness: 40,
        // showTrackOnHover: false,
        scrollbarOrientation: ScrollbarOrientation.right,
        notificationPredicate: (ScrollNotification notification){

          // print('notification.metrics.pixels : ${notification.metrics.pixels}');

          return true;
        },
        // controller: ,
        child: child,
      );

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (isOn == false) {
      return child;
    }

    else {

      if (controller == null) {
        return _StatefulScrollBar(
          child: child,
        );
      }

      else {
        return _StatelessScrollBar(
          controller: controller,
          child: child,
        );
      }
    }

  }
  /// --------------------------------------------------------------------------
}

// --------------------------------------------------------------------------

class _StatelessScrollBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _StatelessScrollBar({
    required this.controller,
    required this.child,
    // super.key,
  });
  // ---------------------------------
  final ScrollController? controller;
  final Widget child;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Scroller.getScrollbar(
        controller: controller,
        child: child,
    );

  }
  // --------------------------------------------------------------------------
}

// --------------------------------------------------------------------------

class _StatefulScrollBar extends StatefulWidget {
  // --------------------------------------------------------------------------
  const _StatefulScrollBar({
    required this.child,
    super.key
  });
  // --------------------
  final Widget child;
  // --------------------
  @override
  State<_StatefulScrollBar> createState() => _StatefulScrollBarState();
  // --------------------------------------------------------------------------
}

class _StatefulScrollBarState extends State<_StatefulScrollBar> {
  // --------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Scroller.getScrollbar(
        controller: _scrollController,
        child: widget.child,
    );

  }
  // --------------------------------------------------------------------------
}

// --------------------------------------------------------------------------
