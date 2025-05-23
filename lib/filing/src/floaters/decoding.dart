part of filing;
/// => TAMAM
abstract class Decoding {
  // -----------------------------------------------------------------------------

  /// DECODER

  // --------------------
  /// TESTED : WORKS PERFECT
  static img.Decoder? getImageDecoderFromBytes({
    required Uint8List? bytes,
  }){
    img.Decoder? _output;

    if (bytes != null){

      tryAndCatch(
          invoker: 'getImageDecoderFromBytes',
          functions: () async {

            _output = img.findDecoderForData(bytes);

          },
      );

    }


    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DECODER

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkImageIsDecodable({
    required Uint8List? bytes,
  }){
    bool _output = true;

    if (bytes != null){

      tryAndCatch(
        invoker: 'getImageDecoderFromBytes',
        functions: () async {

          final img.Decoder? _decoder = img.findDecoderForData(bytes);
          _output = _decoder != null;

        },
        onError: (String? error){
          /// do not blog
        }
      );

    }


    return _output;
  }
  // --------------------
  /*
    static img.Image decodeToImgImage({
      required List<int> bytes,
      required PicFormat picFormat,
    }){

          switch (picFormat){
            case PicFormat.image : return img.decodeImage(bytes); break;
            case PicFormat.jpg : return img.decodeJpg(bytes); break;
            case PicFormat.png : return img.decodePng(bytes); break;
            case PicFormat.tga : return img.decodeTga(bytes); break;
            case PicFormat.webP : return img.decodeWebP(bytes); break;
            case PicFormat.gif : return img.decodeGif(bytes); break;
            case PicFormat.tiff : return img.decodeTiff(bytes); break;
            case PicFormat.psd : return img.decodePsd(bytes); break;
            case PicFormat.exr : return img.decodeExr(bytes); break;
            case PicFormat.bmp : return img.decodeBmp(bytes); break;
            case PicFormat.ico : return img.decodeIco(bytes); break;
            // case PicFormat.animation : return img.decodeAnimation(bytes); break;
            // case PicFormat.pngAnimation : return img.decodePngAnimation(bytes); break;
            // case PicFormat.webPAnimation : return img.decodeWebPAnimation(bytes); break;
            // case PicFormat.gifAnimation : return img.decodeGifAnimation(bytes); break;
            default: return null;
          }

      }
   */
  // -----------------------------------------------------------------------------
}
