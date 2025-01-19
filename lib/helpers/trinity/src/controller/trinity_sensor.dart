part of trinity;

class TrinitySensor extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TrinitySensor({
    required this.controller,
    required this.child,
    this.clipChild = true,
    super.key
  });
  // --------------------
  final TrinityController controller;
  final Widget child;
  final bool clipChild;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (
        controller.canRotate == false
        &&
        controller.canScale == false
        &&
        controller.canMove == false
    ){
      return child;
    }
    // --------------------
    else {
      return GestureDetector(
        onScaleStart: (details) => controller.onScaleStart(details),
        onScaleUpdate: (details) => controller.onScaleUpdate(
          context: context,
          details: details,
        ),
        child: clipChild == true ? ClipRect(child: child) : child,
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
