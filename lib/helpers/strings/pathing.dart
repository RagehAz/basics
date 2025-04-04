import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';

/// => TAMAM
abstract class Pathing {
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFirstPathNode({required String? path}) {
    if (path == null) {
      return null;
    } else {
      /// FIRST PATH NODE IS CHAIN ROOT ID, in this example it's [phid_a] => 'phid_a/phid_b/phid_c'
      final String? _cleanedPath = TextMod.removeTextAfterLastSpecialCharacter(
        text: path,
        specialCharacter: '/',
      );

      /// => <String>[phid_a, phid_b, phid_c]
      final List<String>? _pathNodes = _cleanedPath?.split('/');

      /// => phid_c
      return Lister.checkCanLoop(_pathNodes) == true ? _pathNodes?.first : null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getLastPathNode(String? path) {
    /// LAST PATH NODE IS the FURTHEST FROM ROOT ID, in this example it's [phid_c] => 'phid_a/phid_b/phid_c'

    String? _node;

    if (TextCheck.isEmpty(path) == false) {
      final String? _fixed = Pathing.fixPathFormatting(path!);
      final String? _cleanedPath = TextMod.removeTextAfterLastSpecialCharacter(
        text: _fixed,
        specialCharacter: '/',
      );
      final List<String>? _pathNodes = _cleanedPath?.split('/');
      _node = _pathNodes?.last;
    }
    return _node;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPathsLastNodes(List<String>? paths) {
    final List<String> _lastNodes = <String>[];

    if (Lister.checkCanLoop(paths) == true) {
      for (final String path in paths!) {
        final String? _node = getLastPathNode(path);
        if (_node != null) {
          _lastNodes.add(_node);
        }
      }
    }

    return _lastNodes;
  }
  // -----------------------------------------------------------------------------

  /// GET ADJACENT NODES

  // --------------------
  /// AI TESTED
  static String? getParentNode({
    required String path,
    required String node,
  }) {
    if (TextCheck.isEmpty(path) == true || TextCheck.isEmpty(node) == true) {
      return null;
    } else {
      final List<String> pathNodes = Pathing.splitPathNodes(path);
      final int _index = pathNodes.indexOf(node);

      /// non existent
      if (_index == -1) {
        return null;
      }

      /// first
      else if (_index == 0) {
        return '';
      }

      /// found
      else {
        return pathNodes[_index - 1];
      }
    }
  }
  // --------------------
  /// AI TESTED
  static String? getSonNode({
    required String path,
    required String node,
  }) {
    if (TextCheck.isEmpty(path) == true || TextCheck.isEmpty(node) == true) {
      return null;
    } else {
      final List<String> pathNodes = Pathing.splitPathNodes(path);
      final int _index = pathNodes.indexOf(node);

      /// non existent
      if (_index == -1) {
        return null;
      }

      /// last
      else if (_index == pathNodes.length - 1) {
        return '';
      }

      /// found
      else {
        return pathNodes[_index + 1];
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// PATHS FINDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> findPathsContainingSubstring({
    required List<String>? paths,
    required String? subString,
  }) {
    final List<String> _foundPaths = <String>[];

    if (Lister.checkCanLoop(paths) && subString != null) {
      for (final String path in paths!) {
        final bool _containsSubString = TextCheck.stringContainsSubString(
          string: path.toLowerCase(),
          subString: subString.toLowerCase(),
        );

        if (_containsSubString == true) {
          _foundPaths.add(path);
        }
      }
    }

    return _foundPaths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> findPathsContainingSubStrings({
    required List<String>? paths,
    required List<String>? subStrings,
  }) {
    List<String> _output = <String>[];

    if (Lister.checkCanLoop(paths) == true &&
        Lister.checkCanLoop(subStrings) == true) {
      for (final String phid in subStrings!) {
        final List<String> _foundPaths = findPathsContainingSubstring(
          paths: paths,
          subString: phid,
        );

        if (Lister.checkCanLoop(_foundPaths) == true) {
          _output = Stringer.addStringsToStringsIfDoNotContainThem(
            listToTake: _output,
            listToAdd: _foundPaths,
          );
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> findPathsHavingLastNodeEqual({
    required List<String>? paths,
    required String? lastNode,
  }){
    final List<String> _foundPaths = <String>[];

    if (Lister.checkCanLoop(paths) == true && TextCheck.isEmpty(lastNode) == false) {
      for (final String path in paths!) {

        final String? _lastNode = getLastPathNode(path);

        if (lastNode == _lastNode) {
          _foundPaths.add(path);
        }

      }
    }

    return _foundPaths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> findPathsHavingLastNodeContain({
    required List<String>? paths,
    required String? subString,
  }){
    final List<String> _foundPaths = <String>[];

    if (Lister.checkCanLoop(paths) == true && TextCheck.isEmpty(subString) == false) {
      for (final String path in paths!) {

        final String? _lastNode = getLastPathNode(path);

        final bool _contains = TextCheck.stringContainsSubString(
          string: _lastNode,
          subString: subString,
        );

        if (_contains == true) {
          _foundPaths.add(path);
        }

      }
    }

    return _foundPaths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> findPathsHavingLastNodesContainAny({
    required List<String>? paths,
    required List<String>? subStrings,
  }) {
    List<String> _output = <String>[];

    if (Lister.checkCanLoop(paths) == true &&
        Lister.checkCanLoop(subStrings) == true) {
      for (final String subString in subStrings!) {

        final List<String> _foundPaths = findPathsHavingLastNodeContain(
          paths: paths,
          subString: subString,
        );

        if (Lister.checkCanLoop(_foundPaths) == true) {
          _output = Stringer.addStringsToStringsIfDoNotContainThem(
            listToTake: _output,
            listToAdd: _foundPaths,
          );
        }

      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PATHS MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> addPathToPaths({
    required List<String>? paths,
    required String? path,
  }) {
    final List<String> _output = <String>[...?paths];

    if (TextCheck.isEmpty(path) == false) {
      if (_output.contains(path) == false) {
        _output.add(path!);
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> splitPathNodes(String? path) {
    List<String> _divisions = <String>[];

    if (TextCheck.isEmpty(path) == false) {
      // final String _cleaned = TextMod.removeTextAfterLastSpecialCharacter(path, '/');
      _divisions = path!.split('/').toList();
      _divisions.removeWhere((element) => element == '');
    }

    return _divisions;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> combinePathsNodes(List<String> paths){
    List<String> _output = [];

    if (Lister.checkCanLoop(paths) == true){

      for (final String path in paths){

        final List<String> _nodes = splitPathNodes(path);

        _output = Stringer.addStringsToStringsIfDoNotContainThem(
            listToTake: _output,
            listToAdd: _nodes,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String combinePathNodes(List<String>? nodes) {
    String _path = '';

    if (Lister.checkCanLoop(nodes) == true) {
      for (final String node in nodes!) {
        _path = _path == '' ? '$node/' : '$_path$node/';
      }
    }

    return _path;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? removeLastPathNode({required String? path}) {
    String? _output;

    if (path != null) {
      final String? _fixed = fixPathFormatting(path);
      final List<String> _nodes = splitPathNodes(_fixed);

      if (Lister.checkCanLoop(_nodes) == true) {
        _nodes.removeAt(_nodes.length - 1);
        _output = combinePathNodes(_nodes);
      }
    }

    return fixPathFormatting(_output);
  }
  // -----------------------------------------------------------------------------

  /// FIXERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? fixPathFormatting(String? path) {
    /// NOTE : GOOD FORMAT SHOULD BE
    // 'chainK/blah_blah/phid/
    /// => no '/' in the beggining
    /// => there MUST '/' in the end

    String? _output = path?.trim();

    if (TextCheck.isEmpty(_output) == false) {
      /// REMOVE INITIAL SLASH IS EXISTS
      if (_output![0] == '/') {
        _output = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: _output,
          specialCharacter: '/',
        );
      }

      /// REMOVE LAST '//////' IF EXISTS
      int _lastIndex = _output!.length - 1;
      if (_output[_lastIndex] == '/') {
        _output = TextMod.removeTextAfterLastSpecialCharacter(
          text: _output,
          specialCharacter: '/',
        );
        _output = '$_output/'; // should always keep one last slash
      }

      /// ASSURE LAST SLASH EXISTS
      _lastIndex = _output.length - 1;
      if (_output[_lastIndex] != '/') {
        _output = '$_output/'; // should always keep one last slash
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generatePathsForLastNodes({
    required String? parentNode,
    required List<String>? lastNodes,
    String previousPath = '', // ...xx/
  }) {
    final List<String> _paths = <String>[];

    if (Lister.checkCanLoop(lastNodes) == true && parentNode != null) {
      for (final String phid in lastNodes!) {
        _paths.add('$previousPath$parentNode/$phid/');
      }
    }

    return _paths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generatePathAncestry({
    required String? path,
  }){
    List<String> _output = [];

    /// grand/parent/son/bobo
    /// grand/parent/son/
    /// grand/parent/
    /// grand

    if (path != null){

      _output = [path];

      final List<String> _nodes = splitPathNodes(path);

      if (_nodes.length > 1){
        String? _path = path;
        for (int i = 0; i < _nodes.length; i++){
          _path = removeLastPathNode(path: _path);
          if (TextCheck.isEmpty(_path) == false){
            _output = Stringer.addStringToListIfDoesNotContainIt(
                strings: _output,
                stringToAdd: _path,
            );
          }
        }
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generatePathsAncestries({
    required List<String> paths,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(paths) == true){
      for (final String path in paths){

        final List<String> _ancestry = Pathing.generatePathAncestry(
          path: path,
        );

        _output = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: _output,
          listToAdd: _ancestry,
        );

      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPath(String? text) {
    bool _output = false;

    if (TextCheck.isEmpty(text) == false) {
      _output = TextCheck.stringContainsSubString(
        string: text,
        subString: '/',
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DEBUG BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPaths(List<String> paths) {
    if (Lister.checkCanLoop(paths) == true) {
      Stringer.blogStrings(
        strings: paths,
        invoker: 'blogPaths',
      );
    } else {
      blog('ALERT : paths are empty');
    }
  }
  // -----------------------------------------------------------------------------
}
