part of night_sky;

class Sky extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Sky({
    this.skyType = SkyType.blue,
    this.gradientIsOn = false,
    this.skyColor,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final SkyType skyType;
  final bool gradientIsOn;
  final Color? skyColor;
  /// --------------------------------------------------------------------------
  static List<Color>? _getSkyColors({
    required SkyType skyType,
  }){

    switch (skyType){
      case SkyType.grey:        return null;
      case SkyType.blue:        return <Color>[Colorz.skyLightBlue, Colorz.skyDarkBlue];
      case SkyType.nightStars:  return <Color>[Colorz.skyLightBlue, Colorz.skyDarkBlue];
      case SkyType.stars:       return null;
      case SkyType.blackStars:  return null;
      case SkyType.black:       return null;
      case SkyType.non:         return null;
    }

    if (skyType == SkyType.blue || skyType == SkyType.nightStars){
      return <Color>[Colorz.skyLightBlue, Colorz.skyDarkBlue];
    }
    else if (skyType == SkyType.grey || skyType == SkyType.blackStars){
      return <Color>[Colorz.blackSemi230, Colorz.blackSemi230];
    }
    else if (skyType == SkyType.stars){
      return <Color>[Colorz.black255, Colorz.black255];
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

    else {

      switch (skyType){
        case SkyType.stars:       return Colorz.black255;
        case SkyType.grey:        return Colorz.blackSemi255;
        case SkyType.blue:        return Colorz.skyDarkBlue;
        case SkyType.nightStars:  return Colorz.skyDarkBlue;
        case SkyType.blackStars:  return Colorz.black255;
        case SkyType.black:       return Colorz.black255;
        case SkyType.non:         return Colorz.nothing;
      }

    }

    // else if (skyType == SkyType.non){
    //   return Colorz.nothing;
    // }
    // else if (skyType == SkyType.blue || skyType == SkyType.grey){
    //   return null;
    // }
    // else if (skyType == SkyType.stars ){
    //   return Colorz.black255;
    // }
    // else {
    //   return Colorz.skyDarkBlue;
    // }

  }
  // --------------------
  static Gradient? _getSkyGradient({
    required SkyType skyType,
    required bool gradientIsOn,
  }){

    final List<Color>? _colors = _getSkyColors(skyType: skyType);

    if (_colors == null || gradientIsOn == false){
      return null;
    }

    else {
      return RadialGradient(
          center: const Alignment(0.75, 1.25),
          radius: 1,
          colors: _colors,
          stops: const <double>[0, 0.65]
      );
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
        starsAreOn: skyType == SkyType.blackStars
            ||
            skyType == SkyType.nightStars
            ||
            skyType == SkyType.stars
        ,
      ),
    );
  }
// --------------------
}
