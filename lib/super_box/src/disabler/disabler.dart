part of super_box;

class Disabler extends StatelessWidget {

  const Disabler({
    required this.isDisabled,
    required this.child,
    this.isHidden = false,
    this.disabledOpacity = 0.5,
    super.key
  });

  final bool isDisabled;
  final Widget child;
  final double disabledOpacity;
  final bool isHidden;

  @override
  Widget build(BuildContext context) {

    if (isHidden == true){
      return const SizedBox();
    }

    else {
      return IgnorePointer(
        ignoring: isDisabled,
        child: disabledOpacity == 1 ? child
            :
        Opacity(
          opacity: isDisabled == true ? disabledOpacity : 1,
          child: child,
        ),
      );
    }

  }

}
