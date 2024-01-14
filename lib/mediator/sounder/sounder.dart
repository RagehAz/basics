// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'package:basics/bldrs_theme/classes/sounds.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:just_audio/just_audio.dart';

class Sounder  {
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// private constructor to create instances of this class only in itself
  Sounder._thing();
  // --------------------
  /// Singleton instance
  static final Sounder _singleton = Sounder._thing();
  // --------------------
  /// Singleton accessor
  static Sounder get instance => _singleton;
  // --------------------
  /// local instance
  AudioPlayer? _freePlayer;
  // --------------------
  /// instance getter
  AudioPlayer get player {
    return _freePlayer ??= AudioPlayer();
  }
  // --------------------
  /// static instance getter
  static AudioPlayer _getPlayer() {
    return Sounder.instance.player;
  }
  // --------------------
  void removePlayer(){
    _freePlayer = null;
  }
  // --------------------
  /// Static dispose
  static void dispose(){
    _getPlayer().dispose();
    Sounder.instance.removePlayer();
  }
  // -----------------------------------------------------------------------------

  /// PLAY SOUND

  // --------------------.
  /// TESTED : WORKS PERFECT
  static Future<void> playSound({
    String? mp3Asset,
    String? wavAssetForAndroid, // SOMETIMES WAV FILES WORK BETTER IN ANDROID
    String? filePath = '',
    String? url,
    Map<String, String>? urlHeaders,
    bool preload = false,
    Duration initialPosition = Duration.zero,
    bool loop = false,
    double initialVolume = 1,
    bool canUseNetworkResourcesForLiveStreamingWhilePaused = false,
    double initialSpeed = 1,
    bool fadeIn = false,
    int fadeInMilliseconds = 1000,
    bool mounted = true,
  }) async {

    if (DeviceChecker.deviceIsWindows() == false) {

      if (mp3Asset != null || filePath != null || url != null) {
        await tryAndCatch(
          invoker: 'playSound',
          functions: () async {
            final AudioPlayer _audioPlayer = _getPlayer();

            /// SOUND ASSET
            if (TextCheck.isEmpty(mp3Asset) == false) {
              String? _asset = mp3Asset;
              if (DeviceChecker.deviceIsAndroid() == true) {
                _asset = wavAssetForAndroid ?? mp3Asset;
              }

              if (_asset != null) {
                await _audioPlayer.setAsset(
                  _asset,
                  preload: preload,
                  initialPosition: initialPosition,
                  // package: ,
                );
              }

            }

            /// SOUND FILE
            else if (TextCheck.isEmpty(filePath) == false) {
              await _audioPlayer.setFilePath(
                filePath!,
                initialPosition: initialPosition,
                preload: preload,
              );
            }

            /// SOUND URL
            else if (ObjectCheck.isAbsoluteURL(url) == true) {
              await _audioPlayer.setUrl(
                url!,
                headers: urlHeaders,
                initialPosition: initialPosition,
                preload: preload,
              );
            }

            await Future.wait(<Future>[
              /// VOLUME
              if (initialVolume != 1 && fadeIn == false) _audioPlayer.setVolume(initialVolume),

              /// LOOPING
              if (loop == true) _audioPlayer.setLoopMode(LoopMode.one),

              /// INITIAL SPEED
              if (initialSpeed != 1) _audioPlayer.setSpeed(initialSpeed),

              /// NETWORK RESOURCE WHILE STREAMING
              if (canUseNetworkResourcesForLiveStreamingWhilePaused == true)
                _audioPlayer.setCanUseNetworkResourcesForLiveStreamingWhilePaused(true),
            ]);

            /// PLAY
            unawaited(_audioPlayer.play());

            /// FADE IN
            if (fadeIn == true) {
              await fadeInVolume(
                mounted: mounted,
                fadeDurationInMilliseconds: fadeInMilliseconds,
                initialVolume: initialVolume,
              );
            }
          },
        );
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> fadeInVolume({
    required double initialVolume,
    required int fadeDurationInMilliseconds,
    required bool mounted,
    bool blogFadeIn = false,
  }) async {

    const int incrementCount = 100;
    double _currentVolume = initialVolume;
    final double _remainingToMax = 1 - initialVolume;
    final double _increment = _remainingToMax / incrementCount;
    final int milliSeconds = fadeDurationInMilliseconds ~/ incrementCount;

    for (int i = 1; i < incrementCount; i++) {

      if (mounted == true) {
        _currentVolume = _currentVolume + _increment;
        final double _clean = (_currentVolume * 100).ceilToDouble() / 100;
        // blog('waiting $milliSeconds milliSeconds for (i : $i)');
        await Future.delayed(Duration(milliseconds: milliSeconds), () async {

          if (blogFadeIn == true) {
            blog('i$i '
                ': initialVolume + (increment * i) '
                '= $initialVolume + (${_increment * 100} * $i) '
                '= currentVolume $_clean');
          }

          await _getPlayer().setVolume(_clean);

        });
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// FCM SOUNDS

  // --------------------
  static String getFCMSoundFilePath(String fileNameWithoutExtension){
    return 'resource://raw/$fileNameWithoutExtension';
  }
  // -----------------------------------------------------------------------------

  /// FROM BLDRS THEME

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> playButtonClick() async {

    const List<String> _sounds = <String>[
      BldrsThemeSounds.click_a,
      BldrsThemeSounds.click_b,
      BldrsThemeSounds.click_c,
    ];

    final int _index = Numeric.createRandomIndex(
        listLength: _sounds.length,
    );

    await playSound(
      mp3Asset: _sounds[_index],
    );

  }
  // -----------------------------------------------------------------------------
}
