// ignore_for_file: unnecessary_import
library super_image;
// --------------------------------------------------------------------------
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor/image_editor.dart' as image_editor;
import 'package:matrix2d/matrix2d.dart';
import 'src/super_image/c_image_switcher.dart';
// --------------------------------------------------------------------------
part 'src/super_filter/color_filter_generator.dart';
part 'src/super_filter/color_layers.dart';
part 'src/super_filter/preset_filters.dart';
part 'src/super_filter/super_filtered_image.dart';
// --------------------------------------------------------------------------
/// SUPER IMAGE
part 'src/super_image/a_super_image.dart';
/// SUPER IMAGE BOX
part 'src/super_image/b_super_image_box.dart';
/// CACHELESS IMAGE
part 'src/super_image/x_cacheless_image.dart';
/// FUTURE IMAGE
part 'src/super_image/x_future_bytes_image.dart';
/// INFINITY LOADING BOX
part 'src/super_image/x_infinity_loading_box.dart';
/// LOCAL ASSET CHECKER
part 'src/super_image/x_local_asset_checker.dart';
/// ZOOMABLE IMAGE
part 'src/zoomable_image/zoomable_image.dart';
// --------------------------------------------------------------------------
