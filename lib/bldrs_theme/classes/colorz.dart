import 'dart:ui';

abstract class Colorz {
  // --------------------
  static const Color bloodTest = Color.fromARGB(100, 255, 0, 0);
  static const Color nothing = Color.fromARGB(0, 255, 255, 255);
  // --------------------
  static const Color black0 = Color.fromARGB(0, 0, 0, 0);
  static const Color black10 = Color.fromARGB(10, 0, 0, 0);
  static const Color black20 = Color.fromARGB(20, 0, 0, 0 );
  static const Color black30 = Color.fromARGB(30, 0, 0, 0 );
  static const Color black50 = Color.fromARGB(50, 0, 0, 0);
  static const Color black80 = Color.fromARGB(80, 0, 0, 0);
  static const Color black125 = Color.fromARGB(125, 0, 0, 0);
  static const Color black150 = Color.fromARGB(150, 0, 0, 0);
  static const Color black200 = Color.fromARGB(200, 0, 0, 0);
  static const Color black230 = Color.fromARGB(230, 0, 0, 0);
  static const Color black255 = Color.fromARGB(255, 0, 0, 0);
  // --------------------
  static const Color blackSemi20 = Color.fromARGB(20, 18, 18, 18);
  static const Color blackSemi125 = Color.fromARGB(125, 18, 18, 18);
  static const Color blackSemi230 = Color.fromARGB(230, 18, 18, 18);
  static const Color blackSemi255 = Color.fromARGB(255, 18, 18, 18);
  // --------------------
  static const Color cyan10 = Color.fromARGB(10, 201, 232, 239);
  static const Color cyan50 = Color.fromARGB(50, 201, 232, 239);
  static const Color cyan255 = Color.fromARGB(255, 201, 232, 239);
  // --------------------
  static const Color blue10 = Color.fromARGB(10, 133, 203, 218);
  static const Color blue20 = Color.fromARGB(20, 133, 203, 218);
  static const Color blue50 = Color.fromARGB(50, 133, 203, 218);
  static const Color blue80 = Color.fromARGB(80, 133, 203, 218);
  static const Color blue125 = Color.fromARGB(125, 133, 203, 218);
  static const Color blue255 = Color.fromARGB(255, 133, 203, 218);
  // --------------------
  static const Color darkBlue = Color.fromARGB(255, 20, 20, 80);
  // --------------------
  static const Color skyDarkBlue = Color.fromARGB(255,19, 36, 75); // #13244b
  // --------------------
  static const Color skyLightBlue = Color.fromARGB(255, 0, 71, 123);
  // --------------------
  static const Color yellow10 = Color.fromARGB(10, 255, 192, 0);
  static const Color yellow20 = Color.fromARGB(20, 255, 192, 0);
  static const Color yellow50 = Color.fromARGB(50, 255, 192, 0);
  static const Color yellow80 = Color.fromARGB(80, 255, 192, 0);
  static const Color yellow125 = Color.fromARGB(125, 255, 192, 0);
  static const Color yellow200 = Color.fromARGB(200, 255, 192, 0);
  static const Color yellow255 = Color.fromARGB(255, 255, 192, 0); // #ffc000
  // --------------------
  static const Color red20 = Color.fromARGB(20, 233, 0, 0);
  static const Color red50 = Color.fromARGB(50, 233, 0, 0);
  static const Color red125 = Color.fromARGB(125, 233, 0, 0);
  static const Color red230 = Color.fromARGB(230, 233, 0, 0);
  static const Color red255 = Color.fromARGB(255, 233, 0, 0);
  // --------------------
  static const Color darkRed125 = Color.fromARGB(125, 97, 5, 5);
  static const Color darkRed230 = Color.fromARGB(230, 97, 5, 5);
  static const Color darkRed255 = Color.fromARGB(255, 97, 5, 5);
  // --------------------
  static const Color errorColor = Color.fromARGB(150, 94, 6, 6);
  // --------------------
  static const Color green20 = Color.fromARGB(20, 24, 157, 14);
  static const Color green50 = Color.fromARGB(50, 24, 157, 14);
  static const Color green80 = Color.fromARGB(80, 24, 157, 14);
  static const Color green125 = Color.fromARGB(125, 24, 157, 14);
  static const Color green230 = Color.fromARGB(230, 24, 157, 14);
  static const Color green255 = Color.fromARGB(255, 24, 157, 14);
  // --------------------
  static const Color darkGreen255 = Color.fromARGB(255, 10, 80, 20);
  // --------------------
  static const Color white10 = Color.fromARGB(10, 255, 255, 255);
  static const Color white20 = Color.fromARGB(20, 255, 255, 255);
  static const Color white30 = Color.fromARGB(30, 255, 255, 255);
  static const Color white50 = Color.fromARGB(50, 255, 255, 255);
  static const Color white80 = Color.fromARGB(80, 255, 255, 255);
  static const Color white125 = Color.fromARGB(125, 255, 255, 255);
  static const Color white200 = Color.fromARGB(200, 255, 255, 255);
  static const Color white230 = Color.fromARGB(230, 255, 255, 255);
  static const Color white255 = Color.fromARGB(255, 255, 255, 255);
  // --------------------
  static const Color grey50 = Color.fromARGB(50, 121, 121, 121);
  static const Color grey80 = Color.fromARGB(80, 121, 121, 121);
  static const Color grey150 = Color.fromARGB(150, 121, 121, 121);
  static const Color grey255 = Color.fromARGB(255, 200, 200, 200);
  // --------------------
  static const Color lightGrey255 = Color.fromARGB(255, 220, 220, 220);
  // --------------------
  static const Color darkGrey255 = Color.fromARGB(255, 180, 180, 180);
  static const Color darkGrey80 = Color.fromARGB(80, 180, 180, 180);
  // --------------------
  static const Color facebook = Color.fromARGB(255, 59, 89, 152);
  static const Color linkedIn = Color.fromARGB(255, 0, 115, 176);
  static const Color googleRed = Color.fromARGB(255, 234, 67, 53);
  static const Color youtube = Color.fromRGBO(255, 0, 0, 1);
  static const Color instagram = Color.fromRGBO(193, 53, 132, 1);
  static const Color pinterest = Color.fromRGBO(230, 0, 35, 1);
  static const Color purple = Color.fromARGB(255, 87, 42, 105);
  static const Color tiktok = Color.fromRGBO(0, 0, 0, 1);
  static const Color twitter = Color.fromRGBO(38, 167, 222, 1);
  static const Color snapChat = Color.fromRGBO(255, 252, 0, 1);
  static const Color behance = Color.fromRGBO(5, 62, 255, 1);
  static const Color vimeo = Color.fromRGBO(134, 201, 239, 1);
  static const Color googleMaps = Color.fromRGBO(52, 168, 83, 1);
  static const Color appStore = Color.fromRGBO(0, 122, 255, 1);
  static const Color googlePlay = Color.fromRGBO(255, 212, 0, 1);
  static const Color appGallery = Color.fromRGBO(206, 14, 45, 1);
  // --------------------
  static const Color telegramLightBlue = Color.fromARGB(255, 56, 176, 227);
  static const Color telegramDarkBlue = Color.fromARGB(255, 29, 147, 210);
  // --------------------
  static const Color appBarColor = white20;
  static const Color bzPageBGColor = black80;
  // -------------------------------------------------------------------------
  static const List<Color> allColorz = <Color>[
    bloodTest,
    nothing,
    black0,
    black10,
    black20,
    black50,
    black80,
    black125,
    black150,
    black200,
    black230,
    black255,
    blackSemi20,
    blackSemi125,
    blackSemi230,
    blackSemi255,
    cyan10,
    cyan50,
    cyan255,
    blue10,
    blue20,
    blue80,
    blue125,
    blue255,
    darkBlue,
    skyDarkBlue,
    skyLightBlue,
    yellow10,
    yellow20,
    yellow50,
    yellow80,
    yellow125,
    yellow200,
    yellow255,
    red50,
    red125,
    red230,
    red255,
    darkRed125,
    darkRed230,
    darkRed255,
    green20,
    green50,
    green80,
    green125,
    green230,
    green255,
    darkGreen255,
    white10,
    white20,
    white30,
    white50,
    white80,
    white125,
    white200,
    white230,
    white255,
    grey50,
    grey80,
    grey255,
    lightGrey255,
    darkGrey255,
    facebook,
    linkedIn,
    googleRed,
    appBarColor,
    bzPageBGColor,
    telegramLightBlue,
    telegramDarkBlue,
  ];
  // -----------------------------------------------------------------------------
}
