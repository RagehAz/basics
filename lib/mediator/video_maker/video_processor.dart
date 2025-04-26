// import 'dart:io';
// import 'package:basics/helpers/strings/text_check.dart';
// // import 'package:flutter_native_video_trimmer/flutter_native_video_trimmer.dart';
// import '../../helpers/checks/error_helpers.dart';
// import '../../helpers/checks/tracers.dart';

// abstract class VideoProcessor {
//   // -----------------------------------------------------------------------------
//
//   /// TRIM
//
//   // --------------------
//   ///
//   static Future<File?> trimVideo({
//     required File? file,
//     required int? startMs,
//     required int? endMs,
//     required bool mute,
//   }) async {
//     File? _output;
//
//     if (file != null && startMs != null && endMs != null){
//
//       await tryAndCatch(
//         invoker: 'trimVideo',
//         functions: () async {
//
//           final VideoTrimmer videoTrimmer = VideoTrimmer();
//
//           await videoTrimmer.loadVideo(file.path);
//
//           final String? trimmedPath = await videoTrimmer.trimVideo(
//             startTimeMs: startMs,     // Start time in milliseconds
//             endTimeMs: endMs,    // End time in milliseconds (5 seconds)
//             includeAudio: !mute, // Optional, default is true
//           );
//
//           if (TextCheck.isEmpty(trimmedPath) == false){
//             _output = File(trimmedPath!);
//           }
//
//           // await videoTrimmer.clearCache();
//
//         },
//         onError: (String? error){
//           blog('trimVideo : error : $error');
//         },
//       );
//
//     }
//
//     return _output;
//   }
//   // -----------------------------------------------------------------------------
// }
