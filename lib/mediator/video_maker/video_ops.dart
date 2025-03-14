// ignore_for_file: unused_element
import 'dart:io';
// import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
// import 'package:basics/helpers/maps/lister.dart';
// import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
// import 'package:basics/helpers/strings/idifier.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';
/// NEED_MIGRATION
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
// import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
// import 'package:ffmpeg_kit_flutter/log_redirection_strategy.dart';
// import 'package:ffmpeg_kit_flutter/media_information.dart';
// import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/session_state.dart';
import 'package:ffmpeg_kit_flutter/statistics.dart';
/// => TAMAM
abstract class VideoOps {
  // --------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<VideoEditorController?> initializeVideoEditorController({
    required File? file,
    double aspectRatio = 9 / 16,
    int maxDurationMs = 5000,
    Function(String error)? onError,
  }) async {
    VideoEditorController? _controller;

    if (file != null){

      _controller = VideoEditorController.file(
        file,
        minDuration: const Duration(milliseconds: 1),
        maxDuration: Duration(seconds: maxDurationMs),
        coverStyle: VideoOps.getCoverStyle,
        coverThumbnailsQuality: 100,
        cropStyle: VideoOps.getCropStyle,
        trimStyle: VideoOps.getTrimStyle,
        trimThumbnailsQuality: 100,
      );

      await _controller.initialize(aspectRatio: aspectRatio).catchError(
            (error) {
              onError?.call(error);
              // handle minimum duration bigger than video duration error
            },
        test: (e) => e is VideoMinDurationError,
      );

    }

    return _controller;
  }
  // --------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  /// NEED_MIGRATION
  static Future<void> disposeFFmpegKit() async {
    final List<FFmpegSession> executions = await FFmpegKit.listSessions();
    if (executions.isNotEmpty) {
      await FFmpegKit.cancel();
    }
  }
  // --------------------------------------------------------------------------

  /// EXECUTION

  // --------------------
  /// NEED_MIGRATION
  static Future<File?> executeFFmpeg({
    required FFmpegVideoEditorExecute execute,
    void Function(String error)? onError,
    void Function(Statistics statistics)? onProgress,
  }) async {
    File? _output;
    bool _done = false;

    final Future<void> _theExecution = FFmpegKit.executeAsync(
      execute.command,
      (session) => _executionCompletionCallBack(
        execute: execute,
        onCompleted: (File file){
          _output = file;
          _done = true;
        },
        onError: (String error, StackTrace trace){
          onError?.call(error);
          _done = true;
        },
        session: session,
      ),
      null, // logCallBack
      onProgress,
    );

    while(_done == false){
      await _theExecution;
      if (_done == true){
        break;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }

    return _output;
  }
  // --------------------
  /// NEED_MIGRATION
  static Future<void> _executionCompletionCallBack({
    required FFmpegVideoEditorExecute execute,
    required dynamic session,
    required Function(File file) onCompleted,
    required void Function(String error, StackTrace trace)? onError,
  }) async {

    final SessionState _theState = await session.getState();
    final String _state = FFmpegKitConfig.sessionStateToString(_theState);
    final ReturnCode? _code = await session.getReturnCode();

    if (ReturnCode.isSuccess(_code) == true) {
      onCompleted(File(execute.outputPath));
    }

    else if (onError != null) {
      final String? x = await session.getOutput();
      final String _error = 'FFmpeg process exited with _state $_state and return _code $_code.\n$x';
      onError(_error, StackTrace.current);
    }

  }
  // --------------------------------------------------------------------------

  /// EXPORTING

  // --------------------
  /// NEED_MIGRATION
  static Future<File?> exportVideo({
    required VideoEditorController? videoEditorController,
    void Function(dynamic progress, VideoFFmpegVideoEditorConfig config)? onProgress,
    VideoExportFormat format = VideoExportFormat.mp4,
    String? fileName,
    String? outputDirectory,
    double scale = 1,
    bool mute = false,
    Function(String error)? onError,
  }) async {
    File? _output;

    if (videoEditorController != null){

      int? _bitRate = await VideoOps.readFileBitrate(file: videoEditorController.file);
      _bitRate ??= 1000000;
      blog('_bitRateWas($_bitRate) : scale($scale)');
      double _mbps = _bitRate.clamp(500000, 5000000).toDouble();
      _mbps = _mbps / 1000000;
      _mbps = Numeric.roundFractions(_mbps, 5)!;
      final String _bigRateString = Numeric.stringifyDouble(_mbps);

      final VideoFFmpegVideoEditorConfig config = VideoFFmpegVideoEditorConfig(
        videoEditorController,
        format: format, // DEFAULT
        name: fileName,
        outputDirectory: outputDirectory,
        scale: scale,
        // isFiltersEnabled: true, // DEFAULT
        commandBuilder: (FFmpegVideoEditorConfig config, String videoPath, String outputPath) {

          /// TRIM
          final String _trim = _createTrimParameters(
            controller: config.controller,
          );

          /// CROP
          final String _filters = _createFiltersParameters(
            controller: config.controller,
          );

          /// MUTE
          final String _mute = mute ? '-an' : '';

          /// VIDEO_SIZE_DIM_QUALITY_CALIBRATION
          // 1.2 ~ 2M = 2.5
          // 1.2 ~ xM = 1.2
          final String _bitRate = '$bitRateBasedCompression ${_bigRateString}M';
          // const String _quality = constantRateFactor;
          // const String _preset = presetSlow;
          blog('_bitRateIs($_bitRate)');

          return '$_trim -i $videoPath $_mute $_bitRate $_filters $outputPath';
          // return '$_trim -i $videoPath $_mute $_bitRate $_quality $_preset $_filters $outputPath';

        },
      );

      final FFmpegVideoEditorExecute execute = await config.getExecuteConfig();

      _output = await executeFFmpeg(
        execute: execute,
        onProgress: (Statistics progress) => onProgress?.call(progress, config),
        onError: onError,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const String tuneFilm = '-tune film';
  static const String tuneAnimation = '-tune animation';
  static const String presetVerySlow = '-preset veryslow';
  static const String presetSlow = '-preset slow';
  static const String presetMedium = '-preset medium';
  static const String constantRateFactor = '-crf 0'; /// range : lossless 0 -> 23 default -> 51 max
  static const String bitRateBasedCompression = '-b:v';
  static const String bitRate720p = '2.5M';
  static const String bitRate1080p = '5M';
  static const String bitRate4K = '15M';
  // --------------------
  /// NEED_MIGRATION
  static Future<File?> exportMirroredVideo({
    required VideoEditorController? videoEditorController,
    void Function(dynamic progress, VideoFFmpegVideoEditorConfig config)? onProgress,
    VideoExportFormat format = VideoExportFormat.mp4,
    String? fileName,
    String? outputDirectory,
    double scale = 1,
    Function(String error)? onError,
  }) async {
    File? _output;

    if (videoEditorController != null){

      final VideoFFmpegVideoEditorConfig config = VideoFFmpegVideoEditorConfig(
        videoEditorController,
        format: format, // DEFAULT
        name: fileName,
        outputDirectory: outputDirectory,
        scale: scale,
        isFiltersEnabled: false,
        commandBuilder: (FFmpegVideoEditorConfig config, String videoPath, String outputPath){
          final List<String> filters = config.getExportFilters();
          filters.add('hflip'); // add horizontal flip
          return '-i $videoPath ${config.filtersCmd(filters)} -preset ultrafast $outputPath';
        },
      );
      final FFmpegVideoEditorExecute execute = await config.getExecuteConfig();

      _output = await executeFFmpeg(
        execute: execute,
        onProgress: (Statistics progress) => onProgress?.call(progress, config),
        onError: onError,
      );

    }

    return _output;
  }
  // --------------------
  /// NEED_MIGRATION
  static Future<File?> exportCover({
    required VideoEditorController? videoEditorController,
    void Function(dynamic progress, CoverFFmpegVideoEditorConfig config)? onProgress,
    String? fileName,
    String? outputDirectory,
    double scale = 1,
    int quality = 100,
    CoverExportFormat format = CoverExportFormat.jpg,
    Function(String error)? onError,
  }) async {
    File? _output;

    if (videoEditorController != null){

      final CoverFFmpegVideoEditorConfig config = CoverFFmpegVideoEditorConfig(
        videoEditorController,
        name: fileName,
        outputDirectory: outputDirectory,
        scale: scale,
        isFiltersEnabled: false,
        quality: quality,
        format: format,
        // commandBuilder: (CoverFFmpegVideoEditorConfig config, String videoPath, String outputPath) {
        //   return '';
        // },
      );
      final FFmpegVideoEditorExecute? execute = await config.getExecuteConfig();

      if (execute == null){
        await onError?.call('Error on cover exportation initialization.');
      }
      else {

        _output = await executeFFmpeg(
          execute: execute,
          onProgress: (Statistics progress) => onProgress?.call(progress, config),
          onError: onError,
        );

      }

    }

    return _output;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<void>_onExecutionError(String text) async {
    blog('_onExecutionError : $text');
    await Dialogs.errorDialog(
      titleVerse: Verse.plain('Something went wrong'),
    );
  }
   */
  // --------------------------------------------------------------------------

  /// EXECUTION FILTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String _createFiltersParameters({
    required VideoEditorController controller,
  }){

    final String _crop = _createCropFilter(
      controller: controller,
    );

    return '-vf "$_crop"';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _createCropFilter({
    required VideoEditorController controller,
  }){

    final Offset topLeft = controller.minCrop;
    final Offset bottomRight = controller.maxCrop;
    final Rect _rect = Rect.fromPoints(topLeft, bottomRight);

    final int width = (_rect.width * controller.videoWidth).toInt();
    final int height = (_rect.height * controller.videoHeight).toInt();
    final int x = (_rect.left * controller.videoWidth).toInt();
    final int y = (_rect.top * controller.videoHeight).toInt();

    return 'crop=$width:$height:$x:$y';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _createTrimParameters({
    required VideoEditorController controller,
  }){

    final int _durationMs = controller.videoDuration.inMilliseconds;

    final DateTime _start = DateTime(0, 0, 0, 0, 0, 0, (controller.minTrim * _durationMs).toInt());
    final double _fromSeconds = _start.second + (_start.millisecond / 1000);
    final String _from = '${_start.hour}:${_start.minute}:$_fromSeconds';

    final DateTime _end = DateTime(0, 0, 0, 0, 0, 0, (controller.maxTrim * _durationMs).toInt());
    final double _toSeconds = _end.second + (_end.millisecond / 1000);
    final String _to = '${_end.hour}:${_end.minute}:$_toSeconds';

    // blog('startTime : $_from : endTime : $_to');

    return '-ss $_from -to $_to';

  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions? getVideoEditorControllerDimensions({
    required VideoEditorController? controller,
  }){
   if (controller == null){
     return null;
   }
   else {
     return Dimensions(
         width: controller.videoWidth,
         height: controller.videoHeight,
     );
   }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getFileSize({
    required VideoEditorController? controller,
    required FileSizeUnit unit,
  }){

    if (controller == null){
      return null;
    }

    else {
      final File? _file = controller.file;
      return FileSizer.getFileSizeWithUnit(
          file: _file,
          unit: unit,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getSizeMbString({
    required File? file,
  }){

    final double _size = FileSizer.getFileSizeWithUnit(
        file: file,
        unit: FileSizeUnit.megaByte
      ) ?? 0;

    return '$_size MB';
  }
  // --------------------
  /// DEPRECATED
  /*
  /// NEED_MIGRATION
  static Future<Dimensions?> getVideoFileDimensions({
    required File? file,
  }) async {
    Dimensions? _output;

    // if (file != null){
    //
    //   /// '<file path or url>'
    //   final MediaInformationSession session = await FFprobeKit.getMediaInformation(file.path);
    //   final MediaInformation? information = session.getMediaInformation();
    //
    //   if (information == null) {
    //     // CHECK THE FOLLOWING ATTRIBUTES ON ERROR
    //     // final state = FFmpegKitConfig.sessionStateToString(await session.getState());
    //     // final returnCode = await session.getReturnCode();
    //     // final failStackTrace = await session.getFailStackTrace();
    //     // final duration = await session.getDuration();
    //     // final output = await session.getOutput();
    //   }
    //   else {
    //     final Map<dynamic, dynamic>? _maw = information.getAllProperties();
    //     final Map<String, dynamic> _map = Mapper.convertDynamicMap(_maw);
    //     final List<Object?> _objects = _map['streams'];
    //     final List<Map<String, dynamic>> _maps = Mapper.getMapsFromDynamics(dynamics: _objects);
    //
    //     if( Lister.checkCanLoop(_maps) == true){
    //       final Map<String, dynamic>? _data = _maps.first;
    //       final int? height = _data?['height'];
    //       final int? _width = _data?['width'];
    //       _output = Dimensions(width: _width?.toDouble(), height: height?.toDouble());
    //     }
    //
    //   }
    //
    // }

    return _output;
  }
  // --------------------
  /// NEED_MIGRATION
  static Future<Dimensions?> getVideoBytesDimensions({
    required Uint8List? bytes,
  }) async {
    Dimensions? _output;

    final File? _file = await Filer.createFromBytes(
      bytes: bytes,
      fileName: Idifier.createUniqueIDString(),
    );

    if (_file != null){

      _output = await getVideoFileDimensions(
        file: _file,
      );

    }

    return _output;
  }
   */
  // --------------------------------------------------------------------------

  /// STYLING

  // --------------------
  static CoverSelectionStyle getCoverStyle = const CoverSelectionStyle(
      borderRadius: 0,
      borderWidth: 1,
      selectedBorderColor: Colorz.yellow255,
    );
  // --------------------
  static CropGridStyle getCropStyle = const CropGridStyle(
    // background: Colorz.black255,
    croppingBackground: Colorz.black150,
    /// CORNERS
    boundariesColor: Colorz.white200,
    selectedBoundariesColor: Colorz.yellow255,
    boundariesLength: 10, /// CORNER LINE LENGTH
    boundariesWidth: 2, /// CORNER LINE THICKNESS
    ///GRID
    // gridSize: 3, /// NUMBER OF GRID SECTIONS
    // gridLineWidth: 1, /// GRID LINE THICKNESS
    gridLineColor: Colorz.white125,
  );
  // --------------------
  static TrimSliderStyle getTrimStyle = const TrimSliderStyle(
    background: Colorz.black125,
    borderRadius: 20,
    /// SIDE EDGE
    edgesSize: 25,
    // edgesType: TrimSliderEdgesType.bar, /// THE SIDE EDGE STYLE : A DOT OR VERTICAL BAR
    /// LINE
    lineWidth: 1, /// TOP AND BOTTOM LINE THICKNESS
    lineColor: Colorz.white255,
    onTrimmedColor: Colorz.white255, /// WHEN TRIMMED
    onTrimmingColor: Colorz.white255, /// WHILE TRIMMING
    /// POSITION LINE
    positionLineColor: Colorz.yellow255,
    positionLineWidth: 15,
    /// ICON
    // iconColor: Colorz.black255,
    iconSize: 25,
    leftIcon: Icons.arrow_left,
    rightIcon: Icons.arrow_right,
  );
  // --------------------------------------------------------------------------

  /// PLAYING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> snapVideoToStartingTrim({
    required VideoEditorController? controller,
  }) async {
    final int _startMs = getTrimTimeMinMs(
      controller: controller,
    );
    await controller?.video.seekTo(Duration(milliseconds: _startMs));

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> snapVideoToMs({
    required VideoEditorController? controller,
    required int milliSecond,
  }) async {
    await controller?.video.seekTo(Duration(milliseconds: milliSecond));
  }
  // --------------------------------------------------------------------------

  /// FORMATTING

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static String formatDuration(Duration duration){
    return [
      duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
      duration.inSeconds.remainder(60).toString().padLeft(2, '0')
    ].join(':');
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static String formatDurationToSeconds({
    required Duration duration,
    required int factions,
  }){
    final int _milliseconds = duration.inMilliseconds;
    final double _seconds = _milliseconds / 1000;
    final double _rounded = Numeric.roundFractions(_seconds, factions)!;
    final String _stringified = Numeric.formatDoubleWithinDigits(
        value: _rounded,
        digits: factions,
        addPlus: false,
    )!;

    return '${_stringified}s';
  }
  // --------------------------------------------------------------------------

  /// TRIM TIMES

  // --------------------
  /// TESTED : WORKS PERFECT
  static int getTrimTimeMinMs({
    required VideoEditorController? controller,
  }){
    final double _start = controller?.minTrim ?? 0;
    final int _durationMs = controller?.videoDuration.inMilliseconds ?? 0;
    return (_start * _durationMs).toInt();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getTrimTimeMaxMs({
    required VideoEditorController? controller,
  }){
    final double _start = controller?.maxTrim ?? 0;
    final int _durationMs = controller?.videoDuration.inMilliseconds ?? 0;
    return (_start * _durationMs).toInt();
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static double getTrimTimeMinS({
    required VideoEditorController? controller,
  }){
    final int _startMs = getTrimTimeMinMs(
      controller: controller,
    );

    return _startMs / 1000;
  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static double getTrimTimeMaxS({
    required VideoEditorController? controller,
  }){
    final int _startMs = getTrimTimeMaxMs(
      controller: controller,
    );

    return _startMs / 1000;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getClearTrimDurationS({
    required VideoEditorController? controller,
  }){

    final int _startMs = getTrimTimeMinMs(
      controller: controller,
    );

    final int _endMs = getTrimTimeMaxMs(
      controller: controller,
    );

    final int _diff = _endMs - _startMs;

    return _diff / 1000;
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCurrentTimeIsOutOfTrimRange({
    required int currentMs,
    required VideoEditorController controller,
  }){

    /// CURRENT SECOND
    final int _currentMs = currentMs;

    /// START
    final int _start = VideoOps.getTrimTimeMinMs(controller: controller);
    final bool _isBeforeStart = _currentMs <= _start;

    /// END
    final int _end = VideoOps.getTrimTimeMaxMs(controller: controller);
    final bool _isAfterEnd = _currentMs >= _end;

    return _isBeforeStart || _isAfterEnd;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCurrentTimeIsCloseToStart({
    required int currentMs,
    required VideoEditorController controller,
    /// THE DURATION IN SECONDS WHERE THE SYSTEM CONSIDERS THAT THE VIDEO IS CLOSE TO START OF AT END
    required double snapThresholdMs,
  }){
    final int _currentMs = currentMs;
    final int _startMs = getTrimTimeMinMs(controller: controller);
    final double _startDiff = Numeric.modulus((_currentMs - _startMs).toDouble())!;
    final bool _isCloseToStart = _startDiff <= snapThresholdMs;
    return _isCloseToStart;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCurrentTimeIsCloseToEnd({
    required int currentMs,
    required VideoEditorController controller,
    /// THE DURATION IN MILLI SECONDS WHERE THE SYSTEM CONSIDERS THAT THE VIDEO IS CLOSE TO START OF AT END
    required double snapThresholdMs,
  }){
    final int _currentMs = currentMs;
    final int _endMs = getTrimTimeMaxMs(controller: controller);
    final double _endDiff = Numeric.modulus((_currentMs - _endMs).toDouble())!;
    final bool _isCloseToEnd = _endDiff <= snapThresholdMs;
    return _isCloseToEnd;
  }
  // --------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogVideoEditorController({
    required VideoEditorController? controller,
  }){

    if (controller == null){
      blog('controller is null');
    }

    else {
      blog('controller.file : ${controller.file}');
      blog('controller.video : ${controller.video}');
      blog('controller.initialized : ${controller.initialized}');
      blog('controller.isPlaying : ${controller.isPlaying}');
      blog('controller.cacheMaxCrop : ${controller.cacheMaxCrop}');
      blog('controller.cacheMinCrop : ${controller.cacheMinCrop}');
      blog('controller.croppedArea : ${controller.croppedArea}');
      blog('controller.cropStyle.background : ${controller.cropStyle.background}');
      blog('controller.cropStyle.boundariesColor : ${controller.cropStyle.boundariesColor}');
      blog('controller.cropStyle.boundariesLength : ${controller.cropStyle.boundariesLength}');
      blog('controller.cropStyle.boundariesWidth : ${controller.cropStyle.boundariesWidth}');
      blog('controller.cropStyle.croppingBackground : ${controller.cropStyle.croppingBackground}');
      blog('controller.cropStyle.gridLineColor : ${controller.cropStyle.gridLineColor}');
      blog('controller.cropStyle.gridLineWidth : ${controller.cropStyle.gridLineWidth}');
      blog('controller.cropStyle.boundariesColor : ${controller.cropStyle.boundariesColor}');
      blog('controller.cropStyle.gridSize : ${controller.cropStyle.gridSize}');
      blog('controller.cropStyle.selectedBoundariesColor : ${controller.cropStyle.selectedBoundariesColor}');
      blog('controller.isCropping : ${controller.isCropping}');
      blog('controller.maxCrop : ${controller.maxCrop}');
      blog('controller.minCrop : ${controller.minCrop}');
      blog('controller.cacheRotation : ${controller.cacheRotation}');
      blog('controller.isRotated : ${controller.isRotated}');
      blog('controller.rotation : ${controller.rotation}');
      blog('controller.coverStyle.borderRadius : ${controller.coverStyle.borderRadius}');
      blog('controller.coverStyle.borderWidth : ${controller.coverStyle.borderWidth}');
      blog('controller.coverStyle.selectedBorderColor : ${controller.coverStyle.selectedBorderColor}');
      blog('controller.coverThumbnailsQuality : ${controller.coverThumbnailsQuality}');
      blog('controller.selectedCoverNotifier.timeMs : ${controller.selectedCoverNotifier.value?.timeMs}');
      blog('controller.selectedCoverNotifier.thumbData : ${controller.selectedCoverNotifier.value?.thumbData}');
      blog('controller.selectedCoverVal.thumbData : ${controller.selectedCoverVal?.thumbData}');
      blog('controller.selectedCoverVal.timeMs : ${controller.selectedCoverVal?.timeMs}');
      blog('controller.isTrimmed : ${controller.isTrimmed}');
      blog('controller.minTrim : ${controller.minTrim}');
      blog('controller.maxTrim : ${controller.maxTrim}');
      blog('controller.endTrim : ${controller.endTrim}');
      blog('controller.startTrim : ${controller.startTrim}');
      blog('controller.trimmedDuration : ${controller.trimmedDuration}');
      blog('controller.trimPosition : ${controller.trimPosition}');
      blog('controller.trimStyle.borderRadius : ${controller.trimStyle.borderRadius}');
      blog('controller.trimStyle.background : ${controller.trimStyle.background}');
      blog('controller.trimStyle.iconColor : ${controller.trimStyle.iconColor}');
      blog('controller.trimStyle.edgesSize : ${controller.trimStyle.edgesSize}');
      blog('controller.trimStyle.edgesType : ${controller.trimStyle.edgesType}');
      blog('controller.trimStyle.edgeWidth : ${controller.trimStyle.edgeWidth}');
      blog('controller.trimStyle.iconSize : ${controller.trimStyle.iconSize}');
      blog('controller.trimStyle.leftIcon : ${controller.trimStyle.leftIcon}');
      blog('controller.trimStyle.lineColor : ${controller.trimStyle.lineColor}');
      blog('controller.trimStyle.lineWidth : ${controller.trimStyle.lineWidth}');
      blog('controller.trimStyle.onTrimmedColor : ${controller.trimStyle.onTrimmedColor}');
      blog('controller.trimStyle.onTrimmingColor : ${controller.trimStyle.onTrimmingColor}');
      blog('controller.trimStyle.positionLineColor : ${controller.trimStyle.positionLineColor}');
      blog('controller.trimStyle.positionLineWidth : ${controller.trimStyle.positionLineWidth}');
      blog('controller.trimStyle.rightIcon : ${controller.trimStyle.rightIcon}');
      blog('controller.trimThumbnailsQuality : ${controller.trimThumbnailsQuality}');
      blog('controller.minDuration : ${controller.minDuration}');
      blog('controller.maxDuration : ${controller.maxDuration}');
      blog('controller.videoDuration : ${controller.videoDuration}');
      blog('controller.videoDimension : ${controller.videoDimension}');
      blog('controller.videoWidth : ${controller.videoWidth}');
      blog('controller.videoHeight : ${controller.videoHeight}');
      blog('controller.videoPosition : ${controller.videoPosition}');

    }

  }
  // --------------------
  /// DEPRECATED
  /*
  /// NEED_MIGRATION
  static Future<void> blogMediaInformationSession({
    required dynamic session,
    String invoker = 'blogMediaInformationSession',
  }) async {

    // if (session == null){
    //   blog('session is null');
    // }
    // else {
    //
    //   final MediaInformation? _mediaInformation = session.getMediaInformation();
    //   final Map<dynamic, dynamic>? formatProperties = _mediaInformation?.getFormatProperties();
    //   final Map<dynamic, dynamic>? allProperties =  _mediaInformation?.getAllProperties();
    //   final Map<dynamic, dynamic>? _tags = _mediaInformation?.getTags();
    //   final LogRedirectionStrategy? _strategy = session.getLogRedirectionStrategy();
    //   final ReturnCode? _returnCode = await session.getReturnCode();
    //   final SessionState? _sessionState = await session.getState();
    //   /// IGNORE THOSE FOR NOW
    //   // final List<Chapter>? _chapters = _mediaInformation?.getChapters();
    //   // final List<StreamInformation>? _streamInfo = _mediaInformation?.getStreams();
    //   // final List<Log> _allLogs = await session.getAllLogs();
    //   // final List<Log> _logs = await session.getLogs();
    //
    //   final Map<String, dynamic> _map = {
    //
    //     'mediaInformation.getLongFormat()': _mediaInformation?.getLongFormat(),
    //     'mediaInformation.getFormat()': _mediaInformation?.getFormat(),
    //     'mediaInformation.getFilename()': _mediaInformation?.getFilename(),
    //     'mediaInformation.getBitrate()': _mediaInformation?.getBitrate(),
    //     'mediaInformation.getSize()': _mediaInformation?.getSize(),
    //     'mediaInformation.getDuration()': _mediaInformation?.getDuration(),
    //     'mediaInformation.getStartTime()': _mediaInformation?.getStartTime(),
    //
    //     'getAllLogsAsString()': await session.getAllLogsAsString(),
    //     'getLogsAsString()': await session.getLogsAsString(),
    //     'getArguments()': session.getArguments(),
    //     'getCommand()': session.getCommand(),
    //
    //     'getCreateTime()': session.getCreateTime(),
    //     'getEndTime()': session.getEndTime(),
    //     'getStartTime()': session.getStartTime(),
    //     'getDuration()': await session.getDuration(),
    //     'getFailStackTrace()': await session.getFailStackTrace(),
    //
    //     'strategy.index': _strategy?.index,
    //     'getOutput()': await session.getOutput(),
    //
    //     'returnCode.isValueSuccess()': _returnCode?.isValueSuccess(),
    //     'returnCode.isValueError()': _returnCode?.isValueError(),
    //     'returnCode.isValueCancel()': _returnCode?.isValueCancel(),
    //     'returnCode.getValue()': _returnCode?.getValue(),
    //
    //     'getSessionId()': session.getSessionId(),
    //     'sessionState.toString()': _sessionState.toString(),
    //
    //     'isFFmpeg()': session.isFFmpeg(),
    //     'isFFprobe()': session.isFFprobe(),
    //     'isMediaInformation()': session.isMediaInformation(),
    //     // 'thereAreAsynchronousMessagesInTransmit': await session.thereAreAsynchronousMessagesInTransmit(),
    //
    //   };
    //
    //   Mapper.blogMap(_map, invoker: invoker);
    //
    //   Mapper.blogMap(Mapper.convertDynamicMap(formatProperties), invoker: 'mediaInformation.getFormatProperties()');
    //   Mapper.blogMap(Mapper.convertDynamicMap(allProperties), invoker: 'mediaInformation.getAllProperties()');
    //   Mapper.blogMap(Mapper.convertDynamicMap(_tags), invoker: 'mediaInformation.getTags()');
    //
    // }

  }
   */
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVideoEditorVideosAreIdentical({
    required VideoEditorController? oldController,
    required VideoEditorController? newController,
  }){

    final bool _filesAreIdentical = Filer.checkFilesAreIdentical(
      file1: oldController?.file,
      file2: newController?.file,
    );

    return _filesAreIdentical;
  }
  // --------------------------------------------------------------------------

  /// FILE INFO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int?> readFileBitrate({
    required File? file,
  }) async {
    int? _output;

    if (file != null){

      final Map<String, dynamic>? _info = await Filer.readFileInfo(
        file: file,
      );

      final String? _asText = _info?['format']?['bit_rate']?.toString();

      _output = Numeric.transformStringToInt(_asText);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> reportFileChange({
    required File? fileBefore,
    required File? fileAfter,
  }) async {

    final int? _bitRateBefore = await VideoOps.readFileBitrate(file: fileBefore);
    final double? _kiloWas = FileSizer.getFileSizeWithUnit(file: fileBefore, unit: FileSizeUnit.kiloByte);

    final int? _bitRateAfter = await VideoOps.readFileBitrate(file: fileAfter);
    final double? _kiloIs = FileSizer.getFileSizeWithUnit(file: fileAfter, unit: FileSizeUnit.kiloByte);

    double? _changeRatio = ((_kiloIs??0) / (_kiloWas??1)) * 100;
    _changeRatio = Numeric.roundFractions(_changeRatio, 1);

    double? _bitRateChange = ((_bitRateAfter??0) / (_bitRateBefore??1)) * 100;
    _bitRateChange = Numeric.roundFractions(_bitRateChange, 1);

    blog('reportFileChange [fileSize] : before($_kiloWas kb) : after($_kiloIs kb) : change($_changeRatio%)');
    blog('reportFileChange [bitRate] : before($_bitRateBefore) : after($_bitRateAfter) : change($_bitRateChange%)');

  }
  // --------------------------------------------------------------------------
}
