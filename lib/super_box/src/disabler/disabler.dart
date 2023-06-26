part of super_box;

class Disabler extends StatelessWidget {

  const Disabler({
    required this.isDisabled,
    required this.child,
    this.disabledOpacity = 0.5,
    super.key
  });

  final bool isDisabled;
  final Widget child;
  final double disabledOpacity;

  @override
  Widget build(BuildContext context) {

    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled == true ? disabledOpacity : 1,
        child: child,
      ),
    );
  }

}
