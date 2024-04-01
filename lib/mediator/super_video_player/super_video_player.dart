library super_video_player;

import 'dart:io';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:flutter/material.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
export 'package:video_player/video_player.dart';



part 'src/structure/video_box.dart';
part 'src/zebala/a_super_video_player.dart';
// part 'src/c_video_viewer.dart';
// part 'src/e_file_url_video_player.dart';
// part 'src/f_player.dart';

/// COMPONENTS
part 'src/components/video_loading_indicator.dart';
part 'src/components/video_play_icon.dart';
part 'src/components/video_error_icon.dart';
part 'src/components/video_volume_slider.dart';
part 'src/components/video_card.dart';

/// CONTROLLERS
part 'src/controllers/super_video_controller.dart';

/// PLAYERS
part 'src/players/the_video_player.dart';
part 'src/d_youtube_video_player.dart';
