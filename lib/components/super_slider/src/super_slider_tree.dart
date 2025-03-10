part of super_slider;

class SuperSlider extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperSlider({
    required this.width,
    required this.height,
    required this.snap,
    this.labels,
    this.divisions,
    this.range,
    this.trackColor = Colorz.white80,
    this.draggerColor = Colorz.yellow255,
    this.onChanged,
    this.onChangeEnd,
    this.onChangeStart,
    this.showIndicator = true,
    this.textStyle,
    this.roundFractions = 2,
    this.initialValueOrIndex,
    this.inactiveTrackColor,
    super.key,
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final List<dynamic>? labels;
  final List<int>? divisions;
  final List<double>? range;
  final Color trackColor;
  final Color draggerColor;
  final Function(dynamic value)? onChanged;
  final Function(dynamic value)? onChangeStart;
  final Function(dynamic value)? onChangeEnd;
  final bool showIndicator;
  final TextStyle? textStyle;
  final bool snap;
  final int roundFractions;
  final dynamic initialValueOrIndex;
  final Color? inactiveTrackColor;
  /// --------------------------------------------------------------------------
  static SliderThemeData bldrsSliderTheme({
    required BuildContext context,
    required bool showIndicator,
    required double boxHeight,
    required TextStyle? textStyle,
    required Color trackColor,
    required Color? inactiveTrackColor,
    required Color draggerColor,
    required double boxWidth,
  }){
    return SliderTheme.of(context).copyWith(

      /// TRACK
      trackHeight: boxHeight - 2,
      trackShape: TightRoundedRectSliderTrackShape(
        width: boxWidth,
      ),

      /// TRACK : ACTIVE
      activeTrackColor: trackColor,
      // disabledActiveTrackColor: Colorz.white10, // not effective

      /// TRACK : INACTIVE
      inactiveTrackColor: inactiveTrackColor ?? trackColor.withAlpha(25),
      // disabledInactiveTrackColor: Colorz.white10, // not effective

      /// TICK : ACTIVE
      // tickMarkShape: const RoundSliderTickMarkShape(), // not effective
      // activeTickMarkColor: Colorz.red255, // not effective
      // disabledActiveTickMarkColor: Colorz.red255, // not effective

      /// TICK : IN ACTIVE
      // disabledInactiveTickMarkColor: Colorz.white10, // not effective
      // inactiveTickMarkColor: Colorz.white10, // not effective

      /// OVERLAY CIRCLE
      // overlayColor: draggerColor.withOpacity(0.1),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),

      /// VALUE INDICATOR
      valueIndicatorColor: draggerColor.withAlpha(50),
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      showValueIndicator: showIndicator == true ? ShowValueIndicator.always : ShowValueIndicator.never,
      valueIndicatorTextStyle: textStyle,

      /// THUMB
      thumbColor: draggerColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: boxHeight/2),
      // disabledThumbColor: Colorz.white10, // not effective
      // minThumbSeparation: 20, // not effective
      // rangeThumbShape: const RoundRangeSliderThumbShape( // not effective
      //   disabledThumbRadius: 10, // not effective
      //   elevation: 0, // not effective
      //   pressedElevation: 0, // not effective
      // ),

      /// OVERLAPPING SHAPE STROKE
      overlappingShapeStrokeColor: Colorz.red255, // not effective

    );
  }
  /// --------------------------------------------------------------------------
  static List<int> createIndexedDivisions({
    required List<dynamic> list,
  }){
    final List<int> _output = [];

    if (Lister.checkCanLoop(list) == true){

      for (int i = 0; i < list.length; i++){

        _output.add(i);

      }

    }

    return _output;
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (snap == true){
      return _SliderBox(
        width: width,
        height: height,
        values: divisions,
        sliderThemData: SuperSlider.bldrsSliderTheme(
          context: context,
          showIndicator: showIndicator,
          boxHeight: height,
          textStyle: textStyle,
          trackColor: trackColor,
          draggerColor: draggerColor,
          inactiveTrackColor: inactiveTrackColor,
          boxWidth: width,
        ),
        child: SuperStepSlider(
          labels: labels,
          divisions: divisions!,
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
          onChangeStart: onChangeStart,
          trackColor: trackColor,
          draggerColor: draggerColor,
          initialIndex: initialValueOrIndex,
        ),
      );
    }
    // --------------------
    /// STEP SLIDER : more than 2 values
    else {
      return _SliderBox(
        width: width,
        height: height,
        // values: divisions,
        sliderThemData: SuperSlider.bldrsSliderTheme(
          context: context,
          showIndicator: showIndicator,
          boxHeight: height,
          textStyle: textStyle,
          trackColor: trackColor,
          draggerColor: draggerColor,
          inactiveTrackColor: inactiveTrackColor,
          boxWidth: width,
        ),
        // child: Container(),
        child: SuperRangeSlider(
          range: range,
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
          onChangeStart: onChangeStart,
          trackColor: trackColor,
          draggerColor: draggerColor,
          roundFractions: roundFractions,
          initialValue: initialValueOrIndex,
        ),
      );
    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
