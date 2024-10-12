part of z_grid;

class ZGrid extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ZGrid({
    required this.gridScale,
    required this.controller,
    required this.itemCount,
    required this.mounted,
    required this.blurBackgroundOnZoomedIn,
    required this.onZoomOutStart,
    required this.onZoomOutEnd,
    required this.bigItem,
    required this.bigItemFootprint,
    required this.builder,
    required this.appIsLTR,
    this.bigItemCover,
    super.key
  });
  // --------------------
  final ZGridScale gridScale;
  final ZGridController controller;
  final int itemCount;
  final bool mounted;
  final bool blurBackgroundOnZoomedIn;
  final Function onZoomOutStart;
  final Function onZoomOutEnd;
  final Widget? bigItem;
  final Widget? bigItemCover;
  final Widget? bigItemFootprint;
  final bool appIsLTR;
  final Widget Function(int index) builder;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return LiveWire(
      wire: controller.isZoomed,
      builder: (bool zoomed, Widget? theGrid){

        return GestureDetector(
          onHorizontalDragUpdate: zoomed == false ? null : (details) {
            blog('prevent swipe gestures from affecting the PageView');
          },
          onHorizontalDragEnd: zoomed == false ? null : (details) {
            blog('prevent swipe gestures from affecting the PageView');
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

              /// ZOOMABLE GRID
              if (theGrid != null)
              theGrid,

              /// THE BIG ITEM ON TOP OF GRID AFTER ZOOMING IN
              if (zoomed == true && bigItem != null)
                _BigItemOnZoomIn(
                  key: const ValueKey<String>('TheBigItemWhenZoomedIn'),
                  gridScale: gridScale,
                  controller: controller,
                  itemCount: itemCount,
                  mounted: mounted,
                  blurBackgroundOnZoomedIn: blurBackgroundOnZoomedIn,
                  onZoomOutStart: onZoomOutStart,
                  onZoomOutEnd: onZoomOutEnd,
                  appIsLTR: appIsLTR,
                  zoomed: zoomed,
                  bigItemCover: bigItemCover,
                  bigItem: bigItem,
                  bigItemFootprint: bigItemFootprint,
                ),

            ],
          ),
        );

      },
      child: _TheGrid(
        key: const ValueKey<String>('TheGridOfZGrid'),
        itemCount: itemCount,
        appIsLTR: appIsLTR,
        controller: controller,
        gridScale: gridScale,
        builder: builder,
      ),

    );

  }
  // -----------------------------------------------------------------------------
}

