import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// -----------------------------------------------------------------------------

/// SWITCHER

// --------------------
AssetPickerTextDelegate getPickerTextDelegateByLangCode(String? langCode) {
  switch (langCode) {
    case 'en':return const EnglishAssetPickerTextDelegate();
    case 'ar':return const ArabicAssetPickerTextDelegate();
    case 'es':return const SpanishAssetPickerTextDelegate();
    case 'it':return const ItalianAssetPickerTextDelegate();
    case 'de':return const GermanAssetPickerTextDelegate();
    case 'fr':return const FrenchAssetPickerTextDelegate();
    case 'zh':return const AssetPickerTextDelegate();
    case 'vi':return const VietnameseAssetPickerTextDelegate();
    case 'ru':return const RussianAssetPickerTextDelegate();
    case 'ja':return const JapaneseAssetPickerTextDelegate();
    default: return const EnglishAssetPickerTextDelegate();
  }
}
// -----------------------------------------------------------------------------

/// EXTRA DELEGATES

// --------------------
class SpanishAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const SpanishAssetPickerTextDelegate();

  @override
  String get languageCode => 'es';

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get edit => 'Editar';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Error al cargar';

  @override
  String get original => 'Original';

  @override
  String get preview => 'Vista previa';

  @override
  String get select => 'Seleccionar';

  @override
  String get emptyList => 'Lista vacía';

  @override
  String get unSupportedAssetType => 'Tipo de archivo HEIC no compatible.';

  @override
  String get unableToAccessAll => 'No se pueden acceder a todos los archivos en el dispositivo';

  @override
  String get viewingLimitedAssetsTip =>
      'Solo ver activos y álbumes accesibles para la aplicación.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Haz clic para actualizar los activos accesibles';

  @override
  String get accessAllTip => 'La aplicación solo puede acceder a algunos activos en el dispositivo. '
      'Ve a la configuración del sistema y permite que la aplicación acceda a todos los activos en el dispositivo.';

  @override
  String get goToSystemSettings => 'Ir a la configuración del sistema';

  @override
  String get accessLimitedAssets => 'Continuar con acceso limitado';

  @override
  String get accessiblePathName => 'Activos accesibles';

  @override
  String get sTypeAudioLabel => 'Audio';

  @override
  String get sTypeImageLabel => 'Imagen';

  @override
  String get sTypeVideoLabel => 'Video';

  @override
  String get sTypeOtherLabel => 'Otro archivo';

  @override
  String get sActionPlayHint => 'reproducir';

  @override
  String get sActionPreviewHint => 'vista previa';

  @override
  String get sActionSelectHint => 'seleccionar';

  @override
  String get sActionSwitchPathLabel => 'cambiar ruta';

  @override
  String get sActionUseCameraHint => 'usar cámara';

  @override
  String get sNameDurationLabel => 'duración';

  @override
  String get sUnitAssetCountLabel => 'cantidad';
}
// --------------------
class ItalianAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const ItalianAssetPickerTextDelegate();

  @override
  String get languageCode => 'it';

  @override
  String get confirm => 'Conferma';

  @override
  String get cancel => 'Annulla';

  @override
  String get edit => 'Modifica';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Caricamento fallito';

  @override
  String get original => 'Originale';

  @override
  String get preview => 'Anteprima';

  @override
  String get select => 'Seleziona';

  @override
  String get emptyList => 'Lista vuota';

  @override
  String get unSupportedAssetType => 'Tipo di file HEIC non supportato.';

  @override
  String get unableToAccessAll => 'Impossibile accedere a tutti gli elementi nel dispositivo';

  @override
  String get viewingLimitedAssetsTip =>
      "Visualizza solo gli elementi e gli album accessibili all'app.";

  @override
  String get changeAccessibleLimitedAssets =>
      'Clicca per aggiornare gli elementi accessibili';

  @override
  String get accessAllTip => "L'app può accedere solo ad alcuni elementi nel dispositivo. "
      "Vai alle impostazioni del sistema e permetti all'app di accedere a tutti gli elementi nel dispositivo.";

  @override
  String get goToSystemSettings => 'Vai alle impostazioni del sistema';

  @override
  String get accessLimitedAssets => 'Continua con accesso limitato';

  @override
  String get accessiblePathName => 'Elementi accessibili';

  @override
  String get sTypeAudioLabel => 'Audio';

  @override
  String get sTypeImageLabel => 'Immagine';

  @override
  String get sTypeVideoLabel => 'Video';

  @override
  String get sTypeOtherLabel => 'Altro elemento';

  @override
  String get sActionPlayHint => 'riproduci';

  @override
  String get sActionPreviewHint => 'anteprima';

  @override
  String get sActionSelectHint => 'seleziona';

  @override
  String get sActionSwitchPathLabel => 'cambia percorso';

  @override
  String get sActionUseCameraHint => 'usa la fotocamera';

  @override
  String get sNameDurationLabel => 'durata';

  @override
  String get sUnitAssetCountLabel => 'conteggio';
}
// -----------------------------------------------------------------------------
