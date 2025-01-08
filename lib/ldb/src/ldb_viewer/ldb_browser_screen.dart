part of ldb;

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
          child: VerticalFloatingList(
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
