import 'dart:io';

import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/models/media_meta_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum MediaOrigin {
  cameraImage,
  galleryImage,
  cameraVideo,
  galleryVideo,
  generated,
  downloaded,
}

/// => TAMAM
@immutable
class MediaModel {
  // -----------------------------------------------------------------------------
  const MediaModel({
    required this.file,
    required this.meta,
  });
  // -----------------------------------------------------------------------------
  final XFile? file;
  final MediaMetaModel? meta;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel copyWith({
    XFile? file,
    MediaMetaModel? meta,
  }){
    return MediaModel(
      file: file ?? this.file,
      meta: meta ?? this.meta,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel nullifyField({
    bool file = false,
    bool meta = false,
  }){
    return MediaModel(
      file: file == true ? null : this.file,
      meta: meta == true ? null : this.meta,
    );
  }
  // -----------------------------------------------------------------------------

  /// LDB CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipherToLDB(MediaModel? mediaModel){
    Map<String, dynamic>? _map;

    if (mediaModel != null){
      _map = {
        'path': mediaModel.file?.path, /// id
        'meta': mediaModel.meta?.cipherToLDB()
      };
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static MediaModel? decipherFromLDB(Map<String, dynamic>? map){
    MediaModel? _picModel;

    if (map != null){

      _picModel = MediaModel(
        file: map['path'] == null ? null : XFile(map['path']),
        meta: MediaMetaModel.decipherFromLDB(map['meta']),
      );

    }


    return _picModel;
  }
  // -----------------------------------------------------------------------------

  /// MEDIA SOURCE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherMediaOrigin(MediaOrigin? type){
    switch (type){
      case MediaOrigin.cameraImage:  return 'camera';
      case MediaOrigin.galleryImage: return 'gallery';
      case MediaOrigin.cameraVideo:  return 'cameraVideo';
      case MediaOrigin.galleryVideo: return 'galleryVideo';
      case MediaOrigin.generated:    return 'generated';
      case MediaOrigin.downloaded:   return 'downloaded';
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static MediaOrigin? decipherMediaOrigin(String? type){
    switch (type){
      case 'camera':        return    MediaOrigin.cameraImage;
      case 'gallery':       return    MediaOrigin.galleryImage;
      case 'cameraVideo':   return    MediaOrigin.cameraVideo;
      case 'galleryVideo':  return    MediaOrigin.galleryVideo;
      case 'generated':     return    MediaOrigin.generated;
      case 'downloaded':    return    MediaOrigin.downloaded;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// ASSERTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> assertIsUploadable(MediaModel? mediaModel) async {
    assert(mediaModel != null, 'picModel is null');
    assert(mediaModel?.file?.path != null, 'filepath is null');
    assert(mediaModel?.meta != null, 'meta is null');
    final Uint8List? _bytes = await mediaModel?.file?.readAsBytes();
    assert(_bytes != null, 'bytes is null');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Dimensions?> getDimensions() async {
    final Dimensions? _dim = await DimensionsGetter.fromXFile(
      file: file,
    );
    return _dim;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  Future<double?> getSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) async {

    final double? _size = await file?.readSize(
      fileSizeUnit: fileSizeUnit,
    );

    return _size;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  Future<Uint8List?> getBytes() async {
    final Uint8List? _bytes = await Byter.fromXFile(file);
    return _bytes;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  int getBytesLength(){
    final Map<String, String>? _data = meta?.data;
    return Numeric.transformStringToInt(_data?['sizeB']) ?? 0;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  MediaOrigin? getMediaOrigin(){
    return meta?.getMediaOrigin();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<XFile> getFilesFromMediaModels({
    required List<MediaModel> mediaModels,
  }){
    final List<XFile> _output = [];

    if (Lister.checkCanLoop(mediaModels) == true){
      for (final MediaModel pic in mediaModels){
        if (pic.file != null){
          _output.add(pic.file!);
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<Uint8List>> getBytezzFromMediaModels({
    required List<MediaModel> mediaModels,
  }) async {
    final List<Uint8List> _output = [];
    
    if (Lister.checkCanLoop(mediaModels) == true){
      
      for (final MediaModel model in mediaModels){
        
        final Uint8List? _bytes = await Byter.fromXFile(model.file);
        
        if (_bytes != null){
          _output.add(_bytes);
        }
        
      }
      
    }
    
    return _output;
  }
  // -----------------------------------------------------------------------------
  
  /// MODIFIERS

  // --------------------
  /// TASK : TEST_ME_NOW
  Future<MediaModel> replaceBytes({
    required Uint8List? bytes,
  }) async {
    
    if (bytes == null){
      return this;
    }
    else {
      
      final XFile? _file = await XFiler.replaceBytes(
        file: file,
        bytes: bytes,
      );

      final MediaModel? _output = await MediaModelCreator.fromXFile(
          file: _file,
          mediaOrigin: getMediaOrigin(),
          uploadPath: meta?.uploadPath,
          ownersIDs: meta?.ownersIDs,
          renameFile: null,
      );
      
      return _output ?? this;
      
    }
    
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel overrideUploadPath({
    required String? uploadPath
  }){
    return copyWith(
      meta: meta?.copyWith(
        uploadPath: uploadPath,
      ),
    );
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  Future<MediaModel> renameFile({
    required String? newName,
  }) async {

    if (file == null || newName == null || newName == '' || file?.fileName == newName){
      return this;
    }
    else {

      final String _oldPath = file!.path;
      final String? _newPath = await FilePathing.createPathByName(
        fileName: newName,
      );

      if (_newPath != null && _oldPath != _newPath){

        final MediaModel? _output = await MediaModelCreator.fromXFile(
          file: file,
          mediaOrigin: getMediaOrigin(),
          uploadPath: meta?.uploadPath,
          ownersIDs: meta?.ownersIDs,
          renameFile: newName,
        );

        return _output ?? this;

      }

      else {
        return this;
      }

    }

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<MediaModel>> replaceBytezzInMediaModels({
    required List<MediaModel> mediaModels,
    required List<Uint8List>? bytezz,
  }) async {
    final List<MediaModel> _output = [];
    
    if (Lister.checkCanLoop(bytezz) == true && Lister.checkCanLoop(mediaModels) == true){
      
      if (bytezz!.length == mediaModels.length){
        
        for (int i = 0; i < mediaModels.length; i++){
          
          MediaModel _model = mediaModels[i];
          final Uint8List _newBytes = bytezz[i];

          _model = await _model.replaceBytes(
              bytes: _newBytes,
          );
          
          _output.add(_model);
          
        }
        
      }
      
    }
    
    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPic({
    String invoker = '',
  }){

    final String _text =
    '''
    ${file?.stringify},
    $meta
    ''';

    blog(_text);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPics({
    required List<MediaModel>? pics,
    String invoker = '',
  }){

    if (pics == null){
      blog('blogPics : pics are null');
    }
    else if (pics.isEmpty == true){
      blog('blogPics : pics are empty');
    }
    else {

      for (final MediaModel pic in pics){

        pic.blogPic(
          invoker: invoker,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DUMMY PIC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel> dummyPic({
    String? localAsset,
  }) async {

    final MediaModel? _mediaModel = await MediaModelCreator.fromLocalAsset(
      localAsset: localAsset ?? Iconz.bldrsAppIcon,
      ownersIDs: const ['OwnerID'],
      uploadPath: 'storage/bldrs/bldrs_app_icon.png',
      // renameFile: null,
    );

    return _mediaModel!;

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<bool> checkMediaModelsAreIdentical({
    required MediaModel? model1,
    required MediaModel? model2,
  }) async {
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }
    else if (model1 != null && model2 != null){

      if (MediaMetaModel.checkMetaDatasAreIdentical(meta1: model1.meta, meta2: model2.meta) == true){

        _identical = await XFiler.checkXFilesAreIdentical(
            file1: model1.file,
            file2: model2.file,
        );

      }

    }

    return _identical;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static bool checkMediaModelsAreIdenticalSync({
    required MediaModel? model1,
    required MediaModel? model2,
  }) {
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }
    else if (model1 != null && model2 != null){

      if (MediaMetaModel.checkMetaDatasAreIdentical(meta1: model1.meta, meta2: model2.meta) == true){

        _identical = true;

      }

    }

    return _identical;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<bool> checkMediaModelsListsAreIdentical({
    required List<MediaModel>? models1,
    required List<MediaModel>? models2,
  }) async {

    bool _listsAreIdentical = false;

    if (models1 == null && models2 == null){
      _listsAreIdentical = true;
    }
    else if (models1 != null && models1.isEmpty == true && models2 != null && models2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (Lister.checkCanLoop(models1) == true && Lister.checkCanLoop(models2) == true){

      if (models1!.length != models2!.length) {
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < models1.length; i++) {

          final bool _pairAreIdentical = await checkMediaModelsAreIdentical(
              model1: models1[i],
              model2: models2[i]
          );

          if (_pairAreIdentical == false) {
            _listsAreIdentical = false;
            break;
          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    // blog('checkPicsListsAreIdentical : _listsAreIdentical : $_listsAreIdentical');

    return _listsAreIdentical;

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString(){

    final String _text =
    '''
    PicModel(
      file: ${file?.stringify},
      meta: $meta
    );
    ''';

    return _text;
   }
  // --------------------
  /// TASK : TEST_ME_NOW
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is MediaModel){
      _areIdentical = MediaMetaModel.checkMetaDatasAreIdentical(
        meta1: meta,
        meta2: other.meta,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      meta.hashCode^
      file.hashCode;
  // -----------------------------------------------------------------------------
}

class MediaModelCreator {
  // -----------------------------------------------------------------------------

  const MediaModelCreator();

  // -----------------------------------------------------------------------------

  /// BYTES

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromBytes({
    required Uint8List? bytes,
    required String? fileName,
    String? uploadPath,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
  }) async {

    final XFile? _file = await XFiler.createFromBytes(
      bytes: bytes,
      fileName: fileName,
    );

    return MediaModelCreator.fromXFile(
      file: _file,
      mediaOrigin: mediaOrigin,
      uploadPath: uploadPath,
      ownersIDs: ownersIDs,
      renameFile: fileName,
    );

  }
  // -----------------------------------------------------------------------------

  /// URL

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromURL({
    required String? url,
    required String? fileName,
    String? uploadPath,
    List<String>? ownersIDs,
  }) async {

    if (ObjectCheck.isAbsoluteURL(url) == false){
      return null;
    }
    else {

      final XFile? _file = await XFiler.createFromURL(
        url: url,
        fileName: fileName,
      );

      final MediaModel? _mediaModel = await  MediaModelCreator.fromXFile(
        file: _file,
        mediaOrigin: MediaOrigin.downloaded,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
        renameFile: fileName,
      );

      return _mediaModel?.copyWith(
        meta: _mediaModel.meta?.copyWith(
          data: MapperSS.insertPairInMapWithStringValue(
            map: _mediaModel.meta?.data,
            key: 'original_url',
            value: url!,
            overrideExisting: true,
          )
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// ASSET ENTITY

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromAssetEntity({
    required AssetEntity? asset,
    required String? renameFile,
    String? uploadPath,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
  }) async {

    final XFile? _xFile = await XFiler.readAssetEntity(
      assetEntity: asset,
    );

    final MediaModel? _model = await fromXFile(
      file: _xFile,
      mediaOrigin: mediaOrigin,
      uploadPath: uploadPath,
      ownersIDs: ownersIDs,
      renameFile: renameFile,
    );

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// FROM LOCAL ASSET

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromLocalAsset({
    required String localAsset,
    String? uploadPath,
    List<String>? ownersIDs,
    String? renameFile,
  }) async {
    MediaModel? _output;

    if (TextCheck.isEmpty(localAsset) == false){

      final XFile? _file = await XFiler.createFromLocalAsset(
        localAsset: localAsset,
      );

      _output = await fromXFile(
        file: _file,
        mediaOrigin: MediaOrigin.generated,
        uploadPath: uploadPath ?? '',
        ownersIDs: ownersIDs,
        renameFile: renameFile,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<MediaModel>> fromLocalAssets({
    required List<String> localAssets,
    // required int width,
  }) async {
    final List<MediaModel> _output = [];

    if (Lister.checkCanLoop(localAssets) == true){

      for (final String asset in localAssets){

        final MediaModel? _pic = await fromLocalAsset(
          localAsset: asset,
          // ownersIDs: ,
          // uploadPath: ,
        );

        if (_pic != null){
          _output.add(_pic);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FROM X FILE

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromXFile({
    required XFile? file,
    required MediaOrigin? mediaOrigin,
    required String? uploadPath,
    required List<String>? ownersIDs,
    required String? renameFile,
  }) async {
    MediaModel? _output;

    // blog('  1.combinePicModel start : ${bytes?.length} bytes : picMakerType $picMakerType : '
    //     'assignPath : $assignPath : name : $name');

    if (file != null){

      // blog('  2.combinePicModel bytes exists bytes != null');

      final Uint8List _bytes = await file.readAsBytes();
      final Dimensions? _dims =  await DimensionsGetter.fromXFile(file: file);
      final double? _aspectRatio = Numeric.roundFractions(_dims?.getAspectRatio(), 2);
      final double? _mega = FileSizer.calculateSize(_bytes.length, FileSizeUnit.megaByte);
      final double? _kilo = FileSizer.calculateSize(_bytes.length, FileSizeUnit.kiloByte);
      final String? _deviceID = await DeviceChecker.getDeviceID();
      final String? _deviceName = await DeviceChecker.getDeviceName();
      final String _devicePlatform = kIsWeb == true ? 'web' : Platform.operatingSystem;
      final String? _fileName = FileTyper.fixFileName(fileName: renameFile ?? file.fileName, bytes: _bytes);
      final XFile? _xFile = await XFiler.renameFile(file: file, newName: _fileName);
      final String? _extension = FileTyper.getExtension(object: _xFile);
      final FileExtType? _fileExtensionType = FileTyper.getTypeByExtension(_extension);

      /// SOMETHING IS MISSING
      if (
          _xFile == null ||
          _fileExtensionType == null ||
          _dims == null ||
          _fileName == null ||
          _aspectRatio == null ||
          _mega == null ||
          _kilo == null ||
          _deviceID == null ||
          _deviceName == null
      ){
        _output = null;
        // blog('  3.dims : $_dims');
        // blog('  3.aspectRatio : $_aspectRatio');
        // blog('  3.mega : $_mega');
        // blog('  3.kilo : $_kilo');
        // blog('  3.deviceID : $_deviceID');
        // blog('  3.deviceName : $_deviceName');
        // blog('  3.devicePlatform : $_devicePlatform');
      }

      /// ALL IS GOOD
      else {
        _output = MediaModel(
          file: _xFile,
          meta: MediaMetaModel(
            sizeMB: _mega,
            width: _dims.width,
            height: _dims.height,
            fileExt: _fileExtensionType,
            name: _fileName,
            ownersIDs: ownersIDs ?? [],
            uploadPath: uploadPath,
            data: MapperSS.cleanNullPairs(
              map: {
                'aspectRatio': _aspectRatio.toString(),
                'sizeB': _bytes.length.toString(),
                'sizeKB': _kilo.toString(),
                'source': MediaModel.cipherMediaOrigin(mediaOrigin),
                'deviceID': _deviceID,
                'deviceName': _deviceName,
                'platform': _devicePlatform,
              },
            ),
          ),
        );
      }

    }

    // blog('  3.combinePicModel _output is null ${_output == null}');

    return _output;
  }
  // -----------------------------------------------------------------------------
}
