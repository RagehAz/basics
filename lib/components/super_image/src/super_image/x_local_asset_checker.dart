part of super_image;

class LocalAssetChecker extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LocalAssetChecker({
    required this.child,
    required this.asset,
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget child;
  final dynamic asset;
  /// --------------------------------------------------------------------------
  @override
  State<LocalAssetChecker> createState() => _LocalAssetCheckerState();
  /// --------------------------------------------------------------------------
}

class _LocalAssetCheckerState extends State<LocalAssetChecker> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _exists = ValueNotifier(false);
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

      _triggerLoading(setTo: true).then((_) async {

        final bool _assetExists = await FilePathing.checkLocalAssetExists(widget.asset);

        setNotifier(
            notifier: _exists,
            mounted: mounted,
            value: _assetExists,
        );

        await _triggerLoading(setTo: false);

      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _exists.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.asset == null){
      return const SizedBox();
    }

    else {

      return ValueListenableBuilder(
          key: const ValueKey<String>('LocalAssetChecker'),
          valueListenable: _exists,
          child: widget.child,
          builder: (_, bool assetExists, Widget? child){

            /// WHEN ASSET FOUND
            if (assetExists == true){
              return child ?? const SizedBox();
            }

            /// WHEN ASSET NOT FOUND
            else {
              return const SizedBox();
            }

          }
      );

    }

  }
// -----------------------------------------------------------------------------
}
