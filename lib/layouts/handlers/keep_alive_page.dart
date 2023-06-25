

import 'package:flutter/material.dart';

class KeepAlivePage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const KeepAlivePage({
    required this.child,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
/// --------------------------------------------------------------------------
}

class _KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin {
  // -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;

  }
  // -----------------------------------------------------------------------------
}
