part of super_slider;

/// RANGE SLIDER
class SuperRangeSlider extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperRangeSlider({
    required this.range,
    required this.draggerColor,
    required this.onChanged,
    required this.initialValue,
    this.trackColor = Colorz.white125,
    this.onChangeStart,
    this.onChangeEnd,
    this.roundFractions = 1,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<double>? range;
  final Function(double value)? onChanged;
  final Function(double value)? onChangeStart;
  final Function(double value)? onChangeEnd;
  final Color trackColor;
  final Color draggerColor;
  final int roundFractions;
  final double? initialValue;
  /// --------------------------------------------------------------------------
  @override
  _SuperRangeSliderState createState() => _SuperRangeSliderState();
  /// --------------------------------------------------------------------------
}

class _SuperRangeSliderState extends State<SuperRangeSlider> {
  // -----------------------------------------------------------------------------
  double _live = 0;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    _live = widget.initialValue ?? widget.range?.first ?? 0;
    super.initState();
  }
  // -----------------------------------------------------------------------------

  /// LABEL

  // --------------------
  dynamic _getLabel(){
    if (widget.roundFractions == 0){
      return ' ${_live.toInt()} ';
    }
    else {
      return ' $_live ';
    }

  }
  // -----------------------------------------------------------------------------

  /// CHANGE

  // --------------------
  void _onChange(double value) {

    setState(() {
      _live = _fixDouble(value);
    });

    widget.onChanged?.call(_live);

  }
  // --------------------
  void _onChangeEnd(double value){

    setState(() {
      _live = _fixDouble(value);
    });

    widget.onChangeEnd?.call(_live);

  }
  // --------------------
  double _fixDouble(double value){
    return Numeric.roundFractions(value, widget.roundFractions)!;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Slider(
      value: _live,
      /// MESSED UP
      // divisions: ,
      /// HANDLED IN PARENT WIDGET sliderThemData
      // activeColor: widget.draggerColor,
      // inactiveColor: widget.trackColor,
      label: _getLabel(),
      /// DEFAULT
      max:  widget.range?.last ?? 1,
      min: widget.range?.first ?? 0,
      onChangeEnd: _onChangeEnd,
      onChangeStart: widget.onChangeStart,
      onChanged: _onChange,
      // semanticFormatterCallback: (value){
      //
      //   // if(_isInit == true){
      //   //   setState(() {
      //       _semanticFormatterCallback = value;
      //   //   });
      //   // }
      //
      //   return 'the semantic formatter call back value is : $value';
      // },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
