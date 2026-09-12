import 'package:basics/av/src/e_av_playing/super_video_player/super_video_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// extractVideoIDFromYoutubeURL

  // --------------------
  group('SuperYoutubeMethods.extractVideoIDFromYoutubeURL', () {

    test('Extracts the video id from a standard youtube.com watch link', () {
      final id = SuperYoutubeMethods.extractVideoIDFromYoutubeURL('https://www.youtube.com/watch?v=dQw4w9WgXcQ');
      expect(id, 'dQw4w9WgXcQ');
    });

    test('Extracts the video id from an m.youtube.com watch link', () {
      final id = SuperYoutubeMethods.extractVideoIDFromYoutubeURL('https://m.youtube.com/watch?v=dQw4w9WgXcQ');
      expect(id, 'dQw4w9WgXcQ');
    });

    test('Extracts the video id from a youtu.be short link', () {
      final id = SuperYoutubeMethods.extractVideoIDFromYoutubeURL('https://youtu.be/dQw4w9WgXcQ');
      expect(id, 'dQw4w9WgXcQ');
    });

    test('Extracts the video id when the link has no http(s) scheme', () {
      final id = SuperYoutubeMethods.extractVideoIDFromYoutubeURL('www.youtube.com/watch?v=dQw4w9WgXcQ');
      expect(id, 'dQw4w9WgXcQ');
    });

    test('Returns null for a non-youtube URL', () {
      expect(SuperYoutubeMethods.extractVideoIDFromYoutubeURL('https://vimeo.com/12345'), isNull);
    });

    test('Returns null when the URL is null', () {
      expect(SuperYoutubeMethods.extractVideoIDFromYoutubeURL(null), isNull);
    });

    test('Returns null when the URL is empty', () {
      expect(SuperYoutubeMethods.extractVideoIDFromYoutubeURL(''), isNull);
    });

  });
  // -----------------------------------------------------------------------------

  /// checkIsValidYoutubeVideoID / checkIsValidYoutubeLink (delegate to
  /// SuperVideoCheckers -- assert the delegation behaves identically)

  // --------------------
  group('SuperYoutubeMethods checker delegation', () {

    test('checkIsValidYoutubeVideoID agrees with SuperVideoCheckers', () {
      expect(SuperYoutubeMethods.checkIsValidYoutubeVideoID('dQw4w9WgXcQ'),
          SuperVideoCheckers.checkIsValidYoutubeVideoID('dQw4w9WgXcQ'));
      expect(SuperYoutubeMethods.checkIsValidYoutubeVideoID('bad id!'),
          SuperVideoCheckers.checkIsValidYoutubeVideoID('bad id!'));
    });

    test('checkIsValidYoutubeLink agrees with SuperVideoCheckers', () {
      const link = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
      expect(SuperYoutubeMethods.checkIsValidYoutubeLink(link),
          SuperVideoCheckers.checkIsValidYoutubeLink(link));
      expect(SuperYoutubeMethods.checkIsValidYoutubeLink('https://vimeo.com/12345'),
          SuperVideoCheckers.checkIsValidYoutubeLink('https://vimeo.com/12345'));
    });

  });
}
