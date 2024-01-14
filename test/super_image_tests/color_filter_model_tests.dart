import 'package:basics/components/super_image/super_image.dart';
import 'package:flutter_test/flutter_test.dart';

/// AI GENERATED
void testCombineMatrixes() {
  final List<List<double>> inputMatrixes = <List<double>>[    <double>[      1, 0, 0, 0, 0,      0, 1, 0, 0, 0,      0, 0, 1, 0, 0,      0, 0, 0, 1, 0,    ],
    <double>[      0.5, 0, 0, 0, 0,      0, 0.5, 0, 0, 0,      0, 0, 0.5, 0, 0,      0, 0, 0, 1, 0,    ],
  ];
  final List<double> expectedOutput = <double>[    0.5, 0, 0, 0, 0,    0, 0.5, 0, 0, 0,    0, 0, 0.5, 0, 0,    0, 0, 0, 1, 0,  ];
  final List<double>? result = ImageFilterModel.combineMatrixes(matrixes: inputMatrixes);
  expect(result, expectedOutput);
}

/// AI GENERATED
void testGetStandardMatrix() {
  final List<double> expectedOutput = <double>[    1, 0, 0, 0, 0,    0, 1, 0, 0, 0,    0, 0, 1, 0, 0,    0, 0, 0, 1, 0,  ];
  final List<double> result = ImageFilterModel.standardImageFilterMatrix;
  expect(result, expectedOutput);
}

/// AI GENERATED
void testAddOpacity() {

  const ImageFilterModel inputFilter = ImageFilterModel(
    id: 'phid_filter_normal',
    matrixes: <List<double>>[],
  );
  const double inputOpacity = 0.5;

  const ImageFilterModel expectedOutput = ImageFilterModel(
    id: 'phid_filter_normal',
    matrixes: <List<double>>[
      <double>[
        0.5,  0,    0,    0, 0,
        0,    0.5,  0,    0, 0,
        0,    0,    0.5,  0, 0,
        0,    0,    0,    1, 0,
      ],
    ],
  );

  final ImageFilterModel result = inputFilter.addOpacity(inputOpacity);
  expect(result, expectedOutput);
}

/// AI GENERATED
void testNoFilter() {
  const ImageFilterModel expectedOutput = ImageFilterModel(
    id: 'phid_filter_normal',
    matrixes: <List<double>>[],
  );
  final ImageFilterModel result = ImageFilterModel.noFilter();
  expect(result, expectedOutput);
}

/// AI GENERATED
void testGetFilterByID() {
  ImageFilterModel filter = ImageFilterModel.getFilterByID('phid_filter_sharp');
  expect(filter.id, 'phid_filter_sharp');

  filter = ImageFilterModel.getFilterByID('invalid_id');
  expect(filter.id, 'phid_filter_normal');
}

/// AI GENERATED
void testCheckColorMatrixesAreIdentical() {

  final List<List<double>> matrix1 = <List<double>>[
    ColorFilterLayer.contrast(0.1),
    ColorFilterLayer.saturation(0.15),
  ];
  List<List<double>> matrix2 = <List<double>>[
    ColorFilterLayer.contrast(0.1),
    ColorFilterLayer.saturation(0.15),
  ];

  expect(
    ImageFilterModel.checkColorMatrixesAreIdentical(matrix1: matrix1, matrix2: matrix2),
    true,
  );

  matrix2 = <List<double>>[
    ColorFilterLayer.contrast(0.1),
    ColorFilterLayer.saturation(0.16),
  ];

  expect(
    ImageFilterModel.checkColorMatrixesAreIdentical(matrix1: matrix1, matrix2: matrix2),
    false,
  );

}

/// AI GENERATED
void testCheckFiltersAreIdentical() {
  final ImageFilterModel filter1 = ImageFilterModel(
    id: 'phid_filter_sharp',
    matrixes: <List<double>>[
      ColorFilterLayer.contrast(0.1),
      ColorFilterLayer.saturation(0.15),
    ],
  );
  ImageFilterModel filter2 = ImageFilterModel(
    id: 'phid_filter_sharp',
    matrixes: <List<double>>[
      ColorFilterLayer.contrast(0.1),
      ColorFilterLayer.saturation(0.15),
    ],
  );
  expect(
    ImageFilterModel.checkFiltersAreIdentical(filter1: filter1, filter2: filter2),
    true,
  );

  filter2 = ImageFilterModel(
    id: 'phid_filter_sharp',
    matrixes: <List<double>>[
      ColorFilterLayer.contrast(0.1),
      ColorFilterLayer.saturation(0.16),
    ],
  );
  expect(
    ImageFilterModel.checkFiltersAreIdentical(filter1: filter1, filter2: filter2),
    false,
  );
}


void main (){

  test('testCombineMatrixes', () {
    testCombineMatrixes();
  });

  test('testGetStandardMatrix', () {
    testGetStandardMatrix();
  });

  test('testAddOpacity', () {
    testAddOpacity();
  });

  test('testNoFilter', () {
    testNoFilter();
  });

  test('testGetFilterByID', () {
    testGetFilterByID();
  });

  test('testCheckColorMatrixesAreIdentical', () {
    testCheckColorMatrixesAreIdentical();
  });

  test('testCheckFiltersAreIdentical', () {
    testCheckFiltersAreIdentical();
  });

}
