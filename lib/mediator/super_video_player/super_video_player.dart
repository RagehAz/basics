library super_video_player;

import 'dart:io';
import 'dart:typed_data';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:flutter/material.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/components/super_box/super_box.dart';
/// TURNED_OFF_YOUTUBE_PLAYER
// import 'package:basics/components/super_image/super_image.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
export 'package:video_player/video_player.dart';

/// CONTROLLERS
part 'src/controllers/super_video_controller.dart';

/// COMPONENTS
part 'src/components/video_box.dart';
part 'src/components/video_loading_indicator.dart';
part 'src/components/video_play_icon.dart';
part 'src/components/video_error_icon.dart';
part 'src/components/video_volume_slider.dart';
part 'src/components/video_card.dart';

/// PLAYERS
part 'src/players/a_super_video_player.dart';
part 'src/players/b_super_video_dynamic_object_loader.dart';
part 'src/players/c_video_player_switcher.dart';
part 'src/players/d_file_player.dart';
part 'src/players/e_the_you_tube_player.dart';
