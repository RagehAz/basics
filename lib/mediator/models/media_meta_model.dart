import 'dart:typed_data';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/file_size_unit.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/models/file_typer.dart';
import 'package:flutter/material.dart';

/// => TAMAM
@immutable
class MediaMetaModel {
  // -----------------------------------------------------------------------------
  const MediaMetaModel({
    required this.ownersIDs,
    required this.fileType,
    this.width,
    this.height,
    this.name,
    this.sizeMB,
    this.data,
  });
  // -----------------------------------------------------------------------------
  final List<String> ownersIDs;
  final double? width;
  final double? height;
  final String? name;
  final double? sizeMB;
  final FileType? fileType;
  final Map<String, String>? data;
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
    FileType? fileType,
    Map<String, String>? data,
  }){
    return MediaMetaModel(
      ownersIDs: ownersIDs ?? this.ownersIDs,
      width: width ?? this.width,
      height: height ?? this.height,
      name: name ?? this.name,
      sizeMB: sizeMB ?? this.sizeMB,
      fileType: fileType ?? this.fileType,
      data: data ?? this.data,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> cipherToLDB(){
    return <String, dynamic>{
      'ownersIDs': ownersIDs,
      'fileType': FileTyper.cipherType(fileType),
      'width': width,
      'height': height,
      'name': name,
      'sizeMB': sizeMB,
      'data': data,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static MediaMetaModel? decipherFromLDB(Map<String, dynamic>? map){
    MediaMetaModel? _output;

    if (map != null){
      _output = MediaMetaModel(
        ownersIDs: Stringer.getStringsFromDynamics(map['ownersIDs']),
        fileType: FileTyper.decipherType(map['fileType']),
        width: map['width'],
        height: map['height'],
        name: map['name'],
        sizeMB: map['sizeMB'],
        data: _getDataMap(map['data']),
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
        fileType: FileTyper.decipherType(customMetadata['fileType']),
        width: Numeric.transformStringToDouble(customMetadata['width']),
        height: Numeric.transformStringToDouble(customMetadata['height']),
        name: customMetadata['name'],
        sizeMB: Numeric.transformStringToDouble(customMetadata['sizeMB']),
        data: _getRemainingData(customMetadata),
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
              key != 'sizeMB'
          ){
            _map[key] = metaMap[key]!;
          }

        }

      }

    }

    return _map;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaMetaModel?> completeMeta({
    required Uint8List? bytes,
    required MediaMetaModel? meta,
    required String? path,
  }) async {
    MediaMetaModel? _output = meta;

    /// DIMENSIONS
    if (
        (meta?.height == null || meta?.width == null)
        &&
        bytes != null
    ){

      final Dimensions? _dims = await Dimensions.superDimensions(bytes);

      _output = _output?.copyWith(
        width: _dims?.width,
        height: _dims?.height,
      );

    }

    /// SIZE
    if (meta?.sizeMB == null){

      final double? _mega = Filers.calculateSize(bytes?.length, FileSizeUnit.megaByte);
      _output = _output?.copyWith(
        sizeMB: _mega,
      );
    }

    blog('meta?.name : ${meta?.name} : path : $path');

    /// NAME
    if (TextCheck.isEmpty(meta?.name?.trim()) == true && path != null){

      final String? _name = TextMod.removeTextBeforeLastSpecialCharacter(
        text: path,
        specialCharacter: '/',
      );

      blog ('_name should be : $_name');

      if (_name != null){
        _output = _output?.copyWith(
          name: _name,
        );
      }

    }

    blogStorageMetaModel(_output);

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
              '${model.width} : sizeMB : ${model.sizeMB}'
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
          meta1.fileType == meta2.fileType
          &&
          meta1.sizeMB == meta2.sizeMB
          &&
          meta1.name == meta2.name
          &&
          Mapper.checkMapsAreIdentical(map1: meta1.data, map2: meta2.data) == true
      ){
        _output = true;
      }

    }

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
    return FileTyper.checkFileIsImage(fileType);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkFileIsVideo(){
    return FileTyper.checkFileIsVideo(fileType);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkFileIsAudio(){
    return FileTyper.checkFileIsAudio(fileType);
  }
  // -----------------------------------------------------------------------------

  /// DUMMY

  // --------------------
  /// TESTED : WORKS PERFECT
  static MediaMetaModel emptyModel({
    required FileType fileType,
  }){
    return MediaMetaModel(
      ownersIDs: const [],
      fileType: fileType,
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
          fileType: ${FileTyper.cipherType(fileType)},
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
      fileType.hashCode^
      name.hashCode^
      data.hashCode;
  // -----------------------------------------------------------------------------
}
