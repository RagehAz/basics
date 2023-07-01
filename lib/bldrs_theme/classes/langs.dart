

class BldrsThemeLangs {
  // -----------------------------------------------------------------------------

  const BldrsThemeLangs();

  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const List<String> langCodes = <String>[
    'en',
    'ar',
    'es',
    'fr',
    'zh',
    'de',
    'it',
  ];
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static String? getLangFilePath({
    required String? langCode,
  }){

    if (langCode == null) {
      return null;
    }

    else {
      return 'packages/basics/super_stop_watch/bldrs_theme/assets/languages/$langCode.json';
    }

  }
  // -----------------------------------------------------------------------------
}
