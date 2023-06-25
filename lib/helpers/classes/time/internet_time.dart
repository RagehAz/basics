// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:basics/helpers/classes/rest/rest.dart';
import 'package:basics/helpers/classes/time/timers.dart';

class InternetTime{
  // -----------------------------------------------------------------------------
  const InternetTime({
    required this.abbreviation,
    required this.client_ip,
    required this.datetime,
    required this.day_of_week,
    required this.day_of_year,
    required this.dst,
    required this.dst_offset,
    required this.raw_offset,
    required this.timezone,
    required this.unixtime,
    required this.utc_datetime,
    required this.utc_offset,
    required this.week_number,
  });
  // -----------------------------------------------------------------------------
  final String? abbreviation;
  final String? client_ip;
  final String? datetime;
  final int? day_of_week;
  final int? day_of_year;
  final bool? dst;
  final int? dst_offset;
  final int? raw_offset;
  final String? timezone;
  final int? unixtime;
  final DateTime? utc_datetime;
  final String? utc_offset;
  final int? week_number;
  // --------------------
  /// TESTED : WORKS PERFECT
  InternetTime copyWith({
    String? abbreviation,
    String? client_ip,
    String? datetime,
    int? day_of_week,
    int? day_of_year,
    bool? dst,
    int? dst_offset,
    int? raw_offset,
    String? timezone,
    int? unixtime,
    DateTime? utc_datetime,
    String? utc_offset,
    int? week_number,
  }) {
    return InternetTime(
      abbreviation: abbreviation ?? this.abbreviation,
      client_ip: client_ip ?? this.client_ip,
      datetime: datetime ?? this.datetime,
      day_of_week: day_of_week ?? this.day_of_week,
      day_of_year: day_of_year ?? this.day_of_year,
      dst: dst ?? this.dst,
      dst_offset: dst_offset ?? this.dst_offset,
      raw_offset: raw_offset ?? this.raw_offset,
      timezone: timezone ?? this.timezone,
      unixtime: unixtime ?? this.unixtime,
      utc_datetime: utc_datetime ?? this.utc_datetime,
      utc_offset: utc_offset ?? this.utc_offset,
      week_number: week_number ?? this.week_number,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static InternetTime? decipher(Map<String, dynamic>? map){

    if (map == null){
      return null;
    }

    else {
      return InternetTime(
        abbreviation: map['abbreviation'],
        client_ip: map['client_ip'],
        datetime: map['datetime'],
        day_of_week: map['day_of_week'],
        day_of_year: map['day_of_year'],
        dst: map['dst'],
        dst_offset: map['dst_offset'],
        raw_offset: map['raw_offset'],
        timezone: map['timezone'],
        unixtime: map['unixtime'],
        utc_datetime: Timers.decipherTime(
          time: map['utc_datetime'],
          fromJSON: true,
        ),
        utc_offset: map['utc_offset'],
        week_number: map['week_number'],
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  InternetTime offsetTime() {
    return copyWith(
        utc_datetime: Timers.offsetTime(
          time: utc_datetime,
          offset: utc_offset,
        )
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkDeviceTimeIsCorrect({
    required InternetTime? internetTime,
  }) async {

    if (internetTime == null) {
      return false;
    }

    else {
      final DateTime? _now = Timers.simplifyTime(DateTime.now().toUtc());
      final DateTime? _dateTimeReceived = internetTime.utc_datetime;
      final DateTime? _dateTime = Timers.simplifyTime(_dateTimeReceived);

      return Timers.checkTimesAreIdentical(
        accuracy: TimeAccuracy.minute,
        time1: _now,
        time2: _dateTime,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<InternetTime?> getInternetUTCTime() async {

    InternetTime? _output;

    final http.Response? _response = await Rest.get(
      rawLink: 'http://worldtimeapi.org/api/ip',
      invoker: 'getInternetUTCTime',
    );

    if (_response != null){

      final Map<String, dynamic> _map = json.decode(_response.body);
      _output = InternetTime.decipher(_map);
      /// DO NOT OFFSET UTC TIME,, ONLY DO : DateTime.now().toUTC(), when in comparison
      // _output = _output.offsetTime();

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkDeviceTimeIsAcceptable({
    void Function(InternetTime? internetTime)? internetTime,
    void Function(DateTime? deviceTime)? deviceTime,
    void Function(int? diff)? diff,
  }) async {
    bool _output = true;

    final DateTime _now = DateTime.now();
    final InternetTime? _internetTime = await InternetTime.getInternetUTCTime();

    if (internetTime != null){
      internetTime(_internetTime);
    }
    if (deviceTime != null){
      deviceTime(_now);
    }

    final bool _correct = await InternetTime.checkDeviceTimeIsCorrect(
      internetTime: _internetTime,
    );

    if (_correct == false && _internetTime != null) {

      final DateTime? _internet = _internetTime.utc_datetime?.toLocal();

      final bool _differenceIsBig = Timers.checkTimeDifferenceIsBiggerThan(
        time1: _internet,
        time2: _now,
        maxDifferenceInMinutes: 3,
        diff: diff,
      );

      _output = !_differenceIsBig;

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
