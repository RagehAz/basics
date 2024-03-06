import 'package:wechat_camera_picker/wechat_camera_picker.dart';
// -----------------------------------------------------------------------------

/// SWITCHER : BLDRS_SUPPORTED_LANGS

// --------------------
CameraPickerTextDelegate getCameraTextDelegateByLangCode(String? langCode) {
  switch (langCode) {

    case 'en':return const EnglishCameraPickerTextDelegate();
    case 'ar':return const ArabicCameraPickerTextDelegate();

    case 'es':return const SpanishCameraPickerTextDelegate();
    case 'it':return const ItalianCameraPickerTextDelegate();
    case 'de':return const GermanCameraPickerTextDelegate();
    case 'fr':return const FrenchCameraPickerTextDelegate();
    case 'zh':return const CameraPickerTextDelegate();

    case 'tr':return const TurkishCameraPickerTextDelegate();
    case 'hi':return const HindiCameraPickerTextDelegate();
    case 'ru':return const RussianCameraPickerTextDelegate();
    case 'pt':return const PortugueseCameraPickerTextDelegate();
    case 'fa':return const FarsiCameraPickerTextDelegate();

    case 'vi':return const VietnameseCameraPickerTextDelegate();

    default: return const EnglishCameraPickerTextDelegate();
  }
}
// -----------------------------------------------------------------------------

/// EXTRA DELEGATES

