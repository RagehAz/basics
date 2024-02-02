import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/layouts/handlers/max_bounce_navigator.dart';
import 'package:basics/layouts/layouts/basic_layout.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/components/drawing/separator_line.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/ldb/ldb_viewer/ldb_viewer_screen.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:flutter/material.dart';

class LDBBrowserScreen extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LDBBrowserScreen({
    required this.docs,
  super.key
  });
  final List<String> docs;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToLDBViewer(BuildContext context, String ldbDocName) async {
    await Nav.goToNewScreen(
        appIsLTR: true,
        context: context,
        screen: LDBViewerScreen(
          ldbDocName: ldbDocName,
        )
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(docs) == false){
      return const Center(
          child: SuperText(
              text: 'No Docs found'
          )
      );
    } else {

      return BasicLayout(
        body: MaxBounceNavigator(
          child: FloatingList(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            columnChildren: <Widget>[

              Row(
                children: <Widget>[

                  SuperBox(
                    height: 40,
                    width: 40,
                    icon: Iconz.back,
                    iconSizeFactor: 0.6,
                    onTap: () => Nav.goBack(context: context),
                    margins: const EdgeInsets.symmetric(horizontal: 5),
                  ),

                  const SuperBox(
                    height: 40,
                    text: 'All LDB Docs :-',
                    textFont: BldrsThemeFonts.fontHead,
                    textItalic: true,
                    textWeight: FontWeight.w600,
                    textColor: Colorz.white200,
                  ),

                ],
              ),

              const SeparatorLine(),

              ...List<Widget>.generate(docs.length, (int index) {

                  final String ldbDoc = docs[index];

                  /// HEADLINE
                  if (ldbDoc.startsWith('headline') == true) {
                    return SuperText(
                      text: TextMod.removeTextBeforeFirstSpecialCharacter(
                          text: ldbDoc,
                          specialCharacter: ':',
                      ),
                      font: BldrsThemeFonts.fontHead,
                      weight: FontWeight.w600,
                      italic: true,
                      margins: 10,
                      textHeight: 40,
                      centered: false,
                      appIsLTR: true,
                      // textDirection: TextDirection.ltr,
                    );
                  }

                  /// BUTTON
                  else {
                    return SuperBox(
                      height: 40,
                      text: ldbDoc, // notifications prefs, my user model
                      onTap: () => goToLDBViewer(context, ldbDoc),
                      icon: Iconz.info,
                      iconSizeFactor: 0.6,
                      color: Colorz.bloodTest,
                      margins: 5,
                    );
                  }
                }),

            ],
          ),
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------
}
