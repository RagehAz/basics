part of filing;

/// => TAMAM
class ImageCacheOps {
  // -----------------------------------------------------------------------------

  const ImageCacheOps();

  // -----------------------------------------------------------------------------

  /// CLEAR IMAGE CACHE

  // --------------------
  /// TESTED : WORKS PERFECT
  static void clearCache(){
    imageCache.clear();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void clearLiveImages(){
    imageCache.clearLiveImages();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void clearPaintingBindingImageCache(){
    PaintingBinding.instance.imageCache.clear();
  }
  // -----------------------------------------------------------------------------

  /// CACHE MANAGER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> clearCacheByManager() async {
    await DefaultCacheManager().emptyCache();
  }
  // -----------------------------------------------------------------------------

  /// SUPER WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeCaches() async {

    await Future.wait(<Future>[
      ImageCacheOps.clearCacheByManager(),
    ]);

    ImageCacheOps.clearCache();
    ImageCacheOps.clearLiveImages();
    ImageCacheOps.clearPaintingBindingImageCache();

  }
// --------------------
}
