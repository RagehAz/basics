import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/classes/shadowers.dart';
import 'package:basics/components/sensors/keyboard_sensor.dart';
import 'package:basics/components/sensors/popper.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/components/drawing/separator_line.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:flutter/material.dart';

class CenterDialog extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CenterDialog({
    required this.bubble,
    required this.backgroundColor,
  super.key
  });  // --------------------------------------------------------------------------
  final Widget bubble;
  final Color? backgroundColor;
  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getWidth(BuildContext context) {
    return Scale.screenShortestSide(context) * 0.85;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double clearWidth(BuildContext context){
    return getWidth(context) - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  static const double dialogCornerValue = 20;
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius dialogBorders() {
    return Borderers.cornerAll(dialogCornerValue);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getHeight({
    required BuildContext context,
    double? heightOverride,
  }) {
    final double _screenHeight = Scale.screenHeight(context);
    final double _height = heightOverride ?? _screenHeight * 0.4;
    return _height;
  }
  // -----------------------------------------------------------------------------

  /// COLORS

  // --------------------
  static const Color activeButtonColor = Colorz.yellow255;
  static const Color defaultButtonColor = Colorz.white50;
  // -----------------------------------------------------------------------------

  /// LAUNCHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> showCenterDialog({
    required BuildContext context,
    required Widget bubble,
    Function(BuildContext ctx)? onDialogContextCreated,
    Color? backgroundColor,
  }) async {

    final bool? _result = await showDialog(
      context: context,
      builder: (BuildContext ctx){

        if (onDialogContextCreated != null) {
          onDialogContextCreated(ctx);
        }

        return CenterDialog(
          backgroundColor: backgroundColor,
          bubble: bubble,
        );
      },
    );

    return Mapper.boolIsTrue(_result);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeCenterDialog(BuildContext dialogContext) async {

    await Future.delayed(Duration.zero, (){
      Navigator.pop(dialogContext);
    });

  }
  // --------------------
  /*
//   static double dialogVerticalMargin({BuildContext context, double dialogHeight}){
//     double _screenHeight = Scale.superScreenHeight(context);
//     return (_screenHeight - dialogHeight) / 2;
//   }
// // -----------------------------------------------------------------------------
//   static double dialogHorizontalMargin({BuildContext context, double dialogWidth}){
//     double _screenWidth = Scale.superScreenWidth(context);
//     return (_screenWidth - dialogWidth) / 2;
//   }
   */
  // -----------------------------------------------------------------------------

  /// BUTTONS

  // --------------------
  ///
  static Widget yesNoButtons({
    required BuildContext context,
    String? textFont,
    bool appIsLTR = true,
    TextDirection textDirection = TextDirection.ltr,
    Function? onOk,
    String yesText = 'yes',
    String noText = 'no',
    bool boolDialog = false,
    bool invertButtons = false,
    Color activeButtonColor = Colorz.black255,
    Color defaultButtonColor = Colorz.white50,
    Color activeTextColor = Colorz.white255,
    Color defaultTextColor = Colorz.black255,
  }){
    // --------------------
    final double _dialogWidth = getWidth(context);
    const double _buttonHeight = DialogButton.height;
    const double _buttonZoneHeight = _buttonHeight + (2 * Ratioz.appBarPadding);

      final Color _activeButtonColor = activeButtonColor;
      final Color _defaultButtonColor = defaultButtonColor;
    // --------------------
    return SizedBox(
      width: _dialogWidth,
      height: _buttonZoneHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// NO BUTTON
          if (boolDialog == true && invertButtons == false)
            DialogButton(
              text: noText,
              color: _defaultButtonColor,
              textColor: defaultTextColor,
              onTap: () => Nav.goBack(
                context: context,
                invoker: 'CenterDialog.No',
                passedData: false,
              ),
              font: textFont,
              appIsLTR: appIsLTR,
              textDirection: textDirection,

            ),

          /// YES BUTTON
          DialogButton(
            text: yesText,
            textColor: invertButtons == true ? defaultTextColor : activeTextColor,
            font: textFont,
            textDirection: textDirection,
            appIsLTR: appIsLTR,
            color: invertButtons == true ? _defaultButtonColor : _activeButtonColor,
            onTap: () async {

              if (boolDialog == true){
                await Nav.goBack(
                  context: context,
                  invoker: 'CenterDialog.yes',
                  passedData: true,
                  addPostFrameCallback: true,
                );
              }
              
              else {
                if (onOk != null){
                  onOk();
                }
                else {
                  await Nav.goBack(
                    context: context,
                    invoker: 'CenterDialog.ok',
                    addPostFrameCallback: true,
                  );
                }
                
              }
              
            },
          ),

          /// NO BUTTON
          if (boolDialog == true && invertButtons == true)
            DialogButton(
              text: noText,
              appIsLTR: appIsLTR,
              textDirection: textDirection,
              font: textFont,
              textColor: activeTextColor,
              color: _activeButtonColor,
              onTap: () => Nav.goBack(
                context: context,
                invoker: 'CenterDialog.No',
                passedData: false,
                addPostFrameCallback: true,
              ),
            ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------
  ///
  static Widget buildBubble({
    required BuildContext context,
    required bool? boolDialog,
    Widget? buttons,
    double? height,
    BorderRadius? borders,
    bool appIsLTR = true,
    TextDirection textDirection = TextDirection.ltr,
    Function? onTap,
    Color boxColor = Colorz.white255,
    String? title,
    Color titleColor = Colorz.black255,
    String? titleFont,
    double titleTextHeight = 25,
    String? body,
    String? bodyFont,
    Color bodyColor = Colorz.black255,
    bool bodyCentered = true,
    double bodyTextHeight = 20,
    Widget? child,
  }){

      // --------------------
      final BorderRadius _dialogBorders = borders ?? dialogBorders();
      // --------------------
      final double _dialogHeight = getHeight(
        context: context,
        heightOverride: height,
      );
      // --------------------
      final double _dialogWidth = getWidth(context);
      // --------------------

      return GestureDetector(
        onTap: () async {
          if (onTap != null) {
            onTap();
          }
          /// TO CLOSE OPEN KEYBOARD
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          width: _dialogWidth,
          // height: _dialogHeight,
          constraints: BoxConstraints(
            minHeight: _dialogHeight,
          ),
          decoration: BoxDecoration(
            color: boxColor,
            boxShadow: Shadower.appBarShadow,
            borderRadius: _dialogBorders,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// TITLE
              if (title != null)
              Container(
                width: _dialogWidth,
                alignment: Alignment.center,
                // color: Colorz.BloodTest,
                child: SuperText(
                  boxWidth: _dialogWidth * 0.9,
                  text: title,
                  textColor: titleColor,
                  // shadows: true,
                  textHeight: titleTextHeight,
                  italic: true,
                  maxLines: 2,
                  // labelColor: Colorz.Yellow,
                  margins: const EdgeInsets.only(
                    top: 20,
                    bottom: 5,
                    left: Ratioz.appBarMargin,
                    right: Ratioz.appBarMargin,
                  ),
                  appIsLTR: appIsLTR,
                  textDirection: textDirection,
                  font: titleFont,
                ),
              ),

              /// BODY
              if (TextCheck.isEmpty(body) == false)
                SizedBox(
                  width: _dialogWidth,
                  // height: _bodyZoneHeight,
                  child: SuperText(
                    boxWidth: _dialogWidth * 0.9,
                    text: body,
                    textHeight: bodyTextHeight,
                    maxLines: 20,
                    margins: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: Ratioz.appBarMargin * 2,
                    ),
                    centered: bodyCentered,
                    font: bodyFont,
                    appIsLTR: appIsLTR,
                    textDirection: textDirection,
                    textColor: bodyColor,
                  ),
                ),

              /// CHILD
              if (child != null)
                Column(
                  children: <Widget>[

                    SeparatorLine(
                      width: _dialogWidth,
                    ),

                    Container(
                      width: _dialogWidth,
                      constraints: BoxConstraints(
                        maxHeight: _dialogHeight * 0.6,
                      ),
                      child:
                          SingleChildScrollView(physics: const BouncingScrollPhysics(), child: child),
                    ),

                    SeparatorLine(
                      width: _dialogWidth,
                    ),

                  ],
                ),

              /// BUTTONS
              if (boolDialog != null && buttons != null)
                buttons,

            ],
          ),
        ),
      );
    }
  // -----------------------------------------------------------------------------

  /// DIALOG BUBBLE + CONTENTS

  // --------------------
  Widget buildDialogScreenTree({
    required BuildContext context,
  }){

    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: GestureDetector(
        onTap: () async {
          await Nav.goBack(
            context: context,
            invoker: 'CenterDialog tapping outside the dialog',
            );
          },
          child: KeyboardSensor(
              child: bubble,
              builder: ({required Widget? child, required bool isVisible}){

                final double _keyboardHeight = isVisible == true ? context.screenInsets.bottom : 0;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: _screenWidth,
                  // height: ,
                  constraints: BoxConstraints(
                    minHeight: isVisible == true ?
                    (_screenHeight - _keyboardHeight * 0.5)
                        :
                    _screenHeight,
                  ),
                  alignment: Alignment.center,
                  color: Colorz.nothing,
                  // to let parent gesture detector detect this container
                  child: child,
                );

              }
          ),
        ),
      );

    }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
    return Popper(
      key: const ValueKey<String>('Center_dialog'),
      canGoBack: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor ?? Colorz.black80,
          resizeToAvoidBottomInset: true,
          body: AlertDialog(
            backgroundColor: Colorz.nothing,
            // shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
            contentPadding: EdgeInsets.zero,
            elevation: 10,

            insetPadding: EdgeInsets.zero,

            content: Builder(
              builder: (BuildContext xxx) {

                return WidgetFader(
                  fadeType: FadeType.fadeIn,
                  min: 0.7,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOutCirc,
                  builder: (double value, Widget? child){

                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: child,
                      ),
                    );

                  },
                  child: buildDialogScreenTree(context: context),
                );

              },
            ),
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------
}

class DialogButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DialogButton({
    required this.text,
    this.textColor = Colorz.white255,
    this.width = 100,
    this.color = Colorz.nothing,
    this.onTap,
    this.italic = true,
    this.appIsLTR = true,
    this.textDirection = TextDirection.ltr,
    this.font,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final String? text;
  final Color textColor;
  final double width;
  final Color color;
  final Function? onTap;
  final bool italic;
  final bool appIsLTR;
  final TextDirection textDirection;
  final String? font;
  /// --------------------------------------------------------------------------
  static const double height = 50;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperBox(
      height: height,
      width: width,
      margins: const EdgeInsets.all(Ratioz.appBarPadding),
      text: text,
      textWeight: FontWeight.w600,
      textItalic: true,
      textMaxLines: 2,
      textColor: textColor,
      color: color,
      textScaleFactor: 0.6,
      appIsLTR: appIsLTR,
      textDirection: textDirection,
      textFont: font,
      onTap: onTap,
    );
  }
  /// --------------------------------------------------------------------------
}
