// ignore_for_file: unnecessary_import
library bob;

import 'dart:convert';
import 'dart:io';

import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'src/generated/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

part 'src/ops/bob_ops.dart';
part 'src/foundation/bob_init.dart';
part 'src/models/bob_model.dart';
part 'src/foundation/bob_info.dart';
part 'src/models/media_bob.dart';
part 'src/models/store_model.dart';
