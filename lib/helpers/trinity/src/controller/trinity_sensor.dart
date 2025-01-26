part of trinity;

class TrinitySensor extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TrinitySensor({
    required this.controller,
    required this.child,
    this.clipChild = true,
    this.onMatrixUpdate,
    super.key
  });
  // --------------------
  final TrinityController controller;
  final Widget child;
  final bool clipChild;
  final Function(Matrix4 matrix, Offset focalPoint)? onMatrixUpdate;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    return MultiWires(
        wires: <Wire<bool>>[
          controller.canScale,
          controller.canMove,
          controller.canRotate,
        ],
        builder: (_) {

          final bool _canScale  = controller.canScale.value;
          final bool _canMove   = controller.canMove.value;
          final bool _canRotate = controller.canRotate.value;

          // --------------------
          return GestureDetector(
            onScaleStart: (details) => controller.onScaleStart(details),
            onScaleUpdate: (details) => controller.onScaleUpdate(
              context: context,
              details: details,
              onMatrixUpdate: onMatrixUpdate,
              canScale: _canScale,
              canMove: _canMove,
              canRotate: _canRotate,
            ),
            child: clipChild == true ? ClipRect(child: child) : child,
          );
          // --------------------

        },
    );

  }
  // --------------------------------------------------------------------------
}
