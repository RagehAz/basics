part of trinity;

class TrinitySensor extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TrinitySensor({
    required this.controller,
    this.child,
    this.onViewMatrixUpdate,
    this.builder,
    super.key
  });
  // --------------------
  final TrinityController controller;
  final Widget? child;
  final Function(Matrix4 viewMatrix)? onViewMatrixUpdate;
  final Widget Function(Matrix4 viewMatrix)? builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MultiWires(
        wires: <Wire>[
          controller.canScale,
          controller.canMoveHorizontal,
          controller.canMoveVertical,
          controller.canRotate,
          controller.canOverlay,
          controller.viewMatrix,
          // controller.focalPoint,
        ],
        builder: (_) {
          // --------------------
          final bool _canScale  = controller.canScale.value;
          final bool _canMoveHorizontal   = controller.canMoveHorizontal.value;
          final bool _canMoveVertical   = controller.canMoveVertical.value;
          final bool _canRotate = controller.canRotate.value;
          final bool _canOverlay = controller.canOverlay.value;
          final Matrix4 _viewMatrix = controller.viewMatrix.value;
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
            onScaleEnd: (details) => controller.onScaleEnd(details),
            // child: clipChild == true ? ClipRect(child: child) : child,
            child: ClipRect(
              child: _canOverlay == true ?
              TrinityOverlayer(
                controller: controller,
                child: child ?? builder?.call(_viewMatrix) ?? const SizedBox(),
              )
                  :
              Transform(
                transform: _viewMatrix,
                transformHitTests: false,
                alignment: controller.focalPointAlignment,
                child: child ?? builder?.call(_viewMatrix) ?? const SizedBox(),
              ),
            ),
          );
          // --------------------

        },
    );

  }
  // --------------------------------------------------------------------------
}
