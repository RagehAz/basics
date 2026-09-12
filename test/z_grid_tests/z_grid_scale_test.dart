import 'package:basics/z_grid/z_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  Future<BuildContext> pumpContext(WidgetTester tester) async {
    late BuildContext capturedContext;
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        capturedContext = context;
        return const SizedBox();
      }),
    ));
    return capturedContext;
  }

  group('ZGridScale.getGridDelegate', () {

    testWidgets('Returns a SliverGridDelegateWithFixedCrossAxisCount with the requested column count', (tester) async {
      final context = await pumpContext(tester);
      final delegate = ZGridScale.getGridDelegate(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        itemAspectRatio: 1,
        hasResponsiveSideMargin: false,
      ) as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisCount, 3);
    });

    testWidgets('Uses the same value for crossAxisSpacing and mainAxisSpacing', (tester) async {
      final context = await pumpContext(tester);
      final delegate = ZGridScale.getGridDelegate(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        itemAspectRatio: 1,
        hasResponsiveSideMargin: false,
      ) as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisSpacing, delegate.mainAxisSpacing);
    });

    testWidgets('mainAxisExtent matches smallItemWidth / itemAspectRatio', (tester) async {
      final context = await pumpContext(tester);
      final smallItemWidth = ZGridScale.getSmallItemWidth(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        itemAspectRatio: 2,
        hasResponsiveSideMargin: false,
      );
      final delegate = ZGridScale.getGridDelegate(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        itemAspectRatio: 2,
        hasResponsiveSideMargin: false,
      ) as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.mainAxisExtent, closeTo(smallItemWidth / 2, 0.0001));
    });

    testWidgets('crossAxisSpacing matches smallItemWidth * spacingRatio', (tester) async {
      final context = await pumpContext(tester);
      final smallItemWidth = ZGridScale.getSmallItemWidth(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        itemAspectRatio: 1,
        hasResponsiveSideMargin: false,
      );
      final delegate = ZGridScale.getGridDelegate(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        itemAspectRatio: 1,
        hasResponsiveSideMargin: false,
      ) as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisSpacing, closeTo(smallItemWidth * ZGridScale.spacingRatio, 0.0001));
    });

    testWidgets('Larger gridWidth yields a larger mainAxisExtent', (tester) async {
      final context = await pumpContext(tester);
      final smallDelegate = ZGridScale.getGridDelegate(
        context: context,
        gridWidth: 200,
        gridHeight: 300,
        columnCount: 3,
        itemAspectRatio: 1,
        hasResponsiveSideMargin: false,
      ) as SliverGridDelegateWithFixedCrossAxisCount;
      final bigDelegate = ZGridScale.getGridDelegate(
        context: context,
        gridWidth: 600,
        gridHeight: 300,
        columnCount: 3,
        itemAspectRatio: 1,
        hasResponsiveSideMargin: false,
      ) as SliverGridDelegateWithFixedCrossAxisCount;

      expect(bigDelegate.mainAxisExtent!, greaterThan(smallDelegate.mainAxisExtent!));
    });

    testWidgets('childAspectRatio matches the requested itemAspectRatio', (tester) async {
      final context = await pumpContext(tester);
      final delegate = ZGridScale.getGridDelegate(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 4,
        itemAspectRatio: 1.5,
        hasResponsiveSideMargin: false,
      ) as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.childAspectRatio, 1.5);
    });

  });

  group('ZGridScale.getGridPadding', () {

    testWidgets('top padding falls back to the default app-bar-derived value when not provided', (tester) async {
      final context = await pumpContext(tester);
      final padding = ZGridScale.getGridPadding(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        topPaddingOnZoomOut: null,
        isZoomed: false,
        itemAspectRatio: 1,
        bottomPaddingOnZoomedOut: null,
        hasResponsiveSideMargin: false,
        appIsLTR: true,
      );

      expect(padding.top, ZGridScale.getTopPaddingOnZoomOut(topPaddingOnZoomOut: null));
    });

    testWidgets('bottom padding uses bottomPaddingOnZoomedOut default (10) when not zoomed', (tester) async {
      final context = await pumpContext(tester);
      final padding = ZGridScale.getGridPadding(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        topPaddingOnZoomOut: null,
        isZoomed: false,
        itemAspectRatio: 1,
        bottomPaddingOnZoomedOut: null,
        hasResponsiveSideMargin: false,
        appIsLTR: true,
      );

      expect(padding.bottom, 10);
    });

    testWidgets('bottom padding differs from the zoomed-out value when isZoomed is true', (tester) async {
      final context = await pumpContext(tester);
      final zoomedOutPadding = ZGridScale.getGridPadding(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        topPaddingOnZoomOut: null,
        isZoomed: false,
        itemAspectRatio: 1,
        bottomPaddingOnZoomedOut: null,
        hasResponsiveSideMargin: false,
        appIsLTR: true,
      );
      final zoomedInPadding = ZGridScale.getGridPadding(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        topPaddingOnZoomOut: null,
        isZoomed: true,
        itemAspectRatio: 1,
        bottomPaddingOnZoomedOut: null,
        hasResponsiveSideMargin: false,
        appIsLTR: true,
      );

      expect(zoomedInPadding.bottom, isNot(zoomedOutPadding.bottom));
    });

    testWidgets('left and right padding are equal when hasResponsiveSideMargin is false', (tester) async {
      final context = await pumpContext(tester);
      final padding = ZGridScale.getGridPadding(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        topPaddingOnZoomOut: null,
        isZoomed: false,
        itemAspectRatio: 1,
        bottomPaddingOnZoomedOut: null,
        hasResponsiveSideMargin: false,
        appIsLTR: true,
      );

      expect(padding.left, padding.right);
      expect(padding.left, 10);
    });

    testWidgets('appIsLTR does not change left/right when they are equal', (tester) async {
      final context = await pumpContext(tester);
      final ltr = ZGridScale.getGridPadding(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        topPaddingOnZoomOut: null,
        isZoomed: false,
        itemAspectRatio: 1,
        bottomPaddingOnZoomedOut: null,
        hasResponsiveSideMargin: false,
        appIsLTR: true,
      );
      final rtl = ZGridScale.getGridPadding(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        topPaddingOnZoomOut: null,
        isZoomed: false,
        itemAspectRatio: 1,
        bottomPaddingOnZoomedOut: null,
        hasResponsiveSideMargin: false,
        appIsLTR: false,
      );

      expect(ltr, rtl);
    });

    testWidgets('a custom bottomPaddingOnZoomedOut value is respected when not zoomed', (tester) async {
      final context = await pumpContext(tester);
      final padding = ZGridScale.getGridPadding(
        context: context,
        gridWidth: 300,
        gridHeight: 300,
        columnCount: 3,
        topPaddingOnZoomOut: null,
        isZoomed: false,
        itemAspectRatio: 1,
        bottomPaddingOnZoomedOut: 25,
        hasResponsiveSideMargin: false,
        appIsLTR: true,
      );

      expect(padding.bottom, 25);
    });

  });

}
