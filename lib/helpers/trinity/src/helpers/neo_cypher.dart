part of trinity;
/// => TAMAM
abstract class NeoCypher {
  // -----------------------------------------------------------------------------

  /// MATRIX CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<double>? cipherMatrix(Matrix4? matrix){
    return matrix?.storage;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4? decipherMatrix(List<dynamic>? doubles){
    Matrix4? _matrix;

    if (doubles != null) {
      final List<double>? _doubles = _getDoublesFromDynamics(doubles);

      if (_doubles != null && _doubles.length == 16) {
        _matrix = Matrix4.fromList(_doubles);
      }
    }

    return _matrix;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<double> _getDoublesFromDynamics(List<dynamic>? dynamics){

    final List<double> _output = <double>[];

    if (Lister.checkCanLoop(dynamics) == true){

      for (final dynamic dyn in dynamics!){

        if (dyn is double){
          final double _double = dyn;
          _output.add(_double);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMatrixesAreIdentical({
    required Matrix4? matrix1,
    required Matrix4? matrixReloaded,
  }){

    if (matrix1 == null && matrixReloaded == null){
      return true;
    }

    else if (matrix1 == null || matrixReloaded == null){
      return false;
    }

    else {
      final List<double> _a = matrix1.storage;
      final List<double> _b = matrixReloaded.storage;
      return Lister.checkListsAreIdentical(list1: _a, list2: _b);
    }

  }
  // -----------------------------------------------------------------------------
}
