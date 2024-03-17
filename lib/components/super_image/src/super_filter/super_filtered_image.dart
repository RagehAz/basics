// ignore_for_file: unused_element
part of super_image;

class SuperFilteredImage extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SuperFilteredImage({
    required this.width,
    required this.height,
    required this.pic,
    required this.loading,
    this.filterModel,
    // this.opacity,
    this.boxFit = BoxFit.cover,
    this.scale = 1,
    this.canUseFilter = true,
    this.corners,
      super.key
  });  // -----------------------------------------------------------------------------
  final ImageFilterModel? filterModel;
  final double width;
  final double height;
  final dynamic pic;
  // final ValueNotifier<double> opacity;
  final BoxFit boxFit;
  final double scale;
  final bool canUseFilter;
  final dynamic corners;
  final bool loading;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (canUseFilter == true && filterModel != null && pic != null) {
      return _FilteredImage(
        // opacity: opacity,
        height: height,
        pic: pic,
        width: width,
        scale: scale,
        boxFit: boxFit,
        filterModel: filterModel,
        corners: corners,
      );
    }
    // --------------------
    else {

      return SuperImage(
        width: width,
        height: height,
        pic: pic,
        fit: boxFit,
        scale: scale,
        corners: corners,
        loading: loading,
      );

    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _FilteredImage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _FilteredImage({
    required this.filterModel,
    required this.width,
    required this.height,
    required this.boxFit ,
    required this.scale,
    required this.pic,
    this.corners,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final ImageFilterModel? filterModel;
  final double width;
  final double height;
  final BoxFit boxFit;
  final double scale;
  final dynamic pic;
  final dynamic corners;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<ui.Image?> processImage({
    required dynamic input,
    required ImageFilterModel? filterModel,
  }) async {

    ui.Image? _output;

    // blog('processImage : input : ${input.runtimeType} : input is Uint8List ${input is Uint8List}');

    if (
        input != null &&
        filterModel != null &&
        Lister.checkCanLoop(filterModel.matrixes) == true
    ){

      Uint8List? _bytes = input is Uint8List ? input
          :
      await Byter.fromUiImage(_output);

      if (_bytes != null){

        final image_editor.ImageEditorOption option = image_editor.ImageEditorOption();

        // blog('processImage : filterModel : ${filterModel.id} : matrixes : ${filterModel.matrixes}');

        final List<double>? _combinedMatrix = ImageFilterModel.combineMatrixes(
          matrixes: filterModel.matrixes,
        );

        if (_combinedMatrix != null){

          option.addOption(
            image_editor.ColorOption(matrix: _combinedMatrix),
          );

          _bytes = await image_editor.ImageEditor.editImage(
            image: _bytes,
            imageEditorOption: option,
          );

          if (_bytes != null) {
            _output = await Imager.getUiImageFromUint8List(_bytes);
          }

        }
      }


      // blog('processImage : uint8list is : ${input?.length} bytes');

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Widget _createTree({
    required Widget child,
    required List<List<double>>? matrixes,
  }){
    Widget tree = child;

    if (Lister.checkCanLoop(matrixes) == true){
      for (int i = 0; i < matrixes!.length; i++) {
        tree = ColorFiltered(
          colorFilter: ColorFilter.matrix(matrixes[i]),
          child: tree,
        );
      }
    }

    return tree;
  }
  // -----------------------------------------------------------------------------
  @override
  State<_FilteredImage> createState() => _FilteredImageState();
  // -----------------------------------------------------------------------------
}

class _FilteredImageState extends State<_FilteredImage> {
  // -----------------------------------------------------------------------------
  ui.Image? _uiImage;
  bool _loading = true;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      if (widget.filterModel != null){

        asyncInSync(() async {

          final ui.Image? uiImage = await _FilteredImage.processImage(
            input: widget.pic,
            filterModel: widget.filterModel,
          );

          if (mounted){
            setState(() {
              _uiImage = uiImage;
              _loading = false;
            });
          }

        });

      }

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant _FilteredImage oldWidget) {

     bool _bytesAreIdentical;

    if (widget.pic is Uint8List && oldWidget.pic is Uint8List){
      _bytesAreIdentical = Lister.checkListsAreIdentical(
        list1: widget.pic,
        list2: oldWidget.pic,
      );
    }

    else if (widget.pic is ui.Image && oldWidget.pic is ui.Image){
      _bytesAreIdentical = Imager.checkUiImagesAreIdentical(widget.pic, oldWidget.pic);
    }

    else {
      _bytesAreIdentical = false;
    }

    if (
    widget.width != oldWidget.width ||
    widget.height != oldWidget.height ||
    _bytesAreIdentical == false ||
    // widget.opacity != oldWidget.opacity ||
    widget.scale != oldWidget.scale ||
    widget.boxFit != oldWidget.boxFit ||
    ImageFilterModel.checkFiltersAreIdentical(filter1: widget.filterModel, filter2: oldWidget.filterModel) == false
    ) {

      setState(() {
        _loading = true;
      });

      unawaited(getUiImageFromDynamic(widget.pic).then((ui.Image? uiImage){
        if (mounted == true){
          setState(() {
            _uiImage = uiImage;
            _loading = false;
          });
        }
      }));

    }

    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  @override
  void dispose(){
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<ui.Image?> getUiImageFromDynamic(dynamic pic) async {

    assert(pic is Uint8List || pic is ui.Image || pic == null, 'Pic is neither Bytes nor UiImage nor null');

    if (pic is Uint8List){

      return Imager.getUiImageFromUint8List(pic);
    }

    else {
      return pic;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (_uiImage == null){
      return SuperImage(
        width: widget.width,
        height: widget.height,
        pic: widget.pic,
        fit: widget.boxFit,
        scale: widget.scale,
        corners: widget.corners,
        loading: _loading,
      );
    }

    else {
      return _FilteredImage._createTree(
        matrixes: widget.filterModel?.matrixes,
        child: SuperImage(
          width: widget.width,
          height: widget.height,
          pic: _uiImage,
          fit: widget.boxFit,
          scale: widget.scale,
          corners: widget.corners,
          loading: _loading,
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------
}
