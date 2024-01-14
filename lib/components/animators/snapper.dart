import 'package:flutter/material.dart';

/// TESTED WHEN IN COLUMN INSIDE SINGLE CHILD SCROLL VIEW
class WidgetSnapper extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WidgetSnapper({
    required this.snapKey,
    required this.child,
    super.key
  });
  /// --------------------------------------------------------------------------
  final GlobalKey snapKey;
  final Widget child;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void snapToWidget({
    required GlobalKey? snapKey,
  }){

    /// NOTE : snaps scroll of SingleChildScrollView to the widget holding this snapKey
    /// NOTE : works after build method of parent widget is fired

    if (snapKey != null){
      WidgetsBinding.instance.addPostFrameCallback((_){
        Scrollable.ensureVisible(snapKey.currentContext!);
      });
    }

  }
  // --------------------
  /*
    // _scrollController?.position?.ensureVisible(
    //   _formKey.currentContext.findRenderObject(),
    //   alignment: 0.5, // How far into view the item should be scrolled (between 0 and 1).
    //   duration: const Duration(seconds: 1),
    // );
    /// --------------------
    // Scrollable.ensureVisible(_fuckingKey.currentContext);
   */
  // --------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: snapKey,
      child: child,
    );

  }
// --------------------
}
