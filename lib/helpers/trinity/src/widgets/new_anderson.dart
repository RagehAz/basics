part of trinity;

// import 'dart:math';
// import 'package:basics/helpers/matrices/neo_move.dart';
// import 'package:basics/helpers/matrices/neo_rotate.dart';
// import 'package:basics/helpers/matrices/neo_scale.dart';
// import 'package:flutter/material.dart';
//
// typedef MatrixGestureDetectorCallback = void Function(
//     Matrix4 matrix,
//     Matrix4 translationDeltaMatrix,
//     Matrix4 scaleDeltaMatrix,
//     Matrix4 rotationDeltaMatrix);
//
// class NewAnderson extends StatefulWidget {
//   // --------------------
//   const NewAnderson({
//     required this.onMatrixUpdate,
//     required this.child,
//     this.initialMatrix,
//     this.shouldTranslate = true,
//     this.shouldScale = true,
//     this.shouldRotate = true,
//     this.clipChild = true,
//     this.focalPointAlignment,
//     Key? key,
//   }) : super(key: key);
//   // --------------------
//   final MatrixGestureDetectorCallback onMatrixUpdate;
//   final Widget child;
//   final Matrix4? initialMatrix;
//   final bool shouldTranslate;
//   final bool shouldScale;
//   final bool shouldRotate;
//   final bool clipChild;
//   final Alignment? focalPointAlignment;
//   // --------------------
//   @override
//   _TheStatefulScreenState createState() => _TheStatefulScreenState();
//   // --------------------------------------------------------------------------
// }
//
// class _TheStatefulScreenState extends State<NewAnderson> {
//   // -----------------------------------------------------------------------------
//   Matrix4 translationDeltaMatrix = Matrix4.identity();
//   Matrix4 scaleDeltaMatrix = Matrix4.identity();
//   Matrix4 rotationDeltaMatrix = Matrix4.identity();
//   Matrix4 matrix = Matrix4.identity();
//   // --------------------
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize the transformation matrix
//     matrix = widget.initialMatrix ?? Matrix4.identity();
//
//     // Initialize translation values
//     if (widget.initialMatrix != null) {
//       final Offset initialTranslation = Offset(matrix.storage[12], matrix.storage[13]);
//       oldTranslation = initialTranslation;
//       newTranslation = initialTranslation;
//     } else {
//       oldTranslation = Offset.zero;
//       newTranslation = Offset.zero;
//     }
//
//     // Initialize scale values
//     oldScale = 1.0;
//     newScale = 1.0;
//
//     // Initialize rotation values
//     oldRotation = 0.0;
//     newRotation = 0.0;
//
//   }
//   // --------------------
//   @override
//   void didUpdateWidget(NewAnderson oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.initialMatrix != widget.initialMatrix) {
//       setState(() {
//         matrix = widget.initialMatrix ?? Matrix4.identity();
//       });
//     }
//   }
//   @override
//   void dispose() {
//     super.dispose();
//   }
//   // --------------------
//   /// Function to update translation
//   Offset updateTranslation(Offset newTranslationValue) {
//     // oldTranslation ??= Offset.zero; // Ensure oldTranslation is not null
//     final Offset result = newTranslationValue - oldTranslation;
//     oldTranslation = newTranslationValue; // Update oldTranslation
//     return result;
//   }
//   // --------------------
//   /// Function to update scale
//   double updateScale(double newScaleValue) {
//     // oldScale; // Ensure oldScale is not null
//     final double result = newScaleValue / oldScale;
//     oldScale = newScaleValue; // Update oldScale
//     return result;
//   }
//   // --------------------
//   /// Function to update rotation
//   double updateRotation(double newRotationValue) {
//     // oldRotation; // Ensure oldRotation is not null
//     final double result = newRotationValue - oldRotation;
//     oldRotation = newRotationValue; // Update oldRotation
//     return result;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// VALUE UPDATERS
//
//   // --------------------
//   // Offset _translation = Offset.zero;
//   // double _scale = 1.0;
//   // double _rotation = 0.0;
//   // --------------------
//   /// Declare global variables for translation, scale, and rotation
//   Offset oldTranslation = Offset.zero;
//   Offset newTranslation = Offset.zero;
//   // --------------------
//   double oldScale = 1;
//   double newScale = 1;
//   // --------------------
//   double oldRotation = 0;
//   double newRotation = 0;
//   // -----------------------------------------------------------------------------
//   /// Function to initialize the translation
//   void _initializeTranslation(Offset focalPoint) {
//     oldTranslation = Offset.zero;
//     newTranslation = focalPoint;
//   }
//   // --------------------
//   /// Function to initialize the scale
//   void _initializeScale(double initialScale) {
//     oldScale = 1.0;
//     newScale = initialScale;
//   }
//   // --------------------
//   /// Function to initialize the rotation
//   void _initializeRotation(double initialRotation) {
//     oldRotation = 0.0;
//     newRotation = initialRotation;
//   }
//   // --------------------
//   /// Updated onScaleStart
//   void onScaleStart(ScaleStartDetails details) {
//     _initializeTranslation(details.focalPoint);
//     _initializeScale(1);
//     _initializeRotation(0);
//   }
//   // --------------------
//   /// Updated onScaleUpdate
//   void onScaleUpdate(ScaleUpdateDetails details) {
//     Matrix4 _translationDelta = Matrix4.identity();
//     Matrix4 _scaleDelta = Matrix4.identity();
//     Matrix4 _rotationDelta = Matrix4.identity();
//
//     /// Handle matrix translating
//     if (widget.shouldTranslate) {
//       final Offset translationDelta = updateTranslation(details.focalPoint);
//       _translationDelta = _translateIt(translationDelta);
//       matrix = _translationDelta * matrix;
//     }
//
//     /// Adjust focal point
//     Offset? focalPoint;
//     if (widget.focalPointAlignment != null && context.size != null) {
//       focalPoint = widget.focalPointAlignment!.alongSize(context.size!);
//     } else {
//       final RenderObject? renderObject = context.findRenderObject();
//       if (renderObject != null) {
//         final RenderBox renderBox = renderObject as RenderBox;
//         focalPoint = renderBox.globalToLocal(details.focalPoint);
//       }
//     }
//
//     /// Handle matrix scaling
//     if (widget.shouldScale && details.scale != 1.0 && focalPoint != null) {
//       final double scaleDelta = updateScale(details.scale);
//       _scaleDelta = _scaleIt(scaleDelta, focalPoint);
//       matrix = _scaleDelta * matrix;
//     }
//
//     /// Handle matrix rotating
//     if (widget.shouldRotate && details.rotation != 0.0) {
//       final double rotationDelta = updateRotation(details.rotation);
//       if (focalPoint != null) {
//         _rotationDelta = _rotateIt(rotationDelta, focalPoint);
//         matrix = _rotationDelta * matrix;
//       }
//     }
//
//     // Trigger the callback with updated matrix data
//     widget.onMatrixUpdate(matrix, _translationDelta, _scaleDelta, _rotationDelta);
//   }
//   // -----------------------------------------------------------------------------
//
//   /// MODIFIERS
//
//   // --------------------
//   Matrix4 _translateIt(Offset translation) {
//     final double dx = translation.dx;
//     final double dy = translation.dy;
//
//     // blog('_translate : (x $dx: y $dy)');
//
//     //  ..[0]  = 1       # x scale
//     //  ..[5]  = 1       # y scale
//     //  ..[10] = 1       # diagonal "one"
//     //  ..[12] = dx      # x translation
//     //  ..[13] = dy      # y translation
//     //  ..[15] = 1       # diagonal "one"
//     return Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
//   }
//   // --------------------
//   Matrix4 _scaleIt(double scale, Offset focalPoint) {
//     final double dx = (1 - scale) * focalPoint.dx;
//     final double dy = (1 - scale) * focalPoint.dy;
//
//     //  ..[0]  = scale   # x scale
//     //  ..[5]  = scale   # y scale
//     //  ..[10] = 1       # diagonal "one"
//     //  ..[12] = dx      # x translation
//     //  ..[13] = dy      # y translation
//     //  ..[15] = 1       # diagonal "one"
//     return Matrix4(scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
//   }
//   // --------------------
//   Matrix4 _rotateIt(double angle, Offset focalPoint) {
//     final double _cos = cos(angle);
//     final double _sin = sin(angle);
//     final double dx = (1 - _cos) * focalPoint.dx + _sin * focalPoint.dy;
//     final double dy = (1 - _cos) * focalPoint.dy - _sin * focalPoint.dx;
//
//     //  ..[0]  = c       # x scale
//     //  ..[1]  = s       # y skew
//     //  ..[4]  = -s      # x skew
//     //  ..[5]  = c       # y scale
//     //  ..[10] = 1       # diagonal "one"
//     //  ..[12] = dx      # x translation
//     //  ..[13] = dy      # y translation
//     //  ..[15] = 1       # diagonal "one"
//     return Matrix4(_cos, _sin, 0, 0, -_sin, _cos, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
//   }
//   // -----------------------------------------------------------------------------
//
//   /// MODIFIERS
//
//   // --------------------
//   /// Updated onScaleUpdate
//   void onNewScaleUpdate(ScaleUpdateDetails details) {
//
//       /// MOVE
//     if (widget.shouldTranslate) {
//       final Offset _offset = details.focalPoint - oldTranslation;
//       oldTranslation = details.focalPoint ;
//       matrix = NeoMove.move(
//           matrix: matrix,
//           x: _offset.dx,
//           y: _offset.dy,
//       );
//     }
//
//     /// FOCAL POINT
//     Offset? focalPoint;
//     if (widget.focalPointAlignment != null && context.size != null) {
//       focalPoint = widget.focalPointAlignment!.alongSize(context.size!);
//     }
//     else {
//       final RenderObject? renderObject = context.findRenderObject();
//       if (renderObject != null) {
//         final RenderBox renderBox = renderObject as RenderBox;
//         focalPoint = renderBox.globalToLocal(details.focalPoint);
//       }
//     }
//
//     /// SCALE
//     if (widget.shouldScale && details.scale != 1.0 && focalPoint != null) {
//       final double _newScale = details.scale / oldScale;
//       oldScale = details.scale;
//       matrix = NeoScale.newScale(
//         matrix: matrix,
//         x: _newScale,
//         y: _newScale,
//         focalPoint: focalPoint,
//       );
//     }
//
//     /// ROTATION
//     if (widget.shouldRotate && details.rotation != 0.0 && focalPoint != null) {
//       final double rotationDelta = details.rotation - oldRotation;
//       oldRotation = details.rotation; // Update oldRotation
//       matrix = NeoRotate.rotate(
//         matrix: matrix,
//         radians: rotationDelta,
//         focalPoint: focalPoint,
//       )!;
//     }
//
//     // Trigger the callback with updated matrix data
//     widget.onMatrixUpdate(matrix, Matrix4.identity(), Matrix4.identity(), Matrix4.identity());
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     if (
//         widget.shouldRotate == false
//         &&
//         widget.shouldScale == false
//         &&
//         widget.shouldTranslate == false
//     ){
//       return widget.child;
//     }
//
//     else {
//       return GestureDetector(
//         onScaleStart: onScaleStart,
//         onScaleUpdate: onScaleUpdate,
//         child: widget.clipChild ? ClipRect(child: widget.child) : widget.child,
//       );
//     }
//     // --------------------
//   }
//   // -----------------------------------------------------------------------------
// }
