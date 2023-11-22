

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
  # --------------------------------------------------------------------------------
 */

class BldrsThemeFonts {
  // -----------------------------------------------------------------------------
  static const String fontBldrsHeadlineFont = 'BldrsHeadlineFont';
  static const String fontBldrsBodyFont = 'BldrsBodyFont';
  static const String fontEnglishHeadline = 'EnglishHeadline';
  static const String fontEnglishBody = 'EnglishBody';
  static const String fontArabicHeadline = 'ArabicHeadline';
  static const String fontArabicBody = 'ArabicBody';
  static const String fontBldrsLogo = 'BldrsLogoFont';
  // -----------------------------------------------------------------------------
  final List<String> allFonts = <String>[
    fontBldrsHeadlineFont,
    fontBldrsBodyFont,
    fontEnglishHeadline,
    fontEnglishBody,
    fontArabicHeadline,
    fontArabicBody,
    fontBldrsLogo,
  ];
  // -----------------------------------------------------------------------------
}
