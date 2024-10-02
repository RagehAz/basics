// ignore_for_file: prefer_int_literals

import 'dart:math';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

/// Gesture detector that reports user drags in terms of [PolarCoord]s with the
/// origin at the center of the provided [child].
///
/// [PolarCoord]s are comprised of an angle and a radius (distance).
///
/// Use [onRadialDragStart], [onRadialDragUpdate], and [onRadialDragEnd] to
/// react to the respective radial drag events.
class RadialDragGestureDetector extends StatefulWidget {

  const RadialDragGestureDetector({
    this.onRadialDragStart,
    this.onRadialDragUpdate,
    this.onRadialDragEnd,
    this.child,
    this.stopRotate = false,
    super.key,
  });

  final RadialDragStart? onRadialDragStart;
  final RadialDragUpdate? onRadialDragUpdate;
  final RadialDragEnd? onRadialDragEnd;
  final Widget? child;
  final bool stopRotate;

  @override
  _RadialDragGestureDetectorState createState() =>
      _RadialDragGestureDetectorState();

}

class _RadialDragGestureDetectorState extends State<RadialDragGestureDetector> {
  _onPanStart(DragStartDetails details) {
    if (null != widget.onRadialDragStart) {
      final polarCoord = _polarCoordFromGlobalOffset(details.globalPosition);
      widget.onRadialDragStart!(polarCoord);
    }
  }

  _onPanUpdate(DragUpdateDetails details) {
    if (null != widget.onRadialDragUpdate) {
      final polarCoord = _polarCoordFromGlobalOffset(details.globalPosition);
      widget.onRadialDragUpdate!(polarCoord);
    }
  }

  _onPanEnd(DragEndDetails details) {
    if (null != widget.onRadialDragEnd) {
      widget.onRadialDragEnd!();
    }
  }

  _polarCoordFromGlobalOffset(globalOffset) {
    // Convert the user's global touch offset to an offset that is local to
    // this Widget.
    final localTouchOffset =
    (context.findRenderObject() as RenderBox).globalToLocal(globalOffset);

    // Convert the local offset to a Point so that we can do math with it.
    final localTouchPoint = Point(localTouchOffset.dx, localTouchOffset.dy);

    // Create a Point at the center of this Widget to act as the origin.
    final originPoint =
    Point(context.size!.width / 2, context.size!.height / 2);

    return PolarCoord.fromPoints(originPoint, localTouchPoint);
  }

  @override
  Widget build(BuildContext context) {
    return widget.stopRotate
        ? widget.child!
        : GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: widget.child,
    );
  }
}

class PolarCoord {

  PolarCoord(this.angle, this.radius, this.origin, this.point);

  factory PolarCoord.fromPoints(Point origin, Point point) {
    // Subtract the origin from the point to get the vector from the origin
    // to the point.
    final vectorPoint = point - origin;
    final vector = Offset(vectorPoint.x as double, vectorPoint.y as double);

    // The polar coordinate is the angle the vector forms with the x-axis, and
    // the distance of the vector.
    return PolarCoord(
      vector.direction,
      vector.distance,
      Offset(origin.x as double, origin.y as double),
      Offset(point.x as double, point.y as double),
    );
  }


  double angle;
  double radius;
  Offset origin;
  Offset point;

  @override
  String toString() {
    return 'Polar Coord: ${radius.toStringAsFixed(2)} at ${(angle / (2 * pi) * 360).toStringAsFixed(2)}°';
  }

}

typedef RadialDragStart = Function(PolarCoord startCoord);
typedef RadialDragUpdate = Function(PolarCoord updateCoord);
typedef RadialDragEnd = Function();

enum RotateMode {
  onlyChildrenRotate,
  allRotate,
  stopRotate,
}

class DragAngleRange {

  DragAngleRange(this.start, this.end);

  double start;

  double end;

}


class CircleList extends StatefulWidget {

