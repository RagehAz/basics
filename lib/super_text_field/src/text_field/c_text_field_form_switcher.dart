import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/super_text/super_text.dart';
import 'package:basics/super_text_field/super_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldSwitcher extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TextFormFieldSwitcher({
    /// main
    required this.isFormField,
    required this.controller,
    required this.hintText,
    required this.hintTextDirection,
    required this.autoFocus,
    required this.focusNode,
    required this.counterIsOn,
    required this.autoValidate,

    /// box
    required this.corners,

    /// text
    required this.textDirection,
    required this.appIsLTR,
    required this.obscured,
    required this.centered,
    required this.minLines,
    required this.maxLines,
    required this.maxLength,
    required this.scrollController,

    /// keyboard
    required this.textInputAction,
    required this.textInputType,

    /// styling
    required this.fontWeight,
    required this.textColor,
    required this.textItalic,
    required this.textShadows,
    required this.fieldColor,
    required this.package,
    required this.textFont,
    required this.letterSpacing,
    required this.wordSpacing,

    /// functions
    required this.onTap,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSavedForForm,
    required this.onEditingComplete,
    required this.validator,

    required this.cursorColor,

    required this.scrollPadding,
    required this.textHeight,

    required this.errorTextColor,
    required this.textPadding,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.focusedErrorBorderColor,

    super.key
  }); 
  /// --------------------------------------------------------------------------
  // main
  final bool isFormField;
  final TextEditingController? controller;
  final String? hintText;
  final TextDirection? hintTextDirection;
  final bool autoFocus;
  final FocusNode? focusNode;
  final bool counterIsOn;
  final bool autoValidate;

  /// box
  final dynamic corners;

  /// keyboard
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  /// TEXT
  final TextDirection textDirection;
  final bool appIsLTR;
  final bool obscured;
  final bool centered;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final ScrollController? scrollController;

  /// STYLING
  final FontWeight? fontWeight;
  final Color? textColor;
  final bool textItalic;
  final double? textHeight;
  final List<Shadow>? textShadows;
  final Color? fieldColor;
  final String? package;
  final String? textFont;
  final double? letterSpacing;
  final double? wordSpacing;

  /// functions
  final Function? onTap;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final ValueChanged<String?>? onSavedForForm;
  final Function? onEditingComplete;
  final String? Function(String? text)? validator;
  final Color? cursorColor;

  final EdgeInsets? scrollPadding;

  final Color? errorTextColor;
  final EdgeInsets? textPadding;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;

    /// TESTED : WORKS PERFECT
  static Color? validatorTextColor({
    required String? message,
    required Color? errorColor,
  }){
    Color? _color;

    if (message != null){

      final bool _colorAssigned = TextCheck.stringContainsSubString(
          string: message,
          subString: 'Δ',
      );

      // blog('getValidatorTextColor : _colorAssigned : $_colorAssigned');

      /// SO WHEN ERROR IS ON + BUBBLE HAS COLOR OVERRIDE
      if (_colorAssigned == true){
        _color = errorColor;
      }

    }

    return _color;
  }
  // -----------------------------------------------------------------------------
  ///
  Widget counterBuilder(
      BuildContext context, {
    int? currentLength,
    bool isFocused = false,
    int? maxLength,
  }){
    return SuperTextFieldController.textFieldCounter(
      currentLength: currentLength,
      maxLength: maxLength,
      fieldColor: fieldColor,
      textHeight: textHeight,
      letterSpacing: letterSpacing,
      appIsLTR: appIsLTR,
      textDirection: textDirection,
      font: textFont,
    );
  }
  // --------------------
    String? _validator(String? text, {bool keepColor = false}){
      return SuperTextFieldController.bakeValidator(
        validator: validator,
        text: text,
        keepEmbeddedBubbleColor: keepColor,
      );
    }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _textHeight = textHeight ?? 20;
    // --------------------
    final TextStyle _style = createTextStyle(
      /// DUNNO
      // inherit: inherit,
      // debugLabel: debugLabel,
      // locale: locale,
      package: package,
      /// FONT
      fontFamily: textFont,
      // fontFeatures: fontFeatures,
      // fontFamilyFallback: fontFamilyFallback,
      /// COLOR
      color: textColor,
      // backgroundColor: backgroundColor, /// NO NEED
      /// SIZE
      textHeight: _textHeight,
      /// WEIGHT
      fontWeight: fontWeight,
      /// SPACING
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      /// STYLE
      italic: textItalic,
      // textBaseline: TextBaseline.alphabetic,
      shadows: textShadows,
      // overflow: TextOverflow.ellipsis,
      /// DECORATION
      // decorationColor: lineColor,
      // decoration: line,
      // decorationStyle: lineStyle,
      // decorationThickness: lineThickness,
      /// PAINTS
      // foreground: foreground,
      // background: background,
    );
    // --------------------
    final InputDecoration _inputDecoration = SuperTextFieldController.createDecoration(
      textHeight: _textHeight,
      hintText: hintText, // ?? '...' TASK : TAKE CARE OF DEFAULT DOTS
      hintTextDirection: hintTextDirection,
      textItalic: textItalic,
      corners: corners,
      fieldColor: fieldColor,
      counterIsOn: counterIsOn,
      errorTextColor: TextFormFieldSwitcher.validatorTextColor(
        errorColor: errorTextColor,
        message: _validator(controller?.text, keepColor: true),
      ),
      textPadding: textPadding,
      enabledBorderColor: enabledBorderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      focusedErrorBorderColor: focusedErrorBorderColor,
      font: textFont,
    );
    // --------------------
    final TextAlign _textAlign = SuperTextFieldController.getTextAlignment(
        centered: centered,
    );
    // --------------------
    const MaxLengthEnforcement _maxLengthEnforced = MaxLengthEnforcement.none;
    // --------------------
    final int _maxLines = obscured == true ? 1 : (maxLines ?? 1);
    // --------------------
    const TextAlignVertical _textAlignVertical = TextAlignVertical.center;
    // --------------------
    final TextInputType _keyboardType = SuperTextFieldController.getKeyboardType(
      textInputAction: textInputAction,
      textInputType: textInputType,
    );
    // --------------------
    final EdgeInsets _scrollPadding = scrollPadding ?? SuperTextFieldController.adaptiveScrollPadding(
        context: context,
    );
    // -----------------------------------------------------------------------------
    /// WHEN TEXT FORM FIELD
    if (isFormField == true){
      return TextFormField(
        /// main
        // key: fieldKey ?? key,
        controller: controller,
        autofocus: autoFocus,
        focusNode: focusNode,
        /// scrolling
        scrollPhysics: const BouncingScrollPhysics(),
        scrollPadding: _scrollPadding,
        enableInteractiveSelection: true,
        /// text
        textDirection: textDirection,
        obscureText: obscured,
        minLines: minLines,
        maxLines: _maxLines,
        maxLength: maxLength, /// NO IMPACT
        maxLengthEnforcement: _maxLengthEnforced,
        scrollController: scrollController,
        /// keyboard
        textInputAction: textInputAction,
        keyboardType: _keyboardType,
        keyboardAppearance: Brightness.dark,
        /// styling
        style: _style,
        textAlign: _textAlign,
        cursorColor: cursorColor,
        cursorRadius: const Radius.circular(3),
        decoration: _inputDecoration,
        textAlignVertical: _textAlignVertical,
        /// counter
        buildCounter: counterIsOn == true ? counterBuilder : null,
        /// functions
        onTap: onTap == null ? null : () => onTap!(),
        onChanged: onChanged == null ? null : (String val) => onChanged!(val),
        onFieldSubmitted: onSubmitted == null ? null : (String val) => onSubmitted!(val),
        onSaved: onSavedForForm == null ? null : (String? val) => onSavedForForm!(val),
        onEditingComplete: onEditingComplete == null ? null : () => onEditingComplete!(),
        validator: _validator,
        autovalidateMode: autoValidate == true ?
        AutovalidateMode.always
            :
        AutovalidateMode.disabled,
        /// other stuff
        enabled: true, /// THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
        autocorrect: false,
        // initialValue: ,
        // restorationId: ,
        // autofillHints: ,
        // cursorHeight: ,
        // cursorWidth: ,
        // enableIMEPersonalizedLearning: ,
        // enableInteractiveSelection: ,
        // enableSuggestions: ,
        // expands: ,
        // inputFormatters: [],
        // mouseCursor: ,
        // obscuringCharacter: ,
        // readOnly: ,
        // selectionControls: ,
        // showCursor: ,
        // smartDashesType: ,
        // smartQuotesType: ,
        // strutStyle: ,
        // textCapitalization: ,
        // toolbarOptions: ,

      );
    }
    // --------------------
    /// WHEN TEXT FIELD
    else {
      return TextField(
        /// main
        // key: key,
        controller: controller,
        autofocus: autoFocus,
        focusNode: focusNode,
        /// scrolling
        scrollPhysics: const BouncingScrollPhysics(),
        scrollPadding: _scrollPadding,
        /// text
        textDirection: textDirection,
        obscureText: obscured,
        minLines: minLines,
        maxLines: _maxLines,
        maxLength: maxLength, /// NO IMPACT
        maxLengthEnforcement: _maxLengthEnforced,
        scrollController: scrollController,
        /// keyboard
        textInputAction: textInputAction,
        keyboardType: _keyboardType,
        keyboardAppearance: Brightness.dark,
        /// styling
        style: _style,
        textAlign: _textAlign,
        cursorColor: cursorColor,
        cursorRadius: const Radius.circular(3),
        decoration: _inputDecoration,
        textAlignVertical: _textAlignVertical,
        /// counter
        buildCounter: counterIsOn == true ? counterBuilder : null,
        /// functions
        onTap: onTap == null ? null : () => onTap!(),
        onChanged: onChanged == null ? null :  (String val) => onChanged!(val),
        onSubmitted: onSubmitted == null ? null : (String val) => onSubmitted!(val),
        onEditingComplete: onEditingComplete == null ? null : () => onEditingComplete!(),
        /// other stuff
        enabled: true, /// THIS DISABLES THE ABILITY TO OPEN THE KEYBOARD
        autocorrect: false,
        // toolbarOptions: ,
        // textCapitalization: ,
        // strutStyle: ,
        // smartQuotesType: ,
        // smartDashesType: ,
        // showCursor: ,
        // selectionControls: ,
        // readOnly: ,
        // obscuringCharacter: ,
        // mouseCursor: ,
        // inputFormatters: [],
        // expands: ,
        // enableSuggestions: ,
        // enableInteractiveSelection: ,
        // enableIMEPersonalizedLearning: ,
        // cursorWidth: ,
        // cursorHeight: ,
        // autofillHints: ,
        // restorationId: ,
        // clipBehavior: ,
        // dragStartBehavior: ,
        // onAppPrivateCommand: ,
        // scribbleEnabled: ,
        // selectionHeightStyle: ,
        // selectionWidthStyle: ,

      );
    }
    // -----------------------------------------------------------------------------
  }
  // -----------------------------------------------------------------------------
}
