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
  // ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> localAssetExists(dynamic asset) async {
    bool _isFound = false;

    if (asset is String){
      if (_stringIsEmpty(asset) == false){

        final ByteData? _bytes = await Byter.byteDataFromPath(asset).catchError(
          (Object? error) {
            // blog('LocalAssetChecker : _checkAsset : error : ${error.toString()}');

            if (error == null) {
              _isFound = true;
            }
            else {
              _isFound = false;
            }

            return null;
          },
        );

        _isFound = _bytes != null;
      }
    }

    return _isFound;
  }
    // --------------------
  /// TESTED : WORKS PERFECT
  static bool _stringIsEmpty(String? string) {

    if (string == null || string == '' || string.isEmpty == true

    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

    ) {
      return true;
    }

    else {
      return false;
    }

  }
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

        final bool _assetExists = await LocalAssetChecker.localAssetExists(widget.asset);

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
