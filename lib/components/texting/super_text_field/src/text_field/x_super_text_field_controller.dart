part of super_text_field;

class SuperTextFieldController {
  // -----------------------------------------------------------------------------

  const SuperTextFieldController();

  // --------------------------------------------------------------------------

  /// ALIGNMENT

  // --------------------
  /// TAMAM : WORKS PERFECT
  static TextAlign getTextAlignment({
    required bool centered,
  }){

    if (centered == true){
      return TextAlign.center;
    }

    else {
      return TextAlign.start;
    }

  }
  // --------------------------------------------------------------------------

  /// KEYBOARD

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextInputType getKeyboardType({
    required TextInputAction? textInputAction,
    required TextInputType? textInputType,
  }){
    final TextInputType? _textInputType = textInputAction == TextInputAction.newline ?
    TextInputType.multiline
        :
    textInputType;

    return _textInputType ?? TextInputType.text;
  }
  // --------------------------------------------------------------------------

  /// SIZING

  // --------------------
  ///
  static double getFieldHeight({
    required BuildContext context,
    required int? minLines,
    required double? textHeight,
    required bool withBottomMargin,
    required bool withCounter,
    required EdgeInsets? textPadding,
  }){

    /// UNDER TEXT FIELD BOX MARGIN : THAT WE CAN NOT REMOVE
    final double _bottomMargin = withBottomMargin == true ? 7 : 0;
    final double _textHeight = textHeight ?? 20;
    final int _minLines = minLines ?? 1;

    final double _counterPaddingValue = withCounter ? 2.5 : 0;
    final double _counterHeight = withCounter ? _textHeight * counterTextHeightFactor : 0;

    final double _totalCounterBoxHeight = _counterHeight + (2 * _counterPaddingValue);

    final double _concludedHeight = (textPadding?.top ?? 0 + (textPadding?.bottom ?? 0))
                                  + (_minLines * _textHeight)
                                  + _bottomMargin
                                  + _totalCounterBoxHeight;

    return _concludedHeight + 4; // THE 4 IS A MAGIC NUMBER
  }
  // --------------------------------------------------------------------------

