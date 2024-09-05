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
  static List<Map<String, dynamic>> cipherMediasToLDB(List<MediaModel> medias){
    final List<Map<String, dynamic>> _output = [];

    if (Lister.checkCanLoop(medias) == true){

      for (final MediaModel media in medias){

        final Map<String, dynamic>? _map = cipherToLDB(media);

        if (_map != null){
          _output.add(_map);
        }

      }

    }

    return _output;
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

      _name ??= FileNaming.getNameFromPath(
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
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getExtension(){
    final FileExtType? _type = meta?.fileExt;
    return FileExtensioning.getExtensionByType(_type);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getUploadPath(){
    return meta?.uploadPath;
  }
  // -----------------------------------------------------------------------------

  /// MEDIAS GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getMediasUploadPaths({
    required List<MediaModel> medias,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(medias) == true){

      for (final MediaModel media in medias){

        _output = Stringer.addStringToListIfDoesNotContainIt(
            strings: _output,
            stringToAdd: media.meta?.uploadPath,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getMediasParentUploadPaths({
    required List<MediaModel> medias,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(medias) == true){

      for (final MediaModel media in medias){

        final String? _parentFolder = Pathing.removeLastPathNode(
            path: media.meta?.uploadPath,
        );

        _output = Stringer.addStringToListIfDoesNotContainIt(
          strings: _output,
          stringToAdd: _parentFolder,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<MediaModel> findTheNotUploaded({
    required List<MediaModel> allMedias,
    required List<MediaModel> uploadedMedias,
  }){
    List<MediaModel> _output = [];

    if (Lister.checkCanLoop(uploadedMedias) == false){
      _output = allMedias;
    }
    else if (Lister.checkCanLoop(allMedias) == true){

      for (final MediaModel media in allMedias){

        final MediaModel? _uploaded = findMediaByUploadPath(
            medias: uploadedMedias,
            uploadPath: media.getUploadPath(),
        );

        /// NO FOUND IN UPLOADED LIST
        if (_uploaded == null){
          _output.add(media);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FINDERS

  // --------------------
  /// AI TESTED
  static MediaModel? findMediaByUploadPath({
    required List<MediaModel> medias,
    required String? uploadPath,
  }){
    MediaModel? _output;

    if (Lister.checkCanLoop(medias) == true && uploadPath != null){

      for (final MediaModel _media in medias){

        final String? _mediaUploadPath = _media.getUploadPath();
        if (_mediaUploadPath == uploadPath){
          _output = _media;
          break;
        }

      }

    }

    return _output;
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
        skipMetaData: false,
        // caption: ,
        // includeFileExtension: ,
      );

      return _output ?? this;
    }
    
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  MediaModel overrideUploadPath({
    required String? uploadPath
  }){

    if (uploadPath != meta?.uploadPath){

      final String? _fileName = FileNaming.getNameFromPath(
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
    bool includeFileExtension = false,
  }) async {

    if (TextCheck.isEmpty(newName) == true){
      return this;
    }
    else {

      final String? _newName = await FormatDetector.fixFileNameByBytes(
        fileName: newName,
        bytes: bytes,
        includeFileExtension: includeFileExtension,
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
  MediaModel setFilePath({
    required String? filePath,
  }){

    if (filePath == null){
      return this;
    }
    else {

      final MediaMetaModel? _meta = meta?.copyWith(
        data: MapperSS.insertPairInMapWithStringValue(
          map: meta?.data,
          key: 'file_path',
          value: filePath,
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
  MediaModel setOwnersIDs({
    required List<String>? ownersIDs,
  }){

    if (Lister.checkCanLoop(ownersIDs) == false){
      return this;
    }
    else {

      final MediaMetaModel? _meta = meta?.copyWith(
        ownersIDs: ownersIDs,
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
    id: $id,
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
      skipMetaData: false,
      // renameFile: null,
    );

    return _mediaModel!;

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// DEPRECATED
  /*
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
   */
  // -----------------------------------------------------------------------------

  /// SIMILARITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMediaModelsAreSimilar({
    required MediaModel? model1,
    required MediaModel? model2,
  }) {
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }
    else if (model1 != null && model2 != null){

      if (MediaMetaModel.checkMetaDatasAreSimilar(meta1: model1.meta, meta2: model2.meta) == true){

        _identical = Byter.checkBytesAreIdentical(
          bytes1: model1.bytes,
          bytes2: model2.bytes,
        );

      }

    }

    if (_identical == false){
      blogMediaMainDifferences(
        model1: model1,
        model2: model2,
        invoker: 'checkMediaModelsAreSimilar',
      );
    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMediaModelsListsAreSimilar({
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

          final bool _pairAreIdentical = checkMediaModelsAreSimilar(
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

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogMediaMainDifferences({
    required MediaModel? model1,
    required MediaModel? model2,
    required String invoker,
  }){
    blog('| $invoker | blogMediaMainDifferences | START --------o');

    if (model1 == null){
      blog('||| model1 is null');
    }

    if (model2 == null){
      blog('||| model2 is null');
    }

    if (model1 != null && model2 != null){

      if (model1.meta?.width != model2.meta?.width){
        blog('| model1.meta?.width != model2.meta?.width');
      }

      if (model1.meta?.height != model2.meta?.height){
        blog ('| model1.meta?.height != model2.meta?.height');
      }
      if (model1.meta?.fileExt != model2.meta?.fileExt){
        blog ('| model1.meta?.fileExt != model2.meta?.fileExt');
      }

      if (model1.meta?.sizeMB != model2.meta?.sizeMB){
        blog ('| model1.meta?.sizeMB != model2.meta?.sizeMB');
      }

      if (model1.meta?.name != model2.meta?.name){
        blog ('| model1.meta?.name != model2.meta?.name');
      }

      if (model1.meta?.uploadPath != model2.meta?.uploadPath){
        blog ('| model1.meta?.uploadPath != model2.meta?.uploadPath');
      }

      final bool _bytesAreIdentical = Byter.checkBytesAreIdentical(
        bytes1: model1.bytes,
        bytes2: model2.bytes,
      );

      if (_bytesAreIdentical == false){
        blog('| _bytesAreIdentical = false');
      }

    }

    blog('| $invoker | blogMediaMainDifferences | : END --------o');
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString(){

    final String _text =
    '''
    PicModel(
      id: $id,
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
      _areIdentical = checkMediaModelsAreSimilar(
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
