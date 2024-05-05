part of media_models;
/// => TAMAM
@immutable
class MediaModel {
  // -----------------------------------------------------------------------------
  const MediaModel({
    /// SHOULD BE IDIFIED UPLOAD PATH,
    required this.id,
    required this.bytes,
    required this.meta,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final Uint8List? bytes;
  final MediaMetaModel? meta;
  // -----------------------------------------------------------------------------

  /// PATHING RULES

  // --------------------
  /// AT ALL TIMES, IN ANY INSTANCE, THESE RULES SHOULD APPLY
  /// * ID is an Idified uploadPath
  /// * file name should have no extension
  /// * upload path should have file name as last node
  /// * ID is non nullable
  /// - EXAMPLE :-
  /// uploadPath  = 'folder/subFolder/file_name_without_extension';
  /// fileName    = 'file_name_without_extension';
  /// id          = 'folder_subFolder_file_name_without_extension';
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createID({
    required String? uploadPath,
  }){

    if (TextCheck.isEmpty(uploadPath) == true){
      return null;
    }
    else {

      final String? _output = TextMod.replaceAllCharacters(
        characterToReplace: '/',
        replacement: '_',
        input: uploadPath,
      );

      return TextMod.removeTextAfterLastSpecialCharacter(
        specialCharacter: '.',
        text: _output,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> createIDs({
    required List<String> uploadPaths,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(uploadPaths) == true){

      for (final String path in uploadPaths){

        final String? _id = createID(
          uploadPath: path,
        );

        if (_id != null){
          _output.add(_id);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel copyWith({
    String? id,
    Uint8List? bytes,
    MediaMetaModel? meta,
  }){
    return MediaModel(
      id: id ?? this.id,
      bytes: bytes ?? this.bytes,
      meta: meta ?? this.meta,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel nullifyField({
    bool bytes = false,
    bool meta = false,
  }){
    return MediaModel(
      id: id,
      bytes: bytes == true ? null : this.bytes,
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
        'id': mediaModel.id,
        'bytes': Byter.intsFromBytes(mediaModel.bytes),
        'meta': mediaModel.meta?.cipherToLDB()
      };
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static MediaModel? decipherFromLDB(Map<String, dynamic>? map){
    MediaModel? _picModel;

    if (map?['id'] != null){

      _picModel = MediaModel(
        id: map!['id'],
        bytes: Byter.fromInts(map['bytes']),
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

      case MediaOrigin.facebook:    return 'facebook';
      case MediaOrigin.instagram:   return 'instagram';
      case MediaOrigin.amazon:      return 'amazon';
      case MediaOrigin.website:     return 'website';

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

      case 'facebook':      return    MediaOrigin.facebook;
      case 'instagram':     return    MediaOrigin.instagram;
      case 'amazon':        return    MediaOrigin.amazon;
      case 'website':       return    MediaOrigin.website;

      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// ASSERTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> assertIsUploadable(MediaModel? mediaModel) async {

    assert(mediaModel != null, 'mediaModel is null');
    assert(mediaModel?.id != null, "mediaModel's id is null");
    assert(mediaModel?.meta != null, "mediaModel's meta is null");
    assert(Mapper.boolIsTrue(mediaModel?.bytes?.isNotEmpty) == true, "mediaModel's bytes are empty");

    final String? _id = mediaModel?.id;
    final String? _uploadPath = mediaModel?.meta?.uploadPath;
    final String? _idShouldBe = MediaModel.createID(uploadPath: _uploadPath);
    final bool _pathsAreGood = _id == _idShouldBe;
    assert(_pathsAreGood, 'Paths are not good : id : $_id : _uploadPath : $_uploadPath');

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  String? getName({
    bool withExtension = true,
  }){

    String? _name = meta?.name;

    if (withExtension == false){

      _name = TextMod.removeTextAfterLastSpecialCharacter(
          text: _name,
          specialCharacter: '.',
      );

      _name ??= FilePathing.getNameFromPath(
          path: meta?.uploadPath,
          withExtension: withExtension
      );

    }

    return _name;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions? getDimensions(){

    if (meta?.width == null || meta?.height == null){
      return null;
    }
    else {
      return Dimensions(
          width: meta?.width,
          height: meta?.height,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double? getSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) {

    if (bytes == null){
      return null;
    }
    else {
      return FileSizer.calculateSize(bytes!.length, fileSizeUnit);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  int getBytesLength(){
    return bytes?.length ?? 0;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaOrigin? getMediaOrigin(){
    return meta?.getMediaOrigin();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getOriginalURl(){
    return meta?.getOriginalURL();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getFilePath(){
    return meta?.getFilePath();
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool isVideo(){
    return meta?.checkFileIsVideo() ?? false;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool isImage(){
    return meta?.checkFileIsImage() ?? false;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool isAudio(){
    return meta?.checkFileIsAudio() ?? false;
  }
  // -----------------------------------------------------------------------------
  
  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<MediaModel> replaceBytes({
    required Uint8List? bytes,
  }) async {
    
    if (bytes == null || meta?.uploadPath == null){
      return this;
    }
    else {

      final MediaModel? _output = await MediaModelCreator.fromBytes(
          bytes: bytes,
          mediaOrigin: getMediaOrigin(),
          uploadPath: meta!.uploadPath!,
          ownersIDs: meta?.ownersIDs,
      );

      return _output ?? this;
    }
    
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  MediaModel overrideUploadPath({
    required String? uploadPath
  }){

    if (uploadPath != meta?.uploadPath){

      final String? _fileName = FilePathing.getNameFromPath(
          path: uploadPath,
          withExtension: false,
      );

      return copyWith(
        id: createID(uploadPath: uploadPath),
        meta: meta?.copyWith(
          uploadPath: uploadPath,
          name: _fileName,
        ),
      );
    }

    else {
      return this;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<MediaModel> renameFile({
    required String? newName,
  }) async {

    if (TextCheck.isEmpty(newName) == true){
      return this;
    }
    else {

      final String? _newName = FilePathing.fixFileName(
        fileName: newName,
        bytes: bytes,
        includeFileExtension: false,
        filePath: getFilePath(),
      );

      final String? _newPath = FilePathing.replaceFileNameInPath(
          oldPath: meta?.uploadPath,
          fileName: _newName,
      );

      // blog('--> renameFile | _newName : $_newName | _newPath : $_newPath | id : ${createID(uploadPath: _newPath)} |');

      return copyWith(
        id: createID(uploadPath: _newPath),
        meta: meta?.copyWith(
          name: _newName,
          uploadPath: _newPath,
        ),
      );

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
  MediaModel setOriginalURL({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel setCaption({
    required String? caption,
  }){

    if (caption == null){
      return this;
    }
    else {

      final MediaMetaModel? _meta = meta?.copyWith(
        data: MapperSS.insertPairInMapWithStringValue(
          map: meta?.data,
          key: 'caption',
          value: caption,
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
    bytes: ${bytes?.length} bytes,
    meta: $meta
    ''';

    blog('blooging Media Model : $invoker');
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
  static bool checkMediaModelsAreIdentical({
    required MediaModel? model1,
    required MediaModel? model2,
  }) {
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }
    else if (model1 != null && model2 != null){

      if (MediaMetaModel.checkMetaDatasAreIdentical(meta1: model1.meta, meta2: model2.meta) == true){

        _identical = Byter.checkBytesAreIdentical(
          bytes1: model1.bytes,
          bytes2: model2.bytes,
        );

      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMediaModelsListsAreIdentical({
    required List<MediaModel>? models1,
    required List<MediaModel>? models2,
  }) {

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

          final bool _pairAreIdentical = checkMediaModelsAreIdentical(
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
      bytes: ${bytes?.length} bytes,
      meta: StorageMetaModel(
        width: ${meta?.width},
        height: ${meta?.height},
        sizeMB: ${meta?.sizeMB},
        name: ${meta?.name},
        uploadPath: ${meta?.uploadPath},
        fileExt: ${meta?.fileExt},
        ownersIDs: ${meta?.ownersIDs},
        data: {
          'aspectRatio': ${meta?.data?['aspectRatio']},
          'sizeB': ${meta?.data?['sizeB']},
          'sizeKB': ${meta?.data?['sizeKB']},
          'source': ${meta?.data?['source']},
          'deviceID': ${meta?.data?['deviceID']},
          'deviceName': ${meta?.data?['deviceName']},
          'platform': ${meta?.data?['platform']},
          'original_url': ${meta?.data?['original_url']},
          'file_path': ${meta?.data?['file_path']},
        },
      ),
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
      _areIdentical = checkMediaModelsAreIdentical(
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
      bytes.hashCode;
  // -----------------------------------------------------------------------------
}