  /// STYLING

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextStyle createHintStyle({
    required double textHeight,
    required bool textItalic,
    required String? font,
  }) {

    return createTextStyle(
      color: const Color.fromARGB(80, 255, 255, 255),
      italic: textItalic,
      textHeight: textHeight * 0.8,
      fontFamily: font,
    );

  }
    // --------------------
  /// TESTED : WORKS PERFECT
  static TextStyle createErrorStyle({
    required double textHeight,
    required bool textItalic,
    required String? font,
    Color? errorTextColor,
  }){

    return createTextStyle(
      color: errorTextColor ?? const Color.fromARGB(255, 233, 0, 0),
      // fontWeight: FontWeight.w100,
      textHeight: textHeight * 0.95,
      italic: true,
      fontFamily: font,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static OutlineInputBorder createOutlineBorder({
    required Color borderColor,
    required dynamic corners,
  }) {
    return OutlineInputBorder(
      borderRadius: Borderers.superCorners(corners: corners),
      borderSide: BorderSide(
        color: borderColor,
        width: 0.5,
      ),
      gapPadding: 0,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static InputDecoration createDecoration({
    required double? textHeight,
    required String? hintText,
    required bool textItalic,
    required dynamic corners,
    required Color? fieldColor,
    required bool counterIsOn,
    required Color? errorTextColor,
    required EdgeInsets? textPadding,
    required Color focusedBorderColor,
    required Color enabledBorderColor,
    required Color focusedErrorBorderColor,
    required Color errorBorderColor,
    required String? font,
    required TextDirection? hintTextDirection,
  }){

    final double _textHeight = textHeight ?? 20;

    final InputDecoration _inputDecoration = InputDecoration(
      hintText: hintText,
      hintMaxLines: 1,
      hintStyle: createHintStyle(
        textHeight: _textHeight,
        textItalic: textItalic,
        font: font,
      ),
      hintTextDirection: hintTextDirection,
      alignLabelWithHint: true,
      contentPadding: textPadding ?? EdgeInsets.symmetric(horizontal: _textHeight * 0.2,),

      focusedBorder: createOutlineBorder(
        borderColor: focusedBorderColor,
        corners: corners,
      ),
      enabledBorder: createOutlineBorder(
        borderColor: enabledBorderColor,
        corners: corners,
      ),
      errorStyle: createErrorStyle(
        textItalic: textItalic,
        textHeight: _textHeight,
        errorTextColor: errorTextColor,
        font: font,
      ),
      errorMaxLines: 3,
      // errorText: 'initial state error text',

      focusedErrorBorder: createOutlineBorder(
        borderColor: focusedErrorBorderColor,
        corners: corners,
      ),
      errorBorder: createOutlineBorder(
        borderColor: errorBorderColor,
        corners: corners,
      ),
      border: createOutlineBorder(
          borderColor: enabledBorderColor,
          corners: corners
      ),
      disabledBorder: createOutlineBorder(
        borderColor: Colorz.nothing,
        corners: corners,
      ),

      // counter: counterIsOn == true ? null : const Offstage(),

      // counterText: '${widget.textController?.text?.length} / ${widget.maxLength}',
      counterText: '',
      counterStyle: createTextStyle(textHeight: 0), // to finally eradicate the lower space el kalb

      // SOME BULLSHIT
      isDense: false,
      // isCollapsed: false,
      // semanticCounterText: 'semantic',
      focusColor: const Color.fromARGB(255, 24, 157, 14),
      filled: true,
      fillColor: fieldColor,

      // helperText: 'helper',
      // errorText: 'there is some error here',
      // icon: WebsafeSvg.asset(Iconz.DvRageh, height: 20),
    );

    return _inputDecoration;
  }
  // --------------------------------------------------------------------------

  /// COUNTER

  // --------------------
  static const double counterTextHeightFactor = 0.8;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Widget textFieldCounter({
    required int? currentLength,
    required int? maxLength,
    required double? textHeight,
    required Color? fieldColor,
    required String? font,
    required double? letterSpacing,
    required bool appIsLTR,
    required TextDirection textDirection,
  }){

    final double _textHeight = textHeight ?? 20;
    final int _currentLength = currentLength ?? 0;
    final int _maxLength = maxLength ?? 10;

    final String _text = appIsLTR == true ?
    '$_maxLength / $_currentLength'
        :
    '$_currentLength / $_maxLength';

    return SizedBox(
      width: _textHeight * 4,
      height: _textHeight,
      child: SuperText(
      boxWidth: _textHeight * 4,
      text: _text,
      weight: FontWeight.w100,
      textHeight: _textHeight * counterTextHeightFactor,
      boxColor: _currentLength > _maxLength ? const Color.fromARGB(125, 233, 0, 0) : fieldColor,
      font: font,
      letterSpacing: letterSpacing,
      textDirection: textDirection == TextDirection.rtl ? TextDirection.ltr : TextDirection.rtl,
      appIsLTR: appIsLTR,
      centered: false,
      margins: 0,
    ),
    );

  }
  // --------------------------------------------------------------------------

  /// SCROLL PADDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets adaptiveScrollPadding({
    required BuildContext context,
  }){

    final EdgeInsets _insets = Scale.screenInsets(context);

    final EdgeInsets _scrollPadding = EdgeInsets.only(
      bottom: 100 + _insets.bottom,
      top: 100 + _insets.top,
    );

    return _scrollPadding;
  }
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? bakeValidator({
    required String? Function(String? text)? validator,
    required String? text,
    bool keepEmbeddedBubbleColor = false,
  }){

    if (validator == null){
      return null;
    }

    else {

      if (keepEmbeddedBubbleColor == true){
        return validator(text);
      }

      else {
        return _bakeValidatorMessage(validator(text));
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _bakeValidatorMessage(String? message){
    String? _output;

    if (message != null){
      _output = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: message,
          specialCharacter: 'Δ',
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
