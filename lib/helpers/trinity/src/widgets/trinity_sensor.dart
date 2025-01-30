part of trinity;

class TrinitySensor extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TrinitySensor({
    required this.controller,
    required this.child,
    this.clipChild = true,
    this.onViewMatrixUpdate,
    super.key
  });
  // --------------------
  final TrinityController controller;
  final Widget child;
  final bool clipChild;
  final Function(Matrix4 viewMatrix)? onViewMatrixUpdate;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    return MultiWires(
        wires: <Wire<bool>>[
          controller.canScale,
          controller.canMoveHorizontal,
          controller.canMoveVertical,
          controller.canRotate,
        ],
        builder: (_) {

          final bool _canScale  = controller.canScale.value;
          final bool _canMoveHorizontal   = controller.canMoveHorizontal.value;
          final bool _canMoveVertical   = controller.canMoveVertical.value;
          final bool _canRotate = controller.canRotate.value;

          // --------------------
          return GestureDetector(
            onScaleStart: (details) => controller.onScaleStart(details),
            onScaleUpdate: (details) => controller.onScaleUpdate(
              context: context,
              details: details,
              onViewMatrixUpdate: onViewMatrixUpdate,
              canScale: _canScale,
              canMoveHorizontal: _canMoveHorizontal,
              canMoveVertical: _canMoveVertical,
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
