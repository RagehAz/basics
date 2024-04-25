import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/classes/shadowers.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:flutter/material.dart';

enum BottomDialogType {
  countries,
  cities,
  districts,
  languages,
  bottomSheet,
}

class BottomDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BottomDialog({
    this.height,
    this.draggable = true,
    this.child,
    this.title,
    this.corners = Ratioz.bottomSheetCorner,
    this.padding = standardPadding,
    this.dialogColor,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? height;
  final bool draggable;
  final Widget? child;
  final String? title;
  final double corners;
  final double padding;
  final Color? dialogColor;
  // --------------------------------------------------------------------------

  /// PADDINGS

  // --------------------
  static const double standardPadding = 15;
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets getDialogPaddings({
    required double padding,
  }){
    return EdgeInsets.only(
      left: padding,
      right: padding,
      top: padding,
    );
  }
  // --------------------------------------------------------------------------

  /// DRAGGER

  // --------------------
  /// TESTED : WORKS PERFECT
  static double draggerMarginValue({
    /// one side value only
    required bool draggable
  }) {
    final double _draggerHeight = draggerHeight(draggable: draggable);
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerMarginValue = draggable != true ? 0 : (_draggerZoneHeight - _draggerHeight) / 2;
    return _draggerMarginValue;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets draggerMargins({
    required bool draggable
  }) {
    final EdgeInsets _draggerMargins = EdgeInsets.symmetric(
        vertical: draggerMarginValue(
            draggable: draggable
        )
    );
    return _draggerMargins;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double draggerZoneHeight({
    required bool draggable
  }) {
    final double _draggerZoneHeight = draggable == true ? 10 * 3.0 : 0;
    return _draggerZoneHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double draggerHeight({
    required bool draggable
  }) {
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerHeight = _draggerZoneHeight * 0.35 * 0.5;
    return _draggerHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double draggerWidth(BuildContext context) {
    final double _draggerWidth = Scale.screenWidth(context) * 0.35;
    return _draggerWidth;
  }
  // --------------------------------------------------------------------------

  /// TITLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double titleZoneHeight({
    required bool? titleIsOn,
  }) {
    bool _titleIsOn;

    if (titleIsOn == null) {
      _titleIsOn = false;
    } else {
      _titleIsOn = titleIsOn;
    }

    final double _titleZoneHeight = _titleIsOn == true ?
    Ratioz.appBarSmallHeight
        :
    0;

    return _titleZoneHeight;
  }
  // --------------------------------------------------------------------------

  /// MAIN SCALES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateDialogHeight({
    required bool draggable,
    required bool titleIsOn,
    required double childHeight,
  }){
    final double _draggerHeight = draggerZoneHeight(draggable: draggable);
    final double _titleHeight = titleZoneHeight(titleIsOn: titleIsOn);

    final double _topZoneHeight = _draggerHeight + _titleHeight + childHeight;

    return _topZoneHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double dialogHeight({
    required BuildContext context,
    double ratioOfScreenHeight =  0.5,
    double? overridingDialogHeight,
  }) {
    double _dialogHeight;

    final double _screenHeight = Scale.screenHeight(context);

    if (overridingDialogHeight == null) {
      _dialogHeight = _screenHeight * ratioOfScreenHeight;
    }

    else {
      _dialogHeight = overridingDialogHeight;
    }

    return _dialogHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double dialogWidth(BuildContext context) {
    return Scale.screenWidth(context);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius dialogCorners({
    required BuildContext context,
    required double? corners,
  }) {
    final BorderRadius _dialogCorners = Borderers.cornerOnly(
      appIsLTR: true,
      enTopLeft: corners ?? Ratioz.bottomSheetCorner,
      enBottomLeft: 0,
      enBottomRight: 0,
      enTopRight: corners ?? Ratioz.bottomSheetCorner,
    );
    return _dialogCorners;
  }
  // --------------------------------------------------------------------------

  /// CLEAR SCALES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double clearWidth({
    required BuildContext context,
    double padding = standardPadding,
  }) {

    final double _dialogClearWidth  = Scale.screenWidth(context)
                                    - (padding * 2);

    return _dialogClearWidth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double clearHeight({
    required BuildContext context,
    required bool draggable,
    double padding = standardPadding,
    double? overridingDialogHeight,
    bool? titleIsOn,
  }) {

    // bool _draggable = draggable == null ? false : draggable;

    final double _dialogHeight = dialogHeight(
      context: context,
      overridingDialogHeight: overridingDialogHeight,
      // ratioOfScreenHeight: ,
    );

    final double _titleZoneHeight = titleZoneHeight(titleIsOn: titleIsOn);
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    return _dialogHeight - _titleZoneHeight - _draggerZoneHeight - padding;
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static double dialogClearCornerValue({
    required double? corner,
    required double padding,
  }) {
    final double _corner = corner ?? Ratioz.appBarCorner;
    return _corner - padding;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius dialogClearCorners({
    required BuildContext context,
    required double corners,
    required double padding,
  }) {

    final double _clearValue = dialogClearCornerValue(
      corner: corners,
      padding: padding,
    );

    final BorderRadius _corners = Borderers.cornerOnly(
      appIsLTR: true,
      enBottomRight: 0,
      enBottomLeft: 0,
      enTopRight: _clearValue,
      enTopLeft: _clearValue,
    );

    return _corners;
  }
  // --------------------------------------------------------------------------

  /// SHOWING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showBottomDialog({
    required BuildContext context,
    required bool draggable,
    required Widget child,
    Color? backgroundColor,
    Color? dialogColor,
    double? height,
    String? title,
    double corners = Ratioz.bottomSheetCorner,
    double padding = standardPadding,
  }) async {

    final double _height = height ?? BottomDialog.dialogHeight(
      context: context,
      // ratioOfScreenHeight: 0.5,
      // overridingDialogHeight: ,
    );

    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: Borderers.cornerOnly(
              appIsLTR: true,
              enTopLeft: corners,
              enBottomLeft: 0,
              enBottomRight: 0,
              enTopRight: corners,
            )
        ),
        backgroundColor: dialogColor ?? Colorz.blackSemi255,
        barrierColor: backgroundColor ?? Colorz.black150,
        enableDrag: draggable,
        elevation: 20,
        isScrollControlled: true,
        context: context,
        builder: (_) {

          return StatefulBuilder(
              builder: (BuildContext xxx, state){

                // final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(xxx, listen: false);

                return SizedBox(
                  height: _height,
                  width: Scale.screenWidth(context),
                  child: Scaffold(
                    backgroundColor: Colorz.nothing,
                    resizeToAvoidBottomInset: false,
                    body: BottomDialog(
                      height: _height,
                      draggable: draggable,
                      title: title,
                      corners: corners,
                      padding: padding,
                      dialogColor: dialogColor,
                      child: child,
                    ),
                  ),
                );

              }
          );

        }
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showButtonsBottomDialog({
    required BuildContext context,
    required bool draggable,
    required int numberOfWidgets,
    required List<Widget> Function(BuildContext, Function? setState) builder,
    double buttonHeight = wideButtonHeight,
    String? title,
    Color? backgroundColor,
    Color? dialogColor,
    double corners = Ratioz.bottomSheetCorner,
    double padding = standardPadding,
  }) async {

    final double _spacing = buttonHeight * 0.1;

    await showStatefulBottomDialog(
      context: context,
      draggable: draggable,
      height: Scale.screenHeight(context) * 0.5,
      title: title,
      backgroundColor: backgroundColor,
      dialogColor: dialogColor,
      corners: corners,
      // padding: standardPadding,
      builder: (BuildContext ctx, Function? setState){

        final List<Widget> _widgets = builder(ctx, setState);

        return ListView.builder(
          itemCount: _widgets.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
          itemBuilder: (_, int index) {
            return Column(
              children: <Widget>[
                _widgets[index],
                SizedBox(height: _spacing),
              ],
              // children: builder(ctx, _phraseProvider),
            );
            },
        );

      },
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showStatefulBottomDialog({
    required BuildContext context,
    required Widget Function(BuildContext, Function setState) builder,
    required String? title,
    double padding = standardPadding,
    double corners = Ratioz.bottomSheetCorner,
    bool draggable = true,
    double? height,
    Color? backgroundColor,
    Color? dialogColor,
  }) async {

    final double _height = height ?? BottomDialog.dialogHeight(
      context: context,
      // ratioOfScreenHeight: 0.5,
      // overridingDialogHeight: ,
    );

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BottomDialog.dialogCorners(
          context: context,
          corners: corners,
        ),
      ),

      backgroundColor: dialogColor ?? Colorz.blackSemi255,
      barrierColor: backgroundColor ?? Colorz.black150,
      enableDrag: draggable,
      elevation: 20,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => SizedBox(
          height: _height,
          width: Scale.screenWidth(context),
          child: Scaffold(
            backgroundColor: Colorz.nothing,
            resizeToAvoidBottomInset: false,
            body: BottomDialog(
              height: _height,
              draggable: draggable,
              title: title,
              padding: padding,
              corners: corners,
              dialogColor: dialogColor,
              child: StatefulBuilder(
                builder: (_, Function setState){

                  return builder(context, setState);

                },
              ),
            ),
          )),
    );
  }
  // --------------------
  static const double wideButtonHeight = 45;
  // --------------------
  static Widget wideButton({
    required BuildContext context,
    String? text,
    Future<void> Function()? onTap,
    dynamic icon,
    double height = wideButtonHeight,
    bool verseCentered = false,
    bool isDisabled = false,
    Function? onDisabledTap,
    Color? color,
    Color textColor = Colorz.white255,
    Color? iconColor,
    double margin = standardPadding,
  }) {

    return SuperBox(
      height: height,
      width: clearWidth(
        context: context,
        padding: margin,
      ),
      text: text,
      textScaleFactor: 1.1,
      // verseItalic: false,
      icon: icon,
      iconSizeFactor: 0.6,
      iconColor: iconColor,
      textCentered: verseCentered,
      textMaxLines: 2,
      onTap: onTap,
      isDisabled: isDisabled,
      onDisabledTap: onDisabledTap,
      color: color,
      textColor: textColor,
      textFont: BldrsThemeFonts.fontHead,
      textItalic: true,
    );

  }
  // --------------------
  bool _titleIsOnCheck() {
    bool _isOn;

    if (title == null || TextMod.removeSpacesFromAString(title) == '') {
      _isOn = false;
    }

    else {
      _isOn = true;
    }

    return _isOn;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _dialogWidth = dialogWidth(context);
    final double _dialogHeight = dialogHeight(context: context, overridingDialogHeight: height);
    final BorderRadius _dialogCorners = dialogCorners(
      context: context,
      corners: corners,
    );
    // --------------------
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerHeight = draggerHeight(draggable: draggable);
    final double _draggerWidth = draggerWidth(context);
    final double _draggerCorner = _draggerHeight * 0.5;
    final EdgeInsets _draggerMargins = draggerMargins(draggable: draggable);
    // --------------------
    final bool _titleIsOn = _titleIsOnCheck();
    final double _titleZoneHeight = titleZoneHeight(titleIsOn: _titleIsOn);
    // --------------------
    final double _dialogClearWidth = clearWidth(
      context: context,
      padding: padding,
    );
    final double _dialogClearHeight = clearHeight(
      context: context,
      titleIsOn: _titleIsOn,
      overridingDialogHeight: height,
      draggable: draggable,
      padding: padding,
    );
    // --------------------
    final BorderRadius _dialogClearCorners = dialogClearCorners(
      context: context,
      corners: corners,
      padding: padding,
    );
    // --------------------
    return Container(
      width: _dialogWidth,
      height: _dialogHeight,
      decoration: BoxDecoration(
        color: dialogColor ?? Colorz.white10,
        borderRadius: _dialogCorners,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// --- SHADOW LAYER
          Container(
            width: _dialogWidth,
            height: _dialogHeight,
            decoration: BoxDecoration(
              borderRadius: _dialogCorners,
              boxShadow: Shadower.appBarShadow,
            ),
          ),

          // /// --- BLUR LAYER
          // BlurLayer(
          //   width: _dialogWidth,
          //   height: _dialogHeight,
          //   borders: _dialogCorners,
          // ),

          /// --- DIALOG CONTENTS
          SizedBox(
            width: _dialogWidth,
            height: _dialogHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                /// --- DRAGGER
                if (draggable == true)
                  Container(
                    width: _dialogWidth,
                    height: _draggerZoneHeight,
                    alignment: Alignment.center,
                    // color: Colorz.BloodTest,
                    child: Container(
                      width: _draggerWidth,
                      height: _draggerHeight,
                      margin: _draggerMargins,
                      decoration: BoxDecoration(
                        color: Colorz.white200,
                        borderRadius:
                        Borderers.cornerAll(_draggerCorner),
                      ),
                    ),
                  ),

                /// --- TITLE
                if (TextCheck.isEmpty(title) == false)
                  Container(
                    width: _dialogWidth,
                    height: _titleZoneHeight,
                    alignment: Alignment.center,
                    // color: Colorz.BloodTest,
                    child: FittedBox(
                      child: SuperText(
                        text: title,
                        textHeight: _titleZoneHeight * 0.8,
                        font: BldrsThemeFonts.fontHead,
                        margins: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),

                /// --- DIALOG CONTENT
                Container(
                  width: _dialogClearWidth,
                  height: _dialogClearHeight,
                  decoration: BoxDecoration(
                    color: Colorz.white10,
                    borderRadius: _dialogClearCorners,
                    // gradient: Colorizer.superHeaderStripGradient(Colorz.White20)
                  ),
                  child: ClipRRect(
                    borderRadius: _dialogClearCorners,
                    child: child,
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
// --------------------
}
