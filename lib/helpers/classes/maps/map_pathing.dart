import 'package:basics/helpers/classes/checks/tracers.dart';
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
  static String createNextMapSonPath({
    required String path,
    required String? newKey,
  }) {
    String _output = path;

    if (TextCheck.isEmpty(newKey) == false){
      newKey = newKey!.toLowerCase();
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
  /// TASK : TEST ME BY AI
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
  ///
  static Map<String, dynamic>? generateMapFromSomePaths({
    required List<String> somePaths,
    required Map<String, dynamic> sourceMap,
  }) {
    Map<String, dynamic>? _output;

    if (Lister.checkCanLoop(somePaths) == true) {

      final List<String> _paths = Stringer.cleanDuplicateStrings(strings: somePaths);

      _output = {};

      for (final String path in _paths) {

        final dynamic value = getNodeValue(
            path: path,
            map: sourceMap
        );

        blog('value : $value');

      }

    }

    return _output;
  }
  /*
  // -----------------------
  ///
  static Map<String, dynamic> setNodeValue({
    required String path,
    required dynamic value,
    required Map<String, dynamic> map,
  }) {

    dynamic result = getPathObject(
      path: path,
      object: map,
    );

    return setObject(
      value: value,
      object: result,
    );

  }
  // -----------------------
  ///
  static dynamic getPathObject({
    required String path,
    required dynamic object,
  }){
    dynamic result = object;

    if (object != null){

      final List<String> nodes = Pathing.splitPathNodes(path);
      blog('getPathObject : path : $path : nodes : $nodes');

      /// GO DOWN IN NODES => EACH TIME SET RESULT WITH THE SON OBJECT
      for (int i = 0; i < nodes.length; i++) {

        final String node = nodes[i];
        blog('getPathObject : $i node : $node');

        final String _parentNode = Pathing.getParentNode(path: path, node: node)!;
        blog('getPathObject : $i _parentNode : $_parentNode');

        final bool _isSonOfList = checkNodeIsIndex(_parentNode);
        blog('getPathObject : $i _isSonOfList : $_isSonOfList');

        /// SON OF LIST
        if (_isSonOfList == true){
          result = _getPathList(parentObject: result, parentNode: _parentNode);
        }

        /// SON OF MAP
        else {
          result = _getPathMap(
            parentObject: result,
            node: node,
          );
        }

      }

    }



    return result;
  }

  // -----------------------
  /// Initialize a path object as a map
  static Map<String, dynamic> _getPathMap({
    required dynamic parentObject,
    required String node,
  }) {
    Map<String, dynamic> _output = {};

    blog('_getPathMap : parentObject : $parentObject');
    blog('_getPathMap : node : $node');

    /// PARENT IS LIST
    if (parentObject is List){

    }

    /// PARENT IS MAP
    else {
      final bool _nodeIsIndex =
      _output = parentObject[node];
    }

    return _output;
  }
// -----------------------
  /// Initialize a path object as a list
  static List<dynamic> _getPathList({
    required dynamic parentObject,
    required String parentNode
  }) {
    List<dynamic> _output = [];

    blog('_getPathList : parentObject : $parentObject');
    blog('_getPathList : parentNode : $parentNode');

    return [];
  }
  // -----------------------
  ///
  static dynamic setObject({
    required dynamic value,
    required dynamic object,
  }){
    return value;
  }
  // -----------------------------------------------------------------------------
  /*
  // -----------------------
  /// TASK : TEST ME BY AI
  static dynamic _emptyBox({required dynamic sonNode}){
    if (sonNode is int || checkNodeIsIndex(sonNode) == true){
      return [];
    }
    else {
      return {};
    }
  }
  // -----------------------
  /// TASK : TEST ME BY AI
  static dynamic _insertValueToBox({
    required dynamic box,
    required dynamic value,
    required dynamic key,
  }){

    blog('_insertValueToBox : box : $box : value : $value');

    if (box is List){
      box.add(value);
    }
    else {
      box[key] = value;
    }

    return box;
  }
  // -----------------------
  /// TASK : TEST ME BY AI
  static dynamic _initializeObject({required dynamic sonNode, required dynamic box}){
    return box ?? _emptyBox(sonNode: sonNode);
  }
  // -----------------------------------------------------------------------------
  static Map<String, dynamic> insertValueInMapByPath({
    required String path, // a/b/c/i:0/
    required dynamic value,
    required Map<String, dynamic> map,
  }){
    Map<String, dynamic> _output = map;

    final List<String> nodes = Pathing.splitPathNodes(path);

    if (Lister.checkCanLoop(nodes) == true){

      if (nodes.length == 1){
        final String _node = nodes[0];
        final bool _isIndex = checkNodeIsIndex(_node);
        if (_isIndex == true){
          assert (_isIndex != true, 'First node should never be an index as first nodes always should be maps');
        }
        else {
          final String _key = getNodeKey(_node);
          map[_key] = value;
        }
      }

      else {

        dynamic object = map;
        for (int i = 0; i < nodes.length; i++){

          final String node = nodes[i];
          final String sonNode = Pathing.getSonNode(
            path: path,
            node: node,
          )!;

          final bool _isFirst = i == 0;
          final bool _isLast = i == nodes.length - 1;

          /// FIRST NODE
          if (_isFirst == true){
            final String _key = node;
            object[_key] = object[_key] ?? {};
            object = object[_key];
          }
          /// MIDDLE NODE
          else if (_isFirst == false && _isLast == false){
            final bool _nodeIsList = checkNodeIsIndex(sonNode);
            if (_nodeIsList == true){
              final int sonIndex = getIndexFromNode(sonNode);
              object = object ?? [];
              object = Lister.fillEmptySlotsUntilIndex(
                index: sonIndex,
                list: object,
                fillValue: null,
              );
              object.insert(sonIndex, value);
            }
            else {
              final String _key = node;
              object[_key] = object[_key] ?? {};
              object = object[_key];
            }
          }
          /// LAST NODE
          else if (_isLast == true){

          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
   */

   */
  // -----------------------------------------------------------------------------
}
