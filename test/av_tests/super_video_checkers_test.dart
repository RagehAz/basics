import 'package:basics/av/src/e_av_playing/super_video_player/super_video_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// checkIsValidYoutubeVideoID

  // --------------------
  group('SuperVideoCheckers.checkIsValidYoutubeVideoID', () {

    test('Returns true for a valid 11-character video id', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeVideoID('dQw4w9WgXcQ'), true);
    });

    test('Returns true for a shorter alphanumeric id', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeVideoID('abc-_123'), true);
    });

    test('Returns false for an id longer than 11 characters', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeVideoID('a' * 12), false);
    });

    test('Returns false for an id with invalid characters', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeVideoID('abc def!'), false);
    });

    test('Returns false when videoID is null', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeVideoID(null), false);
    });

  });
  // -----------------------------------------------------------------------------

  /// checkIsValidYoutubeLink

  // --------------------
  group('SuperVideoCheckers.checkIsValidYoutubeLink', () {

    test('Returns true for a standard youtube.com watch link', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeLink('https://www.youtube.com/watch?v=dQw4w9WgXcQ'), true);
    });

    test('Returns true for an m.youtube.com watch link', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeLink('https://m.youtube.com/watch?v=dQw4w9WgXcQ'), true);
    });

    test('Returns true for a youtu.be short link', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeLink('https://youtu.be/dQw4w9WgXcQ'), true);
    });

    test('Returns true for a link without the http(s) scheme', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeLink('www.youtube.com/watch?v=dQw4w9WgXcQ'), true);
    });

    test('Returns false for a non-youtube URL', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeLink('https://vimeo.com/12345'), false);
    });

    test('Returns false when link is null', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeLink(null), false);
    });

    test('Returns false when link is empty', () {
      expect(SuperVideoCheckers.checkIsValidYoutubeLink(''), false);
    });

  });
  // -----------------------------------------------------------------------------

  /// hoisted patterns are shared between SuperVideoCheckers and
  /// SuperYoutubeMethods -- a regression guard that they still agree

  // --------------------
  group('SuperVideoCheckers RegExp patterns', () {

    test('youtubeVideoIdPattern matches the same strings hasMatch would report valid', () {
      expect(SuperVideoCheckers.youtubeVideoIdPattern.hasMatch('dQw4w9WgXcQ'), true);
      expect(SuperVideoCheckers.youtubeVideoIdPattern.hasMatch('bad id!'), false);
    });

    test('youtubeLinkPattern matches a standard watch URL', () {
      expect(SuperVideoCheckers.youtubeLinkPattern.hasMatch('https://www.youtube.com/watch?v=dQw4w9WgXcQ'), true);
    });

  });
}
