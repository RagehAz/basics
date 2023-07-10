import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/dialogs/bottom_dialog.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/colors/colorizer.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/handlers/max_bounce_navigator.dart';
import 'package:basics/layouts/layouts/basic_layout.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/ldb/ldb_viewer/ldb_viewer_screen.dart';
import 'package:basics/ldb/ldb_viewer/small_button.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:basics/super_text/super_text.dart';
import 'package:flutter/material.dart';

class SembastTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SembastTestScreen({
        super.key
  }); 
  /// --------------------------------------------------------------------------
  @override
  _SembastTestScreenState createState() => _SembastTestScreenState();
/// --------------------------------------------------------------------------
}

class _SembastTestScreenState extends State<SembastTestScreen> {
  // -----------------------------------------------------------------------------
  final String _docName = 'test';
  final String _primaryKey = 'id';
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

        await _deleteAll();
        await _readAllMaps();

        await _triggerLoading(setTo: false);
      });
    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CRUD

  // --------------------
  List<Map<String, dynamic>>? _maps;
  // --------------------
  Future<void> _createRandomMap() async {

    blog('SembastTestScreen._createRandomMap');

    final Map<String, dynamic> _map = {
      'id' : 'x${Numeric.createRandomIndex(listLength: 10)}',
      'color' : Colorizer.cipherColor(Colorizer.createRandomColor()),
    };

    await LDBOps.insertMap(
      input: _map,
      docName: _docName,
      primaryKey: _primaryKey,
    );

    await _readAllMaps();
  }
  // --------------------
  Future<void> _createMultipleMaps() async {

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
    for (int i = 0; i < 6; i++){
      final Map<String, dynamic> _map = {
        'id' :'x$i',
        'color' : Colorizer.cipherColor(Colorz.red255),
      };
      _maps.add(_map);
    }

    await LDBOps.insertMaps(
      inputs: _maps,
      docName: _docName,
      primaryKey: _primaryKey,
    );

    await _readAllMaps();
  }
  // --------------------
  Future<void> _readAllMaps() async {

    final List<Map<String, dynamic>> _readMaps = await LDBOps.readAllMaps(
      docName: _docName,
    );

    Mapper.blogMaps(_readMaps);

    setState(() {
      _maps = _readMaps;
    });

    setNotifier(notifier: _loading, mounted: mounted, value: false);

  }
  // --------------------
  Future<void> _updateMap(Map<String, dynamic> map) async {

    final String _newID = Numeric.createUniqueID().toString();
    // final String _newID = await Dialogs.keyboardDialog(
    //   context: context,
    //   keyboardModel: KeyboardModel.standardModel().copyWith(
    //     hintVerse: Verse.plain('Wtf is this'),
    //     titleVerse: Verse.plain('Add new ID instead of Old ( ${map['id']} )'),
    //   ),
    // );

    final Color _newColor = Colorizer.createRandomColor();

    final Map<String, dynamic> _newMap = {
      'id' : _newID,
      'color': Colorizer.cipherColor(_newColor),
    };

    await LDBOps.insertMap(
      docName: _docName,
      input: _newMap,
      primaryKey: _primaryKey,
    );

    await _readAllMaps();

    await Nav.goBack(
      context: context,
      invoker: 'SembastTestScreen._updateMap',
    );
  }
  // --------------------
  Future<void> _deleteAll() async {

    await LDBOps.deleteAllMapsAtOnce(
        docName: _docName,
    );

    await _readAllMaps();
  }
  // --------------------
  Future<void> _deleteMap(Map<String, dynamic> map) async {

    await LDBOps.deleteMap(
        objectID: map['id'],
        docName: _docName,
        primaryKey: _primaryKey,
    );

    await _readAllMaps();

  }
  // --------------------
  Future<void> _onRowOptionsTap(Map<String, dynamic> map) async {

    Mapper.blogMap(map);

    final List<Widget> _buttons = <Widget>[

      BottomDialog.wideButton(
        context: context,
        text: 'Delete',
        onTap: () => _deleteMap(map),
      ),

      BottomDialog.wideButton(
        context: context,
        text: 'Update',
        onTap: () => _updateMap(map),
      ),

    ];

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: _buttons.length,
        builder: (_){
          return _buttons;
        }
        );

  }
  // --------------------
  Future<void> _search() async {

    final List<Map<String, dynamic>> _result = await LDBOps.searchMultipleValues(
        docName: _docName,
        fieldToSortBy: 'id',
        searchField: 'id',
        searchObjects: ['x1'],
    );

    Mapper.blogMaps(_result);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      // backgroundColor: Colorz.red255,
      body: MaxBounceNavigator(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[

            /// APP BAR
            Row(
              children: <Widget>[

                SuperBox(
                  height: 30,
                  icon: Iconz.arrowLeft,
                  iconSizeFactor: 0.5,
                  onTap: () => Nav.goBack(context: context),
                  margins: 5,
                ),

                const SuperText(
                  text: 'Sembast test screen',
                  centered: false,
                  // textDirection: TextDirection.ltr,
                  textHeight: 25,
                  margins: 10,
                  font: BldrsThemeFonts.fontBldrsHeadlineFont,
                  italic: true,
                ),

              ],
            ),

            /// LDB Buttons
            Container(
              width: Scale.screenWidth(context),
              height: 50,
              color: Colorz.bloodTest,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[

                  /// CREATE SINGLE
                  SmallButton(verse: 'Create single', onTap: _createRandomMap),

                  /// CREATE RANDOM
                  SmallButton(verse: 'Create Multi', onTap: _createMultipleMaps),

                  /// READ
                  SmallButton(
                    verse: 'read all',
                    onTap: _readAllMaps,
                  ),

                  // /// UPDATE
                  // SmallFuckingButton(
                  //   verse:  'Update',
                  //   onTap: _updateMap,
                  // ),

                  /// DELETE ALL
                  SmallButton(
                    verse: 'Delete All',
                    onTap: _deleteAll,
                  ),

                  /// SEARCH
                  SmallButton(
                    verse: 'SEARCH',
                    onTap: _search,
                  ),
                ],
              ),
            ),

            /// LDB MAPS
            if (Mapper.checkCanLoopList(_maps) == true)
              ...LDBViewerScreen.rows(
                context: context,
                userColorField: true,
                maps: _maps!,
                onRowOptionsTap: _onRowOptionsTap,
              ),

          ],
        ),
      ),
    );
  }
  // -----------------------------------------------------------------------------
}
