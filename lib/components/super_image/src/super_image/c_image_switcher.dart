// ignore_for_file: unused_import, unused_element
part of super_image;

class ImageSwitcher extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ImageSwitcher({
    required this.width,
    required this.height,
    required this.pic,
    required this.boxFit,
    required this.scale,
    required this.iconColor,
    required this.loading,
    required this.backgroundColor,
    required this.package,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final double? width;
  final double height;
  final BoxFit? boxFit;
  final double? scale;
  final Color? iconColor;
  final bool loading;
  final Color? backgroundColor;
  final String? package;
  // -----------------------------------------------------------------------------
  static const bool _gaplessPlayback = true;
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _errorBuilder (_, Object error, StackTrace? stackTrace) {
    // blog('SUPER IMAGE ERROR : ${pic.runtimeType} : error : $error');
    return Container(
      width: width,
      height: height,
      color: Colorz.white10,
      // child: const SuperVerse(
      //   verse: Verse(
      //     text: 'phid_error',
      //     translate: true,
      //     casing: Casing.lowerCase,
      //   ),
      //   size: 0,
      //   maxLines: 2,
      // ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _getLoadingBuilder(_, Widget? child, ImageChunkEvent? imageChunkEvent){
    return _LoadingBuilder(
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      imageChunkEvent: imageChunkEvent,
      child: child,
    );
  }
  // --------------------
  Widget _emptyBox(){
    return SizedBox(
      width: width,
      height: height,
      // color: Colorz.errorColor,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// LOADING
    if (loading == true){
      return InfiniteLoadingBox(
        width: width!,
        height: height,
        color: iconColor,
        backgroundColor: backgroundColor ?? Colorz.white50,
      );
    }

    /// HAS IMAGE
    else if (pic != null && pic != '' && width != null){

      final BoxFit _boxFit = boxFit ?? BoxFit.cover;

      if (pic is IconData){

        return Container(
          width: width,
          height: height * (scale ?? 1) * 1.3,
          alignment: Alignment.center,
          child: Icon(
            pic,
            key: const ValueKey<String>('SuperImage_iconData'),
            // semanticLabel: 'SuperImage_iconData',
            size: height * (scale ?? 1) * 1.3,
            color: iconColor ?? Colorz.white255,
            // weight: 1,
            // fill: 1,
            // grade: 1,
            // opticalSize: 1,
            // textDirection: TextDirection.ltr,
            // shadows: [],
          ).build(context),
        );
      }

      /// X FILE
      else if (ObjectCheck.objectIsXFile(pic) == true){
        return Image(
          image: XFileImage(pic),
          key: const ValueKey<String>('SuperImage_xfile'),
          fit: _boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
        );
      }

      /// UINT8LIST
      else if (ObjectCheck.objectIsUint8List(pic) == true){

        return Image.memory(
          pic!,
          key: const ValueKey<String>('SuperImage_bytes'),
          fit: _boxFit,
          width: width,
          height: height,
          color: iconColor,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
        );

        // return CachelessImage(
        //   key: const ValueKey<String>('SuperImage_bytes'),
        //   bytes: pic,
        //   width: width,
        //   height: height,
        //   color: backgroundColor,
        //   boxFit: _boxFit,
        //   // blendMode: BlendMode.color,
        // );

      }

      /// URL
      else if (ObjectCheck.isAbsoluteURL(pic) == true){

        return Image.network(
          pic.trim(),
          key: const ValueKey<String>('SuperImage_url'),
          fit: _boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
          loadingBuilder: _getLoadingBuilder,
        );

      }

      /// JPG OR PNG
      else if (ObjectCheck.objectIsJPGorPNG(pic) == true){

        return Image.asset(
          pic,
          key: const ValueKey<String>('SuperImage_png_or_jpg'),
          fit: _boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          scale: 1,
          gaplessPlayback: _gaplessPlayback,
          package: package,
        );

      }

      /// SVG
      else if (ObjectCheck.objectIsSVG(pic) == true){

        return WebsafeSvg.asset(
          pic,
          fit: _boxFit,
          colorFilter: iconColor == null ? null : ColorFilter.mode(iconColor!, BlendMode.srcIn),
          width: width,
          height: height,
          package: package,

        );
      }

      /// MEDIA MODEL
      else if (pic is AvModel){

        final AvModel _avModel = pic;

        /// ADD_VIDEO_PLAYER_IN_BASICS_SUPER_IMAGE_FOR_MEDIA_MODEL
         if (_avModel.isVideo() == true){
          return SuperVideoPlayer(
            width: width!,
            height: height,
            media: _avModel,
            isMuted: true,
            loop: true,
            // autoPlay: true,
          );
        }

        else if (_avModel.xFilePath != null){

           return Image.file(
             File(_avModel.xFilePath!),
             key: const ValueKey<String>('SuperImage_xfile'),
             fit: _boxFit,
             width: width,
             height: height,
             errorBuilder: _errorBuilder,
             gaplessPlayback: _gaplessPlayback,
             color: iconColor,
           );

        }

        else {
          return Container();
        }

      }

      /// FILE
      else if (ObjectCheck.objectIsFile(pic) == true){

        return Image.file(
          pic,
          key: const ValueKey<String>('SuperImage_file'),
          fit: _boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
        );

      }

      /// BASE64 -> CONTRADICTS BUILDING TEXTS
      // else if (ObjectCheck.isBase64(pic) == true){
      //   return CachelessImage(
      //     key: const ValueKey<String>('SuperImage_base64'),
      //     bytes: base64Decode(pic),
      //     width: width,
      //     height: height,
      //     color: backgroundColor,
      //     boxFit: _boxFit,
      //   );
      // }

      /// UI.IMAGE
      else if (ObjectCheck.objectIsUiImage(pic) == true){

        final ui.Image _uiImage = pic;

        return RawImage(
          /// MAIN
          key: const ValueKey<String>('SuperImage_UIIMAGE'),
          // debugImageLabel: ,

          /// IMAGE
          image: _uiImage,
          // repeat: ImageRepeat.noRepeat, // DEFAULT

          /// SIZES
          width: width,
          height: height,
          scale: scale ?? 1,

          /// COLORS
          // color: iconColor,
          // opacity: 0.5,
          // colorBlendMode: BlendMode.srcATop,
          // filterQuality: FilterQuality.low, // DEFAULT
          // invertColors: true, // DEFAULT

          /// POSITIONING
          // alignment: Alignment.center, // DEFAULT
          fit: _boxFit,

          /// DUNNO
          // centerSlice: ,
          // isAntiAlias: ,
          // matchTextDirection: false, // DEFAULT : flips image horizontally
        );
      }

      /// IMG.IMAGE
      else if (ObjectCheck.objectIsImgImage(pic) == true){

        final Uint8List _bytes = img.encodeJpg(pic,
            // quality: 100,
        );

        return CachelessImage(
          key: const ValueKey<String>('SuperImage_imgImage'),
          bytes: _bytes,
          width: width,
          height: height,
          color: backgroundColor,
          boxFit: _boxFit,
        );
      }

      /// STRING - DOUBLE - INT
      else if (pic is String || pic is String? || pic is num || pic is num?){

        final String _text = pic.toString();

        return Center(
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: FittedBox(
              child: SuperText(
                // boxWidth: width,
                // boxHeight: height,
                boxColor: backgroundColor,
                text: _text,
                weight: FontWeight.w100,
                // letterSpacing: 1,
                font: BldrsThemeFonts.fontHead,
                // appIsLTR: true,
                textHeight: height * (scale ?? 1) * 1.4,
                textColor: iconColor ?? Colorz.white255,
              ),
            ),
          ),
        );
      }

      /// NEITHER ANY OF ABOVE
      else {

        // blog('SUPER IMAGE ERROR : ${pic.runtimeType} : $pic');

        return _emptyBox();

      }

    }

    /// EMPTY
    else {
      return _emptyBox();
    }

  }
  // -----------------------------------------------------------------------------
}

class _LoadingBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _LoadingBuilder({
    required this.child,
    required this.imageChunkEvent,
    required this.width,
    required this.height,
    required this.backgroundColor,
    super.key
  });
  // --------------------
  final Widget? child;
  final ImageChunkEvent? imageChunkEvent;
  final double? width;
  final double height;
  final Color? backgroundColor;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// AFTER LOADED
    if (
        imageChunkEvent == null
        ||
        imageChunkEvent?.expectedTotalBytes == null
        ||
        width == null
    ){
      return child ?? const SizedBox();
    }

    /// WHILE LOADING
    else {

      final int _bytes = imageChunkEvent?.expectedTotalBytes ?? 0;

      if (_bytes > 0) {

        final double _percentage = (imageChunkEvent?.cumulativeBytesLoaded ?? 0) / _bytes;

        return Container(
          width: width,
          height: height,
          color: Colorz.white50,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * _percentage,
            color: backgroundColor ?? Colorz.white20,
          ),
        );

      }

      else {
        return child ?? SizedBox(
          width: width,
          height: height,
          // color: Colorz.errorColor,
        );
      }

    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
