part of super_image;
/// => TAMAM : AI TESTED
@immutable
/// The [ImageFilterModel] class to define a Filter which will applied to each color, consists of multiple [-SubFilter-]s
class ImageFilterModel {
  /// --------------------------------------------------------------------------
  const ImageFilterModel({
    required this.id,
    required this.matrixes,
    this.opacity = 1,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final List<List<double>> matrixes;
  final double opacity;
  // -----------------------------------------------------------------------------

  /// MATRIX BUILDER

  // --------------------
  /// TESTED : WORKS PERFECT : Build matrix of current filter
  static List<double>? combineMatrixes({
    required List<List<double>> matrixes,
  }) {

    List<double>? _colorMatrix;

    // blog('combineMatrixes : input are : ${matrixes.length} matrixes ');

    if (Mapper.checkCanLoopList(matrixes) == true){

      const Matrix2d m2d = Matrix2d();

      List<dynamic> result = m2d.reshape([matrixes[0]], 4, 5);
      // List listA = m2d.reshape([filters[0]], 4, 5);

      for (int i = 1; i < matrixes.length; i++) {

        final List<double> listB = <double>[
          ...matrixes[i] is ImageFilterModel ?
          standardImageFilterMatrix
              :
          matrixes[i]
          ,
          0,
          0,
          0,
          0,
          1,
        ];

        result = m2d.dot(
          result,
          m2d.reshape([listB], 5, 5),
        );
      }

      // _colorMatrix =
      return List<double>.from(result.flatten.sublist(0, 20));
      // blog('combineMatrixes : output is : $_colorMatrix');
      // return _colorMatrix;

    }

    else {
      return _colorMatrix;
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT :
  static List<double> standardImageFilterMatrix = <double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0,
    ];
  // -----------------------------------------------------------------------------
  /// Create new filter from this filter with given opacity
  ImageFilterModel addOpacity(double value) {
    return ImageFilterModel(
        id: id,
        matrixes: <List<double>>[
          ...matrixes,
          [
            value,  0,      0,      0,  0,
            0,      value,  0,      0,  0,
            0,      0,      value,  0,  0,
            0,      0,      0,      1,  0,
          ],
        ]
    );
  }
  // -----------------------------------------------------------------------------

  /// BLDRS IMAGE FILTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static ImageFilterModel noFilter(){
    return bldrsImageFilters[0];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ImageFilterModel getFilterByID(String? id){
    ImageFilterModel _filter = noFilter();
    if (id != null){
      _filter = bldrsImageFilters.firstWhere((element) => element.id == id, orElse: () => noFilter());
    }
    return _filter;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ImageFilterModel> bldrsImageFilters = <ImageFilterModel>[
    /// NORMAL
    const ImageFilterModel(
      id: 'phid_filter_normal',
      matrixes: <List<double>>[],
    ),
    /// SHARP
    ImageFilterModel(
      id: 'phid_filter_sharp',
      matrixes: <List<double>>[
        ColorFilterLayer.contrast(0.1),
        ColorFilterLayer.saturation(0.15),
      ],
    ),
    /// LIGHT
    ImageFilterModel(
      id: 'phid_filter_light',
      matrixes: <List<double>>[
        ColorFilterLayer.brightness(30),
        ColorFilterLayer.contrast(0.01),
        ColorFilterLayer.saturation(0.02),
      ],
    ),
    /// DARK
    ImageFilterModel(
      id: 'phid_filter_dark',
      matrixes: <List<double>>[
        ColorFilterLayer.brightness(-28),
        ColorFilterLayer.contrast(0.015),
        ColorFilterLayer.saturation(10),
      ],
    ),
    /// COOL
    ImageFilterModel(
      id: 'phid_filter_cool',
      matrixes: <List<double>>[
        ColorFilterLayer.sepia(0.1),
        ColorFilterLayer.colorOverlay(255, 145, 0, 0.1),
        ColorFilterLayer.brightness(10),
        ColorFilterLayer.saturation(15),
      ],
    ),
    /// WARM
    ImageFilterModel(
      id: 'phid_filter_warm',
      matrixes: <List<double>>[
        ColorFilterLayer.colorOverlay(15, 145, 152, 0.07),
        ColorFilterLayer.sepia(0.05),
      ],
    ),
    /// BLACK & WHITE
    ImageFilterModel(
      id: 'phid_filter_blackandwhite',
      matrixes: <List<double>>[
        ColorFilterLayer.grayscale(),
        ColorFilterLayer.brightness(30),
        ColorFilterLayer.colorOverlay(210, 137, 28, 0.12),
        ColorFilterLayer.contrast(0.12),
      ],
    ),
  ];
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkColorMatrixesAreIdentical({
    required List<List<double>>? matrix1,
    required List<List<double>>? matrix2,
  }){
    bool _identical = false;

    if (matrix1 == null && matrix2 == null){
      _identical = true;
    }
    else if (matrix1 != null && matrix1.isEmpty == true && matrix2 != null && matrix2.isEmpty == true){
      _identical = true;
    }
    else if (matrix1 != null && matrix2 != null){
      if (matrix1.length == matrix2.length){

        bool _allSubListsAreIdentical = false;

        for (int i =0; i < matrix1.length; i++){

          final List<double> _list1 = matrix1[i];
          final List<double> _list2 = matrix2[i];

          final bool _listsAreIdentical = Mapper.checkListsAreIdentical(
            list1: _list1,
            list2: _list2,
          );

          if (_listsAreIdentical == true){
            _allSubListsAreIdentical = true;
          }
          else {
            _allSubListsAreIdentical = false;
            break;
          }
        }

        if (_allSubListsAreIdentical == true){
          _identical = true;
        }

      }
    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFiltersAreIdentical({
    required ImageFilterModel? filter1,
    required ImageFilterModel? filter2,
    bool blogDifferences = false,
  }){
    // blog('checkFiltersAreIdentical : START');
    bool _identical = false;

    if (filter1 == null && filter2 == null){
      _identical = true;
    }
    else if (filter1 != null && filter2 != null){

      if (
      filter1.id == filter2.id &&
          checkColorMatrixesAreIdentical(matrix1: filter1.matrixes, matrix2: filter2.matrixes) &&
          filter1.opacity == filter2.opacity
      ){
        _identical = true;
      }
    }

    if (_identical == false && blogDifferences == true){
      blogFiltersDifferences(
        filter1: filter1,
        filter2: filter2,
      );
    }

    // blog('checkFiltersAreIdentical : END');
    return _identical;
  }

  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogFilter(){
    blog('ImageFilterModel : id : $id');
    blog('ImageFilterModel : matrixes : $matrixes');
    blog('ImageFilterModel : opacity : $opacity');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFiltersDifferences({
    required ImageFilterModel? filter1,
    required ImageFilterModel? filter2,
  }){

    if (filter1 == null){
      blog('blogFiltersDifferences: filter1 is null');
    }
    if (filter2 == null){
      blog('blogFiltersDifferences : filter2 is null');
    }
    if (filter1?.id != filter2?.id){
      blog('blogFiltersDifferences : filters ids are not identical');
    }
    if (checkColorMatrixesAreIdentical(
        matrix1: filter1?.matrixes,
        matrix2: filter2?.matrixes) == false
    ){
      blog('blogFiltersDifferences : ColorMatrixes are not identical');
    }
    if (filter1?.opacity != filter2?.opacity){
      blog('blogFiltersDifferences : Opacities are not identical');
    }

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is ImageFilterModel){
      _areIdentical = checkFiltersAreIdentical(
        filter1: this,
        filter2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      opacity.hashCode^
      matrixes.hashCode;
  // -----------------------------------------------------------------------------
}
