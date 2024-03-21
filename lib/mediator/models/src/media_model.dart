part of media_models;

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
        'id': mediaModel.file?.fileNameWithoutExtension,
        'path': mediaModel.file?.path,
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
