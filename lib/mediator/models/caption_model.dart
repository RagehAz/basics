// ignore_for_file: non_constant_identifier_names
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:flutter/material.dart';

@immutable
class CaptionModel {
  // -----------------------------------------------------------------------------
  const CaptionModel({
    required this.text,
    required this.start,
    required this.duration,
  });
  // --------------------
  final String? text;
  final double? start;
  final double? duration;
  // -----------------------------------------------------------------------------

  /// DEFAULT CYPHERS

  // --------------------
  ///
  static Map<String, dynamic>? cipherCaption({
    required CaptionModel? caption,
  }){
    Map<String, dynamic>? _output;

    if (caption != null){

      _output = {
        'text': caption.text,
        'start': caption.start.toString(),
        'duration': caption.duration.toString(),
      };

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CaptionModel? decipherCaption({
    required Map<String, dynamic>? map,
  }){
    CaptionModel? _output;

    if (map != null){

      _output = CaptionModel(
        text: map['text'],
        start: Numeric.transformStringToDouble(map['start']),
        duration: Numeric.transformStringToDouble(map['duration']),
      );

    }

    return _output;
  }
  // --------------------
  ///
  static List<Map<String, dynamic>> cipherCaptions({
    required List<CaptionModel> captions,
  }) {
    final List<Map<String, dynamic>> _output = [];

    if (Lister.checkCanLoop(captions) == true){

      for (final CaptionModel caption in captions){

        final Map<String, dynamic>? _map = cipherCaption(
            caption: caption
        );

        if (_map != null){
          _output.add(_map);
        }

      }

    }

    return _output;
  }
  // --------------------
  ///
  static List<CaptionModel> decipherCaptions({
    required List<dynamic> maps,
  }) {
    final List<CaptionModel> _output = <CaptionModel>[];

    if (Lister.checkCanLoop(maps) == true) {
      for (final Map<String, dynamic> map in maps) {
        final CaptionModel? _caption = decipherCaption(
          map: map,
        );

        if (_caption != null){
          _output.add(_caption);
        }

      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKSUB CYPHERS

  // --------------------
  /// AI TESTED
  static Map<String, dynamic> cipherCheckSubCaptions(List<CaptionModel> captions){
    Map<String, dynamic> _output = {};

    if (Lister.checkCanLoop(captions) == true){

      final List<CaptionModel> _caps = cleanNullSeconds(captions);

      for (final CaptionModel caption in sortCaptionsBySecond(_caps)){

        assert(caption.start != null, 'second can not be null');

        _output = Mapper.insertPairInMap(
          map: _output,
          key: caption.start!.toInt().toString(),
          value: caption.text,
          overrideExisting: false,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<CaptionModel> decipherChecksubCaptions(Map<String, dynamic>? map){
    final List<CaptionModel> _output = <CaptionModel>[];

    if (map != null) {
      List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys) == true) {

        _keys = Stringer.sortAlphabetically(_keys);

        for (final String? key in _keys) {

          final double? _second = Numeric.transformStringToDouble(key);

          if (_second != null){

            final CaptionModel _caption = CaptionModel(
              start: _second,
              text: map[key],
              duration: null,
            );

            _output.add(_caption);

          }

        }

      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CAPTIONS CONVERTERS

  // --------------------
  /// AI TESTED
  static List<CaptionModel> convertCheckSubStringToCaptions({
    required String? inputString,
  }) {
    final List<CaptionModel> captions = [];

    if (inputString != null) {
      final List<String> lines = inputString.split('\n');

      int? currentTimeInSeconds = 0;

      for (int i = 0; i < lines.length; i++) {
        final String line = lines[i].trim();

        if (checkIs_mm_i_ss_format(line) == true) {
          // If the line is in mm:ss format, convert it to seconds and set the current time.
          currentTimeInSeconds = convert_mm_i_ss_toSeconds(line);
        }

        else if (line.isNotEmpty) {
          // Otherwise, create a new caption model and add it to the list.
          captions.add(CaptionModel(
            text: line,
            start: currentTimeInSeconds?.toDouble(),
            duration: null,
          ));
        }

      }
    }

    return captions;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// AI TESTED
  static List<String?> getTexts(List<CaptionModel> captions) {
    final List<String?> _output = <String>[];

    if (Lister.checkCanLoop(captions) == true) {
      for (final CaptionModel caption in captions) {
        if (caption.text != null){
          _output.add(caption.text);
        }
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// AI TESTED
  static List<CaptionModel> sortCaptionsBySecond(List<CaptionModel> captions){
    final List<CaptionModel> _output = <CaptionModel>[];

    if (Lister.checkCanLoop(captions) == true){

      final List<CaptionModel> _captions = List<CaptionModel>.from(captions);

      _captions.sort((CaptionModel? a, CaptionModel? b){

        if (a!.start != null && b!.start != null){
          return a.start!.compareTo(b.start!);
        } else {
          return 0;
        }

      });

      _output.addAll(_captions);

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<CaptionModel> cleanNullSeconds(List<CaptionModel> captions){
    final List<CaptionModel> _output = <CaptionModel>[];

    if (Lister.checkCanLoop(captions) == true){

      for (final CaptionModel caption in captions){
        if (caption.start != null){
          _output.add(caption);
        }
      }

    }

    return _output;

  }
  // -----------------------------------------------------------------------------

  /// TIME CONVERTERS

  // --------------------
  /// AI TESTED
  static int? convert_mm_i_ss_toSeconds(String mm_i_ss) {
    int? _output;

    /// timeString format => mm:ss, and this should return s

    if (checkIs_mm_i_ss_format(mm_i_ss) == true){
      final List<String> timeParts = mm_i_ss.trim().split(':');
      final int? minutes = Numeric.transformStringToInt(timeParts[0]);
      final int? seconds = Numeric.transformStringToInt(timeParts[1]);
      if (minutes != null && seconds != null){
        _output = minutes * 60 + seconds;
      }
    }
    else{
      blog('convert_mm_i_ss_toSeconds : something is wrong with ($mm_i_ss)');
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static bool checkIs_mm_i_ss_format(String? input){
    bool _output;


    if (input == null) {
      _output = false;
    }

    else {

      final parts = input.split(':');

      if (parts.length != 2) {
        _output = false;
      }

      else {
        final minutes = int.tryParse(parts[0]);
        final seconds = int.tryParse(parts[1]);

        if (minutes == null || seconds == null) {
          _output = false;
        }
        else if (minutes < 0) {
          _output = false;
        }
        else if (seconds < 0 || seconds > 59) {
          _output = false;
        }
        else {
          _output = true;
        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? convertSecondsTo_mm_i_ss(int? seconds){
    String? _output;

    if (seconds != null){
      final int minutes = seconds ~/ 60;
      final int remainingSeconds = seconds % 60;
      final String minuteString = minutes.toString().padLeft(2, '0');
      final String secondString = remainingSeconds.toString().padLeft(2, '0');
      _output = '$minuteString:$secondString';
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> convertCheckSubTimeStampToDateTimes({
    required String checkSubTimeStamp,
  }){
    DateTime? _start;
    DateTime? _end;

    /// CHECK SUB TIME STAMP LOOKS LIKE THIS : 00:00:00,000 --> 00:00:00,000
    if (TextCheck.isEmpty(checkSubTimeStamp) == false){

      final List<String> _timeStampsStrings = checkSubTimeStamp.split(' --> ');

      /// ASSERT THAT THE TIME STAMPS ARE IN THE CORRECT FORMAT
      assert(_timeStampsStrings.length == 2, 'time stamps are not in the correct format');
      /// ASSERT THAT THE TIME STAMPS ARE NOT EMPTY
      assert(TextCheck.isEmpty(_timeStampsStrings[0]) == false, 'time stamp 1 is empty');
      /// ASSERT THAT A TIME STAMP IN THE CORRECT FORMAT
      // TASK : WRITE ME

      _start = DateTime.parse(_timeStampsStrings[0]);
      _end = DateTime.parse(_timeStampsStrings[1]);

    }

    return {
      'start': _start,
      'end': _end,
    };
  }
  // -----------------------------------------------------------------------------

  /// COMBINATIONS

  // --------------------
  static String combineCaptionsIntoString({
    required List<CaptionModel> captions,
  }){
    String _output = '';

    if (Lister.checkCanLoop(captions) == true){

      for (final CaptionModel _caption in captions){

        final String? _text = _caption.text?.trim();
        _output = '$_output$_text ';

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCaptions(List<CaptionModel> captions){

    if (Lister.checkCanLoop(captions) == true){

      blog('CAPTIONS BLOG : ${captions.length} captions =>>> ');

      for (int i = 0; i < captions.length; i++){

        final String? _number = Numeric.formatIndexDigits(
            index: i,
            listLength: captions.length,
        );

        final CaptionModel caption = captions[i];
        // final String _timeStamp = convertSecondsTo_mm_i_ss(caption.start);
        blog('   $_number -> Caption : ${caption.start} : ${caption.text}');

      }

      blog('CAPTIONS BLOG DONE <<<==');

    }
    else {
      blog('CAPTIONS BLOG : captions are Empty');
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCaptionsAreIdentical(CaptionModel? model1, CaptionModel? model2){
    bool _identical = false;

    if (model1 == null && model2 == null) {
      _identical = true;
    }

    else if (model1 != null && model2 != null) {

      if (
          model1.start == model2.start
          &&
          model1.text == model2.text
      ) {
        _identical = true;
      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCaptionsListsAreIdentical({
    required List<CaptionModel> captions1,
    required List<CaptionModel> captions2,
  }){

    return Mapper.checkMapsListsAreIdentical(
        maps1: cipherCaptions(captions: captions1),
        maps2: cipherCaptions(captions: captions2),
    );

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is CaptionModel){
      _areIdentical = checkCaptionsAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      start.hashCode^
      text.hashCode;
  // -----------------------------------------------------------------------------
}
