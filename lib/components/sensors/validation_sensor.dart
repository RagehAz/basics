// ignore_for_file: avoid_positional_boolean_parameters
import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/material.dart';

class ValidationSensor extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ValidationSensor({
    required this.validator,
    required this.controller,
    required this.builder,
    this.child,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? Function(String? text)? validator;
  final TextEditingController? controller;
  final Widget? child;
  final Widget Function(bool isValid, String? error, Widget? child) builder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (validator == null || controller == null){
      return builder(true, null, child);
    }
    // --------------------
    else {
      return _TheValidationSensor(
          validator: validator!,
          controller: controller!,
          builder: builder,
          child: child,
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class _TheValidationSensor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _TheValidationSensor({
    required this.validator,
    required this.controller,
    required this.builder,
    this.child,
    // super.key
  });
  /// --------------------------------------------------------------------------
  final String? Function(String? text) validator;
  final TextEditingController controller;
  final Widget? child;
  final Widget Function(bool isValid, String? error, Widget? child) builder;
  /// --------------------------------------------------------------------------
  @override
  _TheValidationSensorState createState() => _TheValidationSensorState();
  /// --------------------------------------------------------------------------
}

class _TheValidationSensorState extends State<_TheValidationSensor> {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _lastText = widget.controller.text;
    _theError = widget.validator.call(widget.controller.text);
    _isValid = _theError == null;
    widget.controller.addListener(_listener);

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  String? _lastText;
  String? _theError;
  late bool _isValid;
  void _listener() {

    if (_lastText != widget.controller.text) {

      final String? _error = widget.validator.call(widget.controller.text);

      if (mounted == true){
        setState(() {
          _lastText = widget.controller.text;
          _theError = _error;
          _isValid = _error == null;
        });
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return widget.builder(_isValid, _theError, widget.child);
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
