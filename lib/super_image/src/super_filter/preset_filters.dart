part of super_image;
// -----------------------------------------------------------------------------
/// TASK : CLEAN THIS PAGE ON RELEASE
// -----------------------------------------------------------------------------
/// Preset filters that can be used directly
class PresetFilters {
  // -----------------------------------------------------------------------------

  const PresetFilters();

  // -----------------------------------------------------------------------------
  /// NoFilter: No filter
  static ImageFilterModel none = const ImageFilterModel(
    id: 'No Filter',
    matrixes: <List<double>>[],
  );
  // --------------------
  /// Clarendon: adds light to lighter areas and dark to darker areas
  static ImageFilterModel clarendon = ImageFilterModel(
    id: 'Clarendon',
    matrixes: <List<double>>[
      ColorFilterLayer.brightness(.1),
      ColorFilterLayer.contrast(.1),
      ColorFilterLayer.saturation(.15),
    ],
  );
  // --------------------
  /// Increase red color gradient
  static ImageFilterModel addictiveRed = ImageFilterModel(
    id: 'AddictiveRed',
    matrixes: <List<double>>[
      ColorFilterLayer.addictiveColor(50, 0, 0),
    ],
  );
  // --------------------
  /// Increase blue color gradient
  static ImageFilterModel addictiveBlue = ImageFilterModel(
    id: 'AddictiveBlue',
    matrixes: <List<double>>[
      ColorFilterLayer.addictiveColor(0, 0, 50),
    ],
  );
  // --------------------
  /// Gingham: Vintage-inspired, taking some color out
  static ImageFilterModel gingham = ImageFilterModel(
    id: 'Gingham',
    matrixes: <List<double>>[
      ColorFilterLayer.sepia(.04),
      ColorFilterLayer.contrast(-.15),
    ],
  );
  // --------------------
  /// Moon: B/W, increase brightness and decrease contrast
  static ImageFilterModel moon = ImageFilterModel(
    id: 'Moon',
    matrixes: <List<double>>[
      ColorFilterLayer.grayscale(),
      ColorFilterLayer.contrast(-.04),
      ColorFilterLayer.brightness(0.1),
    ],
  );
  // --------------------
  /// Lark: Brightens and intensifies colours but not red hues
  static ImageFilterModel lark = ImageFilterModel(
    id: 'Lark',
    matrixes: <List<double>>[
      ColorFilterLayer.brightness(0.08),
      ColorFilterLayer.grayscale(),
      ColorFilterLayer.contrast(-.04),
    ],
  );
  // --------------------
  /// Reyes: a vintage filter, gives your photos a “dusty” look
  static ImageFilterModel reyes = ImageFilterModel(
    id: 'Reyes',
    matrixes: <List<double>>[
      ColorFilterLayer.sepia(0.4),
      ColorFilterLayer.brightness(0.13),
      ColorFilterLayer.contrast(-.05),
    ],
  );
  // --------------------
  /// Juno: Brightens colors, and intensifies red and yellow hues
  static ImageFilterModel juno = ImageFilterModel(
    id: 'Juno',
    matrixes: <List<double>>[
      ColorFilterLayer.rgbScale(1.01, 1.04, 1),
      ColorFilterLayer.saturation(0.3),
    ],
  );
  // --------------------
  /// Slumber: Desaturates the image as well as adds haze for a retro, dreamy look – with an emphasis on blacks and blues
  static ImageFilterModel slumber = ImageFilterModel(
    id: 'Slumber',
    matrixes: <List<double>>[
      ColorFilterLayer.brightness(.1),
      ColorFilterLayer.saturation(-0.5),
    ],
  );
  // --------------------
  /// Crema: Adds a creamy look that both warms and cools the image
  static ImageFilterModel crema = ImageFilterModel(
    id: 'Crema',
    matrixes: <List<double>>[
      ColorFilterLayer.rgbScale(1.04, 1, 1.02),
      ColorFilterLayer.saturation(-0.05),
    ],
  );
  // --------------------
  /// Ludwig: A slight hint of desaturation that also enhances light
  static ImageFilterModel ludwig = ImageFilterModel(
    id: 'Ludwig',
    matrixes: <List<double>>[
      ColorFilterLayer.brightness(.05),
      ColorFilterLayer.saturation(-0.03),
    ],
  );
  // --------------------
  /// Aden: This filter gives a blue/pink natural look
  static ImageFilterModel aden = ImageFilterModel(
    id: 'Aden',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(228, 130, 225, 0.13),
      ColorFilterLayer.saturation(-0.2),
    ],
  );
  // --------------------
  /// Perpetua: Adding a pastel look, this filter is ideal for portraits
  static ImageFilterModel perpetua = ImageFilterModel(
    id: 'Perpetua',
    matrixes: <List<double>>[
      ColorFilterLayer.rgbScale(1.05, 1.1, 1),
    ],
  );
  // --------------------
  /// Amaro: Adds light to an image, with the focus on the centre
  static ImageFilterModel amaro = ImageFilterModel(
    id: 'Amaro',
    matrixes: <List<double>>[
      ColorFilterLayer.saturation(0.3),
      ColorFilterLayer.brightness(0.15),
    ],
  );
  // --------------------
  /// Mayfair: Applies a warm pink tone, subtle vignetting to brighten the photograph center and a thin black border
  static ImageFilterModel mayfair = ImageFilterModel(
    id: 'Mayfair',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(230, 115, 108, 0.05),
      ColorFilterLayer.saturation(0.15),
    ],
  );
  // --------------------
  /// Rise: Adds a "glow" to the image, with softer lighting of the subject
  static ImageFilterModel rise = ImageFilterModel(
    id: 'Rise',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 170, 0, 0.1),
      ColorFilterLayer.brightness(0.09),
      ColorFilterLayer.saturation(0.1),
    ],
  );
  // --------------------
  /// Hudson: Creates an "icy" illusion with heightened shadows, cool tint and dodged center
  static ImageFilterModel hudson = ImageFilterModel(
    id: 'Hudson',
    matrixes: <List<double>>[
      ColorFilterLayer.rgbScale(1, 1, 1.25),
      ColorFilterLayer.contrast(0.1),
      ColorFilterLayer.brightness(0.15),
    ],
  );
  // --------------------
  /// Valencia: Fades the image by increasing exposure and warming the colors, to give it an antique feel
  static ImageFilterModel valencia = ImageFilterModel(
    id: 'Valencia',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 225, 80, 0.08),
      ColorFilterLayer.saturation(0.1),
      ColorFilterLayer.contrast(0.05),
    ],
  );
  // --------------------
  /// X-Pro II: Increases color vibrance with a golden tint, high contrast and slight vignette added to the edges
  static ImageFilterModel xProII = ImageFilterModel(
    id: 'X-Pro II',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 255, 0, 0.07),
      ColorFilterLayer.saturation(0.2),
      ColorFilterLayer.contrast(0.15),
    ],
  );
  // --------------------
  /// Sierra: Gives a faded, softer look
  static ImageFilterModel sierra = ImageFilterModel(
    id: 'Sierra',
    matrixes: <List<double>>[
      ColorFilterLayer.contrast(-0.15),
      ColorFilterLayer.saturation(0.1),
    ],
  );
  // --------------------
  /// Willow: A monochromatic filter with subtle purple tones and a translucent white border
  static ImageFilterModel willow = ImageFilterModel(
    id: 'Willow',
    matrixes: <List<double>>[
      ColorFilterLayer.grayscale(),
      ColorFilterLayer.colorOverlay(100, 28, 210, 0.03),
      ColorFilterLayer.brightness(0.1),
    ],
  );
  // --------------------
  /// Lo-Fi: Enriches color and adds strong shadows through the use of saturation and "warming" the temperature
  static ImageFilterModel loFi = ImageFilterModel(
    id: 'Lo-Fi',
    matrixes: <List<double>>[
      ColorFilterLayer.contrast(0.15),
      ColorFilterLayer.saturation(0.2),
    ],
  );
  // --------------------
  /// Inkwell: Direct shift to black and white
  static ImageFilterModel inkwell = ImageFilterModel(
    id: 'Inkwell',
    matrixes: <List<double>>[
      ColorFilterLayer.grayscale(),
    ],
  );
  // --------------------
  /// Hefe: Hight contrast and saturation, with a similar effect to Lo-Fi but not quite as dramatic
  static ImageFilterModel hefe = ImageFilterModel(
    id: 'Hefe',
    matrixes: <List<double>>[
      ColorFilterLayer.contrast(0.1),
      ColorFilterLayer.saturation(0.15),
    ],
  );
  // --------------------
  /// Nashville: Warms the temperature, lowers contrast and increases exposure to give a light "pink" tint – making it feel "nostalgic"
  static ImageFilterModel nashville = ImageFilterModel(
    id: 'Nashville',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(220, 115, 188, 0.12),
      ColorFilterLayer.contrast(-0.05),
    ],
  );
  // --------------------
  /// Stinson: washing out the colors ever so slightly
  static ImageFilterModel stinson = ImageFilterModel(
    id: 'Stinson',
    matrixes: <List<double>>[
      ColorFilterLayer.brightness(0.1),
      ColorFilterLayer.sepia(0.3),
    ],
  );
  // --------------------
  /// Vesper: adds a yellow tint that
  static ImageFilterModel vesper = ImageFilterModel(
    id: 'Vesper',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 225, 0, 0.05),
      ColorFilterLayer.brightness(0.06),
      ColorFilterLayer.contrast(0.06),
    ],
  );
  // --------------------
  /// Earlybird: Gives an older look with a sepia tint and warm temperature
  static ImageFilterModel earlybird = ImageFilterModel(
    id: 'Earlybird',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 165, 40, 0.2),
      ColorFilterLayer.saturation(0.15),
    ],
  );
  // --------------------
  /// Brannan: Increases contrast and exposure and adds a metallic tint
  static ImageFilterModel brannan = ImageFilterModel(
    id: 'Brannan',
    matrixes: <List<double>>[
      ColorFilterLayer.contrast(0.2),
      ColorFilterLayer.colorOverlay(140, 10, 185, 0.1),
    ],
  );
  // --------------------
  /// Sutro: Burns photo edges, increases highlights and shadows dramatically with a focus on purple and brown colors
  static ImageFilterModel sutro = ImageFilterModel(
    id: 'Sutro',
    matrixes: <List<double>>[
      ColorFilterLayer.brightness(-0.1),
      ColorFilterLayer.saturation(-0.1),
    ],
  );
  // --------------------
  /// Toaster: Ages the image by "burning" the centre and adds a dramatic vignette
  static ImageFilterModel toaster = ImageFilterModel(
    id: 'Toaster',
    matrixes: <List<double>>[
      ColorFilterLayer.sepia(0.1),
      ColorFilterLayer.colorOverlay(255, 145, 0, 0.2),
    ],
  );
  // --------------------
  /// Walden: Increases exposure and adds a yellow tint
  static ImageFilterModel walden = ImageFilterModel(
    id: 'Walden',
    matrixes: <List<double>>[
      ColorFilterLayer.brightness(0.1),
      ColorFilterLayer.colorOverlay(255, 255, 0, 0.2),
    ],
  );
  // --------------------
  /// 1977: The increased exposure with a red tint gives the photograph a rosy, brighter, faded look.
  static ImageFilterModel f1977 = ImageFilterModel(
    id: '1977',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 25, 0, 0.15),
      ColorFilterLayer.brightness(0.1),
    ],
  );
  // --------------------
  /// Kelvin: Increases saturation and temperature to give it a radiant "glow"
  static ImageFilterModel kelvin = ImageFilterModel(
    id: 'Kelvin',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 140, 0, 0.1),
      ColorFilterLayer.rgbScale(1.15, 1.05, 1),
      ColorFilterLayer.saturation(0.35),
    ],
  );
  // --------------------
  /// Maven: darkens images, increases shadows, and adds a slightly yellow tint overal
  static ImageFilterModel maven = ImageFilterModel(
    id: 'Maven',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(225, 240, 0, 0.1),
      ColorFilterLayer.saturation(0.25),
      ColorFilterLayer.contrast(0.05),
    ],
  );
  // --------------------
  /// Ginza: brightens and adds a warm glow
  static ImageFilterModel ginza = ImageFilterModel(
    id: 'Ginza',
    matrixes: <List<double>>[
      ColorFilterLayer.sepia(0.06),
      ColorFilterLayer.brightness(0.1),
    ],
  );
  // --------------------
  /// Skyline: brightens to the image pop
  static ImageFilterModel skyline = ImageFilterModel(
    id: 'Skyline',
    matrixes: <List<double>>[
      ColorFilterLayer.saturation(0.35),
      ColorFilterLayer.brightness(0.1),
    ],
  );
  // --------------------
  /// Dogpatch: increases the contrast, while washing out the lighter colors
  static ImageFilterModel dogpatch = ImageFilterModel(
    id: 'Dogpatch',
    matrixes: <List<double>>[
      ColorFilterLayer.contrast(0.15),
      ColorFilterLayer.brightness(0.1),
    ],
  );
  // --------------------
  /// Brooklyn
  static ImageFilterModel brooklyn = ImageFilterModel(
    id: 'Brooklyn',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(25, 240, 252, 0.05),
      ColorFilterLayer.sepia(0.3),
    ],
  );
  // --------------------
  /// Helena: adds an orange and teal vibe
  static ImageFilterModel helena = ImageFilterModel(
    id: 'Helena',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(208, 208, 86, 0.2),
      ColorFilterLayer.contrast(0.15),
    ],
  );
  // --------------------
  /// Ashby: gives images a great golden glow and a subtle vintage feel
  static ImageFilterModel ashby = ImageFilterModel(
    id: 'Ashby',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 160, 25, 0.1),
      ColorFilterLayer.brightness(0.1),
    ],
  );
  // --------------------
  /// Charmes: a high contrast filter, warming up colors in your image with a red tint
  static ImageFilterModel charmes = ImageFilterModel(
    id: 'Charmes',
    matrixes: <List<double>>[
      ColorFilterLayer.colorOverlay(255, 50, 80, 0.12),
      ColorFilterLayer.contrast(0.05),
    ],
  );
}
// -----------------------------------------------------------------------------
/// List of filter presets
List<ImageFilterModel> presetFiltersList = <ImageFilterModel>[
  PresetFilters.none,
  PresetFilters.addictiveBlue,
  PresetFilters.addictiveRed,
  PresetFilters.aden,
  PresetFilters.amaro,
  PresetFilters.ashby,
  PresetFilters.brannan,
  PresetFilters.brooklyn,
  PresetFilters.charmes,
  PresetFilters.clarendon,
  PresetFilters.crema,
  PresetFilters.dogpatch,
  PresetFilters.earlybird,
  PresetFilters.f1977,
  PresetFilters.gingham,
  PresetFilters.ginza,
  PresetFilters.hefe,
  PresetFilters.helena,
  PresetFilters.hudson,
  PresetFilters.inkwell,
  PresetFilters.juno,
  PresetFilters.kelvin,
  PresetFilters.lark,
  PresetFilters.loFi,
  PresetFilters.ludwig,
  PresetFilters.maven,
  PresetFilters.mayfair,
  PresetFilters.moon,
  PresetFilters.nashville,
  PresetFilters.perpetua,
  PresetFilters.reyes,
  PresetFilters.rise,
  PresetFilters.sierra,
  PresetFilters.skyline,
  PresetFilters.slumber,
  PresetFilters.stinson,
  PresetFilters.sutro,
  PresetFilters.toaster,
  PresetFilters.valencia,
  PresetFilters.vesper,
  PresetFilters.walden,
  PresetFilters.willow,
  PresetFilters.xProII,
];
// -----------------------------------------------------------------------------
