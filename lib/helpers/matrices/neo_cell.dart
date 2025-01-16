import 'dart:typed_data';
import 'package:flutter/material.dart';
/// =>  TAMAM
abstract class NeoCell {
  // --------------------------------------------------------------------------

  /// CELL GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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

  /// CELL SETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4? setCellValue({
    required Matrix4? matrix,
    required int cellIndex,
    required double value,
  }){
    Matrix4? _output;

    if (matrix != null){
      final List<double> _cells = [...matrix.storage];
      _cells.removeAt(cellIndex);
      _cells.insert(cellIndex, value);
      final Float64List _list = Float64List.fromList(_cells);
      _output = Matrix4.fromFloat64List(_list);
    }

    return _output;
  }
  // --------------------------------------------------------------------------
}
