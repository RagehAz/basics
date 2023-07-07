part of legalizer;

class CopyrightsLine extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CopyrightsLine({
    required this.isArabic,
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
  // --------------------------------------------------------------------------
  String _getLine({
    required bool isArabic,
  }){

    if (isArabic) {
      return '© 2023 NET.BLDRS.LLC. جميع الحقوق محفوظة.';
    }
    else {
      return 'Copyright © 2023 NET.BLDRS.LLC. All rights reserved.';
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
        ),
        textHeight: textHeight,
        font: BldrsThemeFonts.fontBldrsBodyFont,
        textColor: textColor,
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        maxLines: 4,
      ),
    );

  }
  // --------------------------------------------------------------------------
}
