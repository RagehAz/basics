
import 'dart:typed_data';

import 'package:flutter/material.dart';

abstract class Oracle {
  // -----------------------------------------------------------------------------
  /*

  EXPLANATION

  Row 1: | m00  m01  m02  m03 | ->   | _cells[0]   _cells[1]   _cells[2]   _cells[3]  |
  Row 2: | m10  m11  m12  m13 | ->   | _cells[4]   _cells[5]   _cells[6]   _cells[7]  |
  Row 3: | m20  m21  m22  m23 | ->   | _cells[8]   _cells[9]   _cells[10]  _cells[11] |
  Row 4: | m30  m31  m32  m33 | ->   | _cells[12]  _cells[13]  _cells[14]  _cells[15] |

  _cells[0]   = m00
  _cells[1]   = m10
  _cells[2]   = m20
  _cells[3]   = m30
  _cells[4]   = m01
  _cells[5]   = m11
  _cells[6]   = m21
  _cells[7]   = m31
  _cells[8]   = m02
  _cells[9]   = m12
  _cells[10]  = m22
  _cells[11]  = m32
  _cells[12]  = m03
  _cells[13]  = m13
  _cells[14]  = m23
  _cells[15]  = m33

  | [00]scaleX      [01]shearXY     [02]shearXZ     [03]perspX  |   // Row 0
  | [04]shearYX     [05]scaleY      [06]shearYZ     [07]perspY  |   // Row 1
  | [08]shearZX     [09]shearZY     [10]scaleZ      [11]perspZ  |   // Row 2
  | [12]translateX  [13]translateY  [14]translateZ  [15]perspW  |   // Row 3


   */
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static String getCellName(int cellIndex) {
    switch (cellIndex) {
      case 0: return 'scaleX';         // Row 0, Column 0
      case 1: return 'shearXY';       // Row 0, Column 1
      case 2: return 'shearXZ';       // Row 0, Column 2
      case 3: return 'perspX';        // Row 0, Column 3
      case 4: return 'shearYX';       // Row 1, Column 0
      case 5: return 'scaleY';        // Row 1, Column 1
      case 6: return 'shearYZ';       // Row 1, Column 2
      case 7: return 'perspY';        // Row 1, Column 3
      case 8: return 'shearZX';       // Row 2, Column 0
      case 9: return 'shearZY';       // Row 2, Column 1
      case 10: return 'scaleZ';       // Row 2, Column 2
      case 11: return 'perspZ';       // Row 2, Column 3
      case 12: return 'translateX';   // Row 3, Column 0
      case 13: return 'translateY';   // Row 3, Column 1
      case 14: return 'translateZ';   // Row 3, Column 2
      case 15: return 'perspW';       // Row 3, Column 3
      default: return 'Invalid cell';
    }
  }
  // --------------------
  ///
  static double? getCellValue({
    required Matrix4? matrix,
    required int cellIndex,
  }){
    double? _output;

    if (matrix != null){
      final List<double> _cells = matrix.storage;
      _output = _cells[cellIndex];
    }

    return _output;
  }
  // --------------------
  ///
  static List<double> getCells({
    required Matrix4? matrix,
  }){
    List<double> _output = <double>[];

    if (matrix != null){

      _output = matrix.storage;

      /// FOR REFERENCE
      // final List<double> _cells = matrix.storage;
      // _output = <double>[
      //   _cells[0],  _cells[1],  _cells[2],  _cells[3],
      //   _cells[4],  _cells[5],  _cells[6],  _cells[7],
      //   _cells[8],  _cells[9],  _cells[10],  _cells[11],
      //   _cells[12], _cells[13], _cells[14],  _cells[15],
      // ];

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// SETTERS

  // --------------------
  ///
  static Matrix4? setCellValue({
    required Matrix4? matrix,
    required int cellIndex,
    required double value,
  }){
    Matrix4? _output;

    if (matrix != null){
      final List<double> _cells = matrix.storage;
      _cells.removeAt(cellIndex);
      _cells.insert(cellIndex, value);
      final Float64List _list = Float64List.fromList(_cells);
      _output = Matrix4.fromFloat64List(_list);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  void x(){}
}
