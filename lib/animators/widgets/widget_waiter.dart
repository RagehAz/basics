import 'package:flutter/material.dart';

class WidgetWaiter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WidgetWaiter({
    required this.child,
    this.waitDuration = const Duration(milliseconds: 50),
    this.isOn = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final Duration waitDuration;
  final bool isOn;
  /// --------------------------------------------------------------------------
  Future<bool> _rebuild() async {
    await Future.delayed(waitDuration, () {});
    return true;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (isOn == false){
      return child;
    }

    else {
      return FutureBuilder(
        future: _rebuild(),
        builder: (_, AsyncSnapshot<bool> snapshot){

          final bool _build = snapshot.connectionState == ConnectionState.waiting ?
          false : true;

          if (_build == true){
            return child;
          }

          else {
            return const SizedBox.shrink();
          }

          },
      );
    }

  }
  /// --------------------------------------------------------------------------
}
