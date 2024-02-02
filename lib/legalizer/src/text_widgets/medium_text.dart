part of legalizer;

class MediumText extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const MediumText(
      this.text,
      {
  super.key
  });  // -----------------------------------------------------------------------------
  final String text;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperText(
      boxWidth: Scale.screenWidth(context),
      text: text,
      weight: FontWeight.w200,
      centered: false,
      margins: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      maxLines: 100,
      font: BldrsThemeFonts.fontBody,
      textHeight: 30,
      appIsLTR: true,
      // textDirection: TextDirection.ltr,
    );

  }
// -----------------------------------------------------------------------------
}
