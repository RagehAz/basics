import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/strings/pathing.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
/// => TAMAM
class MapPathing {
  // -----------------------------------------------------------------------------

  const MapPathing();

  // -----------------------------------------------------------------------------

  /// GETTERS

  // -----------------------
  /// TESTED : WORKS PERFECT
  static dynamic getNodeValue({
    required String path,
    required Map<String, dynamic>? map,
  }){

    dynamic result = map;

    if (map != null){

      final List<String> _nodes = Pathing.splitPathNodes(path);

      for (final String node in _nodes) {

        if (result is Map && result[node] is Map){
          result = result[node];
        }

        else if (checkNodeIsIndex(node) == true){
          final int _index = getIndexFromNode(node);
          result = result[_index];
        }

        else {
          result = result[node];
        }

      }

    }

    return result;
  }
  // -----------------------
  /// TESTED : WORKS PERFECT
  static int getIndexFromNode(String node){

    final String _stringedIndex = TextMod.removeTextBeforeFirstSpecialCharacter(
      text: node,
      specialCharacter: ':',
    )!;

    return Numeric.transformStringToInt(_stringedIndex)!;

  }
  // -----------------------
  /// TESTED : WORKS PERFECT
  static dynamic getNodeKey(String node){

    if (checkNodeIsIndex(node) == true){
      return getIndexFromNode(node);
    }

    else {
      return node;
    }

  }
  // -----------------------
  /// TESTED : WORKS PERFECT
  static dynamic getParentValue({
    required Map<String, dynamic> map,
    required String path,
  }){
    final String _parentPath = Pathing.removeLastPathNode(path: path)!;
    final dynamic _parentValue = getNodeValue(
        path: _parentPath,
        map: map
    );
    return _parentValue;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // -----------------------
  /// TESTED : WORKS PERFECT
  static bool checkNodeIsIndex(String node){

    return TextCheck.stringStartsExactlyWith(
      text: node,
      startsWith: 'i:',
    );

  }
  // -----------------------
  /// TESTED : WORKS PERFECT
  static bool checkPathNodeHasSons({
    required Map<String, dynamic> map,
    required String path,
  }){

    final dynamic _valueByPath = getNodeValue(
        path: path,
        map: map
    );

    return checkNodeHasSons(
      nodeValue: _valueByPath,
    );

  }
  // -----------------------
  /// TESTED : WORKS PERFECT
  static bool checkNodeHasSons({
    required dynamic nodeValue,
  }) {
    bool _hasSons = false;
    if (nodeValue != null) {
      _hasSons = nodeValue is Map || nodeValue is List;
    }

    return _hasSons;
  }
  // -----------------------
  /// TESTED : WORKS PERFECT
  static bool checkLastNodeIsIndex({
    required String path,
  }){
    final String _lastNode = Pathing.getLastPathNode(path)!;
    return checkNodeIsIndex(_lastNode);
  }
  // -----------------------
  /// TESTED : WORKS PERFECT
  static bool checkNodeIsSonOfList({
    required Map<String, dynamic> map,
    required String path,
  }){
    final String _parentPath = Pathing.removeLastPathNode(path: path)!;
    final dynamic _parentValue = getNodeValue(
        path: _parentPath,
        map: map
    );
    return _parentValue is List;
  }
  // -----------------------------------------------------------------------------

  /// SINGLE PATH CREATORS

  // -----------------------
  /// TESTED : WORKS PERFECT
  static String? createNextMapSonPath({
    required String path,
    required String? newKey,
  }) {
    String? _output;

    if (TextCheck.isEmpty(newKey) == false){
      newKey = newKey;
      _output = '$path$newKey/';
    }

    return _output;
  }
  // -----------------------
  /// TESTED : WORKS PERFECT
  static String createNextListSonPath({
    required Map<String, dynamic> map,
    required String path,
  }){

    final List _list = getNodeValue(
        path: path,
        map: map
    );
    final int _newIndex = _list.length;
    final String _newPath = '${path}i:$_newIndex/';

    return _newPath;
  }
  // -----------------------------------------------------------------------------

  /// GENERATE PATHS FROM MAP

  // -----------------------
  /// AI TESTED
  static List<String> generatePathsFromMap({
    required Map<String, dynamic>? map,
    String previousPath = '', // ...xx/
  }){
    final List<String> _output = [];

    if (previousPath != ''){
      _output.add(previousPath);
    }

    if (map != null){


      final List<String> _keys = map.keys.toList();
      if (Lister.checkCanLoop(_keys) == true){

        for (final String key in _keys){

          List<String> _sonsPaths = [];

          final dynamic _object = map[key];

          /// SON IS MAP
          if (_object is Map){
            _sonsPaths = generatePathsFromMap(
              map: Mapper.convertDynamicMap(_object),
              previousPath: '$previousPath$key/',
            );
          }

          /// SON IS LIST
          else if (_object is List){
            _sonsPaths = generatePathsFromList(
              list: _object,
              previousPath: '$previousPath$key/',
            );
          }

          /// OTHERWISE
          else {
            final String _path = '$previousPath$key/';
            _sonsPaths.add(_path);
          }

          /// COLLECT ALL SONS PATHS FOR ALL KEYS
          _output.addAll(_sonsPaths);

        }

      }

    }

    return _output;
  }
  // -----------------------
  /// AI TESTED
  static List<String> generatePathsFromList({
    required List list,
    String previousPath = '',
  }){
    final List<String> _output = [];

    if (previousPath != ''){
      _output.add(previousPath);
    }

    if (Lister.checkCanLoop(list) == true){

      for (int i = 0; i < list.length; i ++){

        List<String> _sonsPaths = [];

        final dynamic _object = list[i];
        final String _indexedKey = 'i:$i';
        final String _previousPath = '$previousPath$_indexedKey/';

        /// SON IS MAP
        if (_object is Map){
          _sonsPaths = generatePathsFromMap(
            map: _object as Map<String, dynamic>,
            previousPath: _previousPath,
          );
        }

        /// SON IS LIST
        else if (_object is List){
          _sonsPaths = generatePathsFromList(
            list: _object,
            previousPath: _previousPath,
          );
        }

        /// OTHERWISE
        else {
          _sonsPaths.add(_previousPath);
        }

        /// COMBINE SONS PATHS
        _output.addAll(_sonsPaths);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERATE MAP FROM PATHS

  // -----------------------
  /// AI TESTED
  static Map<String, dynamic> generateMapFromSomePaths({
    required List<String> somePaths,
    required Map<String, dynamic> sourceMap,
  }) {
    Map<String, dynamic> _output = {};

    if (Lister.checkCanLoop(somePaths) == true) {

      final List<String> _paths = Stringer.cleanDuplicateStrings(strings: somePaths);

      for (final String path in _paths) {

        final dynamic value = getNodeValue(
            path: path,
            map: sourceMap
        );

        _output = _addValueToPath(
          map: _output,
          path: path,
          value: value,
        );

      }

    }

    return _output;
  }
  // -----------------------
  /// AI TESTED
  static Map<String, dynamic> _addValueToPath({
    required String path,
    required dynamic value,
    required Map<String, dynamic>? map,
  }){
    /// a    / b   / i:5   / i:0   / x   / i:3   / f   /       => value
    /// key  / key / index / index / key / index / key /
    /// sim  / sil / sil   / sim   / sil / sim   / siv /       : sim sonIsMap : sil sonIsList : siv sonIsValue
    /// 0    / 1   / 2     / 3     / 4   / 5     / 6   /

    final Map<String, dynamic> _output = map ?? {};

    if (TextCheck.isEmpty(path) == false){

      final List<String> nodes = Pathing.splitPathNodes(path);

      if (Lister.checkCanLoop(nodes) == true){
        dynamic _object = _output;
        for (int i = 0; i < nodes.length; i++) {

          final String node = nodes[i];
          final dynamic key = MapPathing.getNodeKey(node);
          final String? sonNode = Pathing.getSonNode(path: path, node: node);

          if (sonNode == null){
            // fuck you
          }

          /// SON IS VALUE
          else if (sonNode == ''){
            _object[key] = value;
          }

          /// SON IS LIST
          else if (MapPathing.checkNodeIsIndex(sonNode) == true){
            _object = _summonList(
              node: node,
              sonNode: sonNode,
              object: _object,
            );
          }

          /// SON IS MAP
          else {
            _object[key] = _object[key] ?? {};
            _object = _object[key];
          }

        }
      }

    }

    return _output;
  }
  // -----------------------
  /// AI TESTED
  static List<dynamic> _summonList({
    required String node,
    required String sonNode,
    required dynamic object,
  }){

    final dynamic _key = MapPathing.getNodeKey(node);
    object[_key] = object[_key] ?? [];
    object[_key] = Lister.fillEmptySlotsUntilIndex(
      index: MapPathing.getIndexFromNode(sonNode),
      list: object[_key],
      fillValue: null,
    );

    return object[_key];
  }
  // -----------------------------------------------------------------------------
}
