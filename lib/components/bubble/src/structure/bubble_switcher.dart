part of bubble;

class BubbleSwitcher extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BubbleSwitcher({
    required this.onSwitch,
    this.switchIsOn = false,
    this.width,
    this.height,
    this.switchActiveColor = const Color.fromARGB(255, 255, 255, 255),
    this.switchTrackColor = const Color.fromARGB(125, 20, 20, 35),
    this.switchFocusColor = const Color.fromARGB(255, 20, 20, 80),
    this.switchDisabledColor = const Color.fromARGB(150, 200, 200, 200),
    this.switchDisabledTrackColor = const Color.fromARGB(80, 20, 20, 35),
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final bool switchIsOn;
  final ValueChanged<bool>? onSwitch;

  final Color? switchActiveColor;
  final Color? switchTrackColor;
  final Color? switchFocusColor;
  final Color? switchDisabledColor;
  final Color? switchDisabledTrackColor;
  /// --------------------------------------------------------------------------
  @override
  _BubbleSwitcherState createState() => _BubbleSwitcherState();
  /// --------------------------------------------------------------------------
  static const double switcherWidth = 50;
  static const double switcherHeight = 35;
  /// --------------------------------------------------------------------------
}

class _BubbleSwitcherState extends State<BubbleSwitcher> {
  // -----------------------------------------------------------------------------
  Wire<bool>? _isOn;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _isOn = Wire<bool>(widget.switchIsOn);
  }
  // --------------------
  @override
  void dispose() {

    _isOn?.dispose();
    _isOn = null;

    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant BubbleSwitcher oldWidget) {

    _isOn?.set(
      mounted: mounted,
      value: widget.switchIsOn,
    );

    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.width ?? BubbleSwitcher.switcherWidth,
      height: widget.height ?? BubbleSwitcher.switcherHeight,
      child: SingleWire(
          wire: _isOn,
          builder: (bool isOn){

            return Switch(
              /// COLORS
              activeColor: widget.switchActiveColor,
              focusColor: widget.switchFocusColor,
              // overlayColor: ,
              /// SIZING
              // splashRadius: ,
              /// THUMB IMAGE
              // activeThumbImage: ,
              // onActiveThumbImageError: ,
              // inactiveThumbImage: ,
              // onInactiveThumbImageError: ,
              // thumbColor: ,
              // thumbIcon: ,
              inactiveThumbColor: widget.switchDisabledColor,
              /// TRACK
              // trackColor: ,
              // autofocus: ,
              // materialTapTargetSize: ,
              activeTrackColor: widget.switchTrackColor,
              inactiveTrackColor: widget.switchDisabledTrackColor,
              /// BEHAVIOUR
              // focusNode: ,
              // dragStartBehavior: ,
              /// CURSOR
              // mouseCursor: ,
              // hoverColor: ,
              /// FUNCTIONS
              // onFocusChange: ,
              value: isOn,
              onChanged: (bool val) async {

                if (widget.onSwitch != null){
                  widget.onSwitch?.call(val);
                }

                _isOn?.set(
                  mounted: mounted,
                  value: val,
                );

              },
              trackOutlineWidth: WidgetStateProperty.resolveWith<double?>((Set<WidgetState> states) {
                return 0.75;
              }),
            );

          }
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