  const CircleList({
    required this.children,
    this.innerRadius,
    this.outerRadius,
    this.childrenPadding = 10,
    this.initialAngle = 0,
    this.outerCircleColor,
    this.innerCircleColor,
    this.origin,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.gradient,
    this.centerWidget,
    this.isChildrenVertical = true,
    this.innerCircleRotateWithChildren = false,
    this.showInitialAnimation = false,
    this.animationSetting,
    this.rotateMode,
    this.dragAngleRange,
    super.key,
  });

  final double? innerRadius;
  final double? outerRadius;
  final double childrenPadding;
  final double initialAngle;
  final Color? outerCircleColor;
  final Color? innerCircleColor;
  final Gradient? gradient;
  final Offset? origin;
  final List<Widget> children;
  final bool isChildrenVertical;
  final RotateMode? rotateMode;
  final bool innerCircleRotateWithChildren;
  final bool showInitialAnimation;
  final Widget? centerWidget;
  final RadialDragStart? onDragStart;
  final RadialDragUpdate? onDragUpdate;
  final RadialDragEnd? onDragEnd;
  final AnimationSetting? animationSetting;
  final DragAngleRange? dragAngleRange;

  @override
  _CircleListState createState() => _CircleListState();
}

class _CircleListState extends State<CircleList>
    with SingleTickerProviderStateMixin {
  _DragModel dragModel = _DragModel();
  AnimationController? _controller;
  late Animation<double> _animationRotate;
  bool isAnimationStop = true;

  @override
  void initState() {
    if (widget.showInitialAnimation) {
      _controller = AnimationController(
          vsync: this,
          duration: widget.animationSetting?.duration ?? const Duration(seconds: 1));
      _animationRotate = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller!,
          curve: widget.animationSetting?.curve ?? Curves.easeOutBack));
      _controller!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isAnimationStop = true;
          });
        }
      });
      _controller!.addListener(() {
        setState(() {
          isAnimationStop = false;
        });
      });
      _controller!.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------------------
    final Size size = Scale.screenSize(context);
    final outCircleDiameter = min(size.width, size.height);
    final double outerRadius = widget.outerRadius ?? outCircleDiameter / 2;
    final double innerRadius = widget.innerRadius ?? outerRadius / 2;
    final double betweenRadius = (outerRadius + innerRadius) / 2;
    final rotateMode = widget.rotateMode ?? RotateMode.onlyChildrenRotate;
    final dragAngleRange = widget.dragAngleRange;
    // --------------------
    ///the origin is the point to left and top
    final Offset origin = widget.origin ?? Offset(0, -outerRadius);
    double backgroundCircleAngle = 0.0;
    if (rotateMode == RotateMode.allRotate) {
      backgroundCircleAngle = dragModel.angleDiff + widget.initialAngle;
    }
    // --------------------
    return SizedBox(
      width: outerRadius * 2,
      height: outerRadius * 2,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: origin.dx,
            top: -origin.dy,
            child: RadialDragGestureDetector(
              stopRotate: rotateMode == RotateMode.stopRotate,
              onRadialDragUpdate: (PolarCoord updateCoord) {

                widget.onDragUpdate?.call(updateCoord);

                setState(() {
                  dragModel.getAngleDiff(updateCoord, dragAngleRange);
                });

              },
              onRadialDragStart: (PolarCoord startCoord) {

                widget.onDragStart?.call(startCoord);

                setState(() {
                  dragModel.start = startCoord;
                });

              },
              onRadialDragEnd: () {
                widget.onDragEnd?.call();
                dragModel.end = dragModel.start;
                dragModel.end!.angle = dragModel.angleDiff;
              },
              child: Transform.rotate(
                angle: backgroundCircleAngle,
                child: Container(
                    width: outerRadius * 2,
                    height: outerRadius * 2,
                    decoration: BoxDecoration(
                        gradient: widget.gradient,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.outerCircleColor ?? Colors.transparent,
                          width: outerRadius - innerRadius,
                        ))),
              ),
            ),
          ),
          Positioned(
            left: origin.dx,
            top: -origin.dy,
            child: SizedBox(
              width: outerRadius * 2,
              height: outerRadius * 2,
              child: RadialDragGestureDetector(
                stopRotate: rotateMode == RotateMode.stopRotate,
                onRadialDragUpdate: (PolarCoord updateCoord) {
                  widget.onDragUpdate?.call(updateCoord);
                  setState(() {
                    dragModel.getAngleDiff(updateCoord, dragAngleRange);
                  });
                },
                onRadialDragStart: (PolarCoord startCoord) {
                  widget.onDragStart?.call(startCoord);
                  setState(() {
                    dragModel.start = startCoord;
                  });
                },
                onRadialDragEnd: () {
                  widget.onDragEnd?.call();
                  dragModel.end = dragModel.start;
                  dragModel.end!.angle = dragModel.angleDiff;
                },
                child: Transform.rotate(
                  angle: isAnimationStop
                      ? (dragModel.angleDiff + widget.initialAngle)
                      : (-_animationRotate.value * pi * 2 +
                      widget.initialAngle),
                  child: Stack(
                    children: List.generate(widget.children.length, (index) {
                      final double childrenDiameter =
                          2 * pi * betweenRadius / widget.children.length -
                              widget.childrenPadding;
                      final Offset childPoint = getChildPoint(
                          index,
                          widget.children.length,
                          betweenRadius,
                          childrenDiameter);
                      return Positioned(
                        left: outerRadius + childPoint.dx,
                        top: outerRadius + childPoint.dy,
                        child: Transform.rotate(
                          angle: widget.isChildrenVertical ? (-dragModel.angleDiff - widget.initialAngle)
                              : ((dragModel.angleDiff) + widget.initialAngle),
                          child: Container(
                              width: childrenDiameter,
                              height: childrenDiameter,
                              alignment: Alignment.center,
                              child: widget.children[index]),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: origin.dx + outerRadius - innerRadius,
              top: -origin.dy + outerRadius - innerRadius,
              child: Transform.rotate(
                angle: widget.innerCircleRotateWithChildren
                    ? dragModel.angleDiff + widget.initialAngle
                    : 0,
                child: Container(
                  width: innerRadius * 2,
                  height: innerRadius * 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.innerCircleColor ?? Colors.transparent,
                  ),
                  child: widget.centerWidget ?? const SizedBox(),
                ),
              ))
        ],
      ),
    );
    // -----------------------------------------------------------------------------
  }

  Offset getChildPoint(int index, int length, double betweenRadius, double childrenDiameter) {
    final double angel = 2 * pi * (index / length);
    final double x = cos(angel) * betweenRadius - childrenDiameter / 2;
    final double y = sin(angel) * betweenRadius - childrenDiameter / 2;
    return Offset(x, y);
  }
}

class _DragModel {
  PolarCoord? start;
  PolarCoord? end;
  double angleDiff = 0.0;

  double getAngleDiff(PolarCoord updatePolar, DragAngleRange? dragAngleRange) {

    if (start != null) {
      angleDiff = updatePolar.angle - start!.angle;
      if (end != null) {
        angleDiff += end!.angle;
      }
    }

    return limitAngle(angleDiff, dragAngleRange);

  }

  double limitAngle(double angleDiff, DragAngleRange? dragAngleRange) {

    double _output = angleDiff;

    if (dragAngleRange == null){

    }

    else if (angleDiff > dragAngleRange.end){
      _output = dragAngleRange.end;
    }
    else if (angleDiff < dragAngleRange.start){
      _output = dragAngleRange.start;
    }

    return _output;

  }

}

class AnimationSetting {

  AnimationSetting({this.duration, this.curve});
  final Duration? duration;
  final Curve? curve;
}
