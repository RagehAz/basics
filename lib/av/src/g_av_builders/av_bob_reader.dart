part of av;

class AvBobReader extends StatefulWidget {
  // --------------------------------------------------------------------------
  const AvBobReader({
    required this.uploadPath,
    required this.docName,
    required this.skipMeta,
    required this.builder,
    this.initialData,
    super.key
  });
  // ------------------------
  final String? uploadPath;
  final String docName;
  final bool skipMeta;
  final AvModel? initialData;
  final Widget Function(bool loading, AvModel? avModel) builder;
  // --------------------------------------------------------------------------
  // --------------------
  @override
  _AvBobReaderState createState() => _AvBobReaderState();
// --------------------------------------------------------------------------
}

class _AvBobReaderState extends State<AvBobReader> {
  // --------------------------------------------------------------------------
  AvModel? _avModel;
  bool _isLoading = true;
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

      asyncInSync(() async {
        await _load();
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(AvBobReader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (
        oldWidget.uploadPath != widget.uploadPath ||
        oldWidget.docName != widget.docName ||
        oldWidget.skipMeta != widget.skipMeta
    ) {
      unawaited(_load());
    }
  }
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // --------------------
  Future<void> _load() async {

    if (mounted == true && _isLoading == false){
      setState(() {
        _isLoading = true;
      });
    }

    final AvModel? _model = await AvOps.readSingle(
      uploadPath: widget.uploadPath,
      docName: widget.docName,
      skipMeta: widget.skipMeta,
    );

    if (mounted == true){
      setState(() {
        _avModel = _model;
        _isLoading = false;
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return widget.builder(_isLoading, _avModel ?? widget.initialData);
    // --------------------
  }
// -----------------------------------------------------------------------------
}
