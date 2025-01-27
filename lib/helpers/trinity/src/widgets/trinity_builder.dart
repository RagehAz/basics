part of trinity;

class TrinityBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TrinityBuilder({
    required this.controller,
    required this.builder,
    super.key
  });
  // --------------------
  final TrinityController controller;
  final Widget Function(Matrix4 viewMatrix) builder;
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
        return builder(_theViewMatrix);
      },
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
