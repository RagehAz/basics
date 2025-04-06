part of ldb;

class LDBViewerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LDBViewerScreen({
    required this.ldbDocName,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final String ldbDocName;
  /// --------------------------------------------------------------------------
  static List<Widget> rows({
    required BuildContext context,
    required List<Map<String, dynamic>>? maps,
    required ValueChanged<Map<String, dynamic>>? onRowOptionsTap,
    /// if there is field with name ['color']
    bool userColorField = false,
  }) {

    final double _screenWidth = Scale.screenWidth(context);
    final bool _bubbleIsOn = onRowOptionsTap != null;

    if (Lister.checkCanLoop(maps) == false){
      return <Widget>[];
    }
    else {

      return List<Widget>.generate(maps?.length ?? 0, (int index) {

        final Map<String, dynamic> _map = maps![index];
        final List<String> _keys = _map.keys.toList();
        final List<dynamic> _values = _map.values.toList();
        // final String _primaryValue = _map[_primaryKey];

        return SizedBox(
          width: _screenWidth,
          height: 42,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: <Widget>[

              /// MORE OPTIONS
              SuperBox(
                height: 37,
                width: 37,
                icon: Iconz.more,
                iconSizeFactor: 0.4,
                bubble: _bubbleIsOn,
                onTap: () async {
                  if (onRowOptionsTap != null) {
                    onRowOptionsTap(_map);
                  }
                },
                // margins: EdgeInsets.all(5),
              ),

              /// ROW NUMBER
              SuperBox(
                height: 40,
                width: 40,
                text: '${index + 1}',
                textScaleFactor: 0.6,
                margins: const EdgeInsets.all(5),
                bubble: false,
                color: Colorz.white10,
              ),

              /// ROW VALUES
              ...List<Widget>.generate(_values.length, (int i) {
                final String _key = _keys[i];
                final String _value = _values[i].toString();

                return ValueBox(
                  dataKey: _key,
                  value: _value,
                  color: userColorField == true
                      ? Colorizer.decipherColor(_map['color']) ?? Colorz.bloodTest
                      : Colorz.green125,
                );
              }),
            ],
          ),
        );
      });
    }
  }
  /// --------------------------------------------------------------------------
  @override
  State<LDBViewerScreen> createState() => _LDBViewerScreenState();
  /// --------------------------------------------------------------------------
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('ldbDocName', ldbDocName));
  }
  /// --------------------------------------------------------------------------
}

