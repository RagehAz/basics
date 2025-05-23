part of av;
/// => GREAT
abstract class AvCipher {
  // --------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? toMap(AvModel? avModel){

    if (avModel == null){
      return null;
    }

    else {
      return {
        'id': avModel.id,
        'uploadPath': avModel.uploadPath,
        'xFilePath': avModel.xFilePath,
        'ownersIDs': avModel.ownersIDs,
        'width': avModel.width,
        'height': avModel.height,
        'nameWithoutExtension': avModel.nameWithoutExtension,
        'nameWithExtension': avModel.nameWithExtension,
        'sizeMB': avModel.sizeMB,
        'sizeB': avModel.sizeB,
        'fileExt': FileMiming.getMimeByType(avModel.fileExt),
        'data': avModel.data,
        'origin': AvCipher.cipherAvOrigin(avModel.origin),
        'originalURL': avModel.originalURL,
        'caption': avModel.caption,
        'durationMs': avModel.durationMs,
        'bobDocName': avModel.bobDocName,
        'originalXFilePath': avModel.originalXFilePath,
        'lastEdit': Timers.cipherTime(time: avModel.lastEdit, toJSON: true),
      };
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AvModel? fromMap(Map<String, dynamic>? map){

    if (map == null){
      return null;
    }

    else {

      return AvModel(
        id: map['id'],
        uploadPath: map['uploadPath'],
        xFilePath: map['xFilePath'],
        ownersIDs: Stringer.getStringsFromDynamics(map['ownersIDs']),
        width: map['width'],
        height: map['height'],
        nameWithoutExtension: map['nameWithoutExtension'],
        nameWithExtension: map['nameWithExtension'],
        sizeMB: map['sizeMB'],
        sizeB: map['sizeB'],
        fileExt: FileMiming.getTypeByMime(map['fileExt']),
        data: MapperSS.createStringStringMap(hashMap: map['data'], stringifyNonStrings: true),
        origin: AvCipher.decipherAvOrigin(map['origin']),
        originalURL: map['originalURL'],
        caption: map['caption'],
        durationMs: map['durationMs'],
        bobDocName: map['bobDocName'],
        originalXFilePath: map['originalXFilePath'],
        lastEdit: Timers.decipherTime(time: map['lastEdit'], fromJSON: true),
      );
    }

  }
  // --------------------------------------------------------------------------

  /// Av SOURCE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherAvOrigin(AvOrigin? type){
    switch (type){
      case AvOrigin.cameraImage:  return 'camera';
      case AvOrigin.galleryImage: return 'gallery';
      case AvOrigin.cameraVideo:  return 'cameraVideo';
      case AvOrigin.galleryVideo: return 'galleryVideo';
      case AvOrigin.generated:    return 'generated';
      case AvOrigin.downloaded:   return 'downloaded';

      case AvOrigin.facebook:    return 'facebook';
      case AvOrigin.instagram:   return 'instagram';
      case AvOrigin.amazon:      return 'amazon';
      case AvOrigin.website:     return 'website';
      case AvOrigin.deviceFiles: return 'deviceFiles';

      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AvOrigin? decipherAvOrigin(String? type){
    switch (type){
      case 'camera':        return    AvOrigin.cameraImage;
      case 'gallery':       return    AvOrigin.galleryImage;
      case 'cameraVideo':   return    AvOrigin.cameraVideo;
      case 'galleryVideo':  return    AvOrigin.galleryVideo;
      case 'generated':     return    AvOrigin.generated;
      case 'downloaded':    return    AvOrigin.downloaded;

      case 'facebook':      return    AvOrigin.facebook;
      case 'instagram':     return    AvOrigin.instagram;
      case 'amazon':        return    AvOrigin.amazon;
      case 'website':       return    AvOrigin.website;
      case 'deviceFiles':   return    AvOrigin.deviceFiles;

      default: return null;
    }
  }
  // --------------------------------------------------------------------------

  /// String String Cipher

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String>? toStringStringMap({
    required AvModel? avModel,
    required bool lowerCaseKeys,
  }){

    if (avModel == null){
      return null;
    }

    else {

      final Map<String, String?> _nullable = {
        'id': avModel.id,
        'uploadPath': avModel.uploadPath,
        'xFilePath': avModel.xFilePath,
        // 'ownersIDs': avModel.ownersIDs, /// IS UNFOLDED
        'width': avModel.width?.toString(),
        'height': avModel.height?.toString(),
        'nameWithoutExtension': avModel.nameWithoutExtension,
        'nameWithExtension': avModel.nameWithExtension,
        'sizeMB': avModel.sizeMB?.toString(),
        'sizeB': avModel.sizeB?.toString(),
        'fileExt': FileMiming.getMimeByType(avModel.fileExt),
        // 'data': avModel.data, /// IS MERGED SEPARATELY
        'origin': AvCipher.cipherAvOrigin(avModel.origin),
        'originalURL': avModel.originalURL,
        'caption': avModel.caption,
        'durationMs': avModel.durationMs?.toString(),
        'bobDocName': avModel.bobDocName,
        'originalXFilePath': avModel.originalXFilePath,
        'lastEdit': Timers.cipherTime(time: avModel.lastEdit, toJSON: true)?.toString(),
      };

      /// ADD OWNERS IDS
      Lister.loopSync(
          models: avModel.ownersIDs,
          onLoop: (int index, String? ownerID){
            if (ownerID != null){
              _nullable[ownerID] = 'cool';
            }
          }
      );


      Map<String, String>? _output = MapperSS.cleanNullPairs(
          map: _nullable,
      );

      /// ADD EXTRA DATA MAP
      _output = MapperSS.combineStringStringMap(
        baseMap: _output,
        replaceDuplicateKeys: true,
        insert: avModel.data,
      );

      if (lowerCaseKeys == true){
        _output = MapperSS.lowerCaseAllKeys(
          map: _output,
        );
      }

      return _output;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AvModel? fromStringStringMap({
    required String? uploadPath,
    required String bobDocName,
    required Map<String, String>? map,
    String? xFilePath,
  }){

    if (map == null || uploadPath == null){
      return null;
    }

    else {

      return AvModel(
        id: AvPathing.createID(uploadPath: uploadPath)!,
        uploadPath: uploadPath,
        bobDocName: bobDocName,
        xFilePath: xFilePath,
        ownersIDs: MapperSS.getKeysHavingThisValue(
          map: map,
          value: 'cool',
        ),
        fileExt: FileMiming.getTypeByMime(map['fileType'] ?? map['filetype'] ?? map['fileExt'] ?? map['fileext']),
        width: Numeric.transformStringToDouble(map['width']),
        height: Numeric.transformStringToDouble(map['height']),
        nameWithoutExtension: map['name'] ?? map['nameWithoutExtension'] ?? map['namewithoutextension'],
        sizeMB: Numeric.transformStringToDouble(map['sizeMB'] ?? map['sizemb']),
        sizeB: Numeric.transformStringToInt(map['sizeB'] ?? map['sizeb']),
        data: _getRemainingData(map),
        nameWithExtension: map['nameWithExtension'] ?? map['namewithextension'],
        origin: AvCipher.decipherAvOrigin(map['origin'] ?? map['source']),
        originalURL: map['originalURL'] ?? map['originalurl'],
        caption: map['caption'],
        durationMs: Numeric.transformStringToInt(map['durationMs'] ?? map['durationms']),
        originalXFilePath: map['originalXFilePath'] ?? map['originalxfilepath'],
        lastEdit: Timers.decipherTime(
            time: Numeric.transformStringToInt(map['lastEdit'] ?? map['lastedit']),
            fromJSON: true
        ),
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String>? _getRemainingData(Map<String, String>? metaMap){
    Map<String, String>? _map;

    if (metaMap != null){

      const Map<String, dynamic> _uniqueKeys = {
        'id': true,
        'uploadPath': true,
        'uploadpath': true,
        'bobDocName': true,
        'bobDocname': true,
        'xFilePath': true,
        'xfilepath': true,
        'ownersIDs': true,
        'ownersids': true,
        'fileType': true,
        'filetype': true,
        'fileExt': true,
        'fileext': true,
        'width': true,
        'height': true,
        'nameWithoutExtension': true,
        'namewithoutextension': true,
        'name': true,
        'nameWithExtension': true,
        'namewithextension': true,
        'sizeb': true,
        'sizeB': true,
        'sizemb': true,
        'sizeMB': true,
        'origin': true,
        'source': true,
        'originalURL': true,
        'originalurl': true,
        'caption': true,
        'durationMs': true,
        'durationms': true,
        'originalXFilePath': true,
        'originalxfilepath': true,
        'lastEdit': true,
        'lastedit': true,
      };

      _map = {};

      final List<String> _keys = metaMap.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){

        final List<String> _forbiddenKeys = _uniqueKeys.keys.toList();

        for (final String key in _keys){

          final bool _isForbiddenKey = Stringer.checkStringsContainString(
            strings: _forbiddenKeys,
            string: key,
          );

          final bool _isCool = metaMap[key] == 'cool';

          if (_isForbiddenKey == false && _isCool == false){
            _map[key] = metaMap[key]!;
          }

        }

      }

    }

    return _map;
  }
  // -----------------------------------------------------------------------------
}