// --------------------
class ArabicCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const ArabicCameraPickerTextDelegate();

  @override
  String get languageCode => 'ar';

  @override
  String get confirm => 'تأكيد';

  @override
  String get shootingTips => 'اضغط للتصوير';

  @override
  String get shootingWithRecordingTips => 'اضغط لتصوير صورة، و اضغط طويلا لتسجيل فيديو';

  @override
  String get shootingOnlyRecordingTips => 'اضغط طويلا لتسجيل فيديو';

  @override
  String get shootingTapRecordingTips => 'اضغط لتسجيل فيديو';

  @override
  String get loadFailed => 'فشلت عميلة التحميل';

  @override
  String get loading => 'جاري التحميل ...';

  @override
  String get saving => 'جاري الحفظ ...';

  @override
  String get sActionManuallyFocusHint => 'تعديل البؤرة يدويا';

  @override
  String get sActionPreviewHint => 'عرض';

  @override
  String get sActionRecordHint => 'تسجيل';

  @override
  String get sActionShootHint => 'صور صورة';

  @override
  String get sActionShootingButtonTooltip => 'زر التصوير';

  @override
  String get sActionStopRecordingHint => 'إيقاف التسجيل';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'الكاميرا الخلفية';
    } else if (value == CameraLensDirection.front) {
      return 'الكاميرا الأمامية';
    } else {
      return 'الكاميرا';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == CameraLensDirection.front.name) {
      return 'عرض الكاميرا الأمامية';
    } else if (sCameraLensDirectionLabel(value) == CameraLensDirection.back.name) {
      return 'عرض الكاميرا الخلفية';
    } else {
      return 'عرض الكاميرا';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'فلاش مستمر';
    } else if (mode == FlashMode.auto) {
      return 'فلاش أوتوماتيكي';
    } else if (mode == FlashMode.off) {
      return 'بدون فلاش';
    } else if (mode == FlashMode.torch) {
      return 'فلاش متقطع';
    } else {
      return 'فلاش';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'التحويل للكاميرا الخلفية';
    } else if (value == CameraLensDirection.front) {
      return 'التحويل للكاميرا الأمامية';
    } else {
      return 'تحويل الكاميرا';
    }
  }
}
// --------------------
class ItalianCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const ItalianCameraPickerTextDelegate();

  @override
  String get languageCode => 'it';

  @override
  String get confirm => 'Conferma';

  @override
  String get shootingTips => 'Premi per scattare una foto';

  @override
  String get shootingWithRecordingTips =>
      'Premi per scattare una foto, tieni premuto per registrare un video';

  @override
  String get shootingOnlyRecordingTips => 'Tieni premuto per registrare un video';

  @override
  String get shootingTapRecordingTips => 'Premi per registrare un video';

  @override
  String get loadFailed => 'Caricamento fallito';

  @override
  String get loading => 'Caricamento in corso...';

  @override
  String get saving => 'Salvataggio in corso...';

  @override
  String get sActionManuallyFocusHint => 'Regola manualmente la messa a fuoco';

  @override
  String get sActionPreviewHint => 'Anteprima';

  @override
  String get sActionRecordHint => 'Registra';

  @override
  String get sActionShootHint => 'Scatta una foto';

  @override
  String get sActionShootingButtonTooltip => 'Pulsante di scatto';

  @override
  String get sActionStopRecordingHint => 'Interrompi la registrazione';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Fotocamera posteriore';
    } else if (value == CameraLensDirection.front) {
      return 'Fotocamera anteriore';
    } else {
      return 'Fotocamera';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == CameraLensDirection.front.name) {
      return 'Anteprima fotocamera anteriore';
    } else if (sCameraLensDirectionLabel(value) == CameraLensDirection.back.name) {
      return 'Anteprima fotocamera posteriore';
    } else {
      return 'Anteprima fotocamera';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'Flash sempre attivo';
    } else if (mode == FlashMode.auto) {
      return 'Flash automatico';
    } else if (mode == FlashMode.off) {
      return 'Flash disattivato';
    } else if (mode == FlashMode.torch) {
      return 'Modalità torcia';
    } else {
      return 'Flash';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Passa alla fotocamera posteriore';
    } else if (value == CameraLensDirection.front) {
      return 'Passa alla fotocamera anteriore';
    } else {
      return 'Passa alla fotocamera';
    }
  }
}
// --------------------
class SpanishCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const SpanishCameraPickerTextDelegate();

  @override
  String get languageCode => 'es';

  @override
  String get confirm => 'Confirmar';

  @override
  String get shootingTips => 'Presiona para tomar una foto';

  @override
  String get shootingWithRecordingTips =>
      'Presiona para tomar una foto, mantén presionado para grabar un video';

  @override
  String get shootingOnlyRecordingTips => 'Mantén presionado para grabar un video';

  @override
  String get shootingTapRecordingTips => 'Presiona para grabar un video';

  @override
  String get loadFailed => 'Error al cargar';

  @override
  String get loading => 'Cargando...';

  @override
  String get saving => 'Guardando...';

  @override
  String get sActionManuallyFocusHint => 'Ajustar el enfoque manualmente';

  @override
  String get sActionPreviewHint => 'Vista previa';

  @override
  String get sActionRecordHint => 'Grabar';

  @override
  String get sActionShootHint => 'Tomar una foto';

  @override
  String get sActionShootingButtonTooltip => 'Botón de disparo';

  @override
  String get sActionStopRecordingHint => 'Detener la grabación';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Cámara trasera';
    } else if (value == CameraLensDirection.front) {
      return 'Cámara frontal';
    } else {
      return 'Cámara';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == CameraLensDirection.front.name) {
      return 'Vista previa de la cámara frontal';
    } else if (sCameraLensDirectionLabel(value) == CameraLensDirection.back.name) {
      return 'Vista previa de la cámara trasera';
    } else {
      return 'Vista previa de la cámara';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'Flash siempre activado';
    } else if (mode == FlashMode.auto) {
      return 'Flash automático';
    } else if (mode == FlashMode.off) {
      return 'Flash desactivado';
    } else if (mode == FlashMode.torch) {
      return 'Modo de linterna';
    } else {
      return 'Flash';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Cambiar a cámara trasera';
    } else if (value == CameraLensDirection.front) {
      return 'Cambiar a cámara frontal';
    } else {
      return 'Cambiar la cámara';
    }
  }
}
// --------------------
class GermanCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const GermanCameraPickerTextDelegate();

  @override
  String get languageCode => 'de';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get shootingTips => 'Tippen, um ein Foto aufzunehmen';

  @override
  String get shootingWithRecordingTips =>
      'Tippen, um ein Foto aufzunehmen, lange drücken, um ein Video aufzunehmen';

  @override
  String get shootingOnlyRecordingTips => 'Lange drücken, um ein Video aufzunehmen';

  @override
  String get shootingTapRecordingTips => 'Tippen, um ein Video aufzunehmen';

  @override
  String get loadFailed => 'Fehler beim Laden';

  @override
  String get loading => 'Laden...';

  @override
  String get saving => 'Speichern...';

  @override
  String get sActionManuallyFocusHint => 'Manuelle Fokussierung einstellen';

  @override
  String get sActionPreviewHint => 'Vorschau';

  @override
  String get sActionRecordHint => 'Aufnehmen';

  @override
  String get sActionShootHint => 'Foto aufnehmen';

  @override
  String get sActionShootingButtonTooltip => 'Auslöser';

  @override
  String get sActionStopRecordingHint => 'Aufnahme beenden';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Rückseitige Kamera';
    } else if (value == CameraLensDirection.front) {
      return 'Vorderseitige Kamera';
    } else {
      return 'Kamera';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == CameraLensDirection.front.name) {
      return 'Vorschau der vorderseitigen Kamera';
    } else if (sCameraLensDirectionLabel(value) == CameraLensDirection.back.name) {
      return 'Vorschau der rückseitigen Kamera';
    } else {
      return 'Kameravorschau';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'Immer Blitz';
    } else if (mode == FlashMode.auto) {
      return 'Automatischer Blitz';
    } else if (mode == FlashMode.off) {
      return 'Blitz aus';
    } else if (mode == FlashMode.torch) {
      return 'Taschenlampe';
    } else {
      return 'Blitz';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Zurück zur rückseitigen Kamera wechseln';
    } else if (value == CameraLensDirection.front) {
      return 'Zurück zur vorderseitigen Kamera wechseln';
    } else {
      return 'Kamera wechseln';
    }
  }
}
// --------------------
class FrenchCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const FrenchCameraPickerTextDelegate();

  @override
  String get languageCode => 'fr';

  @override
  String get confirm => 'Confirmer';

  @override
  String get shootingTips => 'Appuyez pour prendre une photo';

  @override
  String get shootingWithRecordingTips =>
      'Appuyez pour prendre une photo, maintenez enfoncé pour enregistrer une vidéo';

  @override
  String get shootingOnlyRecordingTips => 'Maintenez enfoncé pour enregistrer une vidéo';

  @override
  String get shootingTapRecordingTips => 'Appuyez pour enregistrer une vidéo';

  @override
  String get loadFailed => 'Échec du chargement';

  @override
  String get loading => 'Chargement en cours...';

  @override
  String get saving => 'Enregistrement en cours...';

  @override
  String get sActionManuallyFocusHint => 'Ajuster la mise au point manuellement';

  @override
  String get sActionPreviewHint => 'Aperçu';

  @override
  String get sActionRecordHint => 'Enregistrer';

  @override
  String get sActionShootHint => 'Prendre une photo';

  @override
  String get sActionShootingButtonTooltip => 'Bouton de prise de vue';

  @override
  String get sActionStopRecordingHint => "Arrêter l'enregistrement";

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Caméra arrière';
    } else if (value == CameraLensDirection.front) {
      return 'Caméra avant';
    } else {
      return 'Caméra';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == CameraLensDirection.front.name) {
      return 'Aperçu de la caméra avant';
    } else if (sCameraLensDirectionLabel(value) == CameraLensDirection.back.name) {
      return 'Aperçu de la caméra arrière';
    } else {
      return 'Aperçu de la caméra';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'Flash toujours activé';
    } else if (mode == FlashMode.auto) {
      return 'Flash automatique';
    } else if (mode == FlashMode.off) {
      return 'Flash désactivé';
    } else if (mode == FlashMode.torch) {
      return 'Mode lampe de poche';
    } else {
      return 'Flash';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Passer à la caméra arrière';
    } else if (value == CameraLensDirection.front) {
      return 'Passer à la caméra avant';
    } else {
      return 'Changer de caméra';
    }
  }
}
// --------------------
class TurkishCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const TurkishCameraPickerTextDelegate();

  @override
  String get languageCode => 'tr';

  @override
  String get confirm => 'Onayla';

  @override
  String get shootingTips => 'Fotoğraf çekmek için dokunun.';

  @override
  String get shootingWithRecordingTips =>
      'Fotoğraf çekmek için dokunun. Video kaydetmek için uzun basın.';

  @override
  String get shootingOnlyRecordingTips => 'Video kaydetmek için uzun basın.';

  @override
  String get shootingTapRecordingTips => 'Video kaydetmek için dokunun.';

  @override
  String get loadFailed => 'Yüklenemedi';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get saving => 'Kaydediliyor...';

  @override
  String get sActionManuallyFocusHint => 'Manuel odaklama';

  @override
  String get sActionPreviewHint => 'Önizleme';

  @override
  String get sActionRecordHint => 'Kaydet';

  @override
  String get sActionShootHint => 'Fotoğraf çek';

  @override
  String get sActionShootingButtonTooltip => 'Çekim düğmesi';

  @override
  String get sActionStopRecordingHint => 'Kaydı durdur';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Arka Kamera';
    } else if (value == CameraLensDirection.front) {
      return 'Ön Kamera';
    } else {
      return 'Kamera';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == 'Ön Kamera') {
      return 'Ön kamera önizlemesi';
    } else if (sCameraLensDirectionLabel(value) == 'Arka Kamera') {
      return 'Arka kamera önizlemesi';
    } else {
      return 'Kamera önizlemesi';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'Daima Flaş';
    } else if (mode == FlashMode.auto) {
      return 'Otomatik Flaş';
    } else if (mode == FlashMode.off) {
      return 'Flaş Kapalı';
    } else if (mode == FlashMode.torch) {
      return 'El Feneri Flaşı';
    } else {
      return 'Flaş';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Arka Kameraya Geç';
    } else if (value == CameraLensDirection.front) {
      return 'Ön Kameraya Geç';
    } else {
      return 'Kamerayı Değiştir';
    }
  }
}
// --------------------
class HindiCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const HindiCameraPickerTextDelegate();

  @override
  String get languageCode => 'hi';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get shootingTips => 'फ़ोटो लेने के लिए टैप करें।';

  @override
  String get shootingWithRecordingTips =>
      'फ़ोटो लेने के लिए टैप करें। वीडियो रिकॉर्ड करने के लिए लंबे समय तक दबाएं।';

  @override
  String get shootingOnlyRecordingTips => 'वीडियो रिकॉर्ड करने के लिए लंबे समय तक दबाएं।';

  @override
  String get shootingTapRecordingTips => 'वीडियो रिकॉर्ड करने के लिए टैप करें।';

  @override
  String get loadFailed => 'लोड विफल';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get saving => 'सहेजा जा रहा है...';

  @override
  String get sActionManuallyFocusHint => 'मैन्युअल फोकस';

  @override
  String get sActionPreviewHint => 'पूर्वावलोकन';

  @override
  String get sActionRecordHint => 'रिकॉर्ड';

  @override
  String get sActionShootHint => 'फ़ोटो लें';

  @override
  String get sActionShootingButtonTooltip => 'शूटिंग बटन';

  @override
  String get sActionStopRecordingHint => 'रिकॉर्डिंग बंद करें';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'पीछे का कैमरा';
    } else if (value == CameraLensDirection.front) {
      return 'सामने का कैमरा';
    } else {
      return 'कैमरा';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == 'सामने का कैमरा') {
      return 'सामने के कैमरे का पूर्वावलोकन';
    } else if (sCameraLensDirectionLabel(value) == 'पीछे का कैमरा') {
      return 'पीछे के कैमरे का पूर्वावलोकन';
    } else {
      return 'कैमरा पूर्वावलोकन';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'हमेशा फ़्लैश';
    } else if (mode == FlashMode.auto) {
      return 'ऑटोमेटिक फ़्लैश';
    } else if (mode == FlashMode.off) {
      return 'बिना फ़्लैश';
    } else if (mode == FlashMode.torch) {
      return 'टॉर्च फ़्लैश';
    } else {
      return 'फ़्लैश';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'पीछे के कैमरे में बदलें';
    } else if (value == CameraLensDirection.front) {
      return 'सामने के कैमरे में बदलें';
    } else {
      return 'कैमरा बदलें';
    }
  }
}
// --------------------
class RussianCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const RussianCameraPickerTextDelegate();

  @override
  String get languageCode => 'ru';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get shootingTips => 'Нажмите, чтобы сделать фото.';

  @override
  String get shootingWithRecordingTips =>
      'Нажмите, чтобы сделать фото. Удерживайте для записи видео.';

  @override
  String get shootingOnlyRecordingTips => 'Удерживайте для записи видео.';

  @override
  String get shootingTapRecordingTips => 'Нажмите для записи видео.';

  @override
  String get loadFailed => 'Ошибка загрузки';

  @override
  String get loading => 'Загрузка...';

  @override
  String get saving => 'Сохранение...';

  @override
  String get sActionManuallyFocusHint => 'Ручное фокусирование';

  @override
  String get sActionPreviewHint => 'Предпросмотр';

  @override
  String get sActionRecordHint => 'Запись';

  @override
  String get sActionShootHint => 'Сделать снимок';

  @override
  String get sActionShootingButtonTooltip => 'Кнопка съемки';

  @override
  String get sActionStopRecordingHint => 'Остановить запись';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Задняя камера';
    } else if (value == CameraLensDirection.front) {
      return 'Передняя камера';
    } else {
      return 'Камера';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == 'Передняя камера') {
      return 'Предпросмотр передней камеры';
    } else if (sCameraLensDirectionLabel(value) == 'Задняя камера') {
      return 'Предпросмотр задней камеры';
    } else {
      return 'Предпросмотр камеры';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'Всегда вспышка';
    } else if (mode == FlashMode.auto) {
      return 'Автоматическая вспышка';
    } else if (mode == FlashMode.off) {
      return 'Без вспышки';
    } else if (mode == FlashMode.torch) {
      return 'Фонарь';
    } else {
      return 'Вспышка';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Переключиться на заднюю камеру';
    } else if (value == CameraLensDirection.front) {
      return 'Переключиться на переднюю камеру';
    } else {
      return 'Переключиться на камеру';
    }
  }
}
// --------------------
class PortugueseCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const PortugueseCameraPickerTextDelegate();

  @override
  String get languageCode => 'pt';

  @override
  String get confirm => 'Confirmar';

  @override
  String get shootingTips => 'Toque para tirar uma foto.';

  @override
  String get shootingWithRecordingTips =>
      'Toque para tirar uma foto. Pressione e segure para gravar um vídeo.';

  @override
  String get shootingOnlyRecordingTips => 'Pressione e segure para gravar um vídeo.';

  @override
  String get shootingTapRecordingTips => 'Toque para gravar um vídeo.';

  @override
  String get loadFailed => 'Falha ao carregar';

  @override
  String get loading => 'Carregando...';

  @override
  String get saving => 'Salvando...';

  @override
  String get sActionManuallyFocusHint => 'Foco manual';

  @override
  String get sActionPreviewHint => 'Pré-visualização';

  @override
  String get sActionRecordHint => 'Gravar';

  @override
  String get sActionShootHint => 'Tirar foto';

  @override
  String get sActionShootingButtonTooltip => 'Botão de disparo';

  @override
  String get sActionStopRecordingHint => 'Parar gravação';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Câmera traseira';
    } else if (value == CameraLensDirection.front) {
      return 'Câmera frontal';
    } else {
      return 'Câmera';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == 'Câmera frontal') {
      return 'Visualização da câmera frontal';
    } else if (sCameraLensDirectionLabel(value) == 'Câmera traseira') {
      return 'Visualização da câmera traseira';
    } else {
      return 'Visualização da câmera';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'Modo de flash: Sempre';
    } else if (mode == FlashMode.auto) {
      return 'Modo de flash: Automático';
    } else if (mode == FlashMode.off) {
      return 'Modo de flash: Desligado';
    } else if (mode == FlashMode.torch) {
      return 'Modo de flash: Lanterna';
    } else {
      return 'Modo de flash';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'Alternar para câmera traseira';
    } else if (value == CameraLensDirection.front) {
      return 'Alternar para câmera frontal';
    } else {
      return 'Alternar câmera';
    }
  }
}
// --------------------
class FarsiCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const FarsiCameraPickerTextDelegate();

  @override
  String get languageCode => 'fa';

  @override
  String get confirm => 'تأیید';

  @override
  String get shootingTips => 'برای گرفتن عکس، لمس کنید.';

  @override
  String get shootingWithRecordingTips =>
      'برای گرفتن عکس، لمس کنید. برای ضبط ویدیو، نگه دارید.';

  @override
  String get shootingOnlyRecordingTips => 'برای ضبط ویدیو، نگه دارید.';

  @override
  String get shootingTapRecordingTips => 'برای ضبط ویدیو، لمس کنید.';

  @override
  String get loadFailed => 'بارگذاری ناموفق بود';

  @override
  String get loading => 'در حال بارگذاری...';

  @override
  String get saving => 'در حال ذخیره...';

  @override
  String get sActionManuallyFocusHint => 'فوکوس دستی';

  @override
  String get sActionPreviewHint => 'پیش‌نمایش';

  @override
  String get sActionRecordHint => 'ضبط';

  @override
  String get sActionShootHint => 'عکس بگیر';

  @override
  String get sActionShootingButtonTooltip => 'دکمه عکس‌برداری';

  @override
  String get sActionStopRecordingHint => 'توقف ضبط';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'دوربین پشتی';
    } else if (value == CameraLensDirection.front) {
      return 'دوربین جلویی';
    } else {
      return 'دوربین';
    }
  }

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == 'دوربین جلویی') {
      return 'پیش‌نمایش دوربین جلویی';
    } else if (sCameraLensDirectionLabel(value) == 'دوربین پشتی') {
      return 'پیش‌نمایش دوربین پشتی';
    } else {
      return 'پیش‌نمایش دوربین';
    }
  }

  @override
  String sFlashModeLabel(FlashMode mode) {
    if (mode == FlashMode.always) {
      return 'حالت فلاش: همیشه';
    } else if (mode == FlashMode.auto) {
      return 'حالت فلاش: خودکار';
    } else if (mode == FlashMode.off) {
      return 'حالت فلاش: خاموش';
    } else if (mode == FlashMode.torch) {
      return 'حالت فلاش: چراغ قوه';
    } else {
      return 'حالت فلاش';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) {
    if (value == CameraLensDirection.back) {
      return 'تغییر به دوربین پشتی';
    } else if (value == CameraLensDirection.front) {
      return 'تغییر به دوربین جلویی';
    } else {
      return 'تغییر دوربین';
    }
  }
}
// -----------------------------------------------------------------------------
