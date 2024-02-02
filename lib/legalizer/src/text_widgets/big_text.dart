part of legalizer;

class BigText extends StatelessWidget {
// -----------------------------------------------------------------------------
  const BigText(
      this.text,
      {
        super.key,
      });
  // -----------------------------------------------------------------------------
  final String text;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperText(
      boxWidth: Scale.screenWidth(context),
      text: text,
      weight: FontWeight.w600,
      textHeight: 45,
      centered: false,
      maxLines: 2,
      italic: true,
      textColor: Colorz.yellow125,
      margins: const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 20),
      font: BldrsThemeFonts.fontHead,
      appIsLTR: true,
      // textDirection: TextDirection.ltr,
    );

  }
// -----------------------------------------------------------------------------
}
