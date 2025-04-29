library av;

import 'dart:typed_data';

import 'package:basics/exports/cross_file.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/mediator/models/media_models.dart';

part 'src/b_av_ops/creation/av_from_asset_entity.dart';
part 'src/b_av_ops/creation/av_from_bytes.dart';
part 'src/b_av_ops/creation/av_from_url.dart';
part 'src/b_av_ops/creation/av_from_local_asset.dart';

part 'src/a_models/av_model/av_pathing.dart';

part 'src/a_models/av_model/av_model.dart';

part 'src/a_models/av_model/av_bob_ops.dart';
part 'src/a_models/av_model/av_file_ops.dart';

part 'src/ops/av_maker.dart';
