part of super_slider;

class SuperStepSlider extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperStepSlider({
    required this.divisions,
    required this.labels,
    required this.draggerColor,
    required this.onChanged,
    required this.initialIndex,
    this.trackColor = Colorz.white125,
    this.onChangeStart,
    this.onChangeEnd,
    super.key
  });
  /// --------------------------------------------------------------------------
  /// [0, 1, 5, 6, 9] SHOULD START FROM ZERO AND INCREMENT ONLY
  final List<int> divisions;
  final List<dynamic>? labels;
  final Function(int value)? onChanged;
  final Function(int value)? onChangeStart;
  final Function(int value)? onChangeEnd;
  final Color trackColor;
  final Color draggerColor;
  final int? initialIndex;
  /// --------------------------------------------------------------------------
  @override
  State<SuperStepSlider> createState() => _SuperStepSliderState();
  /// --------------------------------------------------------------------------
}

class _SuperStepSliderState extends State<SuperStepSlider> {
  // -----------------------------------------------------------------------------
  List<int> values = [];
  double _live = 0;
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    values = widget.divisions;
    _live = _getLiveValueByIndex(widget.initialIndex ?? 0);

    super.initState();
  }
  // --------------------
  @override
  void didUpdateWidget(SuperStepSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (
    Lister.checkListsAreIdentical(list1: widget.labels, list2: oldWidget.labels) == false ||
    Lister.checkListsAreIdentical(list1: widget.divisions, list2: oldWidget.divisions) == false
    ) {
      if (mounted == true){
        setState(() {
          values = widget.divisions;
          _live = _getLiveValueByIndex(widget.initialIndex ?? 0);
        });
      }
    }
  }
  // --------------------

  /// LABEL

  // --------------------
  dynamic _getLabel(){
    final int _index = _getIntToSnapTo(_live);
    if (Lister.checkCanLoop(widget.labels) == true){

      final int _closest = Numeric.getClosestInt(
        ints: values,
        value: values.last * _live,
      )!;
      final int _intIndex = values.indexWhere((element) => element == _closest);
      return ' ${widget.labels![_intIndex]} ';
    }
    else {
      return ' $_index ';
    }
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  double _concludeSnapToValue(double live){

    final int length = values.length;

    if (length == 0){
      return 0;
    }

    /// List<int>, has to be sequential 1 . 3 . 4 . 5 . 6 getting bigger only
    else {
      return _getValueToSnapTo(live);
    }

  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  double _getValueToSnapTo(double live){

    // final double _live = Numeric.roundFractions(live, 2)! * values.last;
    final int _indexToSnapTo = _getIntToSnapTo(live);
    // final double _stepLength = _getStepLength();

    // final double _go = _indexToSnapTo / values.last;
    //
    // blog('live [$_live] snaps to [$_indexToSnapTo] from $values => [$_go]');

    /// SHOULD RETURN BETWEEN 0 AND 1;
    return _getLiveValueByIndex(_indexToSnapTo);
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  int _getIntToSnapTo(double live){

    final int _closest = Numeric.getClosestInt(
      ints: values,
      value: values.last * live,
    )!;

    return _closest;
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  double _getLiveValueByIndex(int index){
    final double _go = index / values.last;
    return _go;
  }
  // -----------------------------------------------------------------------------

  /// CHANGE

  // --------------------
  void _onChange(double value) {

    _getValueToSnapTo(value);

    if (mounted == true){
      setState(() {
        _live = value;
      });
    }

    widget.onChanged?.call(_getIntToSnapTo(value));

  }
  // --------------------
  void _onChangeEnd(double value){

    if (mounted == true){
      setState(() {
        _live = _concludeSnapToValue(value);
      });
    }

    widget.onChangeEnd?.call(_getIntToSnapTo(value));

  }
  // --------------------
  void _onChangeStart(double value){
    widget.onChangeStart?.call(_getIntToSnapTo(value));
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
      // max:  1,
      // min: 0,
      onChangeEnd: _onChangeEnd,
      onChangeStart: _onChangeStart,
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
