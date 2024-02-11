// ignore_for_file: non_constant_identifier_names
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/bubbles/bubble/bubble_header.dart';
import 'package:basics/components/bubbles/model/bubble_header_vm.dart';
import 'package:basics/helpers/colors/colorizer.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:basics/components/texting/super_text_field/super_text_field.dart';
import 'package:flutter/material.dart';

class TileBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TileBubble({
    this.bubbleHeaderVM,
    this.bubbleWidth,
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.onTileTap,
    this.secondLine,
    this.secondLineColor = const Color.fromARGB(200, 255, 255, 255),
    this.secondLineTextHeight = 15,
    this.iconIsBubble = true,
    this.insideDialog = false,
    this.moreBtOnTap,
    this.child,
    this.bulletPoints,
    this.bubbleColor = const Color.fromARGB(10, 255, 255, 255),
    this.validator,
    this.autoValidate = true,
    this.textDirection,
    this.appIsLTR = true,
    this.focusNode,
    this.font,
    this.bulletPointsMaxLines = 10,
    this.hasBottomPadding = true,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? bubbleWidth;
  final BubbleHeaderVM? bubbleHeaderVM;
  final Color? textColor;
  final Function? onTileTap;
  final String? secondLine;
  final Color? secondLineColor;
  final double? secondLineTextHeight;
  final bool iconIsBubble;
  final bool insideDialog;
  final Function? moreBtOnTap;
  final Widget? child;
  final List<String>? bulletPoints;
  final Color? bubbleColor;
  final String? Function()? validator;
  final bool autoValidate;
  final bool appIsLTR;
  final TextDirection? textDirection;
  final String? font;
  final FocusNode? focusNode;
  final int bulletPointsMaxLines;
  final bool hasBottomPadding;
  /// --------------------------------------------------------------------------
  static const double iconBoxWidth = 30; /// delete me 5alas (im in BubbleHeader class)
  // -----------------------------------------------------------------------------

  /// COLOR CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color? validatorBubbleColor({
    required String? Function()? validator,
    Color? defaultColor = const Color.fromARGB(10, 255, 255, 255),
    bool canErrorize = true,
  }){

    bool _errorIsOn = false;
    Color? _errorColor;
    if (validator != null){
      // ------
      /// MESSAGE
      final String? _validationMessage = validator();
      // ------
      /// ERROR IS ON
      _errorIsOn = _validationMessage != null;
      // ------
      /// BUBBLE COLOR OVERRIDE
      final bool _colorAssigned = TextCheck.stringContainsSubString(string: _validationMessage, subString: 'Δ');
      if (_colorAssigned == true){
        final String? _colorCode = TextMod.removeTextAfterFirstSpecialCharacter(
            text: _validationMessage,
            specialCharacter: 'Δ',
        );
        _errorColor = Colorizer.decipherColor(_colorCode);
      }
      // ------
    }

    if (_errorIsOn == true && canErrorize == true){
      return _errorColor ?? const Color.fromARGB(150, 94, 6, 6);
    }
    else {
      return defaultColor;
    }

  }
  // -----------------------------------------------------------------------------

  /// COLOR CYPHERS

  // --------------------
  static double childWidth({
    required BuildContext context,
    double? bubbleWidthOverride,
  }) {

    final double _bubbleWidth = Bubble.bubbleWidth(
      context: context,
      bubbleWidthOverride: bubbleWidthOverride,
    );

    return _bubbleWidth - iconBoxWidth - (2 * 10);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.bubbleWidth(
      context: context,
      bubbleWidthOverride: bubbleWidth,
    );
    final double _clearWidth = Bubble.clearWidth(
      context: context,
      bubbleWidthOverride: _bubbleWidth,
    );
    final double _childWidth = childWidth(
      context: context,
      bubbleWidthOverride: _bubbleWidth,
    );

    return Bubble(
      bubbleHeaderVM: const BubbleHeaderVM(),
      width: _bubbleWidth,
      onBubbleTap: onTileTap,
      bubbleColor: validatorBubbleColor(
        // canErrorize: true,
        defaultColor: bubbleColor,
        validator: validator,
      ),
      hasBottomPadding: hasBottomPadding,
      columnChildren: <Widget>[

        /// BUBBLE HEADER
        if (bubbleHeaderVM != null)
        BubbleHeader(
          viewModel: bubbleHeaderVM!.copyWith(
            headerWidth: _clearWidth,
            font: font,
            textDirection: textDirection,
            appIsLTR: appIsLTR,
            centered: false,
          ),
        ),

        /// BULLET POINTS
        Padding(
          padding: Scale.superInsets(
            context: context,
            appIsLTR: appIsLTR,
            enLeft: iconBoxWidth,
          ),
          child: BulletPoints(
            bulletPoints: bulletPoints,
            textHeight: 20,
            boxWidth: _childWidth,
            appIsLTR: appIsLTR,
            textDirection: textDirection ?? TextDirection.ltr,
            maxLines: bulletPointsMaxLines,
            font: font,
            showBottomLine: false,
          ),
        ),

        /// SECOND LINE
        if (secondLine != null)
          SizedBox(
            width: _bubbleWidth,
            child: Row(
              children: <Widget>[

                /// UNDER LEADING ICON AREA
                const SizedBox(
                  width: iconBoxWidth,
                ),

                /// SECOND LINE
                SizedBox(
                  width: _childWidth,
                  child: SuperText(
                    text: secondLine,
                    textColor: secondLineColor,
                    textHeight: secondLineTextHeight,
                    // scaleFactor: 1,
                    italic: true,
                    maxLines: 100,
                    centered: false,
                    weight: FontWeight.w100,
                    margins: 5,
                    textDirection: textDirection ?? TextDirection.ltr,
                    appIsLTR: appIsLTR,
                    font: font,
                  ),
                ),

              ],
            ),
          ),

        /// CHILD
        if (child != null)
          SizedBox(
            width: _bubbleWidth,
            // height: 200,
            // padding: const EdgeInsets.symmetric(horizontal: 5),
            // color: Colorz.Yellow255,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                /// UNDER LEADING ICON AREA
                const SizedBox(
                  width: iconBoxWidth,
                ),

                /// CHILD
                Container(
                  width: childWidth(context: context, bubbleWidthOverride: _bubbleWidth),
                  // decoration: BoxDecoration(
                  //     color: Colorz.white10,
                  //     borderRadius: Borderers.superBorderAll(context, Bubble.clearCornersValue)
                  // ),
                  alignment: Alignment.center,
                  child: child,
                ),

              ],
            ),
          ),

        if (validator != null)
          SuperValidator(
            width: _clearWidth,
            validator: () => validator?.call(),
            autoValidate: autoValidate,
            font: bubbleHeaderVM?.font,
            focusNode: focusNode,
          ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
