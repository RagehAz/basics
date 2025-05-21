library av;

import 'dart:async';
import 'dart:isolate';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:basics/helpers/permissions/permits.dart';
import 'package:basics/helpers/permissions/permits_protocols.dart';
import 'package:basics/helpers/strings/idifier.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/helpers/time/timers.dart';
import 'package:basics/ldbob/bob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as vThumb;
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

import 'src/c_av_picking/a_picker_config/camera_text_delegates.dart';
import 'src/c_av_picking/a_picker_config/picker_text_delegates.dart';
import 'package:video_editor/video_editor.dart';
/// NEED_MIGRATION
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:file_picker/file_picker.dart';

// import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
// import 'package:ffmpeg_kit_flutter/log_redirection_strategy.dart';
// import 'package:ffmpeg_kit_flutter/media_information.dart';
// import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/session_state.dart';
import 'package:ffmpeg_kit_flutter/statistics.dart';

part 'src/b_av_ops/a_create/av_from_asset_entity.dart';
part 'src/b_av_ops/a_create/av_from_bytes.dart';
part 'src/b_av_ops/a_create/av_from_url.dart';
part 'src/b_av_ops/a_create/av_from_local_asset.dart';

part 'src/a_models/av_model/av_pathing.dart';

part 'src/a_models/av_model/av_model.dart';

part 'src/c_av_picking/a_picker_config/asset_picker_configs.dart';
part 'src/a_models/av_model/av_origin.dart';

part 'src/a_models/dim_model/dimension_model.dart';
part 'src/a_models/dim_model/dimensions_getter.dart';

part 'src/c_av_picking/pick_image/pick_image_from_camera.dart';
part 'src/c_av_picking/pick_image/pick_image_from_gallery.dart';
part 'src/c_av_picking/pick_video/pick_video_from_camera.dart';
part 'src/c_av_picking/pick_video/pick_video_from_gallery.dart';
part 'src/d_av_processing/video_processor.dart';

part 'src/d_av_processing/image_processor.dart';

part 'src/b_av_ops/d_update/av_update.dart';
part 'src/b_av_ops/a_create/av_from_x_file.dart';

part 'src/b_av_ops/av_ops.dart';
part 'src/a_models/av_model/av_cipher.dart';
part 'src/b_av_ops/a_create/av_create_constructor.dart';
part 'src/b_av_ops/c_read/av_read.dart';

part 'src/b_av_ops/e_delete/av_delete.dart';
part 'src/b_av_ops/a_create/av_from_file.dart';
part 'src/c_av_picking/av_picking.dart';

part 'src/c_av_picking/pick_sound/pick_audio_from_mic.dart';
part 'src/c_av_picking/pick_pdf/pick_pdf_from_device.dart';
part 'src/e_av_playing/av_pic_reader.dart';
part 'src/b_av_ops/b_clone/av_clone.dart';

part 'src/f_av_exporting/av_export.dart';
part 'src/g_av_builders/av_bob_reader.dart';
// -----------------------------------------------------------------------------
/*
/// GIF THING
// check this
// https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
// https://pub.dev/packages/file_picker
// Container(
//   width: 200,
//   height: 200,
//   margin: EdgeInsets.all(30),
//   color: Colorz.BloodTest,
//   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
// ),
 */
// -----------------------------------------------------------------------------
