library pixel_color_picker;

import 'dart:async';
import 'dart:typed_data';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/pixels/pixelizer.dart';
import 'package:basics/components/drawing/spacing.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/helpers/wire/wire.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

part 'src/controller/pixel_color_controller.dart';
part 'src/components/color_indicator.dart';
part 'src/structure/a_pixel_picker.dart';
