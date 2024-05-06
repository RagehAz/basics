part of media_models;
/// => TAMAM
@immutable
class MediaMetaModel {
  // -----------------------------------------------------------------------------
  const MediaMetaModel({
    required this.ownersIDs,
    required this.fileExt,
    required this.uploadPath,
    required this.name,
    this.width,
    this.height,
    this.sizeMB,
    this.data,
  });
  // -----------------------------------------------------------------------------
  final List<String> ownersIDs;
  final double? width;
  final double? height;
  final String? name;
  final double? sizeMB;
  final FileExtType? fileExt;
  final Map<String, String>? data;
  final String? uploadPath; /// storage/collectionName/subCollectionName/fileName.ext
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  MediaMetaModel copyWith({
    List<String>? ownersIDs,
    double? width,
    double? height,
    String? name,
    double? sizeMB,
    FileExtType? fileExt,
    Map<String, String>? data,
    String? uploadPath,
  }){
    return MediaMetaModel(
      ownersIDs: ownersIDs ?? this.ownersIDs,
      width: width ?? this.width,
      height: height ?? this.height,
      name: name ?? this.name,
      sizeMB: sizeMB ?? this.sizeMB,
      fileExt: fileExt ?? this.fileExt,
      data: data ?? this.data,
      uploadPath: uploadPath ?? this.uploadPath,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> cipherToLDB(){
    return <String, dynamic>{
      'ownersIDs': ownersIDs,
      'fileType': FileMiming.getMimeByType(fileExt),
      'width': width,
      'height': height,
      'name': name,
      'sizeMB': sizeMB,
      'data': data,
      'uploadPath': uploadPath,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static MediaMetaModel? decipherFromLDB(Map<String, dynamic>? map){
    MediaMetaModel? _output;

    if (map != null){
      _output = MediaMetaModel(
        ownersIDs: Stringer.getStringsFromDynamics(map['ownersIDs']),
        fileExt: FileMiming.getTypeByMime(map['fileType']),
        width: map['width'],
        height: map['height'],
        name: map['name'],
        sizeMB: map['sizeMB'],
        data: _getDataMap(map['data']),
        uploadPath: map['uploadPath'],
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String>? _getDataMap(dynamic thing){
    Map<String, String>? _output;

    if (thing != null){
      _output = {};

      if (thing is Map){
        final List<dynamic> _keys = thing.keys.toList();
        for (final String key in _keys){

          if (thing[key] is String){
            _output[key] = thing[key];
          }

        }
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static MediaMetaModel? decipherMetaMap({
    required Map<String, String>? customMetadata,
  }){
    MediaMetaModel? _output;

    if (customMetadata != null){
      _output = MediaMetaModel(
        ownersIDs: MapperSS.getKeysHavingThisValue(
          map: customMetadata,
          value: 'cool',
        ),
        fileExt: FileMiming.getTypeByMime(customMetadata['fileType']),
        width: Numeric.transformStringToDouble(customMetadata['width']),
        height: Numeric.transformStringToDouble(customMetadata['height']),
        name: customMetadata['name'],
        sizeMB: Numeric.transformStringToDouble(customMetadata['sizeMB']),
        data: _getRemainingData(customMetadata),
        uploadPath: customMetadata['uploadPath'],
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String>? _getRemainingData(Map<String, String>? metaMap){
    Map<String, String>? _map;

    if (metaMap != null){

      _map = {};

      final List<String> _keys = metaMap.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){

        for (final String key in _keys){

          if (
          metaMap[key] != 'cool' &&
              key != 'width' &&
              key != 'height' &&
              key != 'name' &&
              key != 'sizeMB' &&
              key != 'uploadPath' &&
              key != 'fileType'
          ){
            _map[key] = metaMap[key]!;
          }

        }

      }

    }

    return _map;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  MediaOrigin? getMediaOrigin(){
    final String? _origin = data?['source'];
    return MediaModel.decipherMediaOrigin(_origin);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getOriginalURL(){
    return data?['original_url'];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getFilePath({
    bool withExtension = true,
  }){
    return data?['file_path'];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getCaption(){
    return data?['caption'];
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaMetaModel?> completeMeta({
    required Uint8List? bytes,
    required MediaMetaModel? meta,
    required String? uploadPath,
  }) async {
    MediaMetaModel? _output = meta;

    /// NAME
    if (TextCheck.isEmpty(meta?.name?.trim()) == true && uploadPath != null){

      final String? _name = TextMod.removeTextBeforeLastSpecialCharacter(
        text: uploadPath,
        specialCharacter: '/',
      );

      if (_name != null){
        _output = _output?.copyWith(
          name: _name,
        );
      }

    }

    /// DIMENSIONS
    if (
        (meta?.height == null || meta?.width == null)
        &&
        bytes != null
    ){

      final Dimensions? _dims = await DimensionsGetter.fromBytes(
          bytes: bytes,
          fileName: _output?.name,
      );

      _output = _output?.copyWith(
        width: _dims?.width,
        height: _dims?.height,
      );

    }

    /// SIZE
    if (meta?.sizeMB == null){

      final double? _mega = FileSizer.calculateSize(bytes?.length, FileSizeUnit.megaByte);
      _output = _output?.copyWith(
        sizeMB: _mega,
      );
    }

    /// UPLOAD PATH
    if (TextCheck.isEmpty(meta?.uploadPath) == false){
      _output = _output?.copyWith(
        uploadPath: uploadPath,
      );
    }

    // blogStorageMetaModel(_output);

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogStorageMetaModel(MediaMetaModel? model){

    blog('blogStorageMetaModel ------------------------------------ >> START');

    if (model == null){
      blog('blogStorageMetaModel : model is null');
    }
    else {

      blog(
          'name : ${model.name} : '
          'height : ${model.height} : width : '
          '${model.width} : sizeMB : ${model.sizeMB} : uploadPath : ${model.uploadPath}'
      );
      Stringer.blogStrings(strings: model.ownersIDs, invoker: 'model.ownersIDs');
      Mapper.blogMap(model.data, invoker: 'blogStorageMetaModel.data');

    }

    blog('blogStorageMetaModel ------------------------------------ >> END');
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMetaDatasAreIdentical({
    required MediaMetaModel? meta1,
    required MediaMetaModel? meta2,
  }){
    bool _output = false;

    if (meta1 == null && meta2 == null){
      _output = true;
    }

    else if (meta1 != null && meta2 != null){

      if (
          Lister.checkListsAreIdentical(list1: meta1.ownersIDs, list2: meta2.ownersIDs) == true
          &&
          meta1.width == meta2.width
          &&
          meta1.height == meta2.height
          &&
          meta1.fileExt == meta2.fileExt
          &&
          meta1.sizeMB == meta2.sizeMB
          &&
          meta1.name == meta2.name
          &&
          meta1.uploadPath == meta2.uploadPath
          &&
          Mapper.checkMapsAreIdentical(map1: meta1.data, map2: meta2.data) == true
      ){
        _output = true;
      }

    }

    // if (_output == false){
    //   Mapper.blogMapsDifferences(
    //     // map1: meta1?.cipherToLDB(),
    //     // map2: meta2?.cipherToLDB(),
    //     map1: meta1?.data,
    //     map2: meta2?.data,
    //     invoker: 'checkMetaDatasAreIdentical',
    //   );
    // }

    return _output;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<Size?> getFileWidthAndHeightX({
    required File? file,
  }) async {

    if (file != null){



      final Uint8List? _uInt8List = await Floaters.getBytesFromFile(file);
        // blog('_uInt8List : $_uInt8List');
      final ui.Image? _decodedImage = await Floaters.getUiImageFromUint8List(_uInt8List);

      if (_decodedImage == null){
        return null;
      }
      else {
        return Size(
          _decodedImage.width.toDouble(),
          _decodedImage.height.toDouble(),
        );
      }

    }
    else {
      return null;
    }

  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Map<String, String?>? _cleanNullPairs({
    required Map<String, String?>? map,
  }){
    Map<String, String?>? _output;

    if (map != null){

      _output = {};
      final List<String> _keys = map.keys.toList();

      for (final String key in _keys){

        if (map[key] != null){

          _output = _insertPairInMap(
            map: _output,
            key: key,
            value: map[key],
          );

        }

        // else {
        //   blog('$key : value is null');
        // }

      }

      if (_output != null && _output.keys.isEmpty == true){
        _output = null;
      }

    }

    // else {
    //   blog('cleanNullPairs: map is null');
    // }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String?>? _insertPairInMap({
    required Map<String, String?>? map,
    required String? key,
    required dynamic value,
    bool overrideExisting = true,
  }) {
    final Map<String, String?>? _result = <String, String?>{};

    if (map != null) {
      _result?.addAll(map);
    }

    if (key != null && _result != null) {
      /// PAIR IS NULL
      if (_result[key] == null) {
        _result[key] = value;
        // _result.putIfAbsent(key, () => value);
      }

      /// PAIR HAS VALUE
      else {
        if (overrideExisting == true) {
          _result[key] = value;
        }
      }
    }

    return _result;
  }
   */
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkFileIsImage(){
    return FileTyper.checkTypeIsImage(fileExt);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkFileIsVideo(){
    return FileTyper.checkTypeIsVideo(fileExt);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkFileIsAudio(){
    return FileTyper.checkTypeIsAudio(fileExt);
  }
  // -----------------------------------------------------------------------------

  /// DUMMY

  // --------------------
  /// TESTED : WORKS PERFECT
  static MediaMetaModel emptyModel({
    required FileExtType fileType,
  }){
    return MediaMetaModel(
      ownersIDs: const [],
      fileExt: fileType,
      uploadPath: null,
      name: null,
      // name: null,
      // data: null,
      // width: null,
      // height: null,
      // sizeMB: null,
    );
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString(){

    final String _output =
    '''
        StorageMetaModel(
          ownersIDs : $ownersIDs,
          width : $width,
          height : $height,
          sizeMB : $sizeMB,
          name : $name,
          uploadPath: $uploadPath,
          fileType: ${FileMiming.getMimeByType(fileExt)},
          data : $data,
        )
        ''';

    return _output;
  }
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is MediaMetaModel){
      _areIdentical = checkMetaDatasAreIdentical(
        meta1: this,
        meta2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      ownersIDs.hashCode^
      width.hashCode^
      height.hashCode^
      sizeMB.hashCode^
      fileExt.hashCode^
      name.hashCode^
      uploadPath.hashCode^
      data.hashCode;
  // -----------------------------------------------------------------------------
}
