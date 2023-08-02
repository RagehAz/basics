import 'package:wechat_camera_picker/wechat_camera_picker.dart';
// -----------------------------------------------------------------------------

/// SWITCHER

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
// -----------------------------------------------------------------------------
