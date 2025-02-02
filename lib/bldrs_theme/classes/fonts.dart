/// NOTES TO USE THESE FONTS IN ANOTHER PROJECT
/*
 YOU SHOULD ADD THE BELOW SECTION IN pubspec.yaml in the project that uses these fonts

  # ------------------------------------
  fonts:
    - family: BldrsHeadlineFont
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/bldrs_font_bold.ttf

    - family: BldrsBodyFont
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/bldrs_font_regular.ttf

    - family: EnglishHeadline
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/arabic/BldrsFont.ttf

    - family: EnglishBody
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/english/Roboto_Thin.ttf
        - asset: packages/bldrs_theme/assets/fonts/english/Roboto_ThinItalic.ttf

    - family: ArabicHeadline
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/arabic/BldrsFont.ttf

    - family: ArabicBody
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/arabic/Tajawal_Light.ttf
        - asset: packages/bldrs_theme/assets/fonts/arabic/Tajawal_Regular.ttf
        - asset: packages/bldrs_theme/assets/fonts/arabic/BldrsFont.ttf

    - family: Almarai
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/Almarai-Light.ttf

    - family: Lalezar
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/Lalezar-Regular.ttf

    - family: Mochiy
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/MochiyPopOne-Regular.ttf

    - family: Palanquin
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/PalanquinDark-SemiBold.ttf

    - family: RussoOne
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/RussoOne-Regular.ttf

    - family: Yuji
      fonts:
        - asset: packages/bldrs_theme/assets/fonts/YujiSyuku-Regular.ttf



  # --------------------------------------------------------------------------------
 */

class BldrsThemeFonts {
  // -----------------------------------------------------------------------------
  static const String fontHead = 'head';
  static const String fontBody = 'body';
  // -----------------------------------------------------------------------------
  static const List<String> allFonts = <String>[
    fontHead,
    fontBody,
  ];
  // -----------------------------------------------------------------------------
}
