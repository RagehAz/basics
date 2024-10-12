// ignore_for_file: non_constant_identifier_names
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/errorize.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;

// -----------------------------------------------------------------------------

/// FORMATTING

// --------------------
/*
DAY                          d
 ABBR_WEEKDAY                 E
 WEEKDAY                      EEEE
 ABBR_STANDALONE_MONTH        LLL
 STANDALONE_MONTH             LLLL
 NUM_MONTH                    M
 NUM_MONTH_DAY                Md
 NUM_MONTH_WEEKDAY_DAY        MEd
 ABBR_MONTH                   MMM
 ABBR_MONTH_DAY               MMMd
 ABBR_MONTH_WEEKDAY_DAY       MMMEd
 MONTH                        MMMM
 MONTH_DAY                    MMMMd
 MONTH_WEEKDAY_DAY            MMMMEEEEd
 ABBR_QUARTER                 QQQ
 QUARTER                      QQQQ
 YEAR                         y
 YEAR_NUM_MONTH               yM
 YEAR_NUM_MONTH_DAY           yMd
 YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
 YEAR_ABBR_MONTH              yMMM
 YEAR_ABBR_MONTH_DAY          yMMMd
 YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
 YEAR_MONTH                   yMMMM
 YEAR_MONTH_DAY               yMMMMd
 YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
 YEAR_ABBR_QUARTER            yQQQ
 YEAR_QUARTER                 yQQQQ
 HOUR24                       H
 HOUR24_MINUTE                Hm
 HOUR24_MINUTE_SECOND         Hms
 HOUR                         j
 HOUR_MINUTE                  jm
 HOUR_MINUTE_SECOND           jms
 HOUR_MINUTE_GENERIC_TZ       jmv
 HOUR_MINUTE_TZ               jmz
 HOUR_GENERIC_TZ              jv
 HOUR_TZ                      jz
 MINUTE                       m
 MINUTE_SECOND                ms
 SECOND                       s
Examples Using the US Locale:
 Pattern                           Result
 ----------------                  -------
 new DateFormat.yMd()             -> 7/10/1996
 new DateFormat("yMd")            -> 7/10/1996
 new DateFormat.yMMMMd("en_US")   -> July 10, 1996
 new DateFormat.jm()              -> 5:08 PM
 new DateFormat.yMd().add_jm()    -> 7/10/1996 5:08 PM
 new DateFormat.Hm()              -> 17:08 // force 24 hour time
 */
// -----------------------------------------------------------------------------
enum TimeAccuracy{
  year,
  month,
  week,
  day,
  hour,
  minute,
  second,
  millisecond,
  microSecond,
}

class Timers {
  // -----------------------------------------------------------------------------

  const Timers();

