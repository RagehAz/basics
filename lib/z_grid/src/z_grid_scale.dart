// ignore_for_file: unused_element

part of z_grid;
/// TAMAM
class ZGridScale {
  // --------------------------------------------------------------------------
  const ZGridScale({
    required this.gridWidth,
    required this.gridHeight,
    required this.itemAspectRatio,
    required this.columnCount,
    required this.topPaddingOnZoomOut,
    required this.topPaddingOnZoomIn,
    required this.bottomPaddingOnZoomedOut,
    required this.bigItemWidth,
    required this.bigItemHeight,
    required this.smallItemHeight,
    required this.smallItemWidth,
    required this.hasResponsiveSideMargin,
  });
  // --------------------------------------------------------------------------
  final double gridWidth;
  final double gridHeight;
  /// SPACING RATIO BETWEEN ITEMS AND AROUND THE GRID TO SMALL ITEM WIDTH
  final double itemAspectRatio;
  final int columnCount;
  final double? topPaddingOnZoomOut; // can be null
  final double? topPaddingOnZoomIn; // can be null
  final double? bottomPaddingOnZoomedOut;
  final double bigItemWidth;
  final double bigItemHeight;
  final double smallItemWidth;
  final double smallItemHeight;
  final bool hasResponsiveSideMargin;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static ZGridScale initialize({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required double itemAspectRatio,
    required int columnCount,
    required double? topPaddingOnZoomOut,
    required double? bottomPaddingOnZoomedOut,
    required bool hasResponsiveSideMargin,
  }){

    final double _topPaddingOnZoomedIn = getCenteredTopPaddingOnZoomedIn(
      context: context,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
    );

    final double _smallItemWidth = getSmallItemWidth(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _smallItemHeight = getSmallItemHeight(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _bigItemWidth = getBigItemWidth(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
    );

    final double _bigItemHeight = getBigItemHeight(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
    );

    return ZGridScale(
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      columnCount: columnCount,
      topPaddingOnZoomOut: topPaddingOnZoomOut,
      topPaddingOnZoomIn: _topPaddingOnZoomedIn,
      bottomPaddingOnZoomedOut: bottomPaddingOnZoomedOut,
      bigItemWidth: _bigItemWidth,
      bigItemHeight: _bigItemHeight,
      smallItemHeight: _smallItemHeight,
      smallItemWidth: _smallItemWidth,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

  }
    // -----------------------------------------------------------------------------

  /// SMALL ITEM DIMENSIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getSmallItemWidth({
    required BuildContext context,
    required double gridWidth,
    required double? gridHeight,
    required int columnCount,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){

    final double gridSidePadding = getGridSideMargin(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _clearWidth = gridWidth - (gridSidePadding * 2);

    return _clearWidth /
            (
                    columnCount
                    + (columnCount * spacingRatio)
                    - spacingRatio
            );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getSmallItemHeight({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required int columnCount,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){

    final double _smallItemWidth = getSmallItemWidth(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    return _smallItemWidth / itemAspectRatio;
  }
  // -----------------------------------------------------------------------------

  /// BIG ITEM DIMENSIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getBigItemWidthByGridHeight({
    required double gridHeight,
    required double itemAspectRatio,
  }){

    /// TURNING POINT is when the gridWidth is just the width of the big item when the big item
    /// height is perfectly at gridHeight " minus 10px paddings "
    /// at turning point :-
    /// gridHeight - 20 = bigItemHeight
    /// bigItemHeight = _bigItemWidth / itemAspectRatio
    /// gridWidth - 20 = bigItemWidth
    /// _bigItemWidth = bigItemHeight * itemAspectRatio
    /// _bigItemWidth = (gridHeight - 20) * itemAspectRatio

    return (gridHeight - 20) * itemAspectRatio;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getBigItemWidthByGridWidth({
    required double gridWidth,
  }){
      return gridWidth - 20;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _gridWidthIsNarrow({
    required BuildContext context,
    required double gridWidth,
    required double? gridHeight,
    required double itemAspectRatio, // a = w / h
  }) {
    final double _widthAtMaxGridHeight = _getBigItemWidthByGridHeight(
      gridHeight: gridHeight ?? Scale.screenHeight(context),
      itemAspectRatio: itemAspectRatio,
    );
    return gridWidth < _widthAtMaxGridHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getBigItemWidth({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required double itemAspectRatio, // a = w / h
  }){

    final bool _gridIsNarrow = _gridWidthIsNarrow(
      context: context,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      gridWidth: gridWidth,
    );

    if (_gridIsNarrow == true){
      /// ITEM CAN NOT TAKE MAXIMUM POSSIBLE HEIGHT ANYMORE
      /// SO ITEM SHOULD RESPECT gridWidth
      return _getBigItemWidthByGridWidth(
        gridWidth: gridWidth,
      );
    }
    else {
      return _getBigItemWidthByGridHeight(
        gridHeight: gridHeight,
        itemAspectRatio: itemAspectRatio,
      );
    }

    // return getBigFlyerWidth(
    //   context: context,
    //   aspectRatio: itemAspectRatio,
    //   gridWidth: gridWidth,
    //   gridHeight: gridHeight,
    // );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getBigItemHeight({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required double itemAspectRatio,
  }){

    final double _bigItemWidth = getBigItemWidth(
      context: context,
      gridWidth: gridWidth,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,

    );

    return _bigItemWidth / itemAspectRatio;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getBigItemSideMargin({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required double itemAspectRatio,
  }){

    final double _bigItemWidth = getBigItemWidth(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
    );

    return (gridWidth - _bigItemWidth) * 0.5;

  }
  // -----------------------------------------------------------------------------

  /// GRID SPACING

  // --------------------
  static const double spacingRatio = 0.03;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getSpacing({
    required BuildContext context,
    required double gridWidth,
    required int columnCount,
    required double itemAspectRatio,
    required double gridHeight,
    required bool hasResponsiveSideMargin,
  }){

    final double _smallItemWidth = getSmallItemWidth(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    return _smallItemWidth * spacingRatio;
  }
  // -----------------------------------------------------------------------------

  /// GRID PADDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getCenteredTopPaddingOnZoomedIn({
    required BuildContext context,
    required double gridHeight,
    required double gridWidth,
    required int columnCount,
    required double itemAspectRatio,
  }){

    // final double _bigItemHeight = getBigItemHeight(
    //   context: context,
    //   gridWidth: gridWidth,
    //   gridHeight: gridHeight,
    //   itemAspectRatio: itemAspectRatio,
    // );

    // final double _remaining = Scale.screenHeight(context) - _bigItemHeight;

    // blog('the remaining is $_remaining');

    /// TEMP_SHIT
    return 10;
    // return (_remaining / 2) < 0 ? 0 : _remaining / 2;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getTopPaddingOnZoomOut({
    required double? topPaddingOnZoomOut
  }){
    return topPaddingOnZoomOut ?? (Ratioz.appBarSmallHeight + (Ratioz.appBarMargin * 2));
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets getGridPadding({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required int columnCount,
    required double? topPaddingOnZoomOut,
    required bool isZoomed,
    required double itemAspectRatio,
    required double? bottomPaddingOnZoomedOut,
    required bool hasResponsiveSideMargin,
    required bool appIsLTR,
  }){

    final double _topPaddingOnZoomedOut = getTopPaddingOnZoomOut(
      topPaddingOnZoomOut: topPaddingOnZoomOut,
    );

    final double _bottomPaddingOnZoomedIn = _getBottomPaddingOnZoomedIn(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );
    final double _bottomPaddingOnZoomedOut = getBottomPaddingOnZoomedOut(
        bottomPaddingOnZoomedOut: bottomPaddingOnZoomedOut,
    );
    final double _bottom = isZoomed == true ? _bottomPaddingOnZoomedIn : _bottomPaddingOnZoomedOut;

    final double gridSideMargin = getGridSideMargin(
      context: context,
      gridWidth: gridWidth,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridWidth,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    return Scale.superInsets(
      context: context,
      appIsLTR: appIsLTR,
      enLeft: gridSideMargin,
      top: _topPaddingOnZoomedOut,
      enRight: gridSideMargin,
      bottom: _bottom,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getBottomPaddingOnZoomedIn({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required int columnCount,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){

    final double _smallItemHeight = getSmallItemHeight(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _scale = calculateMaxScale(
      context: context,
      columnCount: columnCount,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double gridSidePadding = getGridSideMargin(
      context: context,
      gridWidth: gridWidth,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridWidth,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    return (_smallItemHeight + gridSidePadding) * _scale;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getBottomPaddingOnZoomedOut({
    required double? bottomPaddingOnZoomedOut,
  }){
    return bottomPaddingOnZoomedOut ?? 10;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getGridSideMargin({
    required BuildContext context,
    required double? gridWidth,
    required double? gridHeight,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){

    if (Scale.isLandScape(context) == true && hasResponsiveSideMargin == true){
      return (Scale.screenWidth(context) - BubbleScale.bubbleWidth(context: context)) / 2;
    }

    else {
      return 10;
    }

  }
  // -----------------------------------------------------------------------------

  /// GRID DELEGATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static SliverGridDelegate getGridDelegate({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required int columnCount,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){

    final double _gridSpacingValue = getSpacing(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _smallItemHeight = getSmallItemHeight(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: _gridSpacingValue,
      mainAxisSpacing: _gridSpacingValue,
      childAspectRatio: itemAspectRatio,
      crossAxisCount: columnCount,
      mainAxisExtent: _smallItemHeight,
    );

  }
    // -----------------------------------------------------------------------------

  /// ZOOMING OFFSETS (MATRIX TRANSLATIONS)

  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static double _getZoomableWidth({
    required double gridWidth,
    required int columnCount,
  }){
    final double _spacing = getSpacing(
      gridWidth: gridWidth,
      columnCount: columnCount,
    );
    final double _smallItemWidth = getSmallItemWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
    );
    return _smallItemWidth + (_spacing * 2);
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getRowOffset({
    required BuildContext context,
    required int rowIndex,
    required double gridWidth,
    required double gridHeight,
    required int columnCount,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){

    final double _smallItemHeight = getSmallItemHeight(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _spacing = getSpacing(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    return (_smallItemHeight + _spacing) * rowIndex;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getTopPaddingZoomOffset({
    required BuildContext context,
    required int columnCount,
    required double gridWidth,
    required double? topPaddingOnZoomOut,
    required double gridHeight,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){

    final double _scale = calculateMaxScale(
      context: context,
      columnCount: columnCount,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _topPaddingOnZoomedOut = getTopPaddingOnZoomOut(
      topPaddingOnZoomOut: topPaddingOnZoomOut,
    );

    final double _topPaddingOnZoomedIn = getCenteredTopPaddingOnZoomedIn(
      context: context,
      columnCount: columnCount,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      gridWidth: gridWidth,
    );

    final double _scaledTopPadding = _topPaddingOnZoomedOut * _scale;

    return - _scaledTopPadding + _topPaddingOnZoomedIn;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _getHorizontalZoomOffset({
    required BuildContext context,
    required int columnIndex,
    required int columnCount,
    required double gridWidth,
    required double gridHeight,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){
    final double _scale = calculateMaxScale(
      context: context,
      columnCount: columnCount,
      gridWidth: gridWidth,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _spacing = getSpacing(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _smallItemWidth = getSmallItemWidth(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double _gridSideMargin = getGridSideMargin(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    /// THE ENTIRE SIDE PADDING GETS SCALED UP
    final double _scaledSidePadding = _gridSideMargin * _scale;

    /// ITEM GETS SCALED UP
    final double _scaledItemWidth = _smallItemWidth * _scale;

    /// SPACING GETS SCALED UP
    final double _scaledSpacing = _spacing * _scale;

    /// FIRST NEED TO OFFSET THE SCALED PADDING TO THE LEFT BY ITS DIFFERENCE TO BIG ITEM'S LEFT
    /// MARGIN
    final double _bigItemLeftMargin = getBigItemSideMargin(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
    );
    final double _zoomedSidePaddingFix = _scaledSidePadding - _bigItemLeftMargin;

    /// NEED TO ADD THE WIDTHS OF ITEMS AND SPACES TO THE LEFT OF THE CURRENT COLUMN
    final double _leftFlyerWidths = (_scaledItemWidth + _scaledSpacing) * columnIndex;

    return - (_zoomedSidePaddingFix + _leftFlyerWidths);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateMaxScale({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required int columnCount,
    required double itemAspectRatio,
    required bool hasResponsiveSideMargin,
  }){

    final double _bigItemWidth = getBigItemWidth(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
    );

    /// OLD METHOD THAT WORKS BUT STUPID
    /// final double _zoomableWidth = _getZoomableWidth(
    ///   gridWidth: gridWidth,
    ///   columnCount: columnCount,
    /// );
    /// final double _smallItemSpacings = getSpacing(
    ///   gridWidth: gridWidth,
    ///   columnCount: columnCount,
    /// ) * 2;
    ///
    /// PROOF OF FORMULA
    /// scale = (_bigItemWidth + (_smallItemSpacings * scale) / _zoomableWidth;
    /// scale * _zoomableWidth = _bigItemWidth + (_smallItemSpacings * scale;
    /// scale * _zoomableWidth - (_smallItemSpacings * scale) = _bigItemWidth;
    /// scale * (_zoomableWidth - _smallItemSpacings) = _bigItemWidth;
    /// scale = _bigItemWidth / (_zoomableWidth - _smallItemSpacings);
    /// return _bigItemWidth / (_zoomableWidth - _smallItemSpacings);
    /// WHICH MEANS
    /// scale = _bigItemWidth / _smallItemWidth
    /// YA 7MAR

    final double _smallItemWidth = getSmallItemWidth(
      context: context,
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    return _bigItemWidth / _smallItemWidth;
  }
  // -----------------------------------------------------------------------------

  /// MATRIXES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 _getZoomMatrix({
    required BuildContext context,
    required int rowIndex,
    required int columnIndex,
    required double gridWidth,
    required int columnCount,
    required double gridHeight,
    required double itemAspectRatio,
    required double? topPaddingOnZoomOut,
    required bool hasResponsiveSideMargin,
  }){

    final double _scale = calculateMaxScale(
      context: context,
      columnCount: columnCount,
      gridWidth: gridWidth,
      itemAspectRatio: itemAspectRatio,
      gridHeight: gridHeight,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );
    final double _transX = _getHorizontalZoomOffset(
      context: context,
      columnIndex: columnIndex,
      columnCount: columnCount,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );
    final double _transY = _getTopPaddingZoomOffset(
      context: context,
      columnCount: columnCount,
      gridWidth: gridWidth,
      topPaddingOnZoomOut: topPaddingOnZoomOut,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );
    // const double _transY = 0;

    final Float64List _list = Float64List.fromList(<double>[
      _scale,  0,        0,        0,
      0,        _scale,  0,        0,
      0,        0,        _scale,  0,
      _transX,  _transY,  0,       1,
    ]);

    return Matrix4.fromFloat64List(_list);
  }
  // --------------------------------------------------------------------------
}


double getBigFlyerWidth({
  required BuildContext context,
  required double aspectRatio,
  required double gridWidth,
  required double gridHeight,
}){

  // final double _screenWidth = Scale.screenWidth(context);
  // final double _screenHeight = Scale.screenHeight(context);

  final double _widthByWidth = gridWidth - 20;

  final double _widthByHeight = (gridHeight - 20) / aspectRatio;

  if (_widthByWidth < _widthByHeight){
    return _widthByWidth;
  }
  else {
    return _widthByHeight;
  }

}
