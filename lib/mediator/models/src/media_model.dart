part of media_models;
/// => TAMAM
@immutable
class MediaModel {
  // -----------------------------------------------------------------------------
  const MediaModel({
    required this.file,
    required this.meta,
  });
  // -----------------------------------------------------------------------------
  final SuperFile? file;
  final MediaMetaModel? meta;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel copyWith({
    SuperFile? file,
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
        'id': mediaModel.file?.getFileName(withExtension: false),
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
        file: map['path'] == null ? null : SuperFile(map['path']),
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
    final Uint8List? _bytes = await Byter.fromSuperFile(mediaModel?.file);
    assert(_bytes != null, 'bytes is null');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  String? getName({
    bool withExtension = true,
  }){

    return file?.getFileName(withExtension: withExtension);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Dimensions?> getDimensions() async {
    final Dimensions? _dim = await DimensionsGetter.fromSuperFile(
      file: file,
    );
    return _dim;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<double?> getSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) async {

    final double? _size = await file?.readSize(
      fileSizeUnit: fileSizeUnit,
    );

    return _size;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Uint8List?> getBytes() async {
    final Uint8List? _bytes = await Byter.fromSuperFile(file);
    return _bytes;
  }
  // --------------------
  //// TESTED : WORKS PERFECT
  int getBytesLength(){
    final Map<String, String>? _data = meta?.data;
    return Numeric.transformStringToInt(_data?['sizeB']) ?? 0;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaOrigin? getMediaOrigin(){
    return meta?.getMediaOrigin();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SuperFile> getFilesFromMediaModels({
    required List<MediaModel> mediaModels,
  }){
    final List<SuperFile> _output = [];

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
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> getBytezzFromMediaModels({
    required List<MediaModel> mediaModels,
  }) async {
    final List<Uint8List> _output = [];
    
    if (Lister.checkCanLoop(mediaModels) == true){
      
      for (final MediaModel model in mediaModels){
        
        final Uint8List? _bytes = await Byter.fromSuperFile(model.file);
        
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
  /// TESTED : WORKS PERFECT
  Future<MediaModel> replaceBytes({
    required Uint8List? bytes,
  }) async {
    
    if (bytes == null){
      return this;
    }
    else {

      final SuperFile? _file = await file?.replaceBytes(
        bytes: bytes,
      );

      final MediaModel? _output = await MediaModelCreator.fromSuperFile(
          file: _file,
          mediaOrigin: getMediaOrigin(),
          uploadPath: meta?.uploadPath,
          ownersIDs: meta?.ownersIDs,
          // rename: null,
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
  /// TESTED : WORKS PERFECT
  Future<MediaModel> renameFile({
    required String? newName,
  }) async {

    if (
           file == null
        || newName == null
        || newName == ''
        || file?.getFileName(withExtension: false) == newName
        || file?.getFileName(withExtension: true) == newName
    ){
      return this;
    }
    else {

      final String _oldPath = file!.path;
      final String? _newPath = await FilePathing.createPathByName(
        fileName: newName,
      );

      if (_newPath != null && _oldPath != _newPath){

        final MediaModel? _output = await MediaModelCreator.fromSuperFile(
          file: file,
          mediaOrigin: getMediaOrigin(),
          uploadPath: meta?.uploadPath,
          ownersIDs: meta?.ownersIDs,
          rename: newName,
        );

        return _output ?? this;

      }

      else {
        return this;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel addOriginalURL({
    required String? originalURL,
  }){

    if (originalURL == null){
      return this;
    }
    else {

      final MediaMetaModel? _meta = meta?.copyWith(
        data: MapperSS.insertPairInMapWithStringValue(
            map: meta?.data,
            key: 'original_url',
            value: originalURL,
            overrideExisting: true,
        ),
      );

      return copyWith(
        meta: _meta,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel setMediaOrigin({
    required MediaOrigin? mediaOrigin,
  }){

    if (mediaOrigin == null){
      return this;
    }
    else {

      final MediaMetaModel? _meta = meta?.copyWith(
        data: MapperSS.insertPairInMapWithStringValue(
          map: meta?.data,
          key: 'source',
          value: MediaModel.cipherMediaOrigin(mediaOrigin)!,
          overrideExisting: true,
        ),
      );

      return copyWith(
        meta: _meta,
      );

    }

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
    $file,
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
  /// TESTED : WORKS PERFECT
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

        _identical = SuperFile.checkFilesAreIdentical(
            file1: model1.file,
            file2: model2.file,
        );

        if (_identical == true){
          _identical = Byter.checkBytesAreIdentical(
              bytes1: await model1.file?.readBytes(),
              bytes2: await model2.file?.readBytes(),
          );
        }

      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMediaModelsAreIdenticalSync({
    required MediaModel? model1,
    required MediaModel? model2,
  }) {
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }
    else if (model1 != null && model2 != null){

      if (
      model1.file?.path == model2.file?.path
      &&
      MediaMetaModel.checkMetaDatasAreIdentical(
          meta1: model1.meta,
          meta2: model2.meta
      ) == true){

        _identical = true;

      }

    }

    // if (_identical == false){
    //   Mapper.blogMapsDifferences(
    //       map1: MediaModel.cipherToLDB(model1),
    //       map2: MediaModel.cipherToLDB(model2),
    //       invoker: 'checkMediaModelsAreIdenticalSync',
    //   );
    // }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
      file: $file,
      meta: $meta
    );
    ''';

    return _text;
   }
  // --------------------
  /// TESTED : WORKS PERFECT
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is MediaModel){
      _areIdentical = checkMediaModelsAreIdenticalSync(
        model1: this,
        model2: other,
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
