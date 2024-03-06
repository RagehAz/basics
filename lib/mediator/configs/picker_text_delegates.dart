import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// -----------------------------------------------------------------------------

/// SWITCHER : BLDRS_SUPPORTED_LANGS

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

    case 'tr':return const TurkishAssetPickerTextDelegate();
    case 'hi':return const HindiAssetPickerTextDelegate();
    case 'ru':return const RussianAssetPickerTextDelegate();
    case 'pt':return const PortugueseAssetPickerTextDelegate();
    case 'fa':return const FarsiAssetPickerTextDelegate();

    case 'vi':return const VietnameseAssetPickerTextDelegate();
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
// --------------------
class TurkishAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const TurkishAssetPickerTextDelegate();

  @override
  String get languageCode => 'tr';

  @override
  String get confirm => 'Onayla';

  @override
  String get cancel => 'İptal';

  @override
  String get edit => 'Düzenle';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Yüklenemedi';

  @override
  String get original => 'Orijinal';

  @override
  String get preview => 'Önizleme';

  @override
  String get select => 'Seç';

  @override
  String get emptyList => 'Boş liste';

  @override
  String get unSupportedAssetType => 'Desteklenmeyen HEIC dosya türü.';

  @override
  String get unableToAccessAll => 'Cihazdaki tüm ögeler erişilebilir değil';

  @override
  String get viewingLimitedAssetsTip =>
      'Sadece uygulamanın erişebildiği ögeleri ve albümleri görüntüle.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Erişilebilir ögeleri güncellemek için tıklayın';

  @override
  String get accessAllTip =>
      'Uygulama cihazdaki bazı ögelere erişebilir. '
      'Sistem ayarlarına gidin ve uygulamanın cihazdaki tüm ögelere erişmesine izin verin.';

  @override
  String get goToSystemSettings => 'Sistem ayarlarına git';

  @override
  String get accessLimitedAssets => 'Sınırlı erişimle devam et';

  @override
  String get accessiblePathName => 'Erişilebilir ögeler';

  @override
  String get sTypeAudioLabel => 'Ses';

  @override
  String get sTypeImageLabel => 'Görüntü';

  @override
  String get sTypeVideoLabel => 'Video';

  @override
  String get sTypeOtherLabel => 'Diğer öge';

  @override
  String get sActionPlayHint => 'oynat';

  @override
  String get sActionPreviewHint => 'önizleme';

  @override
  String get sActionSelectHint => 'seç';

  @override
  String get sActionSwitchPathLabel => 'yolu değiştir';

  @override
  String get sActionUseCameraHint => 'kamerayı kullan';

  @override
  String get sNameDurationLabel => 'süre';

  @override
  String get sUnitAssetCountLabel => 'adet';
}
// --------------------
class HindiAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const HindiAssetPickerTextDelegate();

  @override
  String get languageCode => 'hi';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get edit => 'संपादित करें';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'लोड विफल';

  @override
  String get original => 'मूल';

  @override
  String get preview => 'पूर्वावलोकन';

  @override
  String get select => 'चयन करें';

  @override
  String get emptyList => 'खाली सूची';

  @override
  String get unSupportedAssetType => 'असमर्थित HEIC एसेट प्रकार।';

  @override
  String get unableToAccessAll => 'डिवाइस पर सभी एसेट्स तक पहुँच नहीं सका';

  @override
  String get viewingLimitedAssetsTip =>
      'केवल उन एसेट्स और एल्बम्स को देखें जिन्हें ऐप तक पहुँच है।';

  @override
  String get changeAccessibleLimitedAssets =>
      'पहुँचने योग्य एसेट्स को अपडेट करने के लिए क्लिक करें';

  @override
  String get accessAllTip =>
      'ऐप केवल डिवाइस पर कुछ एसेट्स तक पहुँच सकता है। '
      'सिस्टम सेटिंग्स में जाएं और ऐप को डिवाइस पर सभी एसेट्स तक पहुँचने की अनुमति दें।';

  @override
  String get goToSystemSettings => 'सिस्टम सेटिंग्स में जाएं';

  @override
  String get accessLimitedAssets => 'सीमित पहुँच के साथ जारी रखें';

  @override
  String get accessiblePathName => 'पहुँचने योग्य एसेट्स';

  @override
  String get sTypeAudioLabel => 'ऑडियो';

  @override
  String get sTypeImageLabel => 'छवि';

  @override
  String get sTypeVideoLabel => 'वीडियो';

  @override
  String get sTypeOtherLabel => 'अन्य एसेट';

  @override
  String get sActionPlayHint => 'प्ले करें';

  @override
  String get sActionPreviewHint => 'पूर्वावलोकन';

  @override
  String get sActionSelectHint => 'चुनें';

  @override
  String get sActionSwitchPathLabel => 'पथ बदलें';

  @override
  String get sActionUseCameraHint => 'कैमरा उपयोग करें';

  @override
  String get sNameDurationLabel => 'अवधि';

  @override
  String get sUnitAssetCountLabel => 'गणना';
}
// --------------------
class PortugueseAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const PortugueseAssetPickerTextDelegate();

  @override
  String get languageCode => 'pt';

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get edit => 'Editar';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Falha ao carregar';

  @override
  String get original => 'Original';

  @override
  String get preview => 'Visualizar';

  @override
  String get select => 'Selecionar';

  @override
  String get emptyList => 'Lista vazia';

  @override
  String get unSupportedAssetType => 'Tipo de recurso HEIC não suportado.';

  @override
  String get unableToAccessAll => 'Não foi possível acessar todos os recursos do dispositivo';

  @override
  String get viewingLimitedAssetsTip =>
      'Apenas visualize recursos e álbuns acessíveis ao aplicativo.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Clique para atualizar os recursos acessíveis';

  @override
  String get accessAllTip =>
      'O aplicativo só pode acessar alguns recursos no dispositivo. '
      'Acesse as configurações do sistema e permita que o aplicativo acesse todos os recursos do dispositivo.';

  @override
  String get goToSystemSettings => 'Ir para as configurações do sistema';

  @override
  String get accessLimitedAssets => 'Continuar com acesso limitado';

  @override
  String get accessiblePathName => 'Recursos acessíveis';

  @override
  String get sTypeAudioLabel => 'Áudio';

  @override
  String get sTypeImageLabel => 'Imagem';

  @override
  String get sTypeVideoLabel => 'Vídeo';

  @override
  String get sTypeOtherLabel => 'Outro recurso';

  @override
  String get sActionPlayHint => 'reproduzir';

  @override
  String get sActionPreviewHint => 'visualizar';

  @override
  String get sActionSelectHint => 'selecionar';

  @override
  String get sActionSwitchPathLabel => 'mudar caminho';

  @override
  String get sActionUseCameraHint => 'usar câmera';

  @override
  String get sNameDurationLabel => 'duração';

  @override
  String get sUnitAssetCountLabel => 'quantidade';
}
// --------------------
class FarsiAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const FarsiAssetPickerTextDelegate();

  @override
  String get languageCode => 'fa';

  @override
  String get confirm => 'تایید';

  @override
  String get cancel => 'لغو';

  @override
  String get edit => 'ویرایش';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'بارگذاری ناموفق بود';

  @override
  String get original => 'اصلی';

  @override
  String get preview => 'پیش‌نمایش';

  @override
  String get select => 'انتخاب';

  @override
  String get emptyList => 'لیست خالی';

  @override
  String get unSupportedAssetType => 'نوع فرمت HEIC پشتیبانی نمی‌شود.';

  @override
  String get unableToAccessAll => 'قادر به دسترسی به همه منابع در دستگاه نیست';

  @override
  String get viewingLimitedAssetsTip =>
      'تنها منابع و آلبوم‌هایی که اپلیکیشن به آن دسترسی دارد را مشاهده کنید.';

  @override
  String get changeAccessibleLimitedAssets =>
      'برای به‌روزرسانی منابع قابل دسترسی، کلیک کنید';

  @override
  String get accessAllTip =>
      'اپلیکیشن تنها می‌تواند به برخی از منابع دسترسی پیدا کند. '
      'به تنظیمات سیستم بروید و به اپلیکیشن اجازه دسترسی به تمام منابع را بدهید.';

  @override
  String get goToSystemSettings => 'به تنظیمات سیستم بروید';

  @override
  String get accessLimitedAssets => 'ادامه با دسترسی محدود';

  @override
  String get accessiblePathName => 'منابع قابل دسترسی';

  @override
  String get sTypeAudioLabel => 'صدا';

  @override
  String get sTypeImageLabel => 'تصویر';

  @override
  String get sTypeVideoLabel => 'ویدیو';

  @override
  String get sTypeOtherLabel => 'منبع دیگر';

  @override
  String get sActionPlayHint => 'پخش';

  @override
  String get sActionPreviewHint => 'پیش‌نمایش';

  @override
  String get sActionSelectHint => 'انتخاب';

  @override
  String get sActionSwitchPathLabel => 'تغییر مسیر';

  @override
  String get sActionUseCameraHint => 'استفاده از دوربین';

  @override
  String get sNameDurationLabel => 'مدت زمان';

  @override
  String get sUnitAssetCountLabel => 'تعداد';
}
// -----------------------------------------------------------------------------
