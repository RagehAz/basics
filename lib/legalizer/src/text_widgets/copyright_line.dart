part of legalizer;

class CopyrightsLine extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CopyrightsLine({
    required this.isArabic,
    required this.companyName,
    this.textHeight = 20,
    this.textColor = Colorz.white255,
    this.text,
      super.key
  });
  // --------------------------------------------------------------------------
  final double textHeight;
  final Color textColor;
  final bool isArabic;
  final String? text;
  final String companyName;
  // --------------------------------------------------------------------------
  String _getLine({
    required bool isArabic,
    required String companyName,
  }){

    if (isArabic) {
      return '© 2023 $companyName. جميع الحقوق محفوظة.';
    }
    else {
      return 'Copyright © 2023 $companyName. All rights reserved.';
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: Scale.screenWidth(context),
      alignment: Alignment.center,
      child: SuperText(
        text: text ?? _getLine(
          isArabic: isArabic,
          companyName: companyName,
        ),
        textHeight: textHeight,
        font: BldrsThemeFonts.fontBody,
        textColor: textColor,
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        maxLines: 4,
      ),
    );

  }
  // --------------------------------------------------------------------------
}
