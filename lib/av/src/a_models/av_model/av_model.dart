part of av;

@immutable
class AvModel {
  // --------------------------------------------------------------------------
  const AvModel({
    required this.id,
    required this.xFile,
    this.ownersIDs,
    this.width,
    this.height,
    this.name,
    this.sizeMB,
    this.sizeB,
    this.fileExt,
    this.data,
    this.uploadPath,
    this.origin,
    this.originalURL,
    this.caption,
    this.durationMs,
  });
  // --------------------
  final String id;
  final XFile xFile;
  final List<String>? ownersIDs;
  final double? width;
  final double? height;
  final String? name;
  final double? sizeMB;
  final int? sizeB;
  final FileExtType? fileExt;
  final Map<String, String>? data;
  final String? uploadPath; /// storage/collectionName/subCollectionName/fileName.ext
  final AvOrigin? origin; /// might be called ['source'] in external db
  final String? originalURL;
  final String? caption;
  final int? durationMs;
  /// NOT SURE ABOUT THOSE
  // final String? deviceID;
  // final String? deviceName;
  // final String? platform;
  /// NOT SURE ABOUT THOSE
  // --------------------------------------------------------------------------

  /// DUMMY PIC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> dummyPic({
    String? localAsset,
  }) async {

    // final MediaModel? _mediaModel = await MediaModelCreator.fromLocalAsset(
    //   localAsset: localAsset ?? Iconz.bldrsAppIcon,
    //   ownersIDs: const ['OwnerID'],
    //   uploadPath: 'storage/bldrs/bldrs_app_icon.png',
    //   skipMetaData: false,
    //   // renameFile: null,
    // );
    //
    // return _mediaModel!;

    return null;
  }
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  AvModel copyWith({
    String? id,
    XFile? xFile,
    List<String>? ownersIDs,
    double? width,
    double? height,
    String? name,
    double? sizeMB,
    int? sizeB,
    FileExtType? fileExt,
    Map<String, String>? data,
    String? uploadPath,
    AvOrigin? origin,
    String? originalURL,
    String? caption,
    int? durationMs,
  }){

    return AvModel(
      id: id ?? this.id,
      xFile: xFile ?? this.xFile,
      ownersIDs: ownersIDs ?? this.ownersIDs,
      width: width ?? this.width,
      height: height ?? this.height,
      name: name ?? this.name,
      sizeMB: sizeMB ?? this.sizeMB,
      sizeB: sizeB ?? this.sizeB,
      fileExt: fileExt ?? this.fileExt,
      data: data ?? this.data,
      uploadPath: uploadPath ?? this.uploadPath,
      origin: origin ?? this.origin,
      originalURL: originalURL ?? this.originalURL,
      caption: caption ?? this.caption,
      durationMs: durationMs ?? this.durationMs,
    );

  }
  // --------------------
  ///
  AvModel nullifyField({
    // bool id = false,
    // bool xFile = false,
    bool ownersIDs = false,
    bool width = false,
    bool height = false,
    bool name = false,
    bool sizeMB = false,
    bool sizeB = false,
    bool fileExt = false,
    bool data = false,
    bool uploadPath = false,
    bool origin = false,
    bool originalURL = false,
    bool caption = false,
    bool durationMs = false,
  }){
    return AvModel(
      id: id,
      xFile: xFile,
      ownersIDs: ownersIDs == true ? null : this.ownersIDs,
      width: width == true ? null : this.width,
      height: height == true ? null : this.height,
      name: name == true ? null : this.name,
      sizeMB: sizeMB == true ? null : this.sizeMB,
      sizeB: sizeB == true ? null : this.sizeB,
      fileExt: fileExt == true ? null : this.fileExt,
      data: data == true ? null : this.data,
      uploadPath: uploadPath == true ? null : this.uploadPath,
      origin: origin == true ? null : this.origin,
      originalURL: originalURL == true ? null : this.originalURL,
      caption: caption == true ? null : this.caption,
      durationMs: durationMs == true ? null : this.durationMs,
    );
  }
  // --------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// WRITE_ME
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'xFile': xFile.path,
      'ownersIDs': ownersIDs,
      'width': width,
      'height': height,
      'name': name,
      'sizeMB': sizeMB,
      'sizeB': sizeB,
      'fileExt': FileMiming.getMimeByType(fileExt),
      'data': data,
      'uploadPath': uploadPath,
      'origin': AvModel.cipherMediaOrigin(origin),
      'originalURL': originalURL,
      'caption': caption,
      'durationMs': durationMs,
    };
  }
  // --------------------
  /// WRITE_ME
  static AvModel? fromMap({
    required Map<String, dynamic>? map,
  }){

    final String? _filePath = map?['xFile'];

    /// SHOULD_CHECK_IF_FILE_EXISTS_IN_DIRECTORY

    if (map == null || _filePath == null){
      return null;
    }

    else {

      return AvModel(
        id: map['id'],
        xFile: XFile(_filePath),
        ownersIDs: Stringer.getStringsFromDynamics(map['ownersIDs']),
        width: map['width'],
        height: map['height'],
        name: map['name'],
        sizeMB: map['sizeMB'],
        sizeB: map['sizeB'],
        fileExt: FileMiming.getTypeByMime(map['fileExt']),
        data: MapperSS.createStringStringMap(hashMap: map['data'], stringifyNonStrings: true),
        uploadPath: map['uploadPath'],
        origin: AvModel.decipherMediaOrigin(map['origin']),
        originalURL: map['originalURL'],
        caption: map['caption'],
        durationMs: map['durationMs'],
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
  // --------------------------------------------------------------------------

  /// ASSERTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> assertIsUploadable(AvModel? avModel) async {

    assert(avModel != null, 'avModel is null');
    assert(avModel?.id != null, "avModel's id is null");

    assert(avModel?.width != null, "avModel's width is null");
    assert(avModel?.height != null, "avModel's height is null");
    assert(avModel?.name != null, "avModel's name is null");
    assert(avModel?.sizeMB != null, "avModel's sizeMB is null");
    assert(avModel?.sizeB != null, "avModel's sizeB is null");
    assert(avModel?.fileExt != null, "avModel's fileExt is null");
    assert(avModel?.uploadPath != null, "avModel's uploadPath is null");
    assert(avModel?.origin != null, "avModel's origin is null");

    // List<String>? ownersIDs; can be null
    // String? originalURL; can be null
    // String? caption; can be null
    // int? durationMs; can be null

    final String? _id = avModel?.id;
    final String? _uploadPath = avModel?.uploadPath;
    final String? _idShouldBe = AvPathing.createID(uploadPath: _uploadPath);
    final bool _pathsAreGood = _id == _idShouldBe;
    assert(_pathsAreGood, 'Paths are not good : id : $_id : _uploadPath : $_uploadPath');

  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Uint8List?> getBytes() async {
    return Byter.fromXFile(xFile, 'getBytes');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getName({
    bool withExtension = true,
  }){

    String? _name = name;

    if (withExtension == false){

      _name = TextMod.removeTextAfterLastSpecialCharacter(
        text: _name,
        specialCharacter: '.',
      );

      _name ??= FileNaming.getNameFromPath(
          path: uploadPath,
          withExtension: withExtension
      );

    }

    return _name;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions? getDimensions(){

    return Dimensions(
      width: width,
      height: height,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double? getSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) {

    if (sizeB == null){
      return null;
    }
    else {
      return FileSizer.calculateSize(sizeB, fileSizeUnit);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  int getBytesLength(){
    return sizeB ?? 0;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  AvOrigin? getMediaOrigin(){
    return origin;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getOriginalURl(){
    return originalURL;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getFilePath(){
    return xFile.path;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> getOwnersIDs(){
    return ownersIDs ?? [];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getCaption(){
    return caption;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getExtension(){
    final FileExtType? _type = fileExt;
    return FileExtensioning.getExtensionByType(_type);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getUploadPath(){
    return uploadPath;
  }
  // --------------------------------------------------------------------------

  /// MEDIAS GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getMediasUploadPaths({
    required List<AvModel> avModels,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(avModels) == true){

      for (final AvModel avModel in avModels){

        _output = Stringer.addStringToListIfDoesNotContainIt(
          strings: _output,
          stringToAdd: avModel.uploadPath,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getMediasParentUploadPaths({
    required List<AvModel> avModels,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(avModels) == true){

      for (final AvModel media in avModels){

        final String? _parentFolder = Pathing.removeLastPathNode(
          path: media.uploadPath,
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
  static List<AvModel> findTheNotUploaded({
    required List<AvModel> allModels,
    required List<AvModel> uploadedModels,
  }){
    List<AvModel> _output = [];

    if (Lister.checkCanLoop(uploadedModels) == false){
      _output = allModels;
    }
    else if (Lister.checkCanLoop(allModels) == true){

      for (final AvModel avModel in allModels){

        final AvModel? _uploaded = findMediaByUploadPath(
          avModels: uploadedModels,
          uploadPath: avModel.uploadPath,
        );

        /// NO FOUND IN UPLOADED LIST
        if (_uploaded == null){
          _output.add(avModel);
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FINDERS

  // --------------------
  /// AI TESTED
  static AvModel? findMediaByUploadPath({
    required List<AvModel> avModels,
    required String? uploadPath,
  }){
    AvModel? _output;

    if (Lister.checkCanLoop(avModels) == true && uploadPath != null){

      for (final AvModel avModel in avModels){

        final String? _mediaUploadPath = avModel.uploadPath;
        if (_mediaUploadPath == uploadPath){
          _output = avModel;
          break;
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool isVideo(){
    return FileTyper.checkTypeIsVideo(fileExt);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool isImage(){
    return FileTyper.checkTypeIsImage(fileExt);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool isAudio(){
    return FileTyper.checkTypeIsAudio(fileExt);
  }
  // --------------------------------------------------------------------------

  /// TYPE CHECKERS

  // --------------------
  bool isPNG(){
    return fileExt == FileExtType.png;
  }
  // --------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// DEPRECATED
  /*
  Future<AvModel> replaceBytes({
    required Uint8List? bytes,
  }) async {
    AvModel _output = avModel;

    if (bytes != null || avModel.uploadPath != null){

      final XFile? _xFile = await XFiler.replaceBytes(file: avModel.xFile, bytes: bytes);

      if (_xFile != null){

        AvModel? _output = copyWith(
          xFile: _xFile,
          sizeB: ,
          fileExt: ,
          height: ,
          width: ,
          durationMs: ,
          sizeMB: ,

        );

        // AvModel? _output = await MediaModelCreator.fromBytes(
        //   bytes: bytes,
        //   mediaOrigin: getMediaOrigin(),
        //   uploadPath: meta!.uploadPath!,
        //   ownersIDs: meta?.ownersIDs,
        //   skipMetaData: false,
        //   // caption: ,
        //   // includeFileExtension: ,
        // );

        _output = _output?.setOriginalURL(originalURL: getOriginalURl());
        _output = _output?.setFilePath(filePath: getFilePath());

      }

    }

    return _output;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  AvModel overrideUploadPath({
    required String? uploadPath
  }){

    if (uploadPath != this.uploadPath){

      final String? _fileName = FileNaming.getNameFromPath(
        path: uploadPath,
        withExtension: false,
      );

      return copyWith(
        id: AvPathing.createID(uploadPath: uploadPath),
        uploadPath: uploadPath,
        name: _fileName,
      );
    }

    else {
      return this;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel> renameFile({
    required String? newName,
    bool includeFileExtension = false,
  }) async {

    if (TextCheck.isEmpty(newName) == true){
      return this;
    }
    else {

      final Uint8List? bytes = await Byter.fromXFile(xFile, 'renameFile');

      final String? _newName = await FormatDetector.fixFileNameByBytes(
        fileName: newName,
        bytes: bytes,
        includeFileExtension: includeFileExtension,
      );

      final String? _newPath = FilePathing.replaceFileNameInPath(
        oldPath: uploadPath,
        fileName: _newName,
      );

      // blog('--> renameFile | _newName : $_newName | _newPath : $_newPath | id : ${createID(uploadPath: _newPath)} |');

      return copyWith(
        id: AvPathing.createID(uploadPath: _newPath),
        uploadPath: _newPath,
        name: _newName,
      );

    }

  }
  // --------------------
  /// DEPRECATED
  /*
  static Future<List<AvModel>> replaceBytezzInMediaModels({
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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  AvModel setOriginalURL({
    required String? originalURL,
  }){
    return copyWith(
      originalURL: originalURL,
    );
  }
  // --------------------
  /// DEPRECATED
  /*
  AvModel setFilePath({
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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  AvModel setMediaOrigin({
    required AvOrigin? origin,
  }){
    return copyWith(
      origin: origin,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  AvModel setOwnersIDs({
    required List<String>? ownersIDs,
  }){
    return copyWith(
      ownersIDs: ownersIDs,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  AvModel setCaption({
    required String? caption,
  }){
    return copyWith(
      caption: caption,
    );
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPicIsEmpty(dynamic pic){
    bool _isEmpty = true;

    if (pic != null){

      /// URL
      if (ObjectCheck.isAbsoluteURL(pic) == true){
        _isEmpty = TextCheck.isEmpty(pic);
      }

      /// AV MODEL
      else if (pic is AvModel){
        _isEmpty = false;
      }

      /// XFILE
      else if (pic is XFile){
        final XFile _file = pic;
        _isEmpty = TextCheck.isEmpty(_file.path);
      }

      /// FILE
      else if (pic is File){
        final File _file = pic;
        _isEmpty = TextCheck.isEmpty(_file.path);
      }

      /// STRING
      else if (pic is String){
        _isEmpty = TextCheck.isEmpty(pic);
      }

      /// BYTES
      else if (ObjectCheck.objectIsUint8List(pic) == true){
        final Uint8List _uInts = pic;
        _isEmpty = _uInts.isEmpty;
      }

    }

    return _isEmpty;
  }
  // --------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelsAreIdentical({
    required AvModel? model1,
    required AvModel? model2,
  }) {
    bool _output = false;

    if (model1 == null && model2 == null){
      _output = true;
    }

    else if (model1 != null && model2 != null){

      if (
      model1.id == model2.id &&
          model1.xFile.path == model2.xFile.path &&
          Lister.checkListsAreIdentical(list1: model1.ownersIDs, list2: model2.ownersIDs) == true &&
          model1.width == model2.width &&
          model1.height == model2.height &&
          model1.name == model2.name &&
          model1.sizeMB == model2.sizeMB &&
          model1.sizeB == model2.sizeB &&
          model1.fileExt == model2.fileExt &&
          Mapper.checkMapsAreIdentical(map1: model1.data, map2: model2.data) == true &&
          model1.uploadPath == model2.uploadPath &&
          model1.origin == model2.origin &&
          model1.originalURL == model2.originalURL &&
          model1.caption == model2.caption &&
          model1.durationMs == model2.durationMs
      ){
        _output = true;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMediaModelsListsAreIdentical({
    required List<AvModel>? models1,
    required List<AvModel>? models2,
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

          final bool _pairAreIdentical = checkModelsAreIdentical(
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
  // --------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogModel({
    String invoker = '',
  }){

    final String _text =
    '''
BLOG.$invoker.    
$this
''';

    blog(_text);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPics({
    required List<AvModel>? models,
    String invoker = '',
  }){

    if (models == null){
      blog('blogPics : pics are null');
    }
    else if (models.isEmpty == true){
      blog('blogPics : pics are empty');
    }
    else {

      for (final AvModel model in models){

        model.blogModel(
          invoker: invoker,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogDifferences({
    required AvModel? model1,
    required AvModel? model2,
    required String invoker,
  }){
    blog('| $invoker | blogDifferences | START --------o');

    if (model1 == null){
      blog('||| model1 is null');
    }

    if (model2 == null){
      blog('||| model2 is null');
    }

    if (model1 != null && model2 != null){

      if (model1.id != model2.id){
        blog('model1.id != model2.id');
      }
      if (model1.xFile.path != model2.xFile.path){
        blog('model1.xFile != model2.xFile');
      }
      if (Lister.checkListsAreIdentical(list1: model1.ownersIDs, list2: model2.ownersIDs) == false){
        blog('model1.ownersIDs != model2.ownersIDs');
      }
      if (model1.width != model2.width){
        blog('model1.width != model2.width');
      }
      if (model1.height != model2.height){
        blog('model1.height != model2.height');
      }
      if (model1.name != model2.name){
        blog('model1.name != model2.name');
      }
      if (model1.sizeMB != model2.sizeMB){
        blog('model1.sizeMB != model2.sizeMB');
      }
      if (model1.sizeB != model2.sizeB){
        blog('model1.sizeB != model2.sizeB');
      }
      if (model1.fileExt != model2.fileExt){
        blog('model1.fileExt != model2.fileExt');
      }
      if (Mapper.checkMapsAreIdentical(map1: model1.data, map2: model2.data) == false){
        blog('model1.data != model2.data');
      }
      if (model1.uploadPath != model2.uploadPath){
        blog('model1.uploadPath != model2.uploadPath');
      }
      if (model1.origin != model2.origin){
        blog('model1.origin != model2.origin');
      }
      if (model1.originalURL != model2.originalURL){
        blog('model1.originalURL != model2.originalURL');
      }
      if (model1.caption != model2.caption){
        blog('model1.caption != model2.caption');
      }
      if (model1.durationMs != model2.durationMs){
        blog('model1.durationMs != model2.durationMs');
      }

      // final bool _bytesAreIdentical = Byter.checkBytesAreIdentical(
      //   bytes1: await AvModelExt(model1).getBytes(),
      //   bytes2: await AvModelExt(model2).getBytes(),
      // );
      // if (_bytesAreIdentical == false){
      //   blog('| _bytesAreIdentical = false');
      // }

    }

    blog('| $invoker | blogDifferences | : END --------o');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPictureInfo(PictureInfo info){
    blog('blogPictureInfo : START');

    blog('x---');
    blog('info.size.height                   : ${info.size.height}');
    blog('info.size.width                    : ${info.size.width}');
    blog('info.size.aspectRatio              : ${info.size.aspectRatio}');
    blog('info.size.longestSide              : ${info.size.longestSide}');
    blog('info.size.shortestSide             : ${info.size.shortestSide}');
    blog('x---');
    blog('info.picture.approximateBytesUsed  : ${info.picture.approximateBytesUsed}');
    blog('x---');
    blog('info.size.isEmpty                  : ${info.size.isEmpty}');
    blog('info.size.isFinite                 : ${info.size.isFinite}');
    blog('info.size.isInfinite               : ${info.size.isInfinite}');
    blog('x---');
    blog('info.viewport.left                 : ${info.picture.approximateBytesUsed}');
    blog('info.viewport.bottom               : ${info.picture.debugDisposed}');
    blog('x---');
    // info.size.flipped.
    blog('blogPictureInfo : END');
  }
  // --------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString(){

    final String _text =
'''
AvModel(
  id: $id,
  xFile: ${xFile.path},
  ownersIDs: $ownersIDs,
  width: $width,
  height: $height,
  name: $name,
  sizeMB: $sizeMB,
  sizeB: $sizeB,
  fileExt: $fileExt,
  data: $data,
  uploadPath: $uploadPath,
  origin: $origin,
  originalURL: $originalURL,
  caption: $caption,
  durationMs: $durationMs,
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
    if (other is AvModel){
      _areIdentical = checkModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      xFile.hashCode^
      ownersIDs.hashCode^
      width.hashCode^
      height.hashCode^
      name.hashCode^
      sizeMB.hashCode^
      sizeB.hashCode^
      fileExt.hashCode^
      data.hashCode^
      uploadPath.hashCode^
      origin.hashCode^
      originalURL.hashCode^
      caption.hashCode^
      durationMs.hashCode;
  // --------------------------------------------------------------------------
}

/// OLD META STUFF
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
//   // -----------------------------------------------------------------------------
//
//   /// CYPHERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Map<String, dynamic> cipherToLDB(){
//     return <String, dynamic>{
//       'ownersIDs': ownersIDs,
//       'fileType': FileMiming.getMimeByType(fileExt),
//       'width': width,
//       'height': height,
//       'name': name,
//       'sizeMB': sizeMB,
//       'data': data,
//       'uploadPath': uploadPath,
//     };
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static MediaMetaModel? decipherFromLDB(Map<String, dynamic>? map){
//     MediaMetaModel? _output;
//
//     if (map != null){
//       _output = MediaMetaModel(
//         ownersIDs: Stringer.getStringsFromDynamics(map['ownersIDs']),
//         fileExt: FileMiming.getTypeByMime(map['fileType']),
//         width: map['width'],
//         height: map['height'],
//         name: map['name'],
//         sizeMB: map['sizeMB'],
//         data: _getDataMap(map['data']),
//         uploadPath: map['uploadPath'],
//       );
//     }
//
//     return _output;
//   }

//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static MediaMetaModel? decipherMetaMap({
//     required Map<String, String>? customMetadata,
//   }){
//     MediaMetaModel? _output;
//
//     // blog('decipherMetaMap : customMetadata[fileType] : ${customMetadata?['fileType']} : customMetadata[filetype] : ${customMetadata?['filetype']}');
//
//     if (customMetadata != null){
//
//       _output = MediaMetaModel(
//         ownersIDs: MapperSS.getKeysHavingThisValue(
//           map: customMetadata,
//           value: 'cool',
//         ),
//         fileExt: FileMiming.getTypeByMime(customMetadata['fileType'] ?? customMetadata['filetype']),
//         width: Numeric.transformStringToDouble(customMetadata['width']),
//         height: Numeric.transformStringToDouble(customMetadata['height']),
//         name: customMetadata['name'],
//         sizeMB: Numeric.transformStringToDouble(customMetadata['sizeMB'] ?? customMetadata['sizemb']),
//         data: _getRemainingData(customMetadata),
//         uploadPath: customMetadata['uploadPath'] ?? customMetadata['uploadpath'],
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Map<String, String>? _getRemainingData(Map<String, String>? metaMap){
//     Map<String, String>? _map;
//
//     if (metaMap != null){
//
//       _map = {};
//
//       final List<String> _keys = metaMap.keys.toList();
//
//       if (Lister.checkCanLoop(_keys) == true){
//
//         for (final String key in _keys){
//
//           if (
//           metaMap[key] != 'cool' &&
//               key != 'width' &&
//               key != 'height' &&
//               key != 'name' &&
//               key != 'sizeMB' &&
//               key != 'uploadPath' &&
//               key != 'fileType'
//           ){
//             _map[key] = metaMap[key]!;
//           }
//
//         }
//
//       }
//
//     }
//
//     return _map;
//   }
//   // -----------------------------------------------------------------------------
//
//
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<MediaMetaModel?> completeMeta({
//     required Uint8List? bytes,
//     required MediaMetaModel? meta,
//     required String? uploadPath,
//   }) async {
//     MediaMetaModel? _output = meta;
//
//     /// NAME
//     if (TextCheck.isEmpty(meta?.name?.trim()) == true && uploadPath != null){
//
//       final String? _name = TextMod.removeTextBeforeLastSpecialCharacter(
//         text: uploadPath,
//         specialCharacter: '/',
//       );
//
//       if (_name != null){
//         _output = _output?.copyWith(
//           name: _name,
//         );
//       }
//
//     }
//
//     /// DIMENSIONS
//     if (
//         (meta?.height == null || meta?.width == null)
//         &&
//         bytes != null
//     ){
//
//       final Dimensions? _dims = await DimensionsGetter.fromBytes(
//         invoker: 'completeMeta',
//           bytes: bytes,
//           fileName: _output?.name,
//       );
//
//       _output = _output?.copyWith(
//         width: _dims?.width,
//         height: _dims?.height,
//       );
//
//     }
//
//     /// SIZE
//     if (meta?.sizeMB == null){
//
//       final double? _mega = FileSizer.calculateSize(bytes?.length, FileSizeUnit.megaByte);
//       _output = _output?.copyWith(
//         sizeMB: _mega,
//       );
//     }
//
//     /// UPLOAD PATH
//     if (TextCheck.isEmpty(meta?.uploadPath) == false){
//       _output = _output?.copyWith(
//         uploadPath: uploadPath,
//       );
//     }
//
//     // blogStorageMetaModel(_output);
//
//     return _output;
//   }