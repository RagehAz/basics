part of trinity;

abstract class NeoCurve {
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const List<Curve> curves = [

    Curves.ease,

    Curves.easeIn,
    Curves.easeInSine,
    Curves.easeInQuad,
    Curves.easeInCubic,
    Curves.easeInQuart,
    Curves.easeInQuint,
    Curves.easeInExpo,
    Curves.easeInCirc,
    Curves.easeInBack,

    Curves.easeInOut,
    Curves.easeInOutSine,
    Curves.easeInOutQuad,
    Curves.easeInOutCubic,
    Curves.easeInOutQuart,
    Curves.easeInOutQuint,
    Curves.easeInOutExpo,
    Curves.easeInOutCirc,
    Curves.easeInOutBack,
    Curves.easeInOutCubicEmphasized,

    Curves.easeInToLinear,

    Curves.easeOut,
    Curves.easeOutSine,
    Curves.easeOutQuad,
    Curves.easeOutCubic,
    Curves.easeOutQuart,
    Curves.easeOutQuint,
    Curves.easeOutExpo,
    Curves.easeOutCirc,
    Curves.easeOutBack,

    Curves.linear,
    Curves.linearToEaseOut,

    Curves.slowMiddle,

    Curves.bounceOut,
    Curves.bounceIn,
    Curves.bounceInOut,

    Curves.elasticInOut,
    Curves.elasticIn,
    Curves.elasticOut,

    Curves.decelerate,

    Curves.fastLinearToSlowEaseIn,
    Curves.fastOutSlowIn,
    Curves.fastEaseInToSlowEaseOut,

  ];
  // -----------------------------------------------------------------------------

  /// CURVE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherAnimationCurve(Curve? curve){

    switch (curve){

      case Curves.ease : return 'ease';

      case Curves.easeIn : return 'easeIn';
      case Curves.easeInSine : return 'easeInSine';
      case Curves.easeInQuad : return 'easeInQuad';
      case Curves.easeInCubic : return 'easeInCubic';
      case Curves.easeInQuart : return 'easeInQuart';
      case Curves.easeInQuint : return 'easeInQuint';
      case Curves.easeInExpo : return 'easeInExpo';
      case Curves.easeInCirc : return 'easeInCirc';
      case Curves.easeInBack : return 'easeInBack';

      case Curves.easeInOut : return 'easeInOut';
      case Curves.easeInOutSine : return 'easeInOutSine';
      case Curves.easeInOutQuad : return 'easeInOutQuad';
      case Curves.easeInOutCubic : return 'easeInOutCubic';
      case Curves.easeInOutQuart : return 'easeInOutQuart';
      case Curves.easeInOutQuint : return 'easeInOutQuint';
      case Curves.easeInOutExpo : return 'easeInOutExpo';
      case Curves.easeInOutCirc : return 'easeInOutCirc';
      case Curves.easeInOutBack : return 'easeInOutBack';
      case Curves.easeInOutCubicEmphasized : return 'easeInOutCubicEmphasized';

      case Curves.easeInToLinear : return 'easeInToLinear';

      case Curves.easeOut : return 'easeOut';
      case Curves.easeOutSine : return 'easeOutSine';
      case Curves.easeOutQuad : return 'easeOutQuad';
      case Curves.easeOutCubic : return 'easeOutCubic';
      case Curves.easeOutQuart : return 'easeOutQuart';
      case Curves.easeOutQuint : return 'easeOutQuint';
      case Curves.easeOutExpo : return 'easeOutExpo';
      case Curves.easeOutCirc : return 'easeOutCirc';
      case Curves.easeOutBack : return 'easeOutBack';

      case Curves.linear : return 'linear';
      case Curves.linearToEaseOut : return 'linearToEaseOut';

      case Curves.slowMiddle : return 'slowMiddle';

      case Curves.bounceOut : return 'bounceOut';
      case Curves.bounceIn : return 'bounceIn';
      case Curves.bounceInOut : return 'bounceInOut';

      case Curves.elasticInOut : return 'elasticInOut';
      case Curves.elasticIn : return 'elasticIn';
      case Curves.elasticOut : return 'elasticOut';

      case Curves.decelerate : return 'decelerate';

      case Curves.fastLinearToSlowEaseIn : return 'fastLinearToSlowEaseIn';
      case Curves.fastOutSlowIn : return 'fastOutSlowIn';
      case Curves.fastEaseInToSlowEaseOut : return 'fastEaseInToSlowEaseOut';

      default: return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Curve? decipherAnimationCurve(String? curve){

    switch(curve){

      case 'ease': return Curves.ease;

      case 'easeIn': return Curves.easeIn;
      case 'easeInSine': return Curves.easeInSine;
      case 'easeInQuad': return Curves.easeInQuad;
      case 'easeInCubic': return Curves.easeInCubic;
      case 'easeInQuart': return Curves.easeInQuart;
      case 'easeInQuint': return Curves.easeInQuint;
      case 'easeInExpo': return Curves.easeInExpo;
      case 'easeInCirc': return Curves.easeInCirc;
      case 'easeInBack': return Curves.easeInBack;

      case 'easeInToLinear': return Curves.easeInToLinear;

      case 'easeInOut': return Curves.easeInOut;
      case 'easeInOutSine': return Curves.easeInOutSine;
      case 'easeInOutQuad': return Curves.easeInOutQuad;
      case 'easeInOutCubic': return Curves.easeInOutCubic;
      case 'easeInOutQuart': return Curves.easeInOutQuart;
      case 'easeInOutQuint': return Curves.easeInOutQuint;
      case 'easeInOutExpo': return Curves.easeInOutExpo;
      case 'easeInOutCirc': return Curves.easeInOutCirc;
      case 'easeInOutBack': return Curves.easeInOutBack;
      case 'easeInOutCubicEmphasized': return Curves.easeInOutCubicEmphasized;

      case 'easeOut': return Curves.easeOut;
      case 'easeOutSine': return Curves.easeOutSine;
      case 'easeOutQuad': return Curves.easeOutQuad;
      case 'easeOutCubic': return Curves.easeOutCubic;
      case 'easeOutQuart': return Curves.easeOutQuart;
      case 'easeOutQuint': return Curves.easeOutQuint;
      case 'easeOutExpo': return Curves.easeOutExpo;
      case 'easeOutCirc': return Curves.easeOutCirc;
      case 'easeOutBack': return Curves.easeOutBack;

      case 'linear': return Curves.linear;
      case 'linearToEaseOut': return Curves.linearToEaseOut;

      case 'slowMiddle': return Curves.slowMiddle;

      case 'bounceOut': return Curves.bounceOut;
      case 'bounceIn': return Curves.bounceIn;
      case 'bounceInOut': return Curves.bounceInOut;

      case 'elasticInOut': return Curves.elasticInOut;
      case 'elasticIn': return Curves.elasticIn;
      case 'elasticOut': return Curves.elasticOut;

      case 'decelerate': return Curves.decelerate;

      case 'fastLinearToSlowEaseIn': return Curves.fastLinearToSlowEaseIn;
      case 'fastOutSlowIn': return Curves.fastOutSlowIn;
      case 'fastEaseInToSlowEaseOut': return Curves.fastEaseInToSlowEaseOut;

      default: return null;
    }

  }
  // -----------------------------------------------------------------------------
}
