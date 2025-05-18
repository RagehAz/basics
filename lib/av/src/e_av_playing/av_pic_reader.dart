part of av;

class AvPicReader extends StatefulWidget {
  // --------------------------------------------------------------------------
  const AvPicReader({
    required this.avModel,
    required this.builder,
    super.key
  });
  // --------------------
  final AvModel? avModel;
  final Widget Function(bool loading, Uint8List? bytes) builder;
  // --------------------
  @override
  _AvPicReaderState createState() => _AvPicReaderState();
  // --------------------------------------------------------------------------
}

class _AvPicReaderState extends State<AvPicReader> {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit == true && mounted == true) {
      _isInit = false; // good

      asyncInSync(() async {

        await load();

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(AvPicReader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.avModel != widget.avModel) {
      unawaited(load());
    }
  }
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOAD

  // --------------------
  Uint8List? _bytes;
  bool _loading = true;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> load() async {

    if (widget.avModel?.xFilePath != null){

      if (mounted == true && _loading == false){
        setState(() {
          _loading = true;
        });
      }

      _bytes = await Byter.fromFile(File(widget.avModel!.xFilePath!));

      if (mounted == true){
        setState(() {
          _loading = false;
        });
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return widget.builder(_loading, _bytes);
    // --------------------
  }
// -----------------------------------------------------------------------------
}
