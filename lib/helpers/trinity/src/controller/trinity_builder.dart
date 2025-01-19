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
  final Widget Function(Matrix4 matrix, Offset focalPoint) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MultiWires(
      wires: [
        controller.matrix,
        controller.focalPoint,
      ],
      builder: (_){
        final Matrix4 matrix = controller.matrix.value;
        final Offset focalPoint = controller.focalPoint.value;
        return builder(matrix, focalPoint);
      },
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
