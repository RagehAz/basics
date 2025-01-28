part of trinity;

class TrinityBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TrinityBuilder({
    required this.controller,
    required this.builder,
    this.builderWithFocalPoint,
    super.key
  });
  // --------------------
  final TrinityController controller;
  final Widget Function(Matrix4 viewMatrix) builder;
  final Widget Function(Matrix4 viewMatrix, Offset focalPoint)? builderWithFocalPoint;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MultiWires(
      wires: [
        controller.viewMatrix,
        controller.focalPoint,
      ],
      builder: (_){
        final Matrix4 _theViewMatrix = controller.viewMatrix.value;
        /// WORKS GOOD BUT NOT USED
        // final Offset focalPoint = controller.focalPoint.value;
        
        if (builderWithFocalPoint != null){
          return builderWithFocalPoint!(_theViewMatrix, controller.focalPoint.value);
        }
        else {
          return builder(_theViewMatrix);
        }
        
      },
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
