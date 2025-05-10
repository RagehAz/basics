part of super_cropper;

class CropperCorner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CropperCorner({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colorz.black20,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: const SuperImage(
        width: 10,
        height: 10,
        pic: Iconz.plus,
        loading: false,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
