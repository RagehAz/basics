part of super_cropper;

class CroppedImageBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CroppedImageBuilder({
    required this.controller,
    super.key
  });
  // --------------------
  final PicMediaCropController controller;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MultiWires(
        wires: [
          controller.theCroppedPic,
          controller.isCropping,
          controller.croppedRect,
          controller.currentRect,
          controller.viewWidth,
          controller.viewHeight
        ],
        builder: (context) {

          final MediaModel? _theCroppedPic = controller.theCroppedPic.value;
          final bool isCropping = controller.isCropping.value;
          final Rect? cropRect = controller.croppedRect.value;
          final Rect? currentRect = controller.currentRect.value;

          return SizedBox(
            width: controller.viewWidth.value,
            height: controller.viewHeight.value,
            child: Stack(
              children: <Widget>[

                /// LOADING LAYER
                if (isCropping == true && currentRect != null)
                  Positioned(
                    left: currentRect.left,
                    top: currentRect.top,
                    child: InfiniteLoadingBox(
                      milliseconds: 250,
                      width: currentRect.width,
                      height: currentRect.height,
                      backgroundColor: Colorz.white10,
                    ),
                  ),

                /// GOT CROPPED PIC
                if (cropRect != null)
                  Positioned(
                    left: cropRect.left,
                    top: cropRect.top,
                    child: Builder(
                      builder: (context) {

                        final Dimensions _scaled = controller.scaleCroppedDimensionsToFit(
                          croppedImageDimensions: _theCroppedPic?.getDimensions(),
                        );

                        return SuperImage(
                          width: _scaled.width,
                          height: _scaled.height ?? 0,
                          pic: isCropping ? null : _theCroppedPic,
                          loading: false,
                        );
                      }
                    ),
                  ),

              ],
            ),
          );

        }
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
