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
  final Widget Function(Matrix4 matrix) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SingleWire(
      wire: controller.matrix,
      builder: (Matrix4 matrix){
        return builder(matrix);
      },
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
