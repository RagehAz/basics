// ignore_for_file: unused_catch_clause
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
/// => TAMAM
class Errorize {
  // -----------------------------------------------------------------------------

  const Errorize();

  // -----------------------------------------------------------------------------

  /// THROW

  // ----------------------
  /// TESTED : WORKS PERFECT
  static void throwText({
    required String text,
    required String invoker,
  }){

    final String _text = '''
Errorized : Invoker : [ $invoker ]
          : text :- 
            $text
    ''';

    try {
      throw Exception(_text);
    }
    on Exception catch (error) {
      blog(_text);
    }

  }
  // ----------------------
  /// TESTED : WORKS PERFECT
  static void throwMap({
    required String invoker,
    required Map<String, dynamic>? map,
  }){

    final String _maw = stringifyMap(map);

    final String _text = '''
Errorized : Invoker : [ $invoker ]
          : Map :- 
$_maw
    ''';

    try {
      throw Exception(_text);
    }
    on Exception catch (error) {
      blog(_text);
    }

  }
  // ----------------------
  /// TESTED : WORKS PERFECT
  static void throwMaps({
    required String invoker,
    required List<Map<String, dynamic>> maps,
  }){

    final String _maw = stringifyMaps(maps);

    final String _text = '''
Errorized : Invoker : [ $invoker ]
          : Maps :- 
$_maw
    ''';

    try {
      throw Exception(_text);
    }
    on Exception catch (error) {
      blog(_text);
    }

  }
  // -----------------------------------------------------------------------------

  /// STRINGIFICATION

  // ----------------------
  /// TESTED : WORKS PERFECT
  static String stringifyMap(Map<String, dynamic>? map) {

    if (map != null){

      final List<String> _lines = [];
      final List<dynamic> _keys = map.keys.toList();
      final List<dynamic> _values = map.values.toList();

      for (int i = 0; i < _keys.length; i++) {

        final String? _index = Numeric.formatIndexDigits(
          index: i,
          listLength: _keys.length,
        );

        final String _line = '         $_index. ${_keys[i]} : <${_values[i].runtimeType}>( ${_values[i]} ), ';
        _lines.add(_line);
      }

      String _b = '';
      for (final String _line in _lines){
        _b = _b == '' ? _line : '$_b\n$_line';
      }
      _b = '$_b\n';

      return '''
       <String, dynamic>{
$_b
       }.........Length : ${_keys.length} keys    
      ''';
    }

    else {
      return 'MAP IS NULL';
    }

  }
  // ----------------------
  /// TESTED : WORKS PERFECT
  static String stringifyMaps(List<Map<String, dynamic>> maps){

      String _x = '';
      for (final Map<String, dynamic> _map in maps){
        final String _maw = stringifyMap(_map);
        _x = _x == '' ? _maw : '$_x\n$_maw';
      }
      _x = '$_x\n';

            final String _text = '''
$_x
    ''';

            return _text;
  }
  // -----------------------------------------------------------------------------
}

