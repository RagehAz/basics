import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/animators/scroller.dart';
import 'package:basics/components/dialogs/bottom_dialog.dart';
import 'package:basics/components/dialogs/center_dialog.dart';
import 'package:basics/components/dialogs/top_dialog.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/colors/colorizer.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/handlers/max_bounce_navigator.dart';
import 'package:basics/layouts/layouts/basic_layout.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'value_box.dart';

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

    setState(() {
      _loading = true;
    });

    final List<Map<String, dynamic>> _sembastMaps = await LDBOps.readAllMaps(
      docName: widget.ldbDocName,
    );

    setState(() {
      _maps = _sembastMaps;
      _loading = false;
    });

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
      ),
    );

    if (_result == true) {
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
              width: BottomDialog.clearWidth(context),
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

    return BasicLayout(
      safeAreaIsOn: true,
      body: MaxBounceNavigator(
        child: Column(
          children: <Widget>[

            Row(
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
                  text: 'Tap to wipe this doc [ ${widget.ldbDocName} ]',
                  onTap: _onBldrsTap,
                ),

              ],
            ),

            if (_loading == true)
            Column(
              children: <Widget>[

                InfiniteLoadingBox(
                  width: _screenWidth,
                  height: 40,
                  color: Colorz.bloodTest.withOpacity(0.5),
                  backgroundColor: Colorz.nothing,
                ),

                InfiniteLoadingBox(
                  width: _screenWidth,
                  height: 40,
                  color: Colorz.bloodTest.withOpacity(0.3),
                  backgroundColor: Colorz.nothing,
                ),

                InfiniteLoadingBox(
                  width: _screenWidth,
                  height: 40,
                  color: Colorz.bloodTest.withOpacity(0.1),
                  backgroundColor: Colorz.nothing,
                ),

              ],
            ),

            if (_loading == false && _isInit == false)
            SizedBox(
              width: _screenWidth,
              height: Scale.screenHeight(context) - 40,
              child: Scroller(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _maps.length,
                  itemBuilder: (_, int index){

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
                            // width: 40,
                            maxWidth: 40,
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
            ),

          ],
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
