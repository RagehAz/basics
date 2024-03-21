part of filing;
/// => TAMAM
class Entities {
  // -----------------------------------------------------------------------------

  const Entities();

  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> blogAssetEntity({
    required AssetEntity? entity,
    required String invoker,
  }) async {

    if (entity == null){
      blog('blogAssetEntity : entity is NULL');
    }

    else {

      final File? _file = await entity.file;
      final File? _fileWithSubtype = await entity.fileWithSubtype;
      final Uint8List? _originBytes = await entity.originBytes;
      final File? _originFile = await entity.originFile;
      final File? _originFileWithSubtype = await entity.originFileWithSubtype;
      final File? _loadFile = await entity.loadFile();
      // final _thumbnailDataWithOption = entity.thumbnailDataWithOption(option);
      // final _thumbnailDataWithSize = entity.thumbnailDataWithSize(size);

      blog('blogAssetEntity : INVOKER : $invoker');
      blog('[B] ======================> TYPES');
      blog('  file                   : ${_file?.stringify}');
      blog('  fileWithSubtype        : ${_fileWithSubtype?.stringify}');
      blog('  originFile             : ${_originFile?.stringify}');
      blog('  originFileWithSubtype  : ${_originFileWithSubtype?.stringify}');
      blog('  loadFile()             : ${_loadFile?.stringify}');
      blog('  type                   : ${entity.type}');
      blog('  id                     : ${entity.id}');
      blog('  relativePath           : ${entity.relativePath}');
      blog('  originBytes            : ${_originBytes?.length}');
      blog('[B] ======================> CHECKS');
      blog('  exists                 : ${await entity.exists}');
      blog('  isFavorite             : ${entity.isFavorite}');
      blog('  isLivePhoto            : ${entity.isLivePhoto}');
      blog('  isLocallyAvailable()   : ${await entity.isLocallyAvailable()}');
      blog('[C] ======================> TYPES');
      blog('  subtype                : ${entity.subtype}');
      blog('  typeInt                : ${entity.typeInt}');
      blog('  mimeType               : ${entity.mimeType}');
      blog('  mimeTypeAsync          : ${await entity.mimeTypeAsync}');
      blog('  width                  : ${entity.width}');
      blog('  height                 : ${entity.height}');
      blog('  size                   : ${entity.size}');
      blog('[D] ======================> LOCATION');
      blog('  latitude               : ${entity.latitude}');
      blog('  longitude              : ${entity.longitude}');
      blog('  latlngAsync()          : ${await entity.latlngAsync()}');
      blog('[E] ======================> DURATION');
      blog('  videoDuration          : ${entity.videoDuration}');
      blog('  duration               : ${entity.duration}');
      blog('[F] ======================> TIMES');
      blog('  createDateSecond       : ${entity.createDateSecond}');
      blog('  createDateTime         : ${entity.createDateTime}');
      blog('  modifiedDateSecond     : ${entity.modifiedDateSecond}');
      blog('  modifiedDateTime       : ${entity.modifiedDateTime}');
      blog('[G] ======================> ORIENTATION');
      blog('  orientatedHeight       : ${entity.orientatedHeight}');
      blog('  orientatedSize         : ${entity.orientatedSize}');
      blog('  orientatedWidth        : ${entity.orientatedWidth}');
      blog('  orientation            : ${entity.orientation}');
      blog('[H] ======================> TITLE');
      blog('  title                  : ${entity.title}');
      blog('  titleAsync             : ${await entity.titleAsync}');
      blog('  titleAsyncWithSubtype  : ${await entity.titleAsyncWithSubtype}');
      blog('[I] ======================> OTHER');
      blog('  thumbnailData                      : ${await entity.thumbnailData}');
      blog('  getMediaUrl()                      : ${await entity.getMediaUrl()}');
      blog('  obtainForNewProperties()           : ${await entity.obtainForNewProperties()}');
      // blog('thumbnailDataWithOption(option)    : ${entity.thumbnailDataWithOption(option)}');
      // blog('thumbnailDataWithSize(size)        : ${entity.thumbnailDataWithSize(size)}');
      blog('blogAssetEntity : DONE');

// file
// mimeType
// exists
// type
// height
// width
// videoDuration
// size
// duration
// id
// createDateSecond
// createDateTime
// isFavorite
// fileWithSubtype
// isLivePhoto
// latitude
// longitude
// mimeTypeAsync
// modifiedDateSecond
// modifiedDateTime
// orientatedHeight
// orientatedSize
// orientatedWidth
// orientation
// originBytes
// originFile
// originFileWithSubtype
// relativePath
// subtype
// thumbnailData
// title
// titleAsync
// titleAsyncWithSubtype
// typeInt
// getMediaUrl()
// isLocallyAvailable()
// latlngAsync()
// loadFile()
// obtainForNewProperties()
// thumbnailDataWithOption(option)
// thumbnailDataWithSize(size)


    }

  }
  // -----------------------------------------------------------------------------
}