class _TheGrid extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TheGrid({
    required this.gridScale,
    required this.controller,
    required this.itemCount,
    required this.builder,
    required this.appIsLTR,
    super.key
  });
  // --------------------
  final ZGridScale gridScale;
  final ZGridController controller;
  final int itemCount;
  final bool appIsLTR;
  final Widget Function(int index) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return InteractiveViewer(
      key: key,
      transformationController: controller.transformationController,
      panEnabled: false,
      scaleEnabled: false,
      // maxScale: _maxScale,
      // minScale: 1,
      // clipBehavior: Clip.hardEdge,
      // alignPanAxis: false,
      // boundaryMargin: EdgeInsets.zero,
      // onInteractionEnd:(ScaleEndDetails details) {
      //   blog('onInteractionEnd');
      // },
      // onInteractionStart: (ScaleStartDetails details){
      //   blog('onInteractionStart');
      // },
      // onInteractionUpdate:(ScaleUpdateDetails details) {
      //   blog('onInteractionUpdate : details');
      //   blog(details.toString());
      // },
      // scaleFactor: 200.0, // Affects only pointer device scrolling, not pinch to zoom.
      child: SingleWire(
        wire: controller.isZoomed,
        builder: (bool zoomed){

          /// THE GRID
          return IgnorePointer(
            key: const ValueKey<String>('ZGrid_gridView'),
            ignoring: zoomed,
            child: ScrollConfiguration(
              behavior: const AppScrollBehavior(),
              child: GridView.builder(
                  controller: controller.scrollController,
                  gridDelegate: ZGridScale.getGridDelegate(
                    context: context,
                    gridWidth: gridScale.gridWidth,
                    gridHeight: gridScale.gridHeight,
                    columnCount: gridScale.columnCount,
                    itemAspectRatio: gridScale.itemAspectRatio,
                    hasResponsiveSideMargin: gridScale.hasResponsiveSideMargin,
                  ),
                  padding: ZGridScale.getGridPadding(
                    topPaddingOnZoomOut: gridScale.topPaddingOnZoomOut,
                    gridWidth: gridScale.gridWidth,
                    gridHeight: gridScale.gridHeight,
                    columnCount: gridScale.columnCount,
                    itemAspectRatio: gridScale.itemAspectRatio,
                    context: context,
                    isZoomed: zoomed,
                    bottomPaddingOnZoomedOut: gridScale.bottomPaddingOnZoomedOut,
                    hasResponsiveSideMargin: gridScale.hasResponsiveSideMargin,
                    appIsLTR: appIsLTR,
                  ),
                  itemCount: itemCount,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, int index) => builder(index)
              ),
            ),
          );

        },

      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class _BigItemOnZoomIn extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _BigItemOnZoomIn({
    required this.gridScale,
    required this.controller,
    required this.itemCount,
    required this.mounted,
    required this.blurBackgroundOnZoomedIn,
    required this.onZoomOutStart,
    required this.onZoomOutEnd,
    required this.bigItem,
    required this.bigItemFootprint,
    required this.appIsLTR,
    required this.zoomed,
    required this.bigItemCover,
    super.key
  });
  // --------------------
  final ZGridScale gridScale;
  final ZGridController controller;
  final int itemCount;
  final bool mounted;
  final bool blurBackgroundOnZoomedIn;
  final Function onZoomOutStart;
  final Function onZoomOutEnd;
  final Widget? bigItem;
  final Widget? bigItemFootprint;
  final bool appIsLTR;
  final bool zoomed;
  final Widget? bigItemCover;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final EdgeInsets _topPaddingOnZoomedIn = EdgeInsets.only(
      top: ZGridScale.getCenteredTopPaddingOnZoomedIn(
        context: context,
        columnCount: gridScale.columnCount,
        gridWidth: gridScale.gridWidth,
        itemAspectRatio: gridScale.itemAspectRatio,
        gridHeight: gridScale.gridHeight,
      ),
    );
    // --------------------
    return IgnorePointer(
      key: key,
      ignoring: !zoomed,
      child: WidgetFader(
        fadeType: FadeType.fadeIn,
        duration: ZGridController.zoomedItemFadeInDuration,
        curve: ZGridController.zoomedItemFadeInCurve,
        child: Stack (
          alignment: Alignment.topCenter,
          children: <Widget>[

            /// BLUR LAYER : /// TEMP_SHIT
            if (bigItemFootprint != null)
              WidgetWaiter(
                waitDuration: ZGridController.backgroundBlurDelayDuration,
                child: WidgetFader(
                  fadeType: FadeType.fadeIn,
                  duration: ZGridController.zoomedItemFadeInDuration,
                  child: BlurLayer(
                    width: gridScale.gridWidth,
                    height: gridScale.gridHeight,
                    color: Colorz.black125,
                    blurIsOn: blurBackgroundOnZoomedIn,
                    alignment: Alignment.topCenter,
                    blurIsAbove: false,
                    child: Container( // => THIS TREE STARTING HERE IS USED TWICE : COPY THIS TEXT TO FIND WHERE
                      width: gridScale.bigItemWidth,
                      height: gridScale.bigItemHeight,
                      margin: _topPaddingOnZoomedIn,
                      alignment: Alignment.topCenter,
                      child: bigItemFootprint,
                    ),
                  ),
                ),
              ),

            /// BIG FLYER
            FingersSensor(
              builder: (int fingers, Widget? child) {

                final bool _freeze = fingers > 1;

                return IgnorePointer(
                  ignoring: _freeze,
                  child: DismissiblePage(
                    key: const ValueKey<String>('FullScreenFlyer_DismissiblePage'),
                    onDismissed: () => ZGridController.onDismissBigItem(
                      mounted: mounted,
                      zGridController: controller,
                      onZoomOutStart: onZoomOutStart,
                      onZoomOutEnd: onZoomOutEnd,
                    ),
                    direction: _freeze ?
                    DismissiblePageDismissDirection.none
                        :
                    DismissiblePageDismissDirection.vertical,
                    // isFullScreen: true,
                    dragSensitivity: .4,
                    maxTransformValue: 4,
                    minScale: 0.9,
                    reverseDuration: Ratioz.duration150ms,
                    /// BACKGROUND
                    // startingOpacity: 1,
                    backgroundColor: Colors.transparent,
                    // dragStartBehavior: DragStartBehavior.start,
                    child: child!,
                  ),
                );

              },
              child: Material(
                color: Colors.transparent,
                type: MaterialType.transparency,
                child: Container( // => THIS TREE STARTING HERE IS USED TWICE : COPY THIS TEXT TO FIND WHERE
                  width: gridScale.bigItemWidth,
                  height: gridScale.bigItemHeight,
                  margin: _topPaddingOnZoomedIn,
                  alignment: Alignment.topCenter,
                  child: bigItem,
                ),
              ),
              // child:  DismissiblePage(
              //   key: const ValueKey<String>('FullScreenFlyer_DismissiblePage'),
              //   disabled: fingers >= 1,
              //   onDismissed: () => ZGridController.onDismissBigItem(
              //     mounted: mounted,
              //     zGridController: controller,
              //     onZoomOutStart: onZoomOutStart,
              //     onZoomOutEnd: onZoomOutEnd,
              //   ),
              //   direction: DismissiblePageDismissDirection.down,
              //   // isFullScreen: true,
              //   dragSensitivity: .4,
              //   maxTransformValue: 4,
              //   minScale: 0.9,
              //   reverseDuration: Ratioz.duration150ms,
              //   /// BACKGROUND
              //   // startingOpacity: 1,
              //   backgroundColor: Colors.transparent,
              //   // dragStartBehavior: DragStartBehavior.start,
              //   child: Material(
              //     color: Colors.transparent,
              //     type: MaterialType.transparency,
              //     child: Container( // => THIS TREE STARTING HERE IS USED TWICE : COPY THIS TEXT TO FIND WHERE
              //       width: gridScale.bigItemWidth,
              //       height: gridScale.bigItemHeight,
              //       margin: _topPaddingOnZoomedIn,
              //       alignment: Alignment.topCenter,
              //       child: bigItem,
              //     ),
              //   ),
              // ),
            ),

            /// BIG ITEM COVER
            if (bigItemCover != null)
              bigItemCover!,

          ],

        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