  // -----------------------------------------------------------------------------
  /// "2019-07-19 8:40:23"
  static intl.DateFormat utcDateFormat = intl.DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  static intl.DateFormat localDateFormat = intl.DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  // --------------------
  static DateTime? simplifyTime(DateTime? time){
    if (time == null){
      return time;
    }
    else {
      return createDateTime(
        year: time.year,
        month: time.month,
        day: time.day,

        hour: time.hour,
        minute: time.minute,
        second: time.second,

        // millisecond: 0,
        // microsecond: 0,
      );
    }
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// AI TESTED
  static dynamic cipherTime({
    required DateTime? time,
    required bool toJSON,
    bool toUTC = true,
  }){

    if (toJSON == true){
      return cipherDateTimeToInt(
        time: time,
        toUTC: toUTC,
      );
    }
    else {

      if (toUTC == true){
        return time?.toUtc();
      }
      else {
        return time?.toLocal();
      }

    }

  }
  // --------------------
  /// AI TESTED
  static DateTime? decipherTime({
    required dynamic time,
    required bool fromJSON,
    bool toLocal = true,
  }){
    DateTime? _output;

    // blog('decipherTime : type : ${time.runtimeType} : time : $time');

    if (time == null){
      _output = null;
    }
    else {

      tryAndCatch(
        invoker: 'decipherTime',
        functions: () async {

          /// FROM JSON
          if (fromJSON == true && time is int){
            _output = decipherIntToDateTime(
              integer: time,
              toLocal: toLocal,
            );
          }

          /// TIME STAMP
          else if (time.runtimeType.toString() == 'Timestamp'){
            final Timestamp timeStamp = time;
            _output = timeStamp.toDate();
          }

          /// DATE TIME
          else if (time.runtimeType.toString() == 'DateTime'){
            _output = time;
          }

          /// FIRESTORE ON WEB
          else if (fromJSON == false && ObjectCheck.objectIsMinified(time) == true){

            final bool _hasThePattern = _hasTheStringPattern(time);

            if (_hasThePattern == true){
              final String _string = time.toString().trim();
              _output = DateTime.parse(_string);
            }
            else {
              final Timestamp timeStamp = time;
              _output = timeStamp.toDate();
            }

          }

          /// SOMETHING ELSE
          else {
            _output = decipherDateTimeIso8601(
              timeString: time,
              toLocal: toLocal,
            );
          }

        },
        onError: (String? error){
          Errorize.throwMap(
              invoker: 'decipherTime',
              map: {
                'time': time,
                'fromJSON': fromJSON,
                'toLocal': toLocal,
                'time.runTimeType': time.runtimeType.toString(),
                'isMinified': ObjectCheck.objectIsMinified(time),
                'hasTheStringPattern': _hasTheStringPattern(time),
                'iso8601': decipherDateTimeIso8601(
                  timeString: time?.toString(),
                  toLocal: toLocal,
                )?.toString(),
                'error': error,
              },
          );
        }
      );

    }

    if (toLocal == true){
      return _output?.toLocal();
    }
    else {
      return _output?.toUtc();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _hasTheStringPattern(dynamic input) {

    /// patternA : 1987-06-09 21:00:00.000Z
    /// patternB : 1987-06-09 21:00:00.000

    if (input == null){
      return false;
    }
    else {

      final RegExp regexA = RegExp(r'\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}Z');
      final bool aHasMatch = regexA.firstMatch(input?.toString() ??'') != null;
      final RegExp regexB = RegExp(r'\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}');
      final bool bHasMatch = regexB.firstMatch(input?.toString() ?? '') != null;

      if (aHasMatch == true || bHasMatch == true) {
        return true;
      }

      else {
        return false;
      }

    }

  }
  // --------------------
  /// AI TESTED
  static List<dynamic> cipherTimes({
    required List<DateTime?>? times,
    required bool toJSON,
  }){
    final List<dynamic> _times = <dynamic>[];

    if (Lister.checkCanLoop(times) == true){

      for (final DateTime? time in times!){
        _times.add(cipherTime(
          time: time,
          toJSON: toJSON,
        ));
      }

    }

    return _times;
  }
  // --------------------
  /// AI TESTED
  static List<DateTime?>? decipherTimes({
    required List<dynamic>? times,
    required bool fromJSON,
  }){
    final List<DateTime?> _dateTimes = <DateTime?>[];

    if (Lister.checkCanLoop(times) == true) {
      for (final dynamic time in times!) {

        final DateTime? _time = decipherTime(
          time: time,
          fromJSON: fromJSON,
        );

        _dateTimes.add(_time);

      }
    }

    return _dateTimes;
  }
  // -----------------------------------------------------------------------------

  /// EPOCH INT CYPHERS (supports Lexicographic sorting)

  // --------------------
  /// AI TESTED
  static int? cipherDateTimeToInt({
    required DateTime? time,
    bool toUTC = true,
  }) {
    int? _output;

    if (time != null) {

      if (toUTC == true){
      _output = time.toUtc().microsecondsSinceEpoch;
      }
      else {
      _output = time.toLocal().microsecondsSinceEpoch;
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static DateTime? decipherIntToDateTime({
    required int? integer,
    bool toLocal = true,
  }) {
    DateTime? _output;

    if (integer != null) {
      _output = DateTime.fromMicrosecondsSinceEpoch(integer, isUtc: true);

      if (toLocal == true){
        _output = _output.toLocal();
      }
      else {
        _output = _output.toUtc();
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ISO 8601 CYPHERS (Does not support Lexicographic sorting)

  // --------------------
  /// AI TESTED
  static String? cipherDateTimeIso8601({
    required DateTime? time,
    bool toUTC = true,
  }) {
    String? _string;

    if (time != null) {

      if (toUTC == true){
      _string = time.toUtc().toIso8601String();
      }
      else {
      _string = time.toLocal().toIso8601String();
      }

    }

    return _string;
  }
  // --------------------
  /// AI TESTED
  static DateTime? decipherDateTimeIso8601({
    required String? timeString,
    bool toLocal = true,
  }) {
    DateTime? _time;

    if (timeString != null) {
      _time = DateTime.tryParse(timeString);
    }

    if (_time != null) {

      if (toLocal == true){
        _time = _time.toLocal();
      }
      else {
        _time = _time.toUtc();
      }

    }

    return _time;
  }
  // --------------------
  /// AI TESTED
  static Timestamp? decipherDateTimeIso8601ToTimeStamp({
    required String? timeString,
    bool toLocal = true,
  }) {
    Timestamp? _time;

    if (timeString != null) {

      final DateTime? _dateTime = decipherDateTimeIso8601(
        timeString: timeString,
        toLocal: toLocal,
      );

      if (_dateTime != null) {
        if (toLocal == true) {
          _time = Timestamp.fromDate(_dateTime.toLocal());
        }
        else {
          _time = Timestamp.fromDate(_dateTime.toUtc());
        }
      }

    }

    return _time;
  }
  // -----------------------------------------------------------------------------

  /// STRING GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? generateDayName(DateTime? time){

    if (time == null){
      return null;
    }
    else {
      return intl.DateFormat('EEEE').format(time);
    }

  }
  // --------------------
  /// GENERATES => [ 'dd / MM / yyyy' ]
  static String? generateString_dd_I_MM_I_yyyy({
    required DateTime? time,
    String? monthString,
    String separator = ' / ',
  }){

    if (time == null){
      return null;
    }

    else {
      final String _dd = '${time.day}';
      final String _mm = monthString ?? time.month.toString();
      final String _yyyy = '${time.year}';
      return '$_dd$separator$_mm$separator$_yyyy';
    }

  }
  // --------------------
  /// GENERATES => [ 'hh : mm ampm' ]
  static String? generateString_hh_i_mm_ampm({
    required DateTime? time,
  }){

    if (time == null){
      return null;
    }

    else {
      final String _hh = intl.DateFormat('h').format(time);
      final String? _mm = Numeric.formatIntWithinDigits(num: time.minute, digits: 2);
      final String _ampm = intl.DateFormat('a').format(time);
      return '$_hh:$_mm $_ampm';
    }

  }
  // --------------------
  ///
  static String? generateString_hh_i_mm_i_ss(DateTime? time){

    String _output = '';

    if (
        time != null
    ){

      final String? _hours = Numeric.formatIntWithinDigits(num: time.hour, digits: 2);
      final String? _minutes = Numeric.formatIntWithinDigits(num: time.minute, digits: 2);
      final String? _seconds = Numeric.formatIntWithinDigits(num: time.second, digits: 2);

      _output = '$_hours:$_minutes:$_seconds';
    }

    return _output;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? generateString_hh_i_mm_ampm_day_dd_mm_yyyy({
    required DateTime? time,
  }){
    String _output = '';

    if (time != null) {

      final bool _timeIsEmpty = checkTimeIsEmpty(
        time: time,
      );

      if (_timeIsEmpty == false) {
        final String? _hh = intl.DateFormat('h').format(time);
        final String? _mm = Numeric.formatIntWithinDigits(num: time.minute, digits: 2);
        final String? _ampm = intl.DateFormat('a').format(time);
        final String? _day = generateDayName(time);
        final String? _dd = '${time.day}';
        final String? _MM = time.month.toString();
        final String? _yyyy = '${time.year}';

        _output = '$_hh:$_mm $_ampm, $_day $_dd $_MM $_yyyy';
      }

    }

    return _output;
  }
  // --------------------
  /*
String generateStringsList_hh_i_mm_i_ss(List<DateTime> times){
  String _output = '';

  if (Mapper.canLoopList(times)){

    for (int i = 0; i<times.length; i++){
      final String _string = generateString_hh_i_mm_i_ss(times[i]);

      _output = '$_output$_string\n';
    }

  }

  return _output;
}
  // --------------------
String generateStringsList_index_hh_i_mm_i_ss({
  required List<DateTime> times,
  required List<int> indexes,
}){
  String _output = '';

  if (
      Mapper.canLoopList(times) == true
      &&
      Mapper.canLoopList(indexes) == true
  ){

    for (int i = 0; i<times.length; i++){

      final String _indexString = '${indexes[i]} : ';
      final String _timeStampString =  generateString_hh_i_mm_i_ss(times[i]);

      _output = '${_output+_indexString+_timeStampString}\n';
    }

  }

  return _output;
}
 */
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDateTime({
    int year = 0,
    int month = 0,
    int day = 0,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  }){
    return DateTime(year, month, day, hour, minute, second, millisecond, microsecond);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDate({
    required int year,
    required int month,
    required int day,
  }){
    return
      createDateTime(
        year: year,
        month: month,
        day: day,
        // hour: 0,
        // minute: 0,
        // second: 0,
        // millisecond: 0,
        // microsecond: 0,
      );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createClock({
    required int hour,
    required int minute,
    int? second,
  }){
    return
      createDateTime(
        year: DateTime.now().toLocal().year,
        month: DateTime.now().toLocal().month,
        day: DateTime.now().toLocal().day,
        hour: hour,
        minute: minute,
        second: second ?? 0,//DateTime.now().toLocal().second,
        // millisecond: 0,
        // microsecond: 0,
      );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime? createClockFromSeconds(int? seconds){
    DateTime? _output;

    if (seconds != null){

      final int _hours = (seconds / 3600).floor();
      final int _remainingSeconds = seconds - (_hours * 3600);
      final int _minutes = (_remainingSeconds / 60).floor();
      final int _seconds = seconds - (60 * _minutes);

      _output = createClock(
        hour: _hours,
        minute: _minutes,
        second: _seconds,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDateAndClock({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
    int second = 0,
  }){
    return createDateTime(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      // millisecond: 0,
      // microsecond: 0,
    );
  }
  // --------------------
  ///
  static DateTime createDateTimeAfterNumberOfDays({
    required int days,
  }){

    final DateTime _now = DateTime.now();

    return createDateAndClock(
      year: _now.year,
      month: _now.month,
      day: _now.day + days,
      hour: 0,
      minute: 0,
    );

  }
  // -----------------------------------------------------------------------------

  /// TIME DIFFERENCE

  // --------------------
  /// AI TESTED
  static int calculateTimeDifferenceInSeconds({
    required DateTime? from,
    required DateTime? to,
  }){
    int _output = 0;

    if (to != null && from != null){
      _output = to.difference(from).inSeconds;
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static int calculateTimeDifferenceInMinutes({
    required DateTime? from,
    required DateTime? to,
  }){
    int _output = 0;

    if (to != null && from != null){

      // blog('calculateTimeDifferenceInMinutes : from : $from : to : $to');

      _output = to.difference(from).inMinutes;
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static int calculateTimeDifferenceInHours({
    required DateTime? from,
    required DateTime? to,
  }){
    int _output = 0;

    if (to != null && from != null){
      _output = to.difference(from).inHours;
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static int calculateTimeDifferenceInDays({
    required DateTime? from,
    required DateTime? to,
  }){
    int _output = 0;

    if (to != null && from != null){
      _output = to.difference(from).inDays;
    }

    return Numeric.modulus(_output.toDouble())!.toInt();
  }
  // --------------------
  /// AI TESTED
  static int calculateTimeDifferenceInWeeks({
    required DateTime? from,
    required DateTime? to,
  }){

    if (from == null || to == null) {
      return 0;
    }

    final int _differenceInDays = calculateTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 7).floor();
  }
  // --------------------
  /// AI TESTED
  static int calculateTimeDifferenceInMonths({
    required DateTime? from,
    required DateTime? to,
  }){

    if (from == null || to == null) {
      return 0;
    }

    final differenceInSeconds = to.difference(from).inSeconds;
    final differenceInMonths = differenceInSeconds / 2629746;
    return differenceInMonths.floor();
  }
  // --------------------
  /// AI TESTED
  static int calculateTimeDifferenceInYears({
    required DateTime? from,
    required DateTime? to,
  }){
    if (from == null || to == null) {
      return 0;
    }
    final int _differenceInDays = calculateTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 365).floor();
  }
  // --------------------
  /// AI TESTED
  static String calculateRemainingHoursAndMinutes({
    required int? secondsUntilNow,
  }){
    String _string = '';

    if (secondsUntilNow != null && secondsUntilNow >= 0){

      final int _totalMinutes = (secondsUntilNow / 60).floor();
      final int _hours = (_totalMinutes / 60).floor();
      final int _minutesRemaining = _totalMinutes - (_hours*60);

      final String? _hourString = Numeric.formatIntWithinDigits(
          num: _hours,
          digits: 2,
      );
      final String? _minutesString = Numeric.formatIntWithinDigits(
          num: _minutesRemaining,
          digits: 2,
      );
      _string = '$_hourString:$_minutesString';
    }

    return _string;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogDateTime(DateTime? dateTime){

    if (dateTime == null){
      blog('BLOGGING DATE TIME : dateTime is null');
    }

    else {
      blog('BLOGGING DATE TIME : $dateTime');
    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DateTime?> putTimeInTimes({
    required DateTime? time,
    required List<DateTime?>? times,
  }){
    final List<DateTime?> _result = <DateTime?>[...?times];

    final bool _timesContainIt = checkTimesContainTime(
      times: times,
      time: time,
      // accuracy: 'minute',
    );

    if (time != null && _timesContainIt == false){
      _result.add(time);
    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime? offsetTime({
    required DateTime? time,
    required String? offset, // should look like this +00:00
  }){
    DateTime? _output;

    if (time != null && offset != null && offset.length == 6){

      final List<String> _splitOffset = offset.split('');
      // blog('_splitOffset : $_splitOffset');

      final bool _isPlus = _splitOffset[0] == '+';
      // blog('_isPlus : $_isPlus');

      final _hoursString = '${_splitOffset[1]}${_splitOffset[2]}';
      // blog('_hoursString : $_hoursString');
      final int? _hours = Numeric.transformStringToInt(_hoursString);
      // blog('_hours : $_hours');

      final _minutesString = '${_splitOffset[4]}${_splitOffset[5]}';
      // blog('_minutesString : $_minutesString');
      final int? _minutes = Numeric.transformStringToInt(_minutesString);
      // blog('_minutes : $_minutes');

      if (_hours != null && _minutes != null){
        _output = _isPlus == true ?
        time.add(Duration(hours: _hours, minutes: _minutes))
            :
        time.subtract(Duration(hours: _hours, minutes: _minutes))
        ;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime? pushTime({
    required DateTime? time,
    int year = 0,
    int month = 0,
    int day = 0,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  }){

    if (time == null){
      return null;
    }

    else {
      return createDateTime(
        year: time.year + year,
        month: time.month + month,
        day: time.day + day,
        hour: time.hour + hour,
        minute: time.minute + minute,
        second: time.second + second,
        millisecond: time.millisecond + millisecond,
        microsecond: time.microsecond + microsecond,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static List<DateTime?> getHoursAndMinutesFromDateTimes({
    required List<DateTime?>? times,
  }){
    List<DateTime?> _result = <DateTime?>[];

    if (Lister.checkCanLoop(times) == true){

      for (final DateTime? time in times!){
        if (time != null) {

          final DateTime _hourMinute = createClock(
              hour: time.hour,
              minute: time.minute
          );

          _result = putTimeInTimes(
              time: _hourMinute,
              times: _result,
          );

        }
      }

    }

    return _result;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTimesAreIdentical({
    required TimeAccuracy accuracy,
    required DateTime? time1,
    required DateTime? time2,
  }){
    bool _areIdentical = false;

    if (time1 == null && time2 == null){
      _areIdentical = true;
    }
    /// XXX - check if both are not nulls
    else if (time1 != null && time2 != null){

      /// A - YEAR
      if (time1.year == time2.year){

        /// A1 - WHEN LEVEL == YEAR
        if (accuracy == TimeAccuracy.year){
          _areIdentical = true;
        }

        /// A2 - ZOOM IN
        else {

          /// B - MONTH
          if (time1.month == time2.month){

            /// B1 - LEVEL == MONTH
            if (accuracy == TimeAccuracy.month){
              _areIdentical = true;
            }

            /// B2 - ZOOM IN
            else {

              /// C - DAY
              if (time1.day == time2.day){

                /// C1 - LEVEL == DAY
                if (accuracy == TimeAccuracy.day){
                  _areIdentical = true;
                }

                /// C2 - ZOOM IN
                else {

                  /// D - HOUR
                  if (time1.hour == time2.hour){

                    /// D1 - LEVEL == HOUR
                    if (accuracy == TimeAccuracy.hour){
                      _areIdentical = true;
                    }

                    /// D2 - ZOOM IN
                    else {

                      /// E - MINUTE
                      if (time1.minute == time2.minute){

                        /// E1 - LEVEL == MINUTE
                        if (accuracy == TimeAccuracy.minute){
                          _areIdentical = true;
                        }

                        /// E2 - ZOOM IN
                        else {

                          /// F - SECOND
                          if (time1.second == time2.second){

                            /// F1 - LEVEL == SECOND
                            if (accuracy == TimeAccuracy.second){
                              _areIdentical = true;
                            }

                            /// F2 - ZOOM IN
                            if (accuracy == TimeAccuracy.millisecond){

                              /// G - MILLISECOND
                              if (time1.millisecond == time2.millisecond){

                                /// G1 - LEVEL == MILLISECOND
                                // if (_level == 'millisecond'){
                                _areIdentical = true;
                                // }

                                // /// G2 - ZOOM IN
                                // if (_level != 'millisecond') {
                                //
                                //
                                // }

                              }

                            }

                            else {

                              /// H - MICROSECOND
                              if (time1.microsecond == time2.microsecond){

                                /// H1 - LEVEL == MICROSECOND
                                if (accuracy == TimeAccuracy.microSecond){
                                  _areIdentical = true;
                                }

                              }

                            }

                          }

                        }

                      }

                    }

                  }

                }

              }


            }

          }

        }

      }

    }

    // print('timesAreTheSame : $_areIdentical : accuracy : ${accuracy} : timeA ${timeA} : timeB ${timeB}');

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTimesContainTime({
    required List<DateTime?>? times,
    required DateTime? time,
    TimeAccuracy accuracy = TimeAccuracy.minute,
  }){
    bool _contains = false;

    if (Lister.checkCanLoop(times) && time != null){

      for (int i =0; i < times!.length; i++){

        final bool _timesAreIdentical = checkTimesAreIdentical(
          accuracy: accuracy,
          time1: times[i],
          time2: time,
        );

        if (_timesAreIdentical == true){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTimeIsAfter({
    required DateTime? existing,
    required DateTime? timeAfter,
  }){
    bool _isAfter = false;

    if (existing != null && timeAfter != null){

      _isAfter = timeAfter.isAfter(existing);

    }

    return _isAfter;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTimeIsEmpty({
    required DateTime? time,
    // required TimeAccuracy accuracy,
  }){
    bool _isEmpty = true;

    if (time != null){
      _isEmpty = false;
    }

    return _isEmpty;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
   static bool objectIsTimeStamp(dynamic object) {
    return object?.runtimeType == Timestamp;
  }
  // -----------------------------------------------------------------------------

  /// CHECK

  // --------------------
  /// AI TESTED
  static bool checkTimeDifferenceIsBiggerThan({
    required DateTime? time1,
    required DateTime? time2,
    required int? maxDifferenceInMinutes,
    void Function(int? diff)? diff,
  }){
    bool _isBigger = false;

    if (time1 != null && time2 != null){

      final int? _maxDifferenceInMinutes = maxDifferenceInMinutes == null ?
      1
          :
      Numeric.modulus(maxDifferenceInMinutes.toDouble())?.toInt();

      final int? _diff = Timers.calculateTimeDifferenceInMinutes(
        from: time1.toUtc(),
        to: time2.toUtc(),
      );

      final double? _num = Numeric.modulus(_diff?.toDouble());

      if (_num != null) {
        if (diff != null) {
          diff(_num.toInt());
        }

        _isBigger = _num > _maxDifferenceInMinutes!;
      }
    }

    return _isBigger;
  }
  // -----------------------------------------------------------------------------
}
