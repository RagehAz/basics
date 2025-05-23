// ignore_for_file: avoid_redundant_argument_values
part of av;

@immutable
class AvModel {
  // --------------------------------------------------------------------------
  const AvModel({
    required this.id,
    required this.uploadPath,
    required this.bobDocName,
    this.xFilePath,
    this.ownersIDs,
    this.width,
    this.height,
    this.nameWithoutExtension,
    this.nameWithExtension,
    this.sizeMB,
    this.sizeB,
    this.fileExt,
    this.data,
    this.origin,
    this.originalURL,
    this.caption,
    this.durationMs,
    this.originalXFilePath,
    this.lastEdit,
  });
  // --------------------
  final String id;
  /// EXAMPLE
  /// storage/collectionName/subCollectionName/fileName
  /// upload path last node should be file name without extension
  /// so it can be generated without knowing file type
  final String uploadPath;
  final String? xFilePath;
  final List<String>? ownersIDs;
  final double? width;
  final double? height;
  final String? nameWithoutExtension;
  final String? nameWithExtension;
  final double? sizeMB;
  final int? sizeB;
  final FileExtType? fileExt;
  final Map<String, String>? data;
  /// might be called ['source'] in external db
  final AvOrigin? origin;
  final String? originalURL;
  final String? caption;
  final int? durationMs;
  final String bobDocName;
  final String? originalXFilePath;
  /// NOT SURE ABOUT THOSE
  // final String? deviceID;
  // final String? deviceName;
  // final String? platform;
  /// NOT SURE ABOUT THOSE
  final DateTime? lastEdit;
  // --------------------------------------------------------------------------

