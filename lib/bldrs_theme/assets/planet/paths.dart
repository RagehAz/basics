
class WorldZoningPaths {
  // -----------------------------------------------------------------------------

  const WorldZoningPaths();

  static const String _planetDirectory      = 'packages/basics/lib/bldrs_theme/assets/planet';
  // -----------------------------------------------------------------------------
  static const String flagsDirectory        = '$_planetDirectory/flags';
  // --------------------
  /// CITIES
  static const String citiesFilesDirectory  = '$_planetDirectory/cities';
  static const String populationsFilePath   = '$_planetDirectory/populations.json';
  static const String positionsFilePath     = '$_planetDirectory/positions.json';
  // --------------------
  static String getCountryCitiesJsonFilePath(String countryID){
    return '$citiesFilesDirectory/$countryID.json';
  }
  // --------------------
  /// CONTINENTS
  static const continentsJsonPath           = '$_planetDirectory/continents.json';
  // --------------------
  /// CURRENCIES
  static const String currenciesFilePath    = '$_planetDirectory/currencies.json';
  // -----------------------------------------------------------------------------
}
