library filing;

import 'dart:convert';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/permissions/permits.dart';
import 'package:basics/helpers/rest/rest.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/helpers/time/timers.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

part 'src/file/filers.dart';
part 'src/file/x_filers.dart';
part 'src/file/file_pathing.dart';
part 'src/file/file_sizer.dart';
part 'src/file/xfile_extra.dart';
part 'src/file/file_system_entity_extra.dart';
part 'src/file/file_typer.dart';
part 'src/file/director.dart';

part 'src/floaters/byter.dart';
part 'src/floaters/imager.dart';

part 'src/json/local_json.dart';
