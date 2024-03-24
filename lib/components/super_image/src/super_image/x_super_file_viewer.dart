import 'dart:typed_data';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/filing/filing.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/checks/tracers.dart';

class SuperFileViewer extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SuperFileViewer({
    required this.file,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.backgroundColor = Colorz.white50,
    super.key
  });
  // --------------------
  final SuperFile? file;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color backgroundColor;
  // --------------------
  @override
  _SuperFileViewerState createState() => _SuperFileViewerState();
// --------------------------------------------------------------------------
}

class _SuperFileViewerState extends State<SuperFileViewer> {
  // -----------------------------------------------------------------------------
  Uint8List? _bytes;
  // --------------------
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

        await _loadImage();

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(SuperFileViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.file != widget.file) {

      asyncInSync(() async {

        await _loadImage();

      });

    }

  }
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOAD IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadImage() async {

    if (mounted == true){
      setState(() {
        _loading = true;
      });
    }

    final Uint8List? _fileBytes = await widget.file?.readBytes();

    if (mounted == true){
      setState(() {
        _bytes = _fileBytes;
        _loading = false;
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (_loading == true){
      return InfiniteLoadingBox(
        width: widget.width,
        height: widget.height,
        backgroundColor: widget.backgroundColor,
      );
    }
    // --------------------
    else {
      return CachelessImage(
        bytes: _bytes,
        width: widget.width,
        height: widget.height,
        boxFit: widget.fit ?? BoxFit.cover,
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
