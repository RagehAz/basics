// ignore_for_file: unnecessary_import
library bob;

import 'dart:convert';
import 'dart:io';
import 'package:basics/av/av.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:objectbox/objectbox.dart';

import 'src/generated/objectbox.g.dart';

part 'src/foundation/bob_init.dart';
part 'src/models/bob_model.dart';
part 'src/foundation/bob_info.dart';
part 'src/foundation/store_model.dart';
part 'src/models/bz_bob.dart';
part 'src/models/fish_bob.dart';
part 'src/models/flyer_bob.dart';
part 'src/models/user_bob.dart';
part 'src/models/av_bob.dart';
