part of super_cropper;

class PicMediaCropper extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PicMediaCropper({
    required this.controller,
    required this.viewHeight,
    required this.viewWidth,
    required this.media,
    required this.loading,
    required this.aspectRatio,
    super.key
  });
  // --------------------
  final PicMediaCropController controller;
  final double viewWidth;
  final double viewHeight;
  final MediaModel? media;
  final bool loading;
  final double aspectRatio;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Dimensions? _picDims = media?.getDimensions();
    final double? _picViewHeight = _picDims?.getHeightForWidth(width: viewWidth);
    // --------------------
    return SizedBox(
      width: viewWidth,
      height: viewHeight,
      child: Stack(
        children: <Widget>[

          if (_picViewHeight != null)
            SuperImage(
              width: viewWidth,
              height: _picViewHeight,
              pic: media,
              loading: loading,
            ),

          if (_picViewHeight != null)
            CroppingLayer(
              width: viewWidth,
              height: _picViewHeight,
              image: media,
              onStarted: (Rect newRect){
                controller.setPicAndRect(
                  theOriginalPic: media,
                  theCropRect: newRect,
                  theViewWidth: viewWidth,
                  theViewHeight: viewHeight,
                  aspectRatio: aspectRatio,
                );
              },
              onMoved: (Rect newRect){
                controller.setPicAndRect(
                  theOriginalPic: media,
                  theCropRect: newRect,
                  theViewWidth: viewWidth,
                  theViewHeight: viewHeight,
                  aspectRatio: aspectRatio,
                );
              },
            ),

          if (media != null)
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
