part of night_sky;

class Sky extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Sky({
    this.skyType = SkyType.night,
    this.gradientIsOn = false,
    this.skyColor,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final SkyType skyType;
  final bool gradientIsOn;
  final Color? skyColor;
  /// --------------------------------------------------------------------------
  static List<Color> _getSkyColors({
    required SkyType skyType,
  }){

    if (skyType == SkyType.night){
      return <Color>[Colorz.skyLightBlue, Colorz.skyDarkBlue];
    }
    else if (skyType == SkyType.black){
      return <Color>[Colorz.blackSemi230, Colorz.blackSemi230];
    }
    else {
      return <Color>[Colorz.skyDarkBlue, Colorz.skyDarkBlue];
    }

  }
  // --------------------
  static Color? _getBaseColor({
    required Color? colorOverride,
    required SkyType skyType,
  }){

    if (colorOverride != null){
      return colorOverride;
    }
    else if (skyType == SkyType.night || skyType == SkyType.black){
      return null;
    }
    else {
      return Colorz.skyDarkBlue;
    }

  }
  // --------------------
  static Gradient? _getSkyGradient({
    required SkyType skyType,
    required bool gradientIsOn,
  }){

    if (gradientIsOn == true){
      return RadialGradient(
          center: const Alignment(0.75, 1.25),
          radius: 1,
          colors: _getSkyColors(skyType: skyType),
          stops: const <double>[0, 0.65]
      );
    }

    else {
      return null;
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      key: key,
      width: Scale.screenWidth(context),
      height: Scale.screenHeight(context),
      decoration: BoxDecoration(
        color: _getBaseColor(
          skyType: skyType,
          colorOverride: skyColor,
        ),
        gradient: _getSkyGradient(
          skyType: skyType,
          gradientIsOn: gradientIsOn,
        ),
      ),
      child: SkyStars(
        starsAreOn: skyType == SkyType.blackStars || skyType == SkyType.nightStars,
      ),
    );
  }
// --------------------
}
