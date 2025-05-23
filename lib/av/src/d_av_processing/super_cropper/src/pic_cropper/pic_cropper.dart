part of super_cropper;

class PicCropper extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PicCropper({
    required this.controller,
    required this.canvasHeight,
    required this.canvasWidth,
    required this.avModel,
    required this.loading,
    required this.aspectRatio,
    required this.initialRect,
    required this.initialSize,
    super.key
  });
  // --------------------
  final AvCropController controller;
  final double canvasWidth;
  final double canvasHeight;
  final AvModel? avModel;
  final bool loading;
  final double? aspectRatio;
  final double? initialSize;
  final Rect? initialRect;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Dimensions? _picDims = avModel?.getDimensions();
    final Dimensions? _picViewDims = AvCropController.getImageDimsFitToCanvas(
        canvasDims: Dimensions(
          width: canvasWidth,
          height: canvasHeight,
        ),
        imageDims: _picDims,
    );
    final double? _picViewWidth = _picViewDims?.width;
    final double? _picViewHeight = _picViewDims?.height;
    final bool _canBuild = _picViewWidth != null && _picViewHeight != null;
    // --------------------
    return SizedBox(
      width: canvasWidth,
      height: canvasHeight,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          if (_canBuild == true)
            SuperImage(
              width: _picViewWidth,
              height: _picViewHeight!,
              pic: avModel,
              loading: loading,
            ),

          if (_canBuild == true)
            CroppingLayer(
              width: _picViewWidth!,
              height: _picViewHeight!,
              image: avModel,
              aspectRatio: aspectRatio,
              initialSize: initialSize,
              initialRect: initialRect,
              onStarted: (Rect newRect){
                controller.setPicAndRect(
                  theOriginalPic: avModel,
                  theCropRect: newRect,
                  theViewWidth: _picViewWidth,
                  theViewHeight: _picViewHeight,
                  aspectRatio: aspectRatio,
                );
              },
              onMoved: (Rect newRect){
                controller.setPicAndRect(
                  theOriginalPic: avModel,
                  theCropRect: newRect,
                  theViewWidth: _picViewWidth,
                  theViewHeight: _picViewHeight,
                  aspectRatio: aspectRatio,
                );
              },
            ),

          if (avModel != null)
            IgnorePointer(
              child: CroppedImageBuilder(
                controller: controller,
              ),
            ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
