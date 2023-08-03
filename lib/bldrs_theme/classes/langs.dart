

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
    'it',
    'fr',
    'de',
    'zh',
  ];
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static String getLangFilePath({
    required String? langCode,
  }){
    final String _langCode = langCode ?? 'en';
    return 'packages/basics/lib/bldrs_theme/assets/languages/$_langCode.json';

  }
  // -----------------------------------------------------------------------------
}
