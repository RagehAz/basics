part of super_cropper;

class CropperPages extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CropperPages({
    required this.pageController,
    required this.originalPics,
    required this.aspectRatio,
    required this.controllers,
    required this.onPageChanged,
    required this.imageSpaceHeight,
    required this.somethingIsWrongText,
    super.key
  });
  // -----------------------------------------------------------------------------
  final PageController pageController;
  final List<MediaModel>? originalPics;
  final double aspectRatio;
  final List<PicMediaCropController> controllers;
  final Function(int index) onPageChanged;
  final double imageSpaceHeight;
  final String? somethingIsWrongText;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);

    return SizedBox(
      width: _screenWidth,
      height: imageSpaceHeight,
      child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          scrollBehavior: const AppScrollBehavior(),
          itemCount: originalPics?.length,
          onPageChanged: onPageChanged,
          itemBuilder: (_, int index){

            if (Lister.checkCanLoop(originalPics) == false){
              return Container(
                width: _screenWidth,
                height: imageSpaceHeight,
                color: Colorz.black255,
                child: SuperText(
                  text: somethingIsWrongText ?? "Something's wrong",
                  maxLines: 3,
                ),
              );
            }

            else {

              final MediaModel _media = originalPics![index];

              return KeepAlivePage(
                child: Container(
                  key: PageStorageKey<String>('image_$index'),
                  width: _screenWidth,
                  height: imageSpaceHeight,
                  alignment: Alignment.center,
                  child: PicMediaCropper(
                    media: _media,
                    controller: controllers[index],
                    loading: false,
                    viewHeight: imageSpaceHeight,
                    viewWidth: _screenWidth,
                    aspectRatio: aspectRatio,
                    // initialSize: 0.95,
                  ),
                ),
              );
            }

          }
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