  /// DUMMY PIC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> dummyPic({
    required String localAsset,
    String? bobDocName,
    String fileName = 'theFile',
  }) async {

    return AvOps.createFromLocalAsset(
        localAsset: localAsset,
        data: CreateSingleAVConstructor(
          uploadPath: 'the/upload/$fileName',
          skipMeta: false,
          bobDocName: bobDocName ?? 'theBobDoc',
          originalXFilePath: null,
          ownersIDs: ['x'],
          origin: AvOrigin.downloaded,
          width: null,
          height: null,
          originalURL: 'http://bldrs.com/$fileName',
          durationMs: 22,
          caption: 'what is this',
          // fileExt: ,
        ),
    );

  }
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  AvModel _copyWith({
    String? id,
    String? uploadPath,
    String? xFilePath,
    List<String>? ownersIDs,
    double? width,
    double? height,
    String? nameWithoutExtension,
    String? nameWithExtension,
    double? sizeMB,
    int? sizeB,
    FileExtType? fileExt,
    Map<String, String>? data,
    AvOrigin? origin,
    String? originalURL,
    String? caption,
    int? durationMs,
    String? bobDocName,
    String? originalXFilePath,
    DateTime? lastEdit,
  }){

    return AvModel(
      id: id ?? this.id,
      xFilePath: xFilePath ?? this.xFilePath,
      ownersIDs: ownersIDs ?? this.ownersIDs,
      width: width ?? this.width,
      height: height ?? this.height,
      nameWithoutExtension: nameWithoutExtension ?? this.nameWithoutExtension,
      nameWithExtension: nameWithExtension ?? this.nameWithExtension,
      sizeMB: sizeMB ?? this.sizeMB,
      sizeB: sizeB ?? this.sizeB,
      fileExt: fileExt ?? this.fileExt,
      data: data ?? this.data,
      uploadPath: uploadPath ?? this.uploadPath,
      origin: origin ?? this.origin,
      originalURL: originalURL ?? this.originalURL,
      caption: caption ?? this.caption,
      durationMs: durationMs ?? this.durationMs,
      bobDocName: bobDocName ?? this.bobDocName,
      originalXFilePath: originalXFilePath ?? this.originalXFilePath,
      lastEdit: lastEdit ?? this.lastEdit,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  AvModel nullifyField({
    // bool id = false,
    bool xFilePath = false,
    bool ownersIDs = false,
    bool width = false,
    bool height = false,
    bool nameWithoutExtension = false,
    bool nameWithExtension = false,
    bool sizeMB = false,
    bool sizeB = false,
    bool fileExt = false,
    bool data = false,
    // bool uploadPath = false,
    bool origin = false,
    bool originalURL = false,
    bool caption = false,
    bool durationMs = false,
    // bool bobDocName = false,
    bool originalXFilePath = false,
    bool lastEdit = false,
  }){
    return AvModel(
      id: id,
      xFilePath: xFilePath == true ? null : this.xFilePath,
      ownersIDs: ownersIDs == true ? null : this.ownersIDs,
      width: width == true ? null : this.width,
      height: height == true ? null : this.height,
      nameWithoutExtension: nameWithoutExtension == true ? null : this.nameWithoutExtension,
      nameWithExtension: nameWithExtension == true ? null : this.nameWithExtension,
      sizeMB: sizeMB == true ? null : this.sizeMB,
      sizeB: sizeB == true ? null : this.sizeB,
      fileExt: fileExt == true ? null : this.fileExt,
      data: data == true ? null : this.data,
      uploadPath: uploadPath,
      origin: origin == true ? null : this.origin,
      originalURL: originalURL == true ? null : this.originalURL,
      caption: caption == true ? null : this.caption,
      durationMs: durationMs == true ? null : this.durationMs,
      bobDocName: bobDocName,
      originalXFilePath: originalXFilePath == true ? null : this.originalXFilePath,
      lastEdit: lastEdit == true ? null : this.lastEdit,
    );
  }
  // --------------------------------------------------------------------------

  /// ASSERTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> assertIsUploadable(AvModel? avModel) async {

    assert(avModel != null, 'avModel is null');
    // assert(avModel?.width != null, "avModel's width is null");
    // assert(avModel?.height != null, "avModel's height is null");
    assert(avModel?.nameWithoutExtension != null, "avModel's name is null");
    // assert(avModel?.sizeMB != null, "avModel's sizeMB is null");
    // assert(avModel?.sizeB != null, "avModel's sizeB is null");
    // assert(avModel?.fileExt != null, "avModel's fileExt is null");
    assert(avModel?.uploadPath != null, "avModel's uploadPath is null");
    // assert(avModel?.origin != null, "avModel's origin is null");

    // List<String>? ownersIDs; can be null
    // String? originalURL; can be null
    // String? caption; can be null
    // int? durationMs; can be null

    final String? _uploadPath = avModel?.uploadPath;
    final bool _pathsAreGood = TextCheck.isEmpty(_uploadPath) == false;
    assert(_pathsAreGood, 'Paths are not good : _uploadPath : $_uploadPath');

  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Uint8List?> getBytes() async {
    if (xFilePath == null){
      return null;
    }
    else {
      final XFile _xFile = XFile(xFilePath!);
      return Byter.fromXFile(_xFile, 'getBytes');
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getName({
    bool withExtension = true,
  }){

    if (withExtension == true){
      return nameWithExtension;
    }
    else {
      return nameWithoutExtension;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions? getDimensions(){

    if (width == null && height == null){
      return null;
    }
    else {
      return Dimensions(
        width: width,
        height: height,
      );
    }

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
  AvOrigin? getAvOrigin(){
    return origin;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getOriginalURl(){
    return originalURL;
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
  // --------------------
  /// TESTED : WORKS PERFECT
  File? getFile(){
    if (xFilePath == null){
      return null;
    }
    else {
      return File(xFilePath!);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  XFile? getXFile(){
    if (xFilePath == null){
      return null;
    }
    else {
      return XFile(xFilePath!);
    }
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

        final AvModel? _uploaded = findAvModelByUploadPath(
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
  static AvModel? findAvModelByUploadPath({
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
  /// TESTED : WORKS PERFECT
  bool isPNG(){
    return fileExt == FileExtType.png;
  }
  // --------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> replaceBytes({
    required Uint8List? bytes,
    required Dimensions? newDims,
  }) async {
    return _AvUpdate.overrideBytes(
      bytes: bytes,
      newDims: newDims,
      avModel: this,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> overrideUploadPath({
    required String? uploadPath
  }) async {

    return _AvUpdate.overrideUploadPath(
        avModel: this,
        newUploadPath: uploadPath,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> renameFile({
    required String? newName,
  }) async {
    return _AvUpdate.renameFile(
      avModel: this,
      newName: newName,
    );
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
  Future<AvModel?> setOriginalURL({
    required String? originalURL,
  }) async {
    return _AvUpdate.metaEdit(
      avModel: this,
      originalURL: originalURL,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> setMediaOrigin({
    required AvOrigin? origin,
  }) async {
    return _AvUpdate.metaEdit(
      avModel: this,
      origin: origin,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> setOwnersIDs({
    required List<String>? ownersIDs,
  }) async {
    return _AvUpdate.metaEdit(
      avModel: this,
      ownersIDs: ownersIDs,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> setCaption({
    required String? caption,
  }) async {
    return _AvUpdate.metaEdit(
      avModel: this,
      caption: caption,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> metaEdit({
    String? caption,
    AvOrigin? origin,
    String? originalXFilePath,
    String? originalURL,
    Map<String, String>? data,
    int? durationMs,
    List<String>? ownersIDs,
  }) async {
    return _AvUpdate.metaEdit(
      avModel: this,
      caption: caption,
      ownersIDs: ownersIDs,
      originalURL: originalURL,
      durationMs: durationMs,
      data: data,
      originalXFilePath: originalXFilePath,
      origin: origin,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> completeXFilePath() async {
    return _copyWith(
      xFilePath: await AvPathing.createXFilePath(uploadPath: uploadPath),
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

    final bool _identical = Mapper.checkMapsAreIdentical(
      map1: AvCipher.toMap(model1),
      map2: AvCipher.toMap(model2),
    );

    if (_identical == false){
      blogDifferences(invoker: 'check', model1: model1, model2: model2);
    }

    return _identical;

  }
  // --------------------
  ///
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
      if (model1.xFilePath != model2.xFilePath){
        blog('model1.xFile != model2.xFile');
      }
      if (Lister.checkListsAreIdentical(list1: model1.ownersIDs, list2: model2.ownersIDs) == false){
        blog('model1.ownersIDs != model2.ownersIDs');
        blog('model1.ownersIDs(${model1.ownersIDs })');
        blog('model1.ownersIDs(${model2.ownersIDs})');
      }
      if (model1.width != model2.width){
        blog('model1.width != model2.width');
      }
      if (model1.height != model2.height){
        blog('model1.height != model2.height');
      }
      if (model1.nameWithExtension != model2.nameWithExtension){
        blog('model1.nameWithExtension != model2.nameWithExtension');
      }
      if (model1.nameWithoutExtension != model2.nameWithoutExtension){
        blog('model1.nameWithoutExtension != model2.nameWithoutExtension');
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
        blog('model1.originalURL(${model1.originalURL})');
        blog('model2.originalURL(${model2.originalURL})');
      }
      if (model1.caption != model2.caption){
        blog('model1.caption != model2.caption');
      }
      if (model1.durationMs != model2.durationMs){
        blog('model1.durationMs != model2.durationMs');
      }
      if (model1.originalXFilePath != model2.originalXFilePath){
        blog('model1.originalXFilePath != model2.originalXFilePath');
      }
      if (Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: model1.lastEdit, time2: model2.lastEdit) == false){
        blog('model1.lastEdit(${model1.lastEdit}) != model2.lastEdit(${model2.lastEdit})');
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
  uploadPath: $uploadPath,
  xFilePath: $xFilePath,
  ownersIDs: $ownersIDs,
  width: $width,
  height: $height,
  nameWithExtension: $nameWithExtension,
  nameWithoutExtension: $nameWithoutExtension,
  sizeMB: $sizeMB,
  sizeB: $sizeB,
  fileExt: $fileExt,
  data: $data,
  origin: $origin,
  originalURL: $originalURL,
  caption: $caption,
  durationMs: $durationMs,
  originalXFilePath: $originalXFilePath,
  lastEdit: $lastEdit,
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
      xFilePath.hashCode^
      ownersIDs.hashCode^
      width.hashCode^
      height.hashCode^
      nameWithExtension.hashCode^
      nameWithoutExtension.hashCode^
      sizeMB.hashCode^
      sizeB.hashCode^
      fileExt.hashCode^
      data.hashCode^
      uploadPath.hashCode^
      origin.hashCode^
      originalURL.hashCode^
      caption.hashCode^
      originalXFilePath.hashCode^
      lastEdit.hashCode^
      durationMs.hashCode;
  // --------------------------------------------------------------------------
}

/// OLD META STUFF

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
