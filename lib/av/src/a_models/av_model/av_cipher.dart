part of av;

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
        'origin': AvCipher.cipherMediaOrigin(avModel.origin),
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
        origin: AvCipher.decipherMediaOrigin(map['origin']),
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

  /// MEDIA SOURCE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherMediaOrigin(AvOrigin? type){
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

      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AvOrigin? decipherMediaOrigin(String? type){
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

      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// FOR LDB

  // -----------------------------------------------------------------------------

  /// FOR SETTABLE MAP

  // --------------------
  ///
  static Map<String, String>? generateSettableMap({
    required AvModel? avModel,
  }){

    //   // -----------------------------------------------------------------------------
//
//   /// TO SETTABLE MAP
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Map<String, String>? generateSettableMap({
//     // required Uint8List? bytes,
//     required MediaMetaModel? meta,
//     Map<String, String>? extraData,
//   }){
//
//     /// ASSIGNING NULL TO KEY DELETES PAIR AUTOMATICALLY.
//     final Map<String, String?>? _metaDataMap = <String, String?>{
//       'name': meta?.name,
//       'sizeMB': meta?.sizeMB?.toString(),
//       'width': meta?.width?.toString(),
//       'height': meta?.height?.toString(),
//       'uploadPath': meta?.uploadPath,
//       'fileType': FileMiming.getMimeByType(meta?.fileExt),
//     };
//
//     /// ADD OWNERS IDS
//     if (Lister.checkCanLoop(meta?.ownersIDs) == true){
//       for (final String ownerID in meta!.ownersIDs) {
//         _metaDataMap?[ownerID] = 'cool';
//       }
//     }
//
//     Map<String, String>? _output = MapperSS.cleanNullPairs(
//       map: _metaDataMap,
//     );
//
//     /// ADD META DATA MAP
//     if (meta?.data != null) {
//       _output = MapperSS.combineStringStringMap(
//         baseMap: _output,
//         replaceDuplicateKeys: true,
//         insert: meta!.data,
//       );
//     }
//
//     /// ADD EXTRA DATA MAP
//     if (extraData != null) {
//       _output = MapperSS.combineStringStringMap(
//         baseMap: _output,
//         replaceDuplicateKeys: true,
//         insert: extraData,
//       );
//     }
//
//     return _output;
//
//     // return f_s.SettableMetadata(
//     //   customMetadata: _output,
//     //   // cacheControl: ,
//     //   // contentDisposition: ,
//     //   // contentEncoding: ,
//     //   // contentLanguage: ,
//     //   contentType: FileMiming.getMimeByType(meta?.fileExt),
//     // );
//
//   }

    return MapperSS.lowerCaseAllKeys(
      map: {},
    );

  }
  // -----------------------------------------------------------------------------
  void x(){}
}