class _LDBViewerScreenState extends State<LDBViewerScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey _flushbarKey = GlobalKey();
  // -----------------------------------------------------------------------------
  /// --- LOADING
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

      asyncInSync(() async {

        await Future.delayed(const Duration(milliseconds: 800));

        await _readSembast();
      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _maps = [];
  Future<void> _readSembast() async {

    if (mounted == true){
      setState(() {
        _loading = true;
      });
    }

    final List<Map<String, dynamic>> _sembastMaps = await LDBOps.readAllMaps(
      docName: widget.ldbDocName,
    );

    if (mounted == true){
      setState(() {
        _maps = _sembastMaps;
        _loading = false;
      });
    }

  }
  // --------------------
  Future<void> _onRowTap(Map<String, dynamic> map) async {
    // blog('Bldrs local data base : _bldbName : ${widget.ldbDocName} : row id : $id');
    Mapper.blogMap(map);
  }
  // --------------------
  Future<void> _onClearLDB() async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      bubble: CenterDialog.buildBubble(
        context: context,
        boolDialog: true,
        title: 'Confirm ?',
        body: 'All data will be permanently deleted, do you understand ?',
        buttons: CenterDialog.yesNoButtons(
          context: context,
          boolDialog: true,
        ),
      ),
    );

    if (_result == true) {
      await Nav.goBack(context: context);
      await LDBOps.deleteAllMapsAtOnce(docName: widget.ldbDocName);
      await _readSembast();
    }

    else {
      await TopDialog.showTopDialog(
        flushbarKey: _flushbarKey,
        context: context,
        firstText: 'Nothing was deleted',
      );
    }

  }
  // --------------------
  Future<void> _onBldrsTap() async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: 40,
        numberOfWidgets: 1,
        builder: (_, __){

          return <Widget>[

            SuperBox(
              width: BottomDialog.clearWidth(
                context: context,
              ),
              height: 40,
              text: 'Clear ${widget.ldbDocName} data',
              textScaleFactor: 0.7,
              onTap: _onClearLDB,
            ),

          ];

        }

    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

    return BasicLayout(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          /// LOADING
          if (_loading == true)
            SizedBox(
              width: _screenWidth,
              height: _screenHeight,
              // color: Colorz.bloodTest,
              child: Column(
                children: <Widget>[

                  SizedBox(
                    width: _screenWidth,
                    height: 40,
                  ),

                  InfiniteLoadingBox(
                    width: _screenWidth,
                    height: 37,
                    backgroundColor: Colorz.white255.withAlpha(100),
                    milliseconds: 500,
                  ),

                  const Spacing(size: 3),

                  InfiniteLoadingBox(
                    width: _screenWidth,
                    height: 37,
                    backgroundColor: Colorz.white255.withAlpha(75),
                    milliseconds: 500,
                  ),

                  const Spacing(size: 3),

                  InfiniteLoadingBox(
                    width: _screenWidth,
                    height: 37,
                    backgroundColor: Colorz.white255.withAlpha(50),
                    milliseconds: 500,
                  ),

                  const Spacing(size: 3),

                ],
              ),
            ),

          /// LIST
          if (_loading == false && _isInit == false)
          Scroller(
            child: SuperListView(
              width: _screenWidth,
              height: _screenHeight,
              itemCount: _maps.length,
              topPadding: 40,
              itemBuilder: (int index){

                final Map<String, dynamic> _map = _maps[index];
                final List<String> _keys = _map.keys.toList();
                final List<dynamic> _values = _map.values.toList();
                // final String _primaryValue = _map[_primaryKey];

                return SizedBox(
                  width: _screenWidth,
                  height: 42,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[

                      /// MORE OPTIONS
                      SuperBox(
                        height: 37,
                        width: 37,
                        icon: Iconz.more,
                        iconSizeFactor: 0.4,
                        onTap: () => _onRowTap(_map),
                        // margins: EdgeInsets.all(5),
                      ),

                      /// ROW NUMBER
                      SuperBox(
                        height: 40,
                        width: 40,
                        // maxWidth: 40,
                        text: '${index + 1}',
                        textScaleFactor: 0.4,
                        margins: const EdgeInsets.all(5),
                        bubble: false,
                        color: Colorz.white10,
                      ),

                      /// ROW VALUES
                      ...List<Widget>.generate(_values.length, (int i) {
                        final String _key = _keys[i];
                        final String _value = _values[i].toString();
                        return ValueBox(
                          dataKey: _key,
                          value: _value,
                          color: Colorz.green125,
                        );
                      }),

                    ],
                  ),
                );

              },
            ),
          ),

          if (_loading == false && _isInit == false && _maps.isEmpty == true)
          const Center(
            child: SuperText(
              text: 'Doc is Empty',
              font: 'bebas',
            ),
          ),

          /// APP BAR
          Container(
            width: _screenWidth,
            height: 45,
            color: Colorz.black255,
            child: Row(
              children: <Widget>[

                SuperBox(
                  height: 40,
                  width: 40,
                  icon: Iconz.back,
                  iconSizeFactor: 0.6,
                  onTap: () => Nav.goBack(context: context),
                  margins: const EdgeInsets.symmetric(horizontal: 5),
                ),

                SuperBox(
                  height: 40,
                  textScaleFactor: 0.7,
                  color: Colorz.white20,
                  text: 'Wipe doc(${widget.ldbDocName}).length(${_maps.length})',
                  onTap: _onBldrsTap,
                ),

              ],
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
