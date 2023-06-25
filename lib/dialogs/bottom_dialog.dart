import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/classes/shadowers.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:basics/super_text/super_text.dart';
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
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? height;
  final bool draggable;
  final Widget? child;
  final String? title;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double draggerMarginValue({
    /// one side value only
    required bool draggable
  }) {
    final double _draggerHeight = draggerHeight(draggable: draggable);
    final double _draggerZoneHeight = draggerZoneHeight(draggable: draggable);
    final double _draggerMarginValue =
    draggable != true ? 0 : (_draggerZoneHeight - _draggerHeight) / 2;
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
    final double _draggerZoneHeight = draggable == true ? 10 * 3.0 : 0.0;
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
  static double dialogWidth(BuildContext context) {
    return Scale.screenWidth(context);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const double dialogMarginValue = 15;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const EdgeInsets dialogMargins = EdgeInsets.symmetric(
      horizontal: dialogMarginValue
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static double clearWidth(BuildContext context) {
    final double _dialogClearWidth  = Scale.screenWidth(context)
                                    - (dialogMarginValue * 2);

    return _dialogClearWidth;
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
  static double clearHeight({
    required BuildContext context,
    required bool draggable,
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
    return _dialogHeight - _titleZoneHeight - _draggerZoneHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius dialogCorners(BuildContext context) {
    final BorderRadius _dialogCorners = Borderers.cornerOnly(
      appIsLTR: true,
      enTopLeft: Ratioz.bottomSheetCorner,
      enBottomLeft: 0,
      enBottomRight: 0,
      enTopRight: Ratioz.bottomSheetCorner,
    );
    return _dialogCorners;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double dialogClearCornerValue({double? corner}) {
    return corner ?? Ratioz.appBarCorner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius dialogClearCorners(BuildContext context) {
    final BorderRadius _corners = Borderers.cornerOnly(
      appIsLTR: true,
      enBottomRight: 0,
      enBottomLeft: 0,
      enTopRight: dialogClearCornerValue(),
      enTopLeft: dialogClearCornerValue(),
    );
    return _corners;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showBottomDialog({
    required BuildContext context,
    required bool draggable,
    required Widget child,
    double? height,
    String? title,
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
              enTopLeft: Ratioz.bottomSheetCorner,
              enBottomLeft: 0,
              enBottomRight: 0,
              enTopRight: Ratioz.bottomSheetCorner,
            )
        ),
        backgroundColor: Colorz.blackSemi255,
        barrierColor: Colorz.black150,
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
    double buttonHeight = wideButtonHeight,
    List<Widget> Function(BuildContext)? builder,
    String? title,
  }) async {

    final double _spacing = buttonHeight * 0.1;

    await showStatefulBottomDialog(
      context: context,
      draggable: draggable,
      height: Scale.screenHeight(context) * 0.5,
      title: title,
      builder: (BuildContext ctx, title){

        if (builder == null){
          return const SizedBox();
        }

        else {

          final List<Widget> _widgets = builder(ctx);

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

        }
      },
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showStatefulBottomDialog({
    required BuildContext context,
    required Widget Function(BuildContext, Function setState) builder,
    required String? title,
    bool draggable = true,
    double? height,
  }) async {

    final double _height = height ?? BottomDialog.dialogHeight(
      context: context,
      // ratioOfScreenHeight: 0.5,
      // overridingDialogHeight: ,
    );

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BottomDialog.dialogCorners(context),
      ),
      backgroundColor: Colorz.blackSemi255,
      barrierColor: Colorz.black150,
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
    String? icon,
    double height = wideButtonHeight,
    bool verseCentered = false,
    bool isDisabled = false,
    Function? onDeactivatedTap,
    Color? color,
  }) {

    return SuperBox(
      height: height,
      width: clearWidth(context),
      text: text,
      textScaleFactor: 1.1,
      // verseItalic: false,
      icon: icon,
      iconSizeFactor: 0.6,
      textCentered: verseCentered,
      textMaxLines: 2,
      onTap: onTap,
      isDisabled: isDisabled,
      onDisabledTap: onDeactivatedTap,
      color: color,
      textFont: BldrsThemeFonts.fontBldrsHeadlineFont,
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
    final BorderRadius _dialogCorners = dialogCorners(context);
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
    final double _dialogClearWidth = clearWidth(context);
    final double _dialogClearHeight = clearHeight(
        context: context,
        titleIsOn: _titleIsOn,
        overridingDialogHeight: height,
        draggable: draggable
    );
    // --------------------
    final BorderRadius _dialogClearCorners = dialogClearCorners(context);
    // --------------------
    return Container(
      width: _dialogWidth,
      height: _dialogHeight,
      decoration: BoxDecoration(
        color: Colorz.white10,
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
                if (title != null)
                  Container(
                    width: _dialogWidth,
                    height: _titleZoneHeight,
                    alignment: Alignment.center,
                    // color: Colorz.BloodTest,
                    child: SuperText(
                      text: title,
                      font: BldrsThemeFonts.fontBldrsHeadlineFont,
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
                  child: child,
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
